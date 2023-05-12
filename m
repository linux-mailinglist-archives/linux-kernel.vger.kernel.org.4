Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD670069F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbjELLWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbjELLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:22:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8548E7A97
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD2gX+xy8r9l+4eNQT4mbcOWLrzd60spkzEtRJNzPYmLapYBLgsIl2GEClxqNjbiVsivLbvLfFUTNcOT3DetaICmA0SgcT9hLiRPUe5OPavPG1yDyzLDURT8U3R8k2EXqBXKAZtHiUem8vLaEu1AFFWjW8XV1Q6xhg4VdgZ0mee2VbAGvvReyT7i9fpyRUEBDrKX33RMjGpTGhgpLrzQuWLS6CM1kaLoTTv3SxxU0y8isk1iAWcrT3M+Whgn/+X52hgKmCpk+ABNMGcNnTjtNsRs+fx+2mSiuUfiUpeElOlqBAX6SixIIzx7jtVuDgKFl+1qHGvjR15iC8BqTh5GUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAgnwjSVBklTReuf/eqCoows0/mx+ilLuSZ9EKigBDM=;
 b=iAYWJNtMg/PMuZMnHUDcvFieutqFqOwOtxTUujWKYMSRh5qq01CCRcbsnxlu6HCLmxjNnO/e2Olm/ot2BVZ/eYArMIWqBYNVZAMc3NGLpbM/6vKaJGfyANjatut58xJNYyYR6+kUgp89XVyAM/nEl3QhMT868dLlO49bR8LSBm08ex55i+Z5sqaHJoKLkWSPC87+Ws38+AP/jwSvMJdf28rpVmb4YaWSoB/4DsYdI9aMwkDM60XrTQcvOi2OaeVvUSv6INtkmdC22Lda1Y6DWyvxrTJxpK8cwulNlQfeTHXlXbhyTrpOwfdvF42WcSexFG/arLd1HPCPoqAX6cABNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAgnwjSVBklTReuf/eqCoows0/mx+ilLuSZ9EKigBDM=;
 b=KfK/ykK9dwn9Gq4DstpC/O6ALB1EaztNg3HSuhGzkjQzoS6K2ihPHpsiK1gHc7tr3o942owZPWiBdHop7HLsNiFghwPVWWAzbagNToFNaQViz3QpKYPwiFzfPR+gjSBvA5ku1L9FmLAwefMIbhAypr/r4LXT4dG0sKMYtDKnvvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 11:22:25 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 11:22:25 +0000
Message-ID: <8627aa12-a020-35ac-d954-5a7872957e13@amd.com>
Date:   Fri, 12 May 2023 13:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] firmware: xilinx: Update the zynqmp_pm_fpga_load() API
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>,
        michal.simek@xilinx.com, tanmay.shah@xilinx.com,
        mathieu.poirier@linaro.org, ben.levinsky@amd.com,
        claudiu.beznea@microchip.com, ronak.jain@xilinx.com, marex@denx.de,
        roman.gushchin@linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230503050158.1936467-1-nava.kishore.manne@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230503050158.1936467-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0601CA0032.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::42) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ec01b9-2fc5-4f2b-03d0-08db52db2955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iuKXsj66CVHusW4agy6X2x7kZFVFboJIJFYnnkc6AUEbujcQ+ELunLS7jUoH/CeZWyP+2PW1waPUQIyuX0GRzmbJI8Jz0JWpRiuFfZebVvjo5sk4Y3WrIUT4F4pzwnzrdQTI19SM2li123Z2wJSKKV+8TcWGJPOlgSJxBdlqsdWaEzr3U2PLw2KhZ+Uwge/Y0xAUR8qL72gM2hOVW0seYmENxftFq0Fh4Dqk/UFkyQUzADbPG9PtlF15eSyjLN1wIacaA7zKZbVk8qnRXJHWJ8bJ7d8gUPyaWTafjOsOxnC4dIC8UYc7af2dZX0OMp3/DQKWaIbdk27uzRnXhUMMjVWqxFoy4yPiCNL3jMIQkCJNCWEXZDZPIN3fM6qblU0ic/fQFYQfkmYS3sOvv5WrFdA9pckfG6RU/L94lTw9O/srLu/Rh6TSOyB3eSBPRkN7+uO/8xyoQ11JNGVX/Fv7cx1zKc5JlxoR+nIDQ5qjRk+T9Pngm74/t71h5hqOAGCXzdZ+N8LoHP6N6nvl6t62TgWY6UKDkwNEiDm+BCGGIr3IbcyifEqG6dvw5bQIJfvOeMdHZKfKxQP/FYhdK7H6QiwMMmVt52GIwH/eIHUjdCY3YYKSTUT8ueIpEeHzQFxocI2wzB/sj2+aJrhFCrwLopSrfVlBaz+nAlUVKgN2vQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(921005)(38100700002)(36756003)(86362001)(31696002)(31686004)(6486002)(8936002)(8676002)(44832011)(5660300002)(478600001)(6506007)(6512007)(26005)(186003)(15650500001)(2616005)(2906002)(53546011)(83380400001)(316002)(66946007)(66476007)(66556008)(6666004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z05HLzRpdTFDQmJwK1pSbFRWMHRlMGwwNGl2bTJaT29VUUs2aTFjNm9rbGlT?=
 =?utf-8?B?ajF1OU1LalFoMmhTblE1SlBMdk1EL1ViV1hMK241SnVNbFBoVTJ3WDA2MzEy?=
 =?utf-8?B?N3dUemFWQ3REYnptYXNWR3p0cVpsUmFKNnhTbVE4Ny9pdEpYWVFBQjEwSmJW?=
 =?utf-8?B?QlcvSkNLZEcrNjdTUkl1M1pYMW9WZTZxYnRUNDBOd1V2Q20yUkxHRS92bzY0?=
 =?utf-8?B?STJkVVExdHVVenEvNXpDOTB6MmdSV2l5M0lYVElUNlJwdWd6eVhIWFJXS3Ey?=
 =?utf-8?B?NmZLZWhaVnF2NWUxL3RCUGtXbk5qT3RSakV4N1F3dWdjL2FBV0RKbUFlUlRM?=
 =?utf-8?B?T2xHOFhSbjM1SjVXaUpQZ3ArcEdudnV6THZ1U2xnWGxVVXYvaXR4aityaWxY?=
 =?utf-8?B?c0g5U3FjMHFjZVZGQjBhZFA2QVhnTEx0RzRBQ3FTa2E2NEhMMDZybUJpK3Zp?=
 =?utf-8?B?SHFOWXNtTzE1dEY4UUpqRFZDSGJPeGhyUTZGenF4b0JLQytYby9DWGRvV0xx?=
 =?utf-8?B?dFhkSGsrZzBXRnBiZUE5Qk5jejYrWWlERlBLazVnc2RtZEZwcHh1U3ZDMG9q?=
 =?utf-8?B?N3ZuMHJnVk4rcnUvNkg1Y0d3VXBmYTE0OG5raTlBb1VpSVFUZDJVK1ljL1FH?=
 =?utf-8?B?OEprVTBuRE1SSDRjQ3JxUEFDNFphZ2drQ2ErUEVkUmt4VVFEUHVpN3F1am9r?=
 =?utf-8?B?N2szcmtKT3NzWFl0ZWJ6dG5MVE4xWWNvYU5tMCtCQ3dTdE4zWEVRUzVnRzFN?=
 =?utf-8?B?ZmFvaW16OE5RODM1SXo5QjFEK21UMU10aThNUTdrN3lQV1dHN2JWM095THJv?=
 =?utf-8?B?YzFDNDZZYTlBMXRGekQ4TFRKRVNuVXZtR0djNVk1Z0ZFWWs2YXNpRE9ubklr?=
 =?utf-8?B?aTFMamdsTjFwUEVGT2VGSFVQLzFMVG5oa3g0TXEyaXR2MW44YTJHS0Qvb0Fy?=
 =?utf-8?B?bWpRZDkwaGlOeExSVVplaUJ2eWJ3RnBRNzMrbFhFYUpTNHk1N1k1QW12b0Yz?=
 =?utf-8?B?Rk5QeW9saUpCMkEzQWMzc3BzR0V3eW1hanZjTU5KOGVnRkVRR0Z4UWVFSFkz?=
 =?utf-8?B?cjNkL1diemt3bVdYVDVXV1lWYWJMaldGKzVxUzRwTDdWV05KYnFIOGdVbzRu?=
 =?utf-8?B?b0c2d2FxVWRyd2JGVkdhekhMMlhiR0IzdUR2aDdpVUxQci84QTJzaUt2cnAv?=
 =?utf-8?B?ajZnTEF5WTkrK09zd1duVDFScHY2dWxvTWNlaCtvcHpuajNFVUcyK0tBOGRH?=
 =?utf-8?B?d1pLbHVKZy83ZCs1eWZsWXpYaFF6SDVxY2V4OWpNbEVRMnJCdS9JdUROQk4r?=
 =?utf-8?B?MjlWaVo1TXBDc1J0eDl0bGJaSzBGTmVKYUlwb1NkcjhqYWFEcDB3bjljdVV6?=
 =?utf-8?B?VnFFeld1bnVZMURCUDdmZ2F1TDVQckVmZVk3RDF3SW9KeURINFo5VjhvMnZH?=
 =?utf-8?B?aHlEeHFCUHQzNEcweUlkZ05xb0lvaTdvQVFpby9naEh5cjlqUHVWYmQrMVRG?=
 =?utf-8?B?c2pRMzlTb1lCT1BYSndVYzlzdElDQTVUNktrOFRsbVdMT3NwNVdsMW1kakVk?=
 =?utf-8?B?L01YditBeVZUMkgxR082WThZK05CUVJUY21rMnZyUThObFlOekwwa1pPWnV4?=
 =?utf-8?B?eFhTeWt0WEg1SEZkUkc4cGZvdHdlYXVzdzRGMENLZEJINGpxVVJYREU5UVFB?=
 =?utf-8?B?MWlUWm1CWGpCWnlLa2kwS2pBY3IrWDdlSnd6empzeU5NZzlBNlVJVnpyS0dY?=
 =?utf-8?B?ZE1CZ2Rxb1QzV3RheFlSZmtrc1Vkc2ZCQmJxSnArZUtDelRzbkgyOFFQRDk4?=
 =?utf-8?B?RUxQVERaRXdEeDZKSjAvS1BKZGsrM2hWN3Vta2Rha0dnMG0wWngzQ082RnQw?=
 =?utf-8?B?bmc2OXowYWQyRThwVGNTcE9tVUE4ZmpnUThpR01TQTJHMG1lUmpYT2ttMjZ1?=
 =?utf-8?B?eGRxT1JpRTFhYUdYd055WjdtRUU0YlAxM0FXYVN2ZjUvcWtzR2lLL1BQb2tV?=
 =?utf-8?B?NGpRek1lY3FTMTZaWEtVd1liRmFZVlRlbWRXL1B2SEdVd3R0NHN2eWlWQ0dZ?=
 =?utf-8?B?RC8vbDk2ME44VktoTmZ3eW05dCt6cHRmOGEyQlE0dXhZalQ5bkE3NHZGNE9a?=
 =?utf-8?Q?bcbn0taEZPpBxf2zw8+CQwJPl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ec01b9-2fc5-4f2b-03d0-08db52db2955
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 11:22:25.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7GttJKl/FOj2hJy3VonLMpFs9S1W0YlfCX3XsGQ5aXOkLf6c7PEByCUsAaCOl8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/23 07:01, Nava kishore Manne wrote:
> Update the zynqmp_pm_fpga_load() API to handle the firmware error’s
> properly.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index ce86a1850305..398ab86e2bec 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -942,8 +942,16 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_reset_get_status);
>    */
>   int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
>   {
> -	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
> -				   upper_32_bits(address), size, flags, NULL);
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
> +				  upper_32_bits(address), size, flags,
> +				  ret_payload);
> +	if (ret_payload[0])
> +		return -ret_payload[0];
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);
>   

Applied.
M
