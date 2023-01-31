Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF8D6836DA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAaTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjAaTvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:51:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6D7582AD;
        Tue, 31 Jan 2023 11:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzrGNqBFSDdJYaX4sPlCiBD0tlSmc/n0fAtaOVdoE6yEaQgkeCsaEk6gGmF8ZgM5SkTK20crK2MznzY1XCrIA7hUvs1TdJsVhBdG3grjQRhv+UIYfTPLdbml1gk+GB1Rlt+0QvK4OzHdU3rufj2jMd5FRWtstGoGIrMyu4xa1Z4qve92FIR5+0iySITHizYCYmrF/pNNeVegClvJWwCvpaAdDIHp85ffxCrHAmu+nXRONBOu5SA4RzNYUryFl2zvmzKzJekcGUrp78EoCebfQWZE/a2NzdXmd5K6tMuaSA7LRrRbQLmwd2LRauQKWM+CyCacPQt2GxmgIUlfjvPnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsBLt49to03+LfKi3hOjVpobNNYmqhwlGpQwPby0G6E=;
 b=Upz+OaZsc2nacWERb4YHTbgAYjdaVurte109xGLOMfOYzEjpQ9MI4Wmsiu5l3zKwzoZiUF9+ZWjin7fV/GuLVCA746HmwPHgxaYXrDT4KG17uSksJPwbkRcwKhVmJ6Z0t2RiO3Et844SxAkDWVRxhn6v4uLudsTE8mKprCyOvkdhPzY+FjxmQMBNyWD6VFf3vxpm9B8hCjscFyHXmUHuxmaGhcpJSXyX3GoEgJoYn3NCo1lMwxdoKhP+PFjnOmVnSZr5MsrwA3YQbBvPaLISEUGFGZGOixs9byhuP2xeF17T4Bj2O9e7DFsGQ9DIkPvZAygDy8rqsXwG78tB1iCRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsBLt49to03+LfKi3hOjVpobNNYmqhwlGpQwPby0G6E=;
 b=kiaDnspRWtx4ny+35g3+K3t/o60iRXdd1njbYaUPeH9Avi7QfbmoUAcwbfimLnUiW2jNMOwEibwUEWomxcw/eZSRpvse/cZIfF9O1FiFkXQubJ5p4R9wOLsH20MMuhlk7Ae9oLgdX5Uz4yNxT68484NmluGEi/KeXaob/e5vhKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 19:51:08 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 19:51:08 +0000
Message-ID: <272a68e1-ca89-ff30-81e3-79dfcf211615@amd.com>
Date:   Tue, 31 Jan 2023 13:51:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 5/8] crypto: cpp - Bind to psp platform device on x86
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-6-jpiotrowski@linux.microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230123152250.26413-6-jpiotrowski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 693480e8-123c-4d18-4bab-08db03c47ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxar/Hn5rCfxNSna9DXhpm+H4FCX8mUM0V5iFfRrnAlXc8v/+8wvrB92VXWyn5q/axD1Trt5xteP+o8peaS9TLC5AaYARaheepMG2MM7GrlbanxkPf+VDTFNOssFCjzvZpVdPYVn16EpUctFfCUgS9fu7pYeyU164N+0zJZW9ViPqESlVI3YXTDgl0d/BY/CODPfDZiUjPDnCp9aSP7zHAgxKN+T8UAUXClRS80AZ3oKgFUL3iWDqv9gBfDrLj/GLCSw8xIV4G1L2VvJplT8iRjlVv81h5M8oPAPHtRQTzmPKQvycWzdViotA/kqBUMAkFDRwa2KV1yb/hYt5DWQuchZULu3T+9xtCnoqOzKTjhlHZuqGI8uN+kwmVY5aXHYMx8tq1jYzhmMh63lfv9iLfmgEuWG2IMLVw0TKe39nxbHoljuLARwT1mR4EEHrEk3NsX7d7ILwzzLQPmcrfxx0mw4+jG9QfqXUXPTRXWZ/IDq4y9HwYZiXSrtnU3HWDPIrKhKIbDtsARwyY02IQh4/yETXOW00fInwtkbUsimsi53T7A++nFFT4e2U0v5FLyOXXc5YTER8TJjbKhYLZ8dxHT7arfVq21NSA6MxCNKoZ3JKRGHux6plmlLC1SwWi+OTN44m4AIZU8HcNwrIvhZIgFtyp0/eWt2enpr8kLScwjhCCq+zk+W4ulQEx1X0GzU2EXLH/bXCD5nixZXNdgP6Ad+1NT9zKTdSToxCJInFWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(8676002)(54906003)(316002)(66476007)(478600001)(6486002)(2906002)(8936002)(41300700001)(4326008)(66946007)(5660300002)(66556008)(31686004)(86362001)(38100700002)(36756003)(31696002)(26005)(6512007)(186003)(2616005)(83380400001)(6666004)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVLU1dGUE02MlRJdVhPcWNaenFuNVpXQ3R1eFM5cTVjSlZyUExqa3RndXZV?=
 =?utf-8?B?ZTRKOG55TCtocnFHais5N01jUVVneUlQZnBhaldNZ3U3b1RNY21uMFFBSWV4?=
 =?utf-8?B?MU5GcE9QNmxSUWdFOGlveVZ3M0ZIWlZJMWlBQUsvV09vN04vOTl4bjFablRk?=
 =?utf-8?B?Y1ZqTktWZ2hRekJSZktVdmNHQWxSaFQxVCs3anhtMVBxcUpJM0VaMlVMQWMv?=
 =?utf-8?B?eU5DTGkvMWRwTlpDd3VzeXFzdjFyNHdxU1RKaWhJZTBSK3loUFNKV0dNV0Fo?=
 =?utf-8?B?bDlnUGttVlllbzFLdkQ5UzFuZGJNUCtnL0dOVUh5aXFoZFdmNE1jK0p1cndL?=
 =?utf-8?B?bVA2N3VodXhLYXZXSWk2amF2eFBIV05MeHVZekU4eEwxcnFoZjBtUGJacDlz?=
 =?utf-8?B?NUtGQlZ1YUJzdk9WUUE0a1JKZkxlNFcvZDFXYitsbGtkNGQrNGNuSWl6aHVt?=
 =?utf-8?B?VmV5aGFOdVFjSno1TkJlaXVJTWhERDVZbno2K1RVTjlMTVJMUG9mUVdIZ1hu?=
 =?utf-8?B?V0JFdjFuVER2eEY2S0JDY1dvclBTZllxbVdKSWpPenlWL1E5VXNJN1hyZWNw?=
 =?utf-8?B?T09jRU1wbldBQ2M3b2RDMkt6Qyt4Z0JxcHZBNXFrVVRNQTJLZVBkeGw0TlNu?=
 =?utf-8?B?eVpNN0oxeXgvNkNBWG9lTjBTMVlVZGZ3YUJzNEZyQWNzU0U5K2lqYlhCK0Y3?=
 =?utf-8?B?YlRMcUdDV2U4djZINUI0NjFENlhCY0JkOGF6N3h5QWFDUEcrOUhpa2k1U1ov?=
 =?utf-8?B?WWYrUDhMc2MrK0htZjhiL1o2OUVDNCtBcFBERVl0UkN0UmNaZjlsUDAxWkhi?=
 =?utf-8?B?bmI0engxZ2E5WWtDWHkvcSticExXUkFqZXV2Z0NTRDV4N0RCYWNIQmt6THh3?=
 =?utf-8?B?S2V5UWF0TUt4a2k5cjFlTU9WKzNWUGJ6MUJTbjJ2NTI0ZUZzUTNOV09iM2tl?=
 =?utf-8?B?ek5ZN0JxUlpIVUgyZCtBUG4xTFJ3ZmNQZmlPWGRQVTVpKzYwY1o4QjRnRkxQ?=
 =?utf-8?B?OWpjZVdlK2Z4RFBid3BhM2xiK1c3Rkg1K2JRNFlzMDBSdHh3KytZYmdXYjUw?=
 =?utf-8?B?azd1RWNEU24wbG5XaFh3SG9vQXVxVWpVUDFqWDF5R2VndHFSSCtScnh4MGlC?=
 =?utf-8?B?RDhBRTJ1NkEyQkZJNkt1RzZydisyVlZJZExUMmFmSEtYZi9Cd2xBMmM3Yi9z?=
 =?utf-8?B?NFROd0V6K3V3SHJqaERrRzI1VHhyRG03ZU51Z01mQzJDckV6SGNWNDZiaGF4?=
 =?utf-8?B?SXQzR1ZYMXU2QjhGbWcrVHpaRVR1VWgzNG9yQTVTRGdMWUkyMFRudU9BVlQ1?=
 =?utf-8?B?OStaR09pLzdPYllKTjdEa2VubUVHd0MvN3FISm92dndqQ1E3ZWVnWG8rMkN0?=
 =?utf-8?B?VWt4OGNXM09BY1Z2bCtRL28xM1RaY0FUamNvR0dQNWx1WGR5R2NmZitaOHVI?=
 =?utf-8?B?c1p6N0VOQmRaZWE3dGVxczkyLzMwSFhqSGsvbWgwZFJkcTV5ZHhld2ZKdXBM?=
 =?utf-8?B?cXhQM0dCOGdlV1hVVmJkZDVBcGdmaHd5RkU1ZlorTGxuWUJpMHRGVkYxekhW?=
 =?utf-8?B?dE1mSFNkOFdHVVRuODlubHVERStna0d5OHRvNkc1VHczSzhPTW54RFB6STk4?=
 =?utf-8?B?VXNlV1FXcVQyMDJFZUR6RnczeVRTRGtyKysvRFNEbjJpVWQremVOZWE5bDJQ?=
 =?utf-8?B?WEx3emR1c3ZBdlQ4MXZwMk91L2hPWmFuS29mT1huU2VvNktEbGZNSktCQ3lM?=
 =?utf-8?B?L1FHTDZlckF5d2tiS2JYeHJPdTIvbnh1MW5Ra2JINWRZdGNLLzZvUzhwR0pa?=
 =?utf-8?B?V0dtY2Ftdzl1WmU3V0NDcEg4QVFsSFRib0xXS3QwMHRLS25mTmFjMmpCdSts?=
 =?utf-8?B?RERHblJRakg4RWxBRzlLeWJveTVzcFlmVDMwUFBOMWhWbDFnM0FheEk5NlZn?=
 =?utf-8?B?Q0ZTUnpnMlBtRDU0SHh5aThwSzJWSmgzMWxmOThTc3VJM092VXV0SFppWTlX?=
 =?utf-8?B?TVBUb3NyRVd3RDFMYnFkd2M1YVAwWEdMb3FzKzd4NHI5WWNBaHFPbWVaWXNp?=
 =?utf-8?B?RGZkS3R3WllLNi8yYTBHbExBeHpja0lFZ2FyWFRMakdHc3RpZFN2VC9kTkFh?=
 =?utf-8?Q?nfNSadEIcMXGCd+IlptENko2h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693480e8-123c-4d18-4bab-08db03c47ed3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 19:51:08.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR1c/2Sj1HG+utGBg7157CY7ix9jeNlbsennjz3zw2IqJyGVu/TpvFeucUZ6jIFI6OEf4T9qUoiyBXz73Bfbkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 09:22, Jeremi Piotrowski wrote:
> The PSP in Hyper-V VMs is exposed through the ASP ACPI table and is
> represented as a platform_device. Allow the ccp driver to bind to it by
> adding an id_table and initing the platform_driver also on x86. At this
> point probe is called for the psp device but init fails due to missing
> driver data.
> 
> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
> ---
>   drivers/crypto/ccp/sp-dev.c      | 8 ++++++--
>   drivers/crypto/ccp/sp-platform.c | 7 +++++++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
> index 7eb3e4668286..52b8d957d0f6 100644
> --- a/drivers/crypto/ccp/sp-dev.c
> +++ b/drivers/crypto/ccp/sp-dev.c
> @@ -258,7 +258,11 @@ static int __init sp_mod_init(void)
>   	ret = sp_pci_init();
>   	if (ret)
>   		return ret;
> -
Please keep the blank line here.

> +	ret = sp_platform_init();
> +	if (ret) {
> +		sp_pci_exit();
> +		return ret;
> +	}

Add a blank line here.

>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>   	psp_pci_init();
>   #endif
> @@ -286,7 +290,7 @@ static void __exit sp_mod_exit(void)
>   #ifdef CONFIG_CRYPTO_DEV_SP_PSP
>   	psp_pci_exit();
>   #endif
> -

Please keep the blank line here.

> +	sp_platform_exit(); >   	sp_pci_exit();
>   #endif
>   
> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
> index 7d79a8744f9a..ea8926e87981 100644
> --- a/drivers/crypto/ccp/sp-platform.c
> +++ b/drivers/crypto/ccp/sp-platform.c
> @@ -56,6 +56,12 @@ static const struct of_device_id sp_of_match[] = {
>   MODULE_DEVICE_TABLE(of, sp_of_match);
>   #endif
>   
> +static const struct platform_device_id sp_plat_match[] = {

s/plat/platform/

Thanks,
Tom

> +	{ "psp" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, sp_plat_match);
> +
>   static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
>   {
>   #ifdef CONFIG_OF
> @@ -212,6 +218,7 @@ static int sp_platform_resume(struct platform_device *pdev)
>   #endif
>   
>   static struct platform_driver sp_platform_driver = {
> +	.id_table = sp_plat_match,
>   	.driver = {
>   		.name = "ccp",
>   #ifdef CONFIG_ACPI
