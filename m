Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF096D3834
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjDBOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBOEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:04:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5BEFF35;
        Sun,  2 Apr 2023 07:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhI/b+OJjgv3jE0mL1M6CJ28r8GTPAFuSQXBrb1KVj2hUqV5MqRQsZ81STR1UJ3F/oGP9dA3vTxlr0lSOo45BRkJyBWtJJFuGu0xDnsVsu/CuIIZ4SPS94rZv1PlcOq0fRoVTrP4xtR4o1PCvIICtKwFaBkTi/3rGS+wlhNRws2fohtlOMukFTqC+Y6gZMuKSJo07lWsq97/T5vlYPSqIzhrJS+/7YjsHIkrd5V8iQYmYcc/sX6rpGvvmsebiquacmOt1cilCZN+3tDmzHjjXc0JMdjsC6mlq5C/NOk1kgtAtAx+66Kzzs/04lJlrxFlZbkz/RtB331786lDwV7YVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXERaR9NfDYZniXs8nyWpaI5FMn7a06YCyhK9HSHQc4=;
 b=iIqsKDiMEFT4pb9cVU9mJlH8I7hPDR/GYPyxY+CftFf2ImFYAqxa6crkZXjrnpfjOXOUl1c0m7lRb20AuG8FsqP61Qn2vXEziCIemh0A0hpwCFQNRYMsWMbPxIuRC68DTmOi/bptW19Pu6eLTB2TCN2NBDGOS33JMi9rP77iu+ctUgIyx5UtVp+zsZJJIF3FTj0mdSFlPPGQkcK5iPOk4Rdh8W6d4WT9GN3ZhnQYJnQtn1CKIXpmdvyS5gzkjsw7o6q3/DHajTpUgRvs4jjbYGb++FlYpWFdf5XWnPOmw84DDq7BMSzzdYNve90ezakh1VeouI+/f9gdMF4TbUmvvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXERaR9NfDYZniXs8nyWpaI5FMn7a06YCyhK9HSHQc4=;
 b=ef3trcgkgxweySyP60cgzITWtCBdFXJd6NsC5WG+DStVfwvTLVEL4rB/eJ/ggr3nNZ8PUhEyMSo8C2cd9KpYdDujfvwV9jIxdmQmX6eNArWso7zm5s+/YZGAtkfvdH1ooaEP930FKuEOVK7CtUJ8tRkAzaGK2UJ/PtXFvoltgRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Sun, 2 Apr
 2023 14:04:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Sun, 2 Apr 2023
 14:04:32 +0000
Message-ID: <f2bbd848-2079-d5cb-6a59-9040708dc429@amd.com>
Date:   Sun, 2 Apr 2023 09:04:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] platform/x86: think-lmi: Fix memory leaks when
 parsing ThinkStation WMI strings
Content-Language: en-US
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     hdegoede@redhat.com, markgross@kernel.org, W_Armin@gmx.de,
        mirsad.todorovac@alu.unizg.hr, linux@weissschuh.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:806:23::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2b2181-d749-47e1-e121-08db33832e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5M8JTU3do+8Xox/b3itHs7ni9RGUP+yVCoCr+TRvh3RVZgiVDD1Vju/3cE+aYZlQ2aPGHnHCi2nnWOJF3gny4lUCTbUfs0K1x0gMXTyQvkdRrYTXHzCg+aZozARKSPjlX+soZZjrnU1DMzKdvtVkwG4WGFZpMHYof/Y7Re+1iq6pXlrMSzozfOMGRlAGdeWFmMbssYpKcLuw02VgRuTYTvV65gG+oX1Ife8zHQvRufpJ7RoBBk8bJZrf9bg4m+vaiY+0cubHTRPYQQda5UzVzYKIVYbjIHB0uuh/POumiTamFEHtW8S6AB6p/OeQ9LN9xvktya+/vvwrUqjpnrpzYQ6Y8H6GZUddIcJoqHitnh8mLQZ3h8hoFR/OjOFrmOGr/iaFOLm/XmQcDqqnXvkEqsM7HW3l+ZG8z34h34964ZYWlDuTI0+0RWYbuNLRkNbVz4wNSniQfA+0fVLyAjlZouFVro5AaTSV3QTcG5c+6P6J0pMW+HP1TARLR8a6zFqKHhOhRGEHQnlg93Eboh7YXeN3EwdpG6PYlrZLo3ETxs6pXzJ2EB3DVwPPlRBn7qMWkBrrExOr8aM1oBP1PNVD468PhCp9T5Wvwg+Mu3xXJIEgRPEnTrSVXTwpQAUwNk0NtyiRcvMwxZ8wv3NiHe19MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(6916009)(4326008)(41300700001)(86362001)(31696002)(38100700002)(966005)(53546011)(83380400001)(2616005)(186003)(6512007)(6506007)(5660300002)(8676002)(8936002)(44832011)(478600001)(316002)(66946007)(66556008)(66476007)(6486002)(36756003)(6666004)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFVFWUhkOVhDM2dmQ1p4Tmo0c090VnpKaTZuNHhUUGp4T3VnYWU4WFVUb0kx?=
 =?utf-8?B?VlE4c3JnUkpmQW5jL1dnYTlrOVV3Umx5UkVuMExudjNRMTN0bFZjTC9CcHFW?=
 =?utf-8?B?N3RqUXFMM0dzQW95cHVLckdkUVllSDE1QVVBQWpVSFl2SFdRVmJISThxK0Qx?=
 =?utf-8?B?M0QyZFZlWCtmZzZzcU10Y0tPb2hWeXJMQ1VFQlFsczhheWw5NW1VdHhXemFG?=
 =?utf-8?B?Z2xxLzd0bzgycmsrT1hnY1AxRk14OGhqdU9Jd1l0dytUWnZmUXh5TkQvNmRE?=
 =?utf-8?B?QlR1a295alZMZHEwdjBWMlpuTmFaRTFnOGg4VXFLUDhXQ2tQZWdqbTFYYi9P?=
 =?utf-8?B?SU5aUWFrVHFOT20vb1ZEY1RIaFJMV2g4TUdqcUt5dnFjOFArNGFYTU1pQWQr?=
 =?utf-8?B?V1hKelV6Z1N0dFNuYXFjWk9lL09ncXBjekhxRWRETTZsZVM0UUswanMwM0p3?=
 =?utf-8?B?a2FaZGxPR0EzT2R3Q2RsWjdjckNGNUdYK1RsMDdQcnRQR3ViMTNCSG8xbTlp?=
 =?utf-8?B?bVpORG1lOHowOEM3QmtMQWZvOEVKcEl4YTdhc0VlNlpVcmxsVnZDTVZIWWtP?=
 =?utf-8?B?VUhad0w1SmdnSUIvTDZQMjkrYi9RVFZWWE9VY2U3MUxoODFvMTc1QmRaeTlE?=
 =?utf-8?B?RlFHdUpRNkJNajZWK21sL2dpbjdVTmlYL3U3SzYwT1FEQWgyMWsvZVZYUGVZ?=
 =?utf-8?B?Y1NEZWdNb0MraE1SZEZGazMxYmVNK3JjQmhQVmRXOGVlRHBvMjNGejZGbzdx?=
 =?utf-8?B?ZmxweUdQMGxrUGFTSlVXUWFtUmo0ZVZya0tSTVduTjNhYmhqL3E1WjZGeW9y?=
 =?utf-8?B?MXd5VFZzcVdOMy83S0RnMkRJN3Q4eXIxVm1DYXM3RDMvWXV3YVBNYmRGS3Zo?=
 =?utf-8?B?My9mOGpTcE01enhiUnlCdEk3UFZ3WlIvNkZzZVBWTmdzUmdWS0RyelFWeVBt?=
 =?utf-8?B?UktVMTFwYUNKQ3RrRHVjRHAxbStYUnlROWdCTXBZQ2E3TFhhZjNjbUF3dkNt?=
 =?utf-8?B?U01DOE9CeEp5UVlrSG96RUdYb25QOGNGc3pJOVd4aTc1d3FSTnpmV2F5QU8r?=
 =?utf-8?B?dE9sVjByU2x0VFB4em5NYm9HYS8vOWZCZUNJQ29PMk1lRXF6U1pqUGN0TFBo?=
 =?utf-8?B?SVlBbDk5SDZkQ2pVQi93cHVRTUpRNUxVTHVwRGVtOUFScEVTOTdLbXVLQklO?=
 =?utf-8?B?bnZVd2ZBbDM2K1g5YUp3NTJoUmcrcGNzclpvUGhNSUNjeUlMSjRQaEswL01Y?=
 =?utf-8?B?c29kZlRWS0ZHU0QrUlpDV3lBbnhVZW5ydlZXWWl1QnF1NkkxYVFXcHZRM0xG?=
 =?utf-8?B?bVhhZkpmTk9TZ0FrckcwV3I2L3RlSmhjU2hjNnNHT2c3V2d0cnBpQ1pON2Rt?=
 =?utf-8?B?a0RzcEtFaytzc1RwaWhTWmJzUW94Z3h4MlVkQ2UvSkdoUnljOHViczJJQith?=
 =?utf-8?B?dk1ab3N0Skx4NTRRSGRxd3Z4SmlueldiTFVPYlZHVkRvVWx1ZFk5WTZOMER1?=
 =?utf-8?B?c0puOGlvT1g3YVJzazdoZGJ1VDNKaThkdjlkSWRMZXN4aHgzNGpHMW9mUDF2?=
 =?utf-8?B?bFdLc2k2SnN2NmZNb0ZxOFJuVlVCOTVZUW5DT1Z2QXBTMjdTVlU5d2g5MERJ?=
 =?utf-8?B?VzZHd2ZZU2dzbXRKbnFTdkt1MytQSHRFYW81MjdvUU9WTWw5bmhxaE1QaXBp?=
 =?utf-8?B?TVVsMTlPRUlnajQxZ3AxSW5UQ0RTdmJtLzNwWGNPdERCSkxjWWVMWTRTOFFB?=
 =?utf-8?B?Slc0akNUQmZhbkVsNHNNcHNEd0pjaWt2MG11UnFmVENrVUQ1L3FRQ1BFK0tt?=
 =?utf-8?B?SjBuYzVsOVVMdmhhUzRYbmx5aGFrSEpGZlB1bWhJQnJtMVk2T3ppSXFNMDh1?=
 =?utf-8?B?dGo2U1VEOVpPcWlyN2tHUWsvNzN2UFhvNHBBQ1BncVl4R0VuWUxJeFRlSERF?=
 =?utf-8?B?ZVVyWlFiSEVBblcwMk1PQmVTV0tHU3pHTlBJVHpCY253d21NQStPU0twbFNm?=
 =?utf-8?B?bTNrVzZDNERVU2xwTlU5NUNTQ0x3TTM5U1ZXNkZLS3BVNzFuSDRDQUc1NS84?=
 =?utf-8?B?a1VIdU03aWIxRm1oODFPZyswNjFDSHBDQmJOcVg2ZEhvSEphOTU0Q1M5d0pE?=
 =?utf-8?B?TzFFQlVvd0xrWm5RbVJsSEhuZG1RVUN3VVlsVHVmWUcyclJxdWJoR01ENUs2?=
 =?utf-8?Q?7dqEYxMWEQuwNkp5UwspCexSlZMYiwZsQDgbkZlZU3/d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b2181-d749-47e1-e121-08db33832e57
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 14:04:31.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcdr98iLC7oXnZ/+Zp4sDqt3ZVB3rCOns5P9ckznMDN146TJRqHZyOl23RRGwoikKFlxGlFf6kt3LmJ9mW78+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/23 13:43, Mark Pearson wrote:

> My previous commit introduced a memory leak where the item allocated
> from tlmi_setting was not freed.
> This commit also renames it to avoid confusion with the similarly name
> variable in the same function.
>
> Fixes: 8a02d70679fc ("platform/x86: think-lmi: Add possible_values for ThinkStation")
> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: https://lore.kernel.org/lkml/df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de/T/
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> This patch series builds on top of the proposed patch from Armin Wolf
> "platform/x86: think-lmi: Fix memory leak when showing current settings"

Which version of the patch did you do it from?  I tried to apply v3 of 
Armin's patch
to Linus' tree and then apply these two.

The first applied, but the second had conflicts.  Here was my base (with 
patch 1 in
this series applied).

50c77e3211d7 (HEAD -> master) platform/x86: think-lmi: Fix memory leaks 
when parsing ThinkStation WMI strings
ede629af1e2c platform/x86: think-lmi: Fix memory leak when showing 
current settings
00c7b5f4ddc5 (origin/master, origin/HEAD) Merge tag 'input-for-v6.3-rc4' 
of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input

......

Applying: platform/x86: think-lmi: Clean up display of current_value on 
Thinkstation
error: patch failed: drivers/platform/x86/think-lmi.c:931
error: drivers/platform/x86/think-lmi.c: patch does not apply

>   drivers/platform/x86/think-lmi.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 88da7bcb6ce9..ad952b49617b 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1459,10 +1459,10 @@ static int tlmi_analyze(void)
>   			 * name string.
>   			 * Try and pull that out if it's available.
>   			 */
> -			char *item, *optstart, *optend;
> +			char *optitem, *optstart, *optend;
>   
> -			if (!tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID)) {
> -				optstart = strstr(item, "[Optional:");
> +			if (!tlmi_setting(setting->index, &optitem, LENOVO_BIOS_SETTING_GUID)) {
> +				optstart = strstr(optitem, "[Optional:");
>   				if (optstart) {
>   					optstart += strlen("[Optional:");
>   					optend = strstr(optstart, "]");
> @@ -1471,6 +1471,7 @@ static int tlmi_analyze(void)
>   							kstrndup(optstart, optend - optstart,
>   									GFP_KERNEL);
>   				}
> +				kfree(optitem);
>   			}
>   		}
>   		/*
