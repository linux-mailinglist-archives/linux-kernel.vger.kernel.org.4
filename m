Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF095BA78A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiIPHi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:38:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802AB7B79A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:38:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G7SoTY031002;
        Fri, 16 Sep 2022 07:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=yifgCu+xTb+my+p8ugkk8Mq+KzeR7DwGEzMavxXt9gU=;
 b=v0EWbnNm0+McuoJAZfA+kVXv5J5sYfDim6CSOB2gYBz6LDNLLEINjOsUbCMqYvRhMkub
 VNmP9sqE1sHGRX+xbWt7uBtxlBvYhU3E2kysflnkzR35uCLVY2NAULfw8myG0pl0anUk
 pp748citDSRp4IgUtbEvEPOAfCiDc8nm4Help27SNTd8oO283K4IjEbQ4sgEH8RE8Xqw
 VisL/68h4sVVxnwdyNOaximD2gD3Ms21WBrh/B20Suh6p1lvN4ekjNJFymRBEp4J7iIQ
 DBnif6fAa8pKaNSimrHcd2NMnBa8Ye+nq+/U45siKEz4Lrf85x+cbst7lg6YMSCSVGw1 JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8x8sp8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 07:38:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G49QT7004112;
        Fri, 16 Sep 2022 07:38:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xew52v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 07:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7k6VmZ1dTt8RPDoGM0ugCipqnahuvBXhVTbFf2L8O1v7jdYBO8LT5MUSeJ/GhjhUBLus+oFLKfNtqrLEx1dQqPHfTymHFSJOkO8nFfOWM3mILa8MLdLqhZlcTERd0Cgvt/ZXUL26eX/YFjmLaVJs1dtvx46lXzHuT0gGapFHHfDxAuZpM/NborVoYn5RNVfFw748BmF9JCxSdWyBKeEpELAVzN5Gb3AP3C/QGePWpN2pv1x24vdCkAEWYgh7oS2GMtYjUEwYvW1vO1ya/jqDWBdNXQHSjlkSQmti6fLI9y3XWpubgR7KDExp6f7N5bH3Gig1ZoCbFJuBWXiQ/RkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yifgCu+xTb+my+p8ugkk8Mq+KzeR7DwGEzMavxXt9gU=;
 b=Myf9SeaAlWm8daJKanh0zAYr/pb2F9mFQGIH8GzDn9q61laBObDZnFwNll0fkKW/usXY8OzFsXOISKtfK073jyXuGUhQWyrqSOIU+TpL2l7t+mLxMH5YZMtE/oOC9yP97InBvv+fSJbkaVrAu7TEmvoi0SsGQcP9upZnLiHJ/uQXFBRNDrXL3Jdl4s1cLgnPuQkpudRSgo9pvn/xcSD+4Ip45cBvY8khJH5rbythyFWK1jbxYbVDcOWU/zbGHt8un6YoUcRubQXZL8jdiLNl4OUi/Ie8ww6cO3WnFPLCZj39Se+1LYKiFkEwE0cygqUuVIjnLpaLriMaRV1IM7W1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yifgCu+xTb+my+p8ugkk8Mq+KzeR7DwGEzMavxXt9gU=;
 b=nWkluFAcAoSWg2613MZK4klHYIN2b6YjqQs0OYJmSgvvQrYLcnVguIYCuCJ1PaHOmHZjmLH35R7uBOUzlv8Rg9/0qgsT7xW8AezrmiCLv1rIjzfGd6EwV6CPKHGupwQr/CuhlrMjD65hGckFHVsiZlxIhfRndejuHjVWbIHfE1c=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4659.namprd10.prod.outlook.com
 (2603:10b6:303:6c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 07:38:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 07:38:40 +0000
Date:   Fri, 16 Sep 2022 10:38:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] staging: vt6655: Implement allocation failure
 handling
Message-ID: <YyQn6+C7kkQ7u5qi@kadam>
References: <cover.1663273218.git.namcaov@gmail.com>
 <a046af7f-7b60-108a-39e8-9ac3b5ce7733@gmail.com>
 <CA+sZ8B-93re5277swkO51hMuxqgKaKcR3AWcEJAfwcOS-ytdjw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sZ8B-93re5277swkO51hMuxqgKaKcR3AWcEJAfwcOS-ytdjw@mail.gmail.com>
X-ClientProxiedBy: JNAP275CA0057.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO1PR10MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: 00933af7-c466-4759-6ac0-08da97b678d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2/zMLVJzJbQwltdqeQx59pJ6rFRlCmYEOFotCF8/4AJ0uXVCz4dYN/pSVPyUtodpEFInqtWk/857LxY2EtQMpRE+cV4/BkgVw+BAfbomCkZyCg2w44MhJC2u4jdogxS9uUpPnXG2chW7wJt7x7vc8KUWVqaSMjC0aATb4LG8wqUlRhs6oVrYH5GOmeO9XLrr25JJOZCMnnZpphoV91lHr1ZBtcRr/zcm3bYP4AOuWdC3lHm8tPVFQ1Z5B9aWyB56IETzYYk8/JzhRTNaey6mIspcXlS7MDDxtpntyyNa7Fl++RPQ2pzoVpyAy1lSc81WOKoE0Uk64jcSn43ldreAhfTM0jQ0CYhMoZQDtVRbmKIpeXlQBTf7ZnfWm1VR2jH6m/cGR8PieYX3MfLNVgQPGycaUBxWbTOQwvEdY6ZzqRRFL3d2zU459w+P9qWgjlBpMqyML573sXEiV/jBX9O8SzeuJygyoQQV70DFnztWuzs6IRC5wwFrBJLH5L1qvh+4LAkEnBNY78yGCg6JcZvVh6jgHKfhiViaCUN0jtH9mCfbf/nv0rZwvTk3gMG/3faY9UGQeehrjXSGn3MpRFIRNEdgM6IeTcEyYVIf09svjYpvC7JuJd8xf80HxGyNFP+POUh0CdsKRKeBwenyN2NtGOsX4SNEpf4YMXBAWsVe18XdJSzAUfpTU2by+v2w1M6dJ+lw9q/PmL/KoJS/CrZ52T2fj+MtVQ8fTxt3rWxzBFtDvBlyDVrJe46umaMtWZST5Zs9CB+bEB2+WJHgGqn7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199015)(38100700002)(86362001)(44832011)(6666004)(966005)(2906002)(6486002)(33716001)(6916009)(9686003)(5660300002)(8676002)(26005)(6512007)(186003)(478600001)(66946007)(6506007)(316002)(66556008)(41300700001)(4326008)(66476007)(4744005)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFvxHMIV8AaNO9qsM+mv38ED2uGbmYgJrxUGzTyEziJH2+irpXAX+DQ+MdvT?=
 =?us-ascii?Q?IIyadPIyPQekbAjmWAJrJW3olix6exiYyRLfX343crAUAuTsZPCqvcg3EbUo?=
 =?us-ascii?Q?jzE71DtlmUT+eyQbxawe9oDO3EmXcNdumzsXFuRd/GM35xbZU7Yy3UNkEMXj?=
 =?us-ascii?Q?OtYt6iFHc1iNIHy4VwZTv8A0Vr5YH/oWkm83xKwYtV0Z/DEoSuinMCwBA8cd?=
 =?us-ascii?Q?F7fdgA1HIT9NV32eThgP01UW3+nhCjte2Y3Jmbmqyb5j6pxvUfl/SZ1JGDh2?=
 =?us-ascii?Q?iD9Wc1OYYwdQ38qYBOWSdEKNvcLoEfWutTO49Y5hckSMZuCDCXLzHUwRbwbm?=
 =?us-ascii?Q?uWtqlAaGMGm9ipMmn/bKCVopET07DDa1ypazSpWzb/cGdPffcXe7/bcvLPXL?=
 =?us-ascii?Q?HmX4iz90gb9RJXV50zcPT02fEIFAdp5Jquvxcv8W4378WzaA3/DB9q4Io74+?=
 =?us-ascii?Q?XMbgWwaBQ7xmkHrVDeVZdBxa4LeCHkBnNR2CjW118uKB6/2VKXVaP0/2bUKZ?=
 =?us-ascii?Q?dNtGWkeWE+0sXosLRl1nN1CDGHx4H3EkjCIhSeI3FOyIE60rGhYH7/wvu+e7?=
 =?us-ascii?Q?Tq8BLo2IFky9VrQhjUgf1b816/gEKvQzubm+c3Vuz90GCZ2WH8OjV0QDc/UU?=
 =?us-ascii?Q?6L1zcFkkJ8FIEAvk6zoznmyjhnDA75q5huId3AV6Ae8pTi8mzQuV8raRyGg3?=
 =?us-ascii?Q?UTXv18TkxNzix2HPKgSlncJUJnsuu5YOzMvuBEC61r+97Z4gcjVj7FFwezdC?=
 =?us-ascii?Q?5+T/TnMVvxNvnr9IbvTxDMOl7sjAOFBjh9Gz87WxjciRThgU2px3/PL0bSmO?=
 =?us-ascii?Q?K0Deymsr9K1UoI3uTUyHbgeZMHFTMevBYzfw6uPAUry7/jalFVf9jm7q0vus?=
 =?us-ascii?Q?aZ5818BGlh/ixhRoxvsRwW6P/PpVskx0VPCrh/PVHSwdz0plrm6JDuHlaY2a?=
 =?us-ascii?Q?+SdCeaHceasfn6B+crBOcyIyFV8ZEBMlk/FaNcwrA0GehRVdjQ5DqD1hWn2V?=
 =?us-ascii?Q?Mfd15EKq43WHv+kFGk4h+n55pp3DHW9Vki019t75ozkTOZ+0V8tsAm/oKKF8?=
 =?us-ascii?Q?9/zcQzzN4hP7NQ29u3EE79Mo9HAlX4N8P+q1rd4z56W1zvGfqvPYE/ZxkcQD?=
 =?us-ascii?Q?iVM4+bCft3EcAc6MDtU1Hs3XAdJWYFMCilLd8cvX2t9Rh+gCBBpJinRzDdrG?=
 =?us-ascii?Q?VaVXm0IveIzJ++ZnL7PmKBxJdd4snbTRTJR5YPTh1WzU3FkeiSbW/T13TeLv?=
 =?us-ascii?Q?hKTzC36R8PziNpY0cLIVhMwNao55gjHail8cZXTGVokiq7p01JM1/NfNxbdD?=
 =?us-ascii?Q?kP7N8U2oaf4DNhnmF0TD23rJ75HdCBWq4TXnU2DtX0fSyzNMgupw2Hzq2D8J?=
 =?us-ascii?Q?6NzrYgfn1/EjLnmJP1OHd2V86qI2kSVAYHMC24J9ulQwPIA1hauG7gsIB3HH?=
 =?us-ascii?Q?iB54VZJImjSDNdAC2f0H/xx+cHj/HQqIDSVkVKg97YjpcA5Y6MQrG9YjJWIt?=
 =?us-ascii?Q?jh7T0QC4OxSryI51FJCnUFNWPRdUk0jsQc/IqatFryB0X+FVgZoSBrsszAs+?=
 =?us-ascii?Q?eifqrKwHdJQOQVWfWWNJuG8znewvXn7egIvNfiOZslENpKIx3C+KGY9KhFCo?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00933af7-c466-4759-6ac0-08da97b678d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 07:38:40.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J4AG/q7zOoZXUCqkKvpTt176D4Osg49nKQqBFGhX11/RboPPtxIGZsK/F6UZ2WKTQbjx2C4OfjiPwR5nDKCk+Sx6dBAq/WAbRZupb2arwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_03,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=812 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160056
X-Proofpoint-GUID: ogK5jeLSdSE0TH1EYJN93V7DK7i_lyaC
X-Proofpoint-ORIG-GUID: ogK5jeLSdSE0TH1EYJN93V7DK7i_lyaC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 09:11:58AM +0200, Nam Cao wrote:
> > Find in this email a comment from Greg about RFC:
> > https://lore.kernel.org/linux-gpio/YwS4WDekXM3UQ7Yo@kroah.com/
> > This patch is marked as "RFC" but I don't see any questions that you
> > have here.  Please resolve anything you think needs to be handled and
> > submit a "this series is ok to be merged" version.
> >
> > May be this is applicable to this patch as well.
> 
> I add the RFC tag to "tells maintainers should review your patch thoroughly,
> and provide feedback. RFC is typically used when sending feature patches for
> the first time, or anytime the patch is more than just a simple bug fix."
> (from https://kernelnewbies.org/PatchTipsAndTricks). I was not aware that this
> tag may be interpreted differently. I can send a new patchset if necessary.

Clean up patches are much simpler than bug fixes.  No need for an RFC.

But this patch does too many things and Greg will not apply it.

regards,
dan carpenter

