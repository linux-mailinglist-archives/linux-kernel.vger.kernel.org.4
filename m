Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2AA6112E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJ1Neh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiJ1Ne2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:34:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E007673
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:34:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNfUe011185;
        Fri, 28 Oct 2022 13:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=HugjZH2KFuMK7dRfEHlUOELvbVdB9lVfiXHI7gJGaeY=;
 b=tI6lARP6EFsFmLzr4XJ+9/XM86ajGvzme6G7l558YawBTUYBnYJeSmYA4kpRF1l1B8gq
 uP7vWeM7gBuNWVh1RLkcuWPk3kTVOrddReQWbUYW8hFOxFvtIqqXaPQPyYnYTme1egy/
 6B4F8tIZn/X+TsX5j/wJJaMiIg6batAIdiGC+2nS1+7JNccjRkoFrH7SDCP+qwAyu+TQ
 XWshx/34hOOu7jwolbLuZw7I2AEDNVNDjXaqqcZN6/a7KukHNaFGk29I8H1iDiT1qWpu
 Uhzih66LAP+AEQ1mPxh8otG5hlPNUWmwpjVwSaOIEYnknuJyo+6n1QfXnGHStJsW8FYw TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahedb13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 13:34:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBPL7L009654;
        Fri, 28 Oct 2022 13:34:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagg2trn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 13:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mpb6AdLaHmxmMuIf9LsikdJg/JQnaHrpU4gLYmuopjSfVWa75QBAWAFaCO5s012ZqE/SZu8nynvfCDi47WTerL61aQo1YfEeHdfjYsYL1w6VWE35zKPdUo1azCEqh/YaTb3ERpguiVRkwPh1A+Q8d5LN/KwDlfwby2wHd7NLjaGd6WDurSuBT/flEz7atyDxKQCA78iO1REF39gs8pIxhwdz8+1n45saA1yeUEG1Xi6CpAu8/7wPPzZ21ayTIP3qQ9D66UPvxXbg+5ovYLBTvvKfeXKQ0d8am0/rgIVIFwKF2vtR4d4mr0MypkPHykyJV2fw3Rde26Lgt2js98b0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HugjZH2KFuMK7dRfEHlUOELvbVdB9lVfiXHI7gJGaeY=;
 b=XJzE+WThTi9bfKZDH8MhgMgiKn6F9ZFUdLCP0FwYDnHn4VejPirDUcYxNbxmiEgB1j7xEK/YhfN6rWx3deJMj0q7AyukSmOkbLE/8Ojf+bp+/H8EXNlhcOyz2xf47RsUtXihpTT+RTRRa27LLjbiZJg6QQ5/toQ8bOirX/oriqPpXVUpwjfMgMq5hgvn1SyrSD2Dt7CPWMZQ8Bc5mDDpCJFBlYrBsCmFQiWChPopdx/pe/BF1EEyTMZ2gUkjxaLKVyBy6/7QS1EMh1LX0+PSO/AZ6hN5SGZt2/3DGpVaM2InT8xlYciGt/St2zC/I0SqTYRhF63+b6YgZ03cVNIs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HugjZH2KFuMK7dRfEHlUOELvbVdB9lVfiXHI7gJGaeY=;
 b=p3jtYT5DLAg9bJOD9VoRZLZ1TTTOT45oDnW15bWT7TwBfVUSJGIX8TS7+54diTVnqSsx5VMIAAvPnupXzg72jCeAFtq9n1oH8lE3QbLn1Rnxk/wdkLTYLYP9laPPPtw/nqJf+VONQJeVGSq0Ip1pPZ7h5ErDt1mO6T02sp7ScuY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6356.namprd10.prod.outlook.com
 (2603:10b6:510:1b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 13:34:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 13:34:11 +0000
Date:   Fri, 28 Oct 2022 16:33:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Use flexible-array for one /
 zero-length arrays
Message-ID: <Y1vaR0olLH9+bJbk@kadam>
References: <Y1vNNSSWK1EkcohT@ubunlion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vNNSSWK1EkcohT@ubunlion>
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH7PR10MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1d71db-cb4a-404d-55d6-08dab8e918b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07bp+BpDUkLMZX+GcgCXudTJwK3tJz/xwcGHRVlg8lD1oDTEzXu/EzgFVmcak53yhkcEYu3C5MeBJb79Jv/wYaFOeQjinrpeGEQOjkKfrbYy+WnFNYYX96/pMfXHXTcZ2kylapXnXhwTUssMRBoym/mQF0np8V4NQg3PGdSYMLEbbBAL+fQn+sn9NyWbTQeuyAAJAw/x4xJbIy6sjTyRYgh9Z8EwoNw+vnZ1UgQWXLMUWrVGfrGla7WHErya0n/HIb6dv21LsNK+eRQyz1JNDhaIPS0bSy2uIbzdjkKNP+iHh+m5Ghojd70x8Ze59e4bCkkKBvbjKTBQt5hGPFsJOt9eNFPo2fSRNUYVtjhkSG6yfFIlzId6sCB7GZvhaC3dFB1+G4Ug3Blfe427fI8VwzKzUFRV9rn/+W87t9pvLCUUSAaLN6lnDVKazmvGyZ+4z7+QBg7TkUt03OGQ3mEEq1WgpqqvAnpadZ1ooumBQHW/3L0E5kuh9QplggI6KItAV9EDdMax5Y8DOxTs6mbLRQBhwLbVkj1FCZwY5s2+JsNOWv7GsBub8tN3xfTlWWfQodf8B7bAkukdNRnm4IGtd+L/L+foant7rlSvOVE4lIkU0s9ImGLEsHwEGH+Ri98fu/KtWi1HeBtALFgVQ0Nr0FHwdil2WkefiZ9SIlBDje7rI7H97mhsVE9N/qc3aBJj/mmm2KH7JKAQexWlK/3BYfzPS9BB1XOIccT8KETsI5LzYajigdWtj8vu+p+rLC7qyMl4gFfANlP5imtvN+FbVcWiaTI2T+8qIbu2wLAm0K8DVTafkznTjpVs0jo/7Wvk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(186003)(26005)(33716001)(9686003)(83380400001)(6506007)(44832011)(6666004)(41300700001)(8676002)(66556008)(66946007)(2906002)(6916009)(6512007)(478600001)(66476007)(8936002)(316002)(5660300002)(86362001)(4326008)(6486002)(966005)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O2kJgGImfIWJOYXMfXdiKpHdUGTRxJwE+OTuhD6eeI7pLvGBIfJrNqQ2sKGF?=
 =?us-ascii?Q?TQ5BHW2S4mGdYchQDo0wL9t5fN40bau80HpLiye6P37zEjjIPiN/Cvb0lhKB?=
 =?us-ascii?Q?dtVfhaNqxzE6c4id/kRb10l/cnTmeI7lJmAabXQMJBl0ARVuMqHU5QTHBnNz?=
 =?us-ascii?Q?vIL5rxVuyE4uHBzPuQwL73+aayA9nPPyVgLDhwAIxOnmq9XtP9PTHQyeFT2I?=
 =?us-ascii?Q?tWAqqjoTaNgdPp5tyJ2ZomUeO6lx7s7+nAS0jTbkzAlaADMUtOd9UTlZB0Xs?=
 =?us-ascii?Q?Gg4Bt50wClstyuFdgJIBhRFU7ajczUe6Md7jY8yPYuTAztG406MQmbU6FaWp?=
 =?us-ascii?Q?8SpkmZsOv+a5+A7KozNj64UTwIFc7xzO5cS3JyK5MuJ2jG/U87GBroycssE6?=
 =?us-ascii?Q?x4crAaj+EoBgqlvmHwJ47SbNWgvKaIuBPIvSkJr4EtrHwIRpG2nmav5ZcA54?=
 =?us-ascii?Q?aEAFk9GH5aL5njOo/OBIFSNP9uZevWar6MCuJfajR0zg2cERR7+WO5e3RvOU?=
 =?us-ascii?Q?u7rglz1neWFWw+buf2q5l2gxMo42haeVymMD3xJkHp7aiZrDnXnfOtUI5P2+?=
 =?us-ascii?Q?oYM/yROk2vyx7BOUe8fh8DCRKy1RvM/mU2vNtRRdqGz6+47D/CijlKLdMTkD?=
 =?us-ascii?Q?aDlr3mroljVz+n26KPue4Ljz8wWOdqbdBQim4j0mXQgA0AoFaeEFf6F1wfMR?=
 =?us-ascii?Q?Pwz1+8QDjw8dp+k2y9rAg4+ejPp5PvKZX7kKDBRYRDUvAFu/wwb1NsZ1JfkP?=
 =?us-ascii?Q?J/3q6iQefI4nZ8j8sXE6ij06LgPZkpEmoBTFnDUT6PhbbLKP13sDEexAeJlC?=
 =?us-ascii?Q?jsi2PJg9vEWFJHZ5Q/G5sEiW2mEL5sxIXx5qGlpuOm/c5EzrX6ljwkrd4/Dw?=
 =?us-ascii?Q?xvAvWDBUNJDhs+VuZAb8D2+dS7/Ioc8MeDwlbrQyFD3qVJ98fM0zbSSHDd3s?=
 =?us-ascii?Q?JJjFy4v+HzX7YKXmp9ZwogI0d2+jHoYEkxssCFRRrDttyFHtEKBJJ3jkKOyD?=
 =?us-ascii?Q?YHqOASDGITlQHxazrBtfoO4xwvSW+5iPEGLpk5zz2w9iWhqOsQ3ZYO44vQta?=
 =?us-ascii?Q?+QrPFsrm7V9YO4KpyHXk3lDVaJG2Fi0cKkguQ0wmfQdpIZCFaBOCca8/iPaC?=
 =?us-ascii?Q?n7OifIV9GRRh6R//c9BR9xnXZqOFQi2S+yzVzVaSLGd6eslb3Jxb4+VKLXF1?=
 =?us-ascii?Q?ZfBh7wyHRpabsbzlG3UrHSiqUYP63n+Bu9I5oUR+3Ar8/iznv/gqvUT9TV84?=
 =?us-ascii?Q?9CeIDjf2ywdzPQmKCrZGSIr168Zoxu+5ijCq1NfjLK9zfVbXjAWqUdpRsflI?=
 =?us-ascii?Q?HQ/lNnmJHjyZj0dNP3qdghm6fThdadiNFmKWZLSAbUm2j8sHzLuyPN0pOWe/?=
 =?us-ascii?Q?IcihnqABRTczLjc1Z4bzRB0DI107ucIlVGAzyCvIOimkD8sj677k4QlhriDu?=
 =?us-ascii?Q?Pze5v+uefZhYhd3BKXIy+aTVyBTPgs2iM1X6hMd1MVivwlZ2doaX4rKLB3SO?=
 =?us-ascii?Q?W4/WZ5vRVNsQ0nn0HLh3Kg8Dvm4xVgVBVmXaS2Obg+hIluFFIVFpAdHKNKe3?=
 =?us-ascii?Q?pCKPTwjpqFsxrmeW4qFMi1D8Co98S5wize6PrZbgEZsndg96gEpQv1tn/w/l?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1d71db-cb4a-404d-55d6-08dab8e918b0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 13:34:11.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+nwIaUG4Gy3P1kk8jyXGNgsjDMAd8+8ALZlPNcmq9JjWraHDfwIIrCT2uFa2EgI5XR6k1TKE/XP1DnvPCsLShq1LVqawrRLdcEhS9OGVlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280084
X-Proofpoint-GUID: n_lpvYdYVvdzTNA5Fje7i_yC_emyD_49
X-Proofpoint-ORIG-GUID: n_lpvYdYVvdzTNA5Fje7i_yC_emyD_49
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:08:13PM +0530, Deepak R Varma wrote:
> Flexible-array member should be used instead of one or zero member to
> meet the need for having a dynamically sized trailing elements in a
> structure. Refer to links [1] and [2] for detailed guidance on this
> suggestion.
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Issue identified using coccicheck.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/wlan-ng/p80211mgmt.h  | 8 ++++----
>  drivers/staging/wlan-ng/p80211types.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
> index 1ef30d3f3159..d6fe52de2c8f 100644
> --- a/drivers/staging/wlan-ng/p80211mgmt.h
> +++ b/drivers/staging/wlan-ng/p80211mgmt.h
> @@ -229,14 +229,14 @@ struct wlan_ie {
>  struct wlan_ie_ssid {
>  	u8 eid;
>  	u8 len;
> -	u8 ssid[1];		/* may be zero, ptrs may overlap */
> +	u8 ssid[];		/* may be zero, ptrs may overlap */

How have you ensured that changing this from a 1 byte array to a zero
byte array does not break anything?  It's not uncommon for a people
to do math like "size - 1 + length".  The "- 1" would be to take the
1 element into consideration.

I was trying to read through this code to check your work, but then
you sent a second patch which also does not explain how you are auditing
your changes.  Can you go a bit slower?

regards,
dan carpenter

