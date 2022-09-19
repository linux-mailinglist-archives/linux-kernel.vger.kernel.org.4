Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47585BC58A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiISJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiISJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:37:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95FF25E95
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:37:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J9E9Qo026301;
        Mon, 19 Sep 2022 09:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XmSD8OC54Ftz18+LC8aFKDw2tv2n/QCaeW/TBPRp+aY=;
 b=Z4AL/+eIQMCy5wU/lkGHt9DwNFnnAsqkqd4UBtdi1WOqxjCFWA2qrRlAuKrsbIZrwQff
 +7c7Va4RWOM9JdEb+y4K1KoOJa87FYUCsn9Pze8hqkn4++7kpXX+bfrIrw7v49yp2VFd
 dtNm6NhDVNNQEL5d28XXAw33iYLt/GPRgmhBtk734qlcDApmczTbXzy9ORrtFgIAPSsd
 nDbF6pSdZgwtmuQDZaIIccIegdCXpaSH28il0nDktzBle8ctYF8nbKdhuFRtIw4ueguK
 4PmniEKiAiPHALq8N41yqfRYV7cas8EMz/b8MTe7c2gcXrCd0+BM/tn0fOxKZ4KRC/Ho ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kk918-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:36:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J7a03X010076;
        Mon, 19 Sep 2022 09:36:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39nuy9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOHuG5BR4bStC3vPKHPxo7hDNzorGMTqmsxp7WSs3s/DD1mth7UI7E8Ag4Hedw2/s9Mt7pn7OKkGqEBY2Lsiz60+XWMVcxtMnrI+pnri7hQN5H5NWuA2erF1RlqSOaJBJawZckISf3JYCD/o+GML6G0Q6jVViRRgg/mTi7d6bztIav6evpDavOUeksj7nx71z8bVc70+6G7fvy8jsiPBhNElp/BWI2DssVdUEqwq7QGh4KHxj2xa1RlZmjbv0zFxaU/1kFu4OsNZKjUSmZTmIE0ICW70ao9PKOjDhTBXbX9IuruGqmOi7qwU++gcGJ/ymuuQ2RUkCEChNFLYf5ECoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmSD8OC54Ftz18+LC8aFKDw2tv2n/QCaeW/TBPRp+aY=;
 b=gRq84gtwgpvs9IworU/nrfWQxMc15Pi2IbsW6kH6NVbeTJo6kxJmKjHb0zwR/YWk0pTSxydmuJXyzecaS4Dh2Xg00SpAM5cTBR0YPWzcEidiBHXb+V32V034iTiup51hazPQn1lAzKoYFfbgVaCJMvVqdB54QsEiP74W0ePaHv1/YTc5bi+FY5F16uYvgQIuAR7qK91j6xExOs1bkbN3RlJ5yotfsrOni51rbwhlDjOfLB4yffrQFFuk9STsdM1sWeH2E4C5a8H1Nf0mLYb5AP5sAFU6Vgxfw9GoUTHC7GjelALCN11/mFdahPDl7+5NctTS5q+TEfEcJcyrLVfuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmSD8OC54Ftz18+LC8aFKDw2tv2n/QCaeW/TBPRp+aY=;
 b=gYL/B2vk9JNflPHztRTV86mMZxNkqYYv5/YLDc+Ifd9QxyyDjv3HfGHmVWVh14bren5/v1HPecy8wDuiDwbXrQWc6zMJ4aVbm+Vz+HW+KPyyebBnKULoQQGwnUg0gUxSxSBWZPjKzILEJxTlwt+1uPKteog+WdXPw/t3H8m7c/Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4437.namprd10.prod.outlook.com
 (2603:10b6:510:3a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 09:36:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 09:36:51 +0000
Date:   Mon, 19 Sep 2022 12:36:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] staging: vt6655: Implement allocation failure
 handling
Message-ID: <Yyg4Gev7WxwIQtAI@kadam>
References: <cover.1663273218.git.namcaov@gmail.com>
 <a046af7f-7b60-108a-39e8-9ac3b5ce7733@gmail.com>
 <CA+sZ8B-93re5277swkO51hMuxqgKaKcR3AWcEJAfwcOS-ytdjw@mail.gmail.com>
 <YyQn6+C7kkQ7u5qi@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyQn6+C7kkQ7u5qi@kadam>
X-ClientProxiedBy: MRXP264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::33) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e5cf9e-75ec-4514-3ae9-08da9a227b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwBQZ+F0PWtWKLdp8HCRLY7TXjve7uM2XGRowjndKa0O3v249ZDWoR+c9v+iuv5pOoQGqbhd+Sf41fncAhtbSUdXM0Y1DrsBoJJz9Up39klL/Si7WRYFsg21viK8i3vb/TNilXkhUk2EhbhHVqyf0yxN+T1YF6YWFeYv2AJ1EFBOZGnej/9dhZVeFI4dpHEB2CHGsKN50bgjT6eHECJ7LfAfXjulUKjJAuy8uXn/DPF7fELg4VFeYzZkNzUJtFUL32LBP7ffKsh0tns/8cwrs4C406wt2T8kKSTFW3k6RUgagHazy9MgNC1TeZcRDl491SoJQKaMWksFV1HugbqTIR/0cICwq3Iiv9RJa26g8WJaM7u2C9EMAMVhzHRWVVhE6PTvv82JsLjJpb8usK5X5CknbkDuoQKRx26MPz0tC/pR55sDkaKiRpniPvtYZCEqy0zn/NYOPyZrgx/ZlCv/1y4v/5ax5icRXw8Vj2DxUQMsJku4HNMXqpUB5AgjlLPTB4fVt+ug+oPR0cVfwQGks/y8SG7QU1JzE5SPWvSDgJNq66TF+wObZwowJAtIWw8leqmay0eS77FnbbyPG+tjbSxYyGp0tFoIlRKp1ygN0cQuXm8A8q/Ct2Ea0mbmhYOoCjwDnJN59LyNkUJVfCKyMhxAyao1vdfRUB7/ZlJbpI/+7No3Hp3uX4+QJNw9e2gCLvD+wotGZ6e0Gb3oB4CfavlUsjVnm8RPn2IHKOyHrrO0GnhnKahY5mXq3YTfT2WhKxyTVJ6QxhwFULUT9VHNSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(6666004)(8676002)(38100700002)(9686003)(6512007)(26005)(6506007)(478600001)(6486002)(966005)(316002)(6916009)(5660300002)(186003)(2906002)(44832011)(41300700001)(66946007)(4326008)(66476007)(66556008)(8936002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tYw66MwPx+3Tm7VKZhvOh9DsCjL+aPxAliuF2/pN3A5IPPjG2YHtBuiS9OBS?=
 =?us-ascii?Q?QW9o8aRUP7AjQAaB/qAG+CIyY1Mlbn7ryQyygcXRTd2cwnMYkwZ26gvDfV3g?=
 =?us-ascii?Q?yHE5grNCVM/OfZQSlFBllyQ5hz74UDaDmFl7JfBsD8S7ZWL3ebuKdNqAHe74?=
 =?us-ascii?Q?PJ6gvcO4OnmcIQ473+tosCWpB+vOrpIiqQlq1cRlKyYlXQTRSSfSIc5ZwzHT?=
 =?us-ascii?Q?j97N1Mm1ZH1GWzvMmWChD5jWpvH9OwQoUaz0ypLIvmRtZIvHFBDhSexl9Paz?=
 =?us-ascii?Q?CQ2MD2QuwydHyZdSAjzKklPijkfY8Wz8nXpHIw2f5WjNTBYNK/jSjB68XtdI?=
 =?us-ascii?Q?FFeHcFbkg4V3T+vUc6zJ9jpuX51yWqQ5K1LaeJaH3PLGX5VfSsfqKu99+Nd7?=
 =?us-ascii?Q?KndbU8pR0OXQxsd6SpqBGDG9GctCK10Qi3h17RYmHGiwe42wRylor1/O3Z3A?=
 =?us-ascii?Q?Hmlv4PzdbVjO572Yf6jsDSpR2D9ZZPvYORQaamghwHCS2Zwse5K5sXtZr/1M?=
 =?us-ascii?Q?/f7FqDyswcOn/um/d+tIShPoTGeQwpau1qTJyUT2TDWtWpaFT0+icf+8eBrK?=
 =?us-ascii?Q?jjTuoAZOqdww4/dKwLyiAjtwS+6M93IRJM+1CDGmxDebojK1zbqoSvY6FGKU?=
 =?us-ascii?Q?YOKfsjqcRSyqryyhNe+x/NrzUtChfVAX6yffNjyzLrQBcGf7zqi5LqLqMuuC?=
 =?us-ascii?Q?MkLFU77pbs9f/dIVqvDBOawNjwQe22M4+YilHtgxw6EmvV9xiq5n2CSv0ytF?=
 =?us-ascii?Q?hSVU6mcn7w7xixdWO6iyqXBsfOrV2omc3wS8/bBALfhVFVnjtnq9so/ClxCU?=
 =?us-ascii?Q?lJHuy96RMymgBzqJWNejExlrWzDy8vqcLjEoHEAiwP+OSu5lKLbLqmhMq8sc?=
 =?us-ascii?Q?zC+ZY+XK+9OEApfdrlpHKg/DLQZMyE/PPfLTNsCJQ3Wd230UMSyE7zBPaiEN?=
 =?us-ascii?Q?d57eI8GyDGDM56wfjOKpOt+XUL1Ke21/WaETU8nIfNBcYiD2DDfHc/PmA0O6?=
 =?us-ascii?Q?4D1sMu2VjdyBRMnHuX84tTHRZg3vABVRvqUf8seVoSEDAqV51lOsRYOj7qsM?=
 =?us-ascii?Q?rnJGm5CQhLciT6+6AwyLqJrKyhOarmuluBoGNhP7qQGUBLZPa45g/yT6a2G2?=
 =?us-ascii?Q?kSZ+4coRPSD+OPRfQC/g/ntEPEmKG7NMusedc0CeQ2DbLLsIcqGBtRkQWmYs?=
 =?us-ascii?Q?1P2ur10RtAPhu/mHvN1oBVXCSbSaislLp11YNgFkgsbeZvwTnSYtZ4NoKPAU?=
 =?us-ascii?Q?Pg/uVs/1GZ5yAzF9/Jx0CjYIgXuqqWQJGcThy03VgSJNshAq7tnaF1lrag0A?=
 =?us-ascii?Q?41dnqB42HQ9qLAmxbTlAqU5ARWTOEAZfJhpI6UVTFi6ij5aj6AkWTPqcf46z?=
 =?us-ascii?Q?eOc08D0Etsh++SnPQfBSfGESTsFY/18MvLVLlKAtIlmkvFqVMgcji20p3dhO?=
 =?us-ascii?Q?vfiEPP8kG3yE639bDJvKgxEVFFdBJZm0xvSdEeNorZHGaAt4MEXPO0cdQuCF?=
 =?us-ascii?Q?wYzpWyvPjRzTBr4MN0JUzFjwvBp8rf6MvEya0xatCdsJe0wxsKOh/zxxyIa2?=
 =?us-ascii?Q?uPjZutA4ikDY7SO04m/v+dvwI/Nk+oZ9m2rHzFhM14SYmxZMng7GbkQtQP5d?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e5cf9e-75ec-4514-3ae9-08da9a227b3b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 09:36:51.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6pAdsLCEHArqGVeJmYptqeo3X4JF9/PcomxqRq55blLbLCVIAeflH0eRYn2l6LOwmHV9aaofLFaN9q3cI/eo0ZwbAuCpD89d3+spk2vpco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=852 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190064
X-Proofpoint-ORIG-GUID: 4ihbpWKpRAwVgrNa7jXrf5nxbH2N3YKr
X-Proofpoint-GUID: 4ihbpWKpRAwVgrNa7jXrf5nxbH2N3YKr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 10:38:19AM +0300, Dan Carpenter wrote:
> On Fri, Sep 16, 2022 at 09:11:58AM +0200, Nam Cao wrote:
> > > Find in this email a comment from Greg about RFC:
> > > https://lore.kernel.org/linux-gpio/YwS4WDekXM3UQ7Yo@kroah.com/
> > > This patch is marked as "RFC" but I don't see any questions that you
> > > have here.  Please resolve anything you think needs to be handled and
> > > submit a "this series is ok to be merged" version.
> > >
> > > May be this is applicable to this patch as well.
> > 
> > I add the RFC tag to "tells maintainers should review your patch thoroughly,
> > and provide feedback. RFC is typically used when sending feature patches for
> > the first time, or anytime the patch is more than just a simple bug fix."
> > (from https://kernelnewbies.org/PatchTipsAndTricks). I was not aware that this
> > tag may be interpreted differently. I can send a new patchset if necessary.
> 
> Clean up patches are much simpler than bug fixes.  No need for an RFC.
> 
> But this patch does too many things and Greg will not apply it.

Sorry, when I wrote this email I thought I was responding to a different
thread.

regards,
dan carpenter

