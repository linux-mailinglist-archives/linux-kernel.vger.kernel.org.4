Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410396114BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJ1OiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiJ1OiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:38:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F177169ED1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:37:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNjir030888;
        Fri, 28 Oct 2022 14:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=jo2kogNNGbSVowQpAEA/9F1mKDFnn+i6Cmqgxs7jDnc=;
 b=27jG/CI8/Z/pXW6qZYhoAN0xKz3K00HkYr64zZZ9tw/A+nq9IheaPvQZ720SofFjwyoW
 sGyGk2/XZqKNFRyDoQ2pa8jRuhZ8pjZliIGf52r2jm3OiKerp3ryDOcQ6vWWTCJ03fkv
 koXE+CFg27H1Cldzrz0OuBnYvdN/oHGxdGtNyomVJhkuqagjqI2QY35TtYELsJJ7ftJQ
 CYfyV89UDfnDtNp0sTCe2vICu5uM2DuHvYiEdmCt/VkKUNLURR8xLRoU00nzSqpCmd9q
 G2UBWLdmUMOTNxv0/zUNSe3KhS1haffT+ufHQabYUHmwXR5+1EgKY86nc8XVHShSbSpa 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfays5a8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:36:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBI8Tb009426;
        Fri, 28 Oct 2022 14:36:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagg4g8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2fBTDWwWFllje22j8kGElDelzIGJ6zZiy1P4U8qNYcIPu6fqIljGGVUwOk6wWmrd4k++bDzmZyqxDoAhBlNKrbGsaeqERinHIvpLDo/AyF8QG+B2uoDHE4TPIxgYY6eI2KLc9tLmhVkYmK33DNuUvCykYeIc4T2W3OjXoxoqMlt13i/J3/inI3pyX0csO1/6KfQRFAIC4u0o98u1Jl8bydxeHhl5PGKNmcEuIOvdomjSuc8/Ai4u+YPQq9J73AGRkYeSnZGKbAHZbq5y0cncJGMO2kcyiPHfzsZOxzWHtrXzm0bOfhClZmMMudf3SE61nDI91snmFI0eLtky6aILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo2kogNNGbSVowQpAEA/9F1mKDFnn+i6Cmqgxs7jDnc=;
 b=SMG7HSKC+z6Pr9x/rPX3zpitr3vAbYcS4FFYkG1Mz8guvSgq/x68WR8HINQa+e0ZjxYDDPIxOYyZ38+cZWhb2aGfkeHALj7thRdWhe2YCEvHvQ64N4vHq7d0w+4p5YPi/dqiiOwTQR/g7xPd7JdIBTylf4Ep7kg/fIRLj+yLEzCK0DtcWuWeLKIwaA7HYeLrf3GvpK++/IagmRMQ0YfjVyqJhrfKZEmf8uPIb2nXBGqJEvJP5pjxF0ionI/k+3lMzPmcAXIuC46Sup42ur53oCBD7bRYqYVUcqIKeh/C2E5XjTGB+M0mDGsQTKrlBv52p7thpSKXyrwgq+M0/j4akQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo2kogNNGbSVowQpAEA/9F1mKDFnn+i6Cmqgxs7jDnc=;
 b=lwbfhm6Y0JG7nla3clIUuh2UuAD/YZ+Du4RwQMCC+/v+H5lPbEngeov0cZgHlbH5cXZKFRM2tOVUvIlmSeAGQ6MEMq4x2n7N3D8kmlTD4vUc9tShHQiaTDxcSYW22VPnJmn0wHHeVdFMkMYL1xSey3534BYeH4pavCryuZswSac=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4433.namprd10.prod.outlook.com
 (2603:10b6:303:6e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 14:36:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:36:53 +0000
Date:   Fri, 28 Oct 2022 17:36:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Use flexible-array for one /
 zero-length arrays
Message-ID: <Y1vo+TjS/mWyT7Zc@kadam>
References: <Y1vNNSSWK1EkcohT@ubunlion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vNNSSWK1EkcohT@ubunlion>
X-ClientProxiedBy: JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d19fbc-f3e9-4cf8-343b-08dab8f1dae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7BmIf+wCUuuoV4pO3Sdtvs+wks5vxAJ8jV/Yb8iHGr6NPD6jwt+uQfzv8kLimvHdx9cS7+DOaTNt9ZGZA6s+nCkAwtsf/eIbCtBKeigracA45leSRuMY7WPbCkZhsVtC8oPvE4h3CQMmHFCugBYRf0QNrWCJt942zGjIkMwhZDrUz44GUbLStN8YAA4LWDlUy30bSaM1eapU0WNEH8+Ox1yxGjCRkulp3XFCyCgs6ESRezZbjBWY/Kz1fh9loezhwIYhkR03xoo8BreAWoF0DdIQgTj1MA9xZo+f3pvya30CnwPxoc1i8eLkI8yo4+17jvlNOpYH00t48KXS7tkNWr4J5zYFftBFF4IN2JCIvXQ2VlaRaEKBI3pcPF9pLJS2jjWO6pp9khyPHUF4iaVJIYoGl/hVymweDKVlfxotoAA9B8o9vq5+rALB2xKMJiiVKz3VdXCCCIvONU5G1CsxrQTWbRonvQMOEHnKTbxElHbKNLuw38+c5D558V67uUsfmphpF+bDGSEZQKTMrnaQoOscOAQpSWaJt8k6jWR4iSlo0UZGJGipmAbPDQj8vDl5i+Uzn7YO8wpGw1NwdiKissZo07uX6wF79eTYforyl6lDueUMWbCBq/kbpVpDzNQynrMs1KpkZ0UcDTQ4MfzVJ+5ogkIoTFqUGTskeSa7wM5Jm7INm6Wpscjlznvzo2c+Ri+P6rKMSLXnNnBjjeNAo4mgWMbQKDIa0A2n0BikHt57X9v1upZJ4PO2K/R6SwGHqoCZU/O2Cr9/W27ATyO4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(41300700001)(6916009)(44832011)(316002)(33716001)(66476007)(66556008)(8936002)(66946007)(8676002)(5660300002)(4326008)(38100700002)(6506007)(6666004)(9686003)(6512007)(26005)(6486002)(2906002)(83380400001)(86362001)(966005)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBUZSanIMSwDpmW8+EWfab2F0MusBThL9qtDuxXrRAWMmcI0aSwoIATy2DGk?=
 =?us-ascii?Q?EqMzX7+cO/kbZdrStuCyAGJGJbqyEYw5RzzAhKLn9/tjbOb9A6LXIObA/+q0?=
 =?us-ascii?Q?RKn5gBK/dRVC2tDCa4epnw9fjSiHtoc7eIxzfgbnFNTR4KExrnHFy0CQndwD?=
 =?us-ascii?Q?2KWhc9nXG96FOQN6If8zI1mYlnoZ+C0SAL0KEMH7qFD2KPHEHX+dGk2QzO62?=
 =?us-ascii?Q?8iaAX8ldPiQSvLZLFwgfldY2JuQY/xOfm6m/SFlN3lfEYzMhPpOJdyecdWm8?=
 =?us-ascii?Q?fjNGlBDkudOIHsIsWX/rFj2wXXx1wmMzAv6weKr4nfy8wKWezWFIsXgejshj?=
 =?us-ascii?Q?6RuqtFF2KeLCMzgjQmThVey7B4JAlSc5VkLJ1CllbKrNCbTe9XGdM78emtrp?=
 =?us-ascii?Q?TEub9O2zCZwOCQ5SqAEV5nl+BRvqYG8rAIM+2AYYGodEBSUdLajFf7A1McZS?=
 =?us-ascii?Q?e+JPJ5yU6yBxcioOYQcb3Xk0vD2+Pku3GgdJPSpMBMCx81Bp8hIDY/MB5MLW?=
 =?us-ascii?Q?OH1yaA+5598OrlBC260nUWyyS2O7EfUQirmOYU2JclLa2UtI9VjHHCHz2VJ7?=
 =?us-ascii?Q?F+EOhK3jqDTwfu2ilGWXl3lxpiThgglEz1y7KbigQqw0m1Q5WDATj8EOTnHT?=
 =?us-ascii?Q?jwxCdPn3Z0WJgl/X852SjvE2rGCEP2Y7pXoOCNMyoXcILhgc8G4RZY0LIF1P?=
 =?us-ascii?Q?KvdN/Q+PJKXD32xvVFHN4F6dKbd+R0BHWZfOUtQ7mRxexgxDZsAHAWV2WiWB?=
 =?us-ascii?Q?xWxXrgo6CGcnNmaeICfPZp8wXLIKBMgstMwlih9CinMO2PP3M9JriHfH75VL?=
 =?us-ascii?Q?cVCIr0VvAqwykx5PPgLVPJhB0bLC04crj90HSOvYXV2LViHBKQBCO+a9wkGJ?=
 =?us-ascii?Q?jKxaVBLR38czivSmj0rBtzlsXNirNfvAt57mVO+VnImjTMgWdWWB8WaxPJK0?=
 =?us-ascii?Q?ckJcQNaHnP4CJ5JEVXec59WDfW8qka5eJ37YF8TtC6rIJkdp9wDam1kbsK6D?=
 =?us-ascii?Q?skL9AiSgcAODvkKf3UWx6TLi5+asNKY3hVO14+noH+cSYPlUY04mpPW3Dl4U?=
 =?us-ascii?Q?6bZ3j5PSuabieHRs31/r1GgmkXNVsr1l3AMREDCtbQxzY94Zhc8txCakxHte?=
 =?us-ascii?Q?cgVnKW3VmMQtaX/SqTR1mFjlo1Ma7YK4OJ5x3jkCk0J+iHhDfExvu6VPoi9T?=
 =?us-ascii?Q?08JDLCkL0KGwsCmVJu7hypRlt9AG90D+CrK+xiUKWEJ7BwtGnRPg1ZcXgChP?=
 =?us-ascii?Q?kB+/NBA+eaxmnaamgBe7ZGXKpPUjv2dcEwtX9KbWLHYlGnWSFATdP2QFEGgy?=
 =?us-ascii?Q?MamcmL8/7J52pC4vGvXoa1a2eIRgDhToy8pdtGs1Pswx/dnmBZ9aDa7zSUE2?=
 =?us-ascii?Q?XLkndlreGEdZLM6DzXG7f4ymvtqTnUKz6efzyjoRz7hoG7UQdNjjmqdVfDW8?=
 =?us-ascii?Q?e4ZjuyuepYqNxueIP9/N02Zm9JPUzJpnr7Nedk94Utmi8s2xDeSSU9DBFqV8?=
 =?us-ascii?Q?lSkqPRFzNsGFyOnV3w75fuZlYRC28XsIioMWtslfuVVsmAlej5RmOv1t7yrJ?=
 =?us-ascii?Q?xbx+hE5kR4TjtiMB78T9/6zEAOyQJU/gLCU0tpRbifOkzrphhmdHQ86eOA0x?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d19fbc-f3e9-4cf8-343b-08dab8f1dae7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:36:53.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqaP5eAIQzpzQggkeUvCooWZ/r8GGOYkpc77oKy7zQV3OJ3UbXMMi6UVHcVkwHSxoYaiGm29XwWIBYAbDAF53aUYrzHgw8zrkdNoWBn5ub4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280090
X-Proofpoint-ORIG-GUID: pHHjLXnquOkTfvBrH4NPD6LY99t5ZJhC
X-Proofpoint-GUID: pHHjLXnquOkTfvBrH4NPD6LY99t5ZJhC
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
>  } __packed;

When you're writing this change look at where struct wlan_ie_ssid is
used.  It's included in five different structs:

	struct wlan_ie_ssid *ssid;

But none of those *ssid pointers are used.  So instead of doing this
just delete the wlan_ie_ssid struct and delete every reference to it.
Send that as a patch by itself and then repeat that process for the next
struct.

regards,
dan carpenter

