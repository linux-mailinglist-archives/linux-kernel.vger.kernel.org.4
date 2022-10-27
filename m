Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDE60F129
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiJ0Hc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiJ0Hcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:32:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD616654C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:32:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R6Kn0M000948;
        Thu, 27 Oct 2022 07:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=KkJf2LoTWtmKqhDQvF3BSgPgagzK10hhv6w6UBvfpBs=;
 b=b0bfOGvlcv1Iq2i8+G5Makz35Ges0zjjMb2iy3qvRBv2L0cxo7k92MlH1IPnLIlquYLa
 0OIUGwEhIYZ8wknR4wH+3XYRK74MjYF5ExRn1bBVkVmJRaFK+SeSajwFpKiTWZPvDHQ0
 1g7DEBngOJjxAZMQrAF8u4RS/19I4qITwigG9qTN2A8mdjxACWc3xg2DvAf2lcfRxt+t
 +UmjWzZzfgdR/lx4TqXXS1Y4ZWzg0Jsc3hOO4sNCbZlt2gkY2hWLGWJG7TnouSzDCTyi
 V7zB7TyrXviyQdKqIsdFCFwkKvsTR+r8SlmsgTDBxQcJ+28L9v41oHgwIV0SbbZ+L/Xa 5g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7s4dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:32:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29R7Tol5011644;
        Thu, 27 Oct 2022 07:32:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagqpt4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 07:32:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT82JIsr9WNWknV+Hfb3sqfvD3SZ+5ZmINkHzG38w6f+9IKs7IW5o1E4kRkPsI9yQSRM6kZU7gw+fW1wvZFnRXkfme4s6oZ5NWhV3wgrZSfvda9STVFzCGNFWyFuWfxOPCZvq/AI9a2NlYvap7tjs5vW71yOOSKGmMur5LsH1xC8ii5vWuazyMaGtbhM2nNOlmFZtfY2qkEO6VrvS4fiEyLoso2C4l5rOsMf0Uy7UNRxEKlcfMlZQkkIljnyG5iu7/qLknHDtFNF1Ui78plRKthgh4MdPNamOgzo3z052H7HtHOWgzwor1rhAOGzxMStX2PAk2OTBw3qS8ZMq4gyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkJf2LoTWtmKqhDQvF3BSgPgagzK10hhv6w6UBvfpBs=;
 b=HznUqzP1/64DA9VjfDJXUIjtl2+DWFw0X3eix+7HEZpWEOFQnVYGt8/ojYEwUjnXd27IacJTinj11yT1LcVxdmdCy3dJKyA+Pm813hiS7OUy4LEpCVIA/d4p3EB7Pn1bbqX3KnmypMPb1n9WilycQQKaS2/R+YYzXn8t4WtHaF5FONWrO4eOcZk9xp2L3X2NlC7Gzq5QL0LBot7szqKqiJBpDiBYT6DV1WMxn1HpuA1UIWGfrqFuRJF+rKvuWp1eW4kL4F8psRySzvE+3KLrCZAgVX35/4tlp61vOvdVCz7fs4X9Z633Vi17CgTxTdMXeu3olVaqxW9/U1kZHO6+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkJf2LoTWtmKqhDQvF3BSgPgagzK10hhv6w6UBvfpBs=;
 b=Y+I7ZtEN0wkWd/lP/gv7EZJJoE2Kvk+uqTuk9pY2X9UhofsIAN7HvP6iqxBKN2itSyJFkup+kzg/ooDawOIgP7pWKWPeMhpPTb3Xlyvf2EXsqgT5SPOGAS2hi/Mdxx3W+rcCNvE1+XurrJn00Avs9kntIPFZMgGxugaNooq/TZ0=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by IA1PR10MB6686.namprd10.prod.outlook.com
 (2603:10b6:208:41a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 27 Oct
 2022 07:32:37 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::7dee:dce8:921f:d623%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 07:32:37 +0000
Date:   Thu, 27 Oct 2022 10:32:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Emily Peri <eperi1024@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Replace ternary statement with min
 function
Message-ID: <Y1oz/w9qfwQ+8gWt@kadam>
References: <Y1neXqVYZ8mq8jH+@marshmallow>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1neXqVYZ8mq8jH+@marshmallow>
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_|IA1PR10MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2e2e9f-9dc7-43a6-880c-08dab7ed6b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OEa3pJaFoFEGRVc5j6PhQFMviGVfWjpZ7t1ln+0y3pHAhMQcf1/nhtHQsbUmqsigq5SZfQ8DFxNNI4rO0lawz4+XBqiJnKv+mf4jfwK0uJgD3aoJ1Rof7zM8+yTzWpQXVhcpbdhMrXC9WxLeYHHI9MgkTX2EHm1SGIrP8wpne3GqCeEV6SKuH/vqsQk51J48WNvexhua3F7BKkhzhHWiQgJ3BHVQaDRugtIW+W70+tWF/fyiq81QgubQpqLKdgipu5Ok1nEIP7azFjtnzZW8Ii/QoyNplpsrhrwtR8rvibO/jeOCGgIMXh7/LF7Rsj9Xk8ImDA18Uzp1zWFlkxch9+8O7R4XfJ3DxFfVCdYCppFyHJNyMll9GASr3RB75AKp/e8JDIrJ4Gbc1e7zDLZGk0UmPz5sMVHunX45ZoA5+GdNW2nB/evJyvcIcBsZyf+ZX7qIEqXfc9dL4zeXz7OiAfRGhLHokBFfbGLvO4fnnKocZDyR2n/e6H4GpkExsTJ/EQuS0lDIAjmZAPUjYZwLagQHBNwvZz3/5UT4HW58r9XnIKP9xs4Dz9h5Dpo1wbOlD6T8bQPxXo3DW+30C17J7jU59xRbaT9+i1V8Av6t6jnPkXnqw1dAEhrI6gB+DH/56UOL6bsRA+ZrH1Hwtc+a/gf5bwvo8swA9GojzzoW1dl5tcFx+BuXt+3ClEbUN+6c0LTYW10Ic0u1ZB0li/ojQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(66946007)(41300700001)(6916009)(8676002)(66476007)(38100700002)(4326008)(6666004)(6506007)(5660300002)(316002)(4744005)(9686003)(478600001)(6486002)(26005)(66556008)(6512007)(44832011)(186003)(8936002)(86362001)(33716001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WbP4Q74/27lFX5eNzp4IxS0ZMupYeMeqWeenloZhUYlhzXjus+enV5hiBhYG?=
 =?us-ascii?Q?MjdjWwFACUsCu3hvi69KXcap6iEZk/9aePtUQkctN0IY4OxoS9wSx51rtj93?=
 =?us-ascii?Q?oISIEwXAOmXHs8xO3RwHLl53duP4HczJ3ozcXAINpo8RRx12S+bHmiid94st?=
 =?us-ascii?Q?RhlrI/0evMO+Ec5xoOZTjcV07xXTXonCqGOIXXsyOSvqwaJWgDL371Y7/eCK?=
 =?us-ascii?Q?69RZ2mr5NNa0VM4VSSZMjFBIgCZyLUkKbY+VlrWr3HinR3r6DUHLAZ6ngLsV?=
 =?us-ascii?Q?z+qXAO+moc3nEYDTYatlZmnRcnb2lnLXkUezbhddrSwpxXFi2zOChd1SZ02c?=
 =?us-ascii?Q?dcxTgOJmxXtv8E1fMvmiRZPEm5kgGkQnaEMA/nMWoueA9RBDjB54FfSynFIM?=
 =?us-ascii?Q?XAEeKsq1A6O0S+1EOO5QGbRcm2s9bmxfzb8B3v5InrmlDUdNjIEtBIL994Jt?=
 =?us-ascii?Q?xFByZ/ctu2Bqo+vMtWXpVM9jvC4tfY6TZhX5RF4F9JMs59BMsTI6E2M9sMlT?=
 =?us-ascii?Q?re6fWP1ZJOu5Tnt03B/WKATHORhue+Gj9J2OeMOUHI3lSh6FEaSQdU+zyMtb?=
 =?us-ascii?Q?3zQQRQQPtnDtAQIQclyGT5uyVUQw7DQ8cA79PXQ31so9wUuA+ynruWB5iUV2?=
 =?us-ascii?Q?3bW2ndjiwgPFYnZu5SQJN0p+Xk/X5bS26Go13iL7FbiKGK3orRyAMbgMIt2H?=
 =?us-ascii?Q?DQpWt3LI8pCWrD9b0akTyBz9NGkhavF5pL31cfFrjf9sMjHPr9wF94Ea8zyS?=
 =?us-ascii?Q?AI7tfLEcnRhlQQWy1qPtHW1pnOQ/pI7eLS2F5tNptfPjGW3yu3LPmIFrzHqF?=
 =?us-ascii?Q?JPeiwQYwlVxPtowz56lDc+5MSJ5Fa57deQGgXS1ckmJi7cLzC8FAtBhXZJFI?=
 =?us-ascii?Q?uKsbUedDYfF8ICxb9Wx6gHvvbgMT/NUssGyNYSicVYqJKCctdJrnYPp9VhVG?=
 =?us-ascii?Q?GICFk181cGG44VnMMmq74+5TmvKy6KW+w9pqm+JMlEbpFD6lb/uEK9BAHwcH?=
 =?us-ascii?Q?mYp8BS7bjn9xZgvIgmCxwmfnBbjgyDtNN1dLl5lC5Bak6YXcVJ2+qRaEcvjv?=
 =?us-ascii?Q?53t/ZyZjgajdemzboGkHhFXPbEeTmniJmbw0N5o00H7wwTsDp++YHaXujRSd?=
 =?us-ascii?Q?uvdFTGwmHAi0blPZQgB1QMtWTlNjz6/3xhskio45v4ez98gz85x2mTALzhBq?=
 =?us-ascii?Q?5YikNGRuzWsOyQzLf19P2BjFDzNUfmdcvtKpTNYhcWTnT+/GT3WdCmoaNb04?=
 =?us-ascii?Q?JASCB3BjOnd/qFZn8ZstpSqLmmvmcIv6dGyN2uDsobmqsxJPJTta3Y8v41OO?=
 =?us-ascii?Q?hITd47E0ua9PYJdaGUkrUhp93nu259gvmk3iFbZ8xiIocKl3w0HssEo/nSJl?=
 =?us-ascii?Q?Xg0VUWYVUmkR8sz3ac4jbE9d37KK8N2Dli22hGS142KgrZj75yPn5LIycCWu?=
 =?us-ascii?Q?qwnsoU/TnPTN2Bg648RSM6ZV/gVaMW4SCbn8fbSiwxGZWoROIOcxdkAeCYEf?=
 =?us-ascii?Q?edzHpD2hx1azwRnwm6FRbEswgOU/wLuA9O8JtQZjy5stAEORTj/yCS/aB+l2?=
 =?us-ascii?Q?xyfJlEwm4OV3UF75nBA450MLpAY2TTX70DFQpbUZgzsrR+PerixpfaXi7o4p?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2e2e9f-9dc7-43a6-880c-08dab7ed6b78
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 07:32:37.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo8aaLWh5VpjdtQxAmwZvAsyeGZtkRQkjRVeruBESdsu4RI1huppIIFP8ySglLr5SUZKrBmdFc1H2u1fAMWtekiilwfANfORkTO3xmGkHVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=764 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270041
X-Proofpoint-GUID: WONIfyuemoTfue9lE2AIkoMfqrOc2wfU
X-Proofpoint-ORIG-GUID: WONIfyuemoTfue9lE2AIkoMfqrOc2wfU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 06:26:54PM -0700, Emily Peri wrote:
> Ternary statements that pick the min of two values can be replaced by
> the built-in min() function. This improves readability, since its quicker
> to understand min(x, y) than x < y ? x : y. Issue found by coccicheck.
> 
> Signed-off-by: Emily Peri <eperi1024@gmail.com>

This breaks the build.  Use min_t(uint, wps_ielen, MAX_WPS_IE_LEN);

regards,
dan carpenter
 
