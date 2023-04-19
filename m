Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A506E832A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDSVMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjDSVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:12:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96143468C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:12:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JL4ihG013658;
        Wed, 19 Apr 2023 21:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=6f1FjFe9/y/OoBlIld97pJGZAfU/6B7tDM/A/pR83DI=;
 b=CK8PLwfhMqQwz0NV8C3Np+WDaI/o5C6uvmBXrxkCOHx7NK0KBP49ZOM7IMPFIVXimpy0
 mpwtLP9A+DwSxHWywZpPCJFN71fwD9RyEgz3sw4x8kIb6p4DvpAOE/Jo0PnzjbEZaEmi
 1UPW1053Jbj5rz0s39/4cyeizQVxBLBmXUhwrBsCyZvLiNl7vt3zpvabDhltnyfbkXDq
 oGaBqt+H3y0QJL3/sWZ8/6IVIJ++zqcIm/uKypXkKV9BFlF42i1S3W9Cmo/vPP6S4FTd
 6KPEwF7xJJOD5Y6uqU488028b4m5snhd8kce3G4NZVI4moxOxPHkoCuL3ctz99pQi6tF 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfuhbjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 21:11:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JJKLix011173;
        Wed, 19 Apr 2023 21:11:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc6ypk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 21:11:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMlmpySFI4JEL+31vizDeyCM8uGCk3qRNAHIMxoiPODLoSzFiMoHL2avVyZ1oy5puNCqgkC1xySC+1Kl1fimkO1aeZIAWXXX9aQ3tAtVU6v0RomWH1CMCAWjIFrA+/yYzdDU/Y8f+EBCV94LAyHIk62aq0XADvL5HKATjwMmk5dOCOA1wUuFnk4cZUVtVoKlJ20nx12Bqvsy86QTPB3ZFIfgmn6topDxP6eijN6xkXb2myT4BcSS32bDQrq7Nb8NRCHdAinu387FYImlVjX4SVZjb/0orw3HKOQ2F/UwUl6lsc3kXK0mxh7wwUPa6MCR9UtFMfq1B5jpTxdhFh1/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f1FjFe9/y/OoBlIld97pJGZAfU/6B7tDM/A/pR83DI=;
 b=DzhOwaycUuFd5bpy+c9BKuMHcMeebMT6FzRWEoMiJEhGk1nNO9X+nf8W6n34F4uPB32AkkYfANICKOe+bgS+hVjfsQCUxZs2oQpCvv8oyUtPAjSejg1zUUAzp/s+/JeovOjcOlF8U1GVV+x94FxTGMK08ODoBASBIeEaifDDkH49sOG5mW346QLcXE/R8IsqWeGSJ1bzRqwKaTAQq2wK5uNvSe3bebhN2Mjr/2r+BbqxH6t/z2wOQvnJwfOy5+VAJduImhRMmhfIwA8/vVn2MWwMWX0tMHB4sFC7MfpfNYglArtGTu9/J/fXzcZfcSWwnXB/A1N0lqzUu8dqZgkoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f1FjFe9/y/OoBlIld97pJGZAfU/6B7tDM/A/pR83DI=;
 b=CtDtW2N9ar93aMyvjapDVd/kp6TNa0C/nyhrHcXryrdUrYlO2Qtxsfjq5apmlm8U4iVBj9DO4MS2viHx5LhTPoPQQBI/gXjXq8H5ksoV3wW/Ki77FB0tLPKXOyIFuVrJ1it+FwamrpfHH5+wVUEDl7sOFXf5qqF6nx/2gpJTHro=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 21:11:51 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa%7]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 21:11:50 +0000
Date:   Wed, 19 Apr 2023 17:11:47 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: Fix allocation in mas_sparse_area()
Message-ID: <20230419211147.oyqxns7t3c6vlh7i@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230419093625.99201-1-zhangpeng.00@bytedance.com>
 <20230419124902.7cb9b5c54afa37736e7b0e3a@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419124902.7cb9b5c54afa37736e7b0e3a@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::9) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|MW5PR10MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e39ec4-d1ea-4720-c89a-08db411ab149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kajOWSqW0ZRSQERwSjl+50RGuylMZpxKASyV3IELCt5hw/4fXeyiDADBA+bPiVVX3s5pihJORaM8Hpo1D4oxRPr5HNCgJIpoEOaae9BAn2RKDjHkfejKHLoi8/TyazklP16mvra+AX2JCd/L407ZzYBAToYv7VUB6w6S9Osdn5sNJYLDqWZxtof1aUnW7hUD/Cz+F3XO3YW6u6nvRrB5jsOXIXHp4wCO9qXZei0kJIPujWiFWJTSTl+Z1mHACcvDCa1c4GdHuzciuwEu3MvMyM1x7EbtWJVLEgHjdE9KkQQdkmSrNXMN118w/03e+QWtggulKMWcmDXnGM/j64u1tnmSaHjsfldl6MhnXT95FPTp3hp+D9SxZpI+dy8+UEyTBdUHn7AY9U47nX+xN9YRRvM75fhvQr7TE6kGMJLqbdm8t7Vyd02/1NWylmclc15brh006FM9cqbA3bJC0kM98w4psmRp1n41bfX7hc71ufQU4qfz7cKGqan2ZR91K/026MmK/CUsHw1hIlkT7119lxFBiSO1sPeWtCehdbBLN4LNjiI38i3383lqwLw+2ouU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(316002)(41300700001)(4326008)(66946007)(66476007)(66556008)(6916009)(478600001)(8936002)(8676002)(5660300002)(38100700002)(6486002)(186003)(6666004)(1076003)(6512007)(26005)(6506007)(9686003)(86362001)(33716001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mAWPHQOE8TcvDswULzuPSex3E3fWotq3ewtH0PDWVSxhB8CeVDaeVL5bxa/T?=
 =?us-ascii?Q?SiGBfgmbjnP3t5RieYVwvVyOcJrWyTtXYElRAnyTFVdEAd/+oIIC57B/JcpV?=
 =?us-ascii?Q?1+6gM/yWQz7Z4rfzt0sGdPQLck6jCXeqpiSqlhmxKjMmz/tKJ3fNYs2QlbxW?=
 =?us-ascii?Q?bENvYjsf7Tj+xmuv/Np5BMAX9Jzz4oRKQwxj/KiLcY7j7PXGUtQbDfns2ZPl?=
 =?us-ascii?Q?8YItBm1jO3+wnIUFhKOENFuD1g8hlbwjIYByGOZGtkWBPkWeNF/4nweUF5rW?=
 =?us-ascii?Q?rj5C7DNSScwyjiQWHL5+FF8RxxH7yBh4YHGCv8GNrjJ8j711pVyr/OhhNX3c?=
 =?us-ascii?Q?q2xETAy8xvJ2xUA9DAGh1DJo3CwH+PQnyMbBwQ8ekELjDA/1AiFjN67T3ZR4?=
 =?us-ascii?Q?wOOereKKV+ktBGlmq8E1JUJxfjJa2AThagvfF5sdqHvgqi1pNH4XABseOnpv?=
 =?us-ascii?Q?aJ7G8tvSwFqT5EiCnYUDjHxdWNf0IByxsxfLVg10I1KirkNWvqiHO/WKg01m?=
 =?us-ascii?Q?CFQjCNhP0icPB6ReKENJCgRJFLz7/gwGBSyc57A0K+C9xnp1izOTP/OpOgCg?=
 =?us-ascii?Q?KVplSqClw7VSG5T7Y7IOBDr4K0QnVZgCmX77JkO4DlO8VWuq+moi8cRrU9el?=
 =?us-ascii?Q?JN8NI/BL8406bthJWzMJJzgw8INSFIu05VH1Itbt5vdadnsXNZeIYN6w9rVM?=
 =?us-ascii?Q?wbmiPyV1VcZk7u3ry6R2Z7px9J0nXfsLhoWM9Rt6eOazWCFYrFof+HXrKW5z?=
 =?us-ascii?Q?VG4mCoGnQy9doV2zMUlCl4glLosdl/37XFY/qhb3FfEQj6WwulHorSG4EtNp?=
 =?us-ascii?Q?/6pPAjx4tA170HumgnTd5itc02HTpCoAjA1SsGrkAKmRF2VoUln5GLba3++o?=
 =?us-ascii?Q?oDbqrC5frEoBovQjNNFdY8ehiAOaCWU62+klRLYnCYcqPyoPmfdeoYzMHmLK?=
 =?us-ascii?Q?xGbKToxWE8uesERgVbCtL69qt/+62yWsPT5HS2fYrpE1ijLf8jhf+XqiyfQn?=
 =?us-ascii?Q?GAz0+E3PMklwrHu+nG9LSobKvigBx+Cgs9QJdPLuCb5ygkuB7NfqGMzYeEHD?=
 =?us-ascii?Q?9uPMrHPvbvMgZ18O8CENipZyG2GnzgdCx1bY3L/LIScsyGzz7rJyJsBZ1Rh+?=
 =?us-ascii?Q?FpMePg6+II1wde21GwhJuWpUnOr4htPHqptvhyX1ilKroJ8U3s4hXozQZwXp?=
 =?us-ascii?Q?6x62E0N8xIzRNGSpZTwAh9RDCm7CBGmC/jceUSWsmydjr5LNATvnsKlqCckD?=
 =?us-ascii?Q?RC7230a00HhlPXzWs9OuF9UjMYqUjACaWF9WPBXZ/q01Ttt07aMAeZlvIko5?=
 =?us-ascii?Q?QmooU0vWzuvJgJJy3I6FosYoB8HTf9+CmQMJdUUjBWExKEjuvmMOwUqk/Ub8?=
 =?us-ascii?Q?DZX+orIgkVhi5R3KUPKFqlxmJterIJUlIprK8ROb1rcqnEOUt3n1W0j7dsjU?=
 =?us-ascii?Q?rTkyNSlSIqkSgQ+QYJtqMFKiaIbMMxmSmczz4CDPip0d8q7hLdXnjnWDiQH2?=
 =?us-ascii?Q?V+5mnQ6PG1BBJjN9Hd3+f227mXjS9y4PIv9SxrygnWh5ZoGs6olsCu/BpANV?=
 =?us-ascii?Q?EHCjqKN53Eat11QvvwQJAwleTKZiH6qU92ZqWOAt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jiYZWvrd6qq+KLyc3p16g3u9kxteCuvhNDp+8FA4cbW3eSRWB+ihFp2TIvE8?=
 =?us-ascii?Q?BPD/GAfkQcuUacaA2wwDZKem8wiP+cPINTUovukUQxLSYH5uNOkh2XojP2+y?=
 =?us-ascii?Q?921+DPf0Z17MNzfKT781XE6h6x5lOGuIjrbuzcV4A6wtnf6C5LAf3kH00vRc?=
 =?us-ascii?Q?iyMvGqGuckvqafIazBeC9dNyOzE57KB/aZXG5DJjUt/eGSJ/dAde0NFuE0W4?=
 =?us-ascii?Q?4Cl1qDwieC3WWlGLU6ZQ0OepNf4hLKYJQkuXCzYiHML8mNz33SmSGeMghrnv?=
 =?us-ascii?Q?W04sVNBp/E0Z4m6JbGOwAWWmdTVO5xg6uw+gj6UvB8h30+YIrsnh1EijLZLf?=
 =?us-ascii?Q?OVO+iWFeIrcQRyeLI48NS1/igfjrujm7ZpZc3DEi+UzFHgaojWa3Z5h4W8eR?=
 =?us-ascii?Q?We470ZC6N1ZiEjd9X5tYwA7Zrbz7LM3g6QH6l37/uUT8QAa90sXamGjY5Tqx?=
 =?us-ascii?Q?fmUuz2+pfiVcfOwNaVWQ8aiGjkHTAmj3ASz6t8if63Dl6+HL0Fk/cvQjZg66?=
 =?us-ascii?Q?RJUUtsLQ79h6JjdDnS/m/Ca/BnpmNfoKiuYL6xeisIEcfAKrofmMXuiu+jH1?=
 =?us-ascii?Q?vnZKnpUDjo4Uyoz7EpB9wEEyfFFCD9UXDTyOoMJ2rVCZuF6/pekgYbu00G1t?=
 =?us-ascii?Q?SIddQ2MiK8Hxl4mAFCtbwzh3mrh5aV7cWBE2O1EGaFjYZaYx5xfG86OXnylE?=
 =?us-ascii?Q?I0uH9+KWurhoaHBWgJCowQz6VUFxN45TSDSu+B9Ny0+1iQG5GRFFD5n6wPfB?=
 =?us-ascii?Q?kREY/WZm6RkcxLWTNzGiG0b2tPEWGxJmFSOun3mTw488B2afXIEWQMn9CwGi?=
 =?us-ascii?Q?8q+kv2XtT7Y4sFbc1sGGtsxdFnHK0BQEib310ykd5jyB0DDkVVhG682cNePO?=
 =?us-ascii?Q?a30CUIqYDoUL19ITE5xwkhZw/lGTtrWjrETdO8mChCM9gdCez/iOBG+iHK+N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e39ec4-d1ea-4720-c89a-08db411ab149
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 21:11:50.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26IOcGX9g7tltus42HMUCmac4SKVucdVbWqqou4/Jtsimld/yOmIolFJ4AtV4va+yXlVDQupj5y/N5b61/qUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_14,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=832 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190183
X-Proofpoint-GUID: LSpblquwQ52Vp0CRfhuKF510L2JO2PiQ
X-Proofpoint-ORIG-GUID: LSpblquwQ52Vp0CRfhuKF510L2JO2PiQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230419 15:49]:
> On Wed, 19 Apr 2023 17:36:25 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:
> 
> > In the case of reverse allocation, mas->index and mas->last do not point
> > to the correct allocation range, which will cause users to get incorrect
> > allocation results, so fix it. If the user does not use it in a specific
> > way, this bug will not be triggered.
> 
> Please describe the user-visible effects of the bug.  I assume "none",
> because there are presently no callers which can trigger it?

Yes, sparse nodes are not enabled at this time.

> 
> > Also re-checks whether the size is still satisfied after the lower bound
> > was increased, which is a corner case and is incorrect in previous versions.
> 
> Again, what are the user-visible effects of the bug?

Correct, none.
