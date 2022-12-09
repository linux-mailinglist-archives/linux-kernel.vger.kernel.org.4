Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C746D648174
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLILQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLILPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:15:43 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F770BAB;
        Fri,  9 Dec 2022 03:15:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpt+Y7Si5BP26DrSMuoiH5kjnq4qXdnqpImaGlqUv0N6+310PiJg9DtReWrGSL1gDfr4ylBSr/Jjt9HzTKMOkLLprOTyX1E0e2puXD3DQsBskAZipGgc70we8eAH6PSQCxL57Q1QG5qeYeBHEVM8ybZnF6d5vM3CvTHPxMAPy4v8FMVz+6BRfUUKpG95DPATuIYFcYAMVKLp3omCxmfTJK9HuGTSByU+mXn+XYBYBK2CGivafo+A7O12/tMQiWlMjqPxBHq4y4xsRqrLD4u/hTIp/6aGOk+ee3l+oYC+vknMQ64Q0xVWoNyDFQYisfs7/urzXjJlVFsBOLOM6GRfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z49EBeTkSbE4WunP1JWWe3GQ8uPUVc+w/njDPq2S+Bw=;
 b=iv7arOaJXKTgrDZVTSAKHqFXLJNTGqo6wFbKBdDp7TWpQlSjF63VDVHeNKQiTLwm0hxSqfYYY2j8GrSHTKo23kGemmDedeZLyghk3ZF4hAppDCHCyc2HDhjV2a2rc71agn9my6joQl14sFhVYyqd01CQWkXAQTRonRi9smqVGgQa6RDcDi/0d/ZxbIjvIp5NN0JkEDEfca4IuuDlpK9dG+paKzWI2gDWLsFNzMJ+tbQfbELt55FdUVoVKOnJQIsws7Li5KWwWV7zoe+FJ2pPo2SrfDKcWnGr6ED+rS+D52nME+pAXcABUZbuxzIP6fenvwoWwEQfkOMEBrHbo6DK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z49EBeTkSbE4WunP1JWWe3GQ8uPUVc+w/njDPq2S+Bw=;
 b=R1eOZ9B6f5Dqpnx5hYNo+OijlG4Y/KZU8xwcc/8KyTmzZR6WRwQMa7nxd9AqvQhfRRs9ouPMYPScgDpKhwii7Oju2v6F+NphwOZ2TffmNT2/O3uASUTB9FG1VGTVl8Z0ArKP7Cl7FIkXjIZbRoQcOjBn4Db0JAR5HOdgjMWfyZE0pS4qakktfL1Mt7z74pAaSqSoHUhF4gZ2NeATE8o79pKx+hM1Gr9zJylLpGnyVap3h5j/li7+B3LpHVlhr1jUuSfRL+vNjz2OciLy7a69Ny45Mz9xCaAcM8dyjel6PFFMOD2XAzr7iATHZm2xlh0a4x6w+saKTRVltG3jKhNkCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Fri, 9 Dec
 2022 11:15:36 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 11:15:36 +0000
Message-ID: <69c0f9c0-5c89-e99e-c807-9963ca377093@theobroma-systems.com>
Date:   Fri, 9 Dec 2022 12:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] usb: dwc2: prevent core phy initialisation
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
References: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
 <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
 <Y5IIaeip81DIvEZ6@kroah.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <Y5IIaeip81DIvEZ6@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5776eff5-1e29-404c-9e20-08dad9d6b27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHdTDsPWYAol1BL7i4HKctVaJlQdZSU8u5ejE3gwmexBweATHWncb1TImYoPrzaJ7alaFT87qnSMw/jqjnP7v0dGd8Y13E49OGkTYVDAX2MMvcwMfNu5HDRyK3G1khE2r8PNlXQibGiSLjktCT14Umd/nowPGYZWJIjNXTpzzxjy2zfsMLPUXW1L6LAsdhzlI1GBl85uehVafG6EsaIsB65ZnaItNniB+Sv6NK1wUC/51qm+5YfmY6WwzCoG2HrfhxLHeK3CVs69GWpp9K01TAK8V+sNq+lP96OUcw+hw59XaW8EI+3vuLnQHQpuwmyhJAnxPRRRI6BnYpOKc5bUT1Xx+uyJU1PWANMx2tqpILnK07W5qgnuDAZKKnEMohYHEEZ5QUcai4AjGcBr56qfohwcUgnGweaZ0Kgeue8J9aV1wC/8UHJOm3gB/od0QNPs00N4NFjRy/A8ppwlCjHLpQq5wIITUVVpTN2S7siBL05PCVTwICSsXeMGvIPp2XsJUFcxksSWofmxTCPPD1xfBuJQPfZ0/p3AvMnUG05f0cKIDbnjVOWGx5VeL4aA4ftcjkcy+kBk/Q85fL9XQpLpYEfyUWsw2QyFVax6R+uUvwuh1THQP766HKjSv2vypAJtOXX5JauukaKH/DQ+lOZQktK/2FmuQMMjkIZExnnToMCz8YLMawndoj7GcsERfWXhhblLYWMFKsBFuFKxwhgG0DicyLb7/bWMNmKNUeeprgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39850400004)(451199015)(31686004)(36756003)(5660300002)(8936002)(44832011)(31696002)(38100700002)(86362001)(41300700001)(6486002)(54906003)(83380400001)(478600001)(110136005)(186003)(53546011)(6506007)(4326008)(8676002)(66556008)(66476007)(66946007)(316002)(2616005)(26005)(2906002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NKZy83dHVKdXQrSTRraTFlVlBUN1d3L25pMkNjWmUyWWxSNXhXMTFRakJp?=
 =?utf-8?B?dWtmcnhkWDdsYy9lUVdCTmxLY0c1eEk4Rnp4TzZLZkFTdndNU3NONDVwUGJ6?=
 =?utf-8?B?WS9XbmdMRkthMzM0dVhqa0lqWDNIUG9ZdnBuam5SdmZTalFxQkZEVjBRSHdi?=
 =?utf-8?B?RFluUWZxNEQwZDhPS09KbTZSV0ozRGdHdWpDOEJBLzZOQzlWQjBKNjE3QWNv?=
 =?utf-8?B?NE93MGRlWlRqNkRtUjFnREdJa21ra1pWQ0tuaUY3NmZCUUFFZXdVWDhPZEds?=
 =?utf-8?B?U1Rid3ZSeGpCU1VUOGNkSmZlV0psaUxDWklFZDdMUGtkZERjcEVKVm9LMW4y?=
 =?utf-8?B?MkM0dVNHc1ZiQmx2Wm9vS3B6YjJ1SEltbzAzZzVmbVdNSkwzKzRLTTJUMXpY?=
 =?utf-8?B?ZHlUQTVlUklnQU5relQ4d2RkMHVQdmpzOS9lNXlaWngrYUZYc2pnRHhzL1pL?=
 =?utf-8?B?cFJQSk5FM3V3TkdVdVdESE0vZkdabGVXTGdXRnJGbmU2ZzMxcTNpYWZUSzhY?=
 =?utf-8?B?d2VBbHhhajJ4b0ZnUXhTenBPKzBFczdFSHJsUkI5NGNxdEFISmJSa1c0dHoy?=
 =?utf-8?B?dXFHdGFpNjVLWTF3MHNDZi9WcmJRN1NpMVAwcUM5WHNqMWdvUkV5V3gyUDJR?=
 =?utf-8?B?NEhWSkplaWZiYXJmOVJ6OUFBelRqa3kxd0crNWEyRzUxSkNha2NlTVh5M1NR?=
 =?utf-8?B?UFFUSnhneHVheks1RFhsMnBveEtpdUhDTXBDOHowbk1veW1mQVliSGEzc0pN?=
 =?utf-8?B?aHIxVC9SZDFQOE9FTjJ2N2dWd0F6cE8rcEVDY1BZL0k0T1JnWkdlV1JJdWJs?=
 =?utf-8?B?L3lXZ3dMSW5rYnQ2a2tGbXI5K2NKTUNKVGtlUk5Uczc5TU9lVkxkSjZVZmcy?=
 =?utf-8?B?M21QbjRxeWpUeklSeWhGVFIzNEZzdHc2YU1rY2tOOVBlSWFHMGdWeWxXdlUr?=
 =?utf-8?B?cmF5Mzc5cVd6dUNjcEFtMm9ydklVdkZiSmdnc2tmL20rRnhQNi80SHpRb3JE?=
 =?utf-8?B?ajh2RFhCcHVHZlNlOEFnRjAxZUt2SzVRdENaYmZlMU5kaHBaZVFYOXhMbEY2?=
 =?utf-8?B?MDdpUmZaNTdFeld6Qy8rWElBcUdHY2VEYi91bDdUYW0rWnRBNUVORFZCZTVO?=
 =?utf-8?B?RVBWK3RFNjZMZnNndmo2UW9RcDJqRjl2RlpiN01nckRlVzRjR3o5TG9EZGhO?=
 =?utf-8?B?RkdYTlBDQUdoZEhFbjdMYWF3Tll2d0xCZzU2N3BqT2txQStqYWtJQVNtNmVH?=
 =?utf-8?B?M2cxMVdGTER3RWphZ09ZYnZKWVgzV2VySjk3d3JvMVhJWGdQWkFaQnlsZFNX?=
 =?utf-8?B?V0FDRkhMN2lpQjE3RFB5eGRMMXpPQk1IYlhvWG5FU1JWeTF4bzBCcmxMTnl2?=
 =?utf-8?B?RTFkdEZFOW5EZVQ1ZWI3VXFOV2d1N2Q2L0JwaHhFK0ZIeFJrcVlEQ1NjQy9t?=
 =?utf-8?B?c2MxQXZPUG5KSDF2bGJyb3FUVWVKOFp1Q1ZOUEh4MTFHdWh6cUF4YjUySGN0?=
 =?utf-8?B?emdCOEphMVRWZm1zRkZZQ3o1UjV0R2F5c2lRSnpmYTdpSUZNNVZGejZONXlq?=
 =?utf-8?B?aGMrTVY5SnppNnd6eVdvQlNlaFU3Zmk3a21obFYydWVQOFhiaGYrRlMxalNW?=
 =?utf-8?B?aGM0WDdibm1ZdTFMZFBBVldIdmZHenJISGVkN2RwM2RWRUxWbDdWQjh5emVY?=
 =?utf-8?B?dkVnWnNvdDZ2cHQ0T2pLNmt4enpUNkRyUjlyTXhDcSt5K2Z3ZzYyYVFVbUp5?=
 =?utf-8?B?OXV4dW14WTRGcHNjVGhhYlFGMFNTazFLM2RPakp1aHZZREtJR0QxVHhIcnR0?=
 =?utf-8?B?ME9UeHBlejFaL0RrZGRRalFET3JaZlhJYXFGM2RBWWp6aXEwZkt3L2V0b3gw?=
 =?utf-8?B?YVVqSGRucFFQM3FGdXBMVVBnRXF1Rk1BUmlVS0w5ZjRhcHB6NmxGSmI2QnNu?=
 =?utf-8?B?STBpY3NNMkx5dEdydG1lOHVMM3dnUUFZUC96dU5xdnNZR2J6a3JLMjBpd2Vx?=
 =?utf-8?B?bVMyV1IvYTJiakRxK0F5cENPWklhS1QxTjNlemdWMW9DbGdudldvRGo4ZGdn?=
 =?utf-8?B?dVVpMEtxS0hXRmQzd1RocC9WV0dYTjN2LzNMOG1qUXljcUV5QU1DZ25vL2ZK?=
 =?utf-8?B?ZHRlUWVFcGEyZkRMSG9RNjBFbUdRTlBMRmtRanFXaGJaMmd4enJSTVFURlRj?=
 =?utf-8?Q?k+bp3TTKkiBDrKf9DgyJ80s=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5776eff5-1e29-404c-9e20-08dad9d6b27d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 11:15:36.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /C26THG4y9XNRMIE0beNu2hjmsVAu0livatoX9VrD/zZnAsUyCRKncavU8HRHb74fBWlbAMd3yj4vYqg0vMeEoYUzO+IH2M1ytz719H0NfsGjMEyI7J38ud4Q1ZVWRha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/8/22 16:53, Greg Kroah-Hartman wrote:
> On Wed, Dec 07, 2022 at 02:19:18PM +0100, Quentin Schulz wrote:
>> From: Bin Yang <yangbin@rock-chips.com>
>>
>> The usb phys need to be controlled dynamically on some Rockchip SoCs.
>> So set the new HCD flag which prevents USB core from trying to manage
>> our phys.
>>
>> Signed-off-by: Bin Yang <yangbin@rock-chips.com>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>   drivers/usb/dwc2/hcd.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>> index 657f1f659ffaf..757a66fa32fa8 100644
>> --- a/drivers/usb/dwc2/hcd.c
>> +++ b/drivers/usb/dwc2/hcd.c
>> @@ -5315,6 +5315,13 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>   	if (!IS_ERR_OR_NULL(hsotg->uphy))
>>   		otg_set_host(hsotg->uphy->otg, &hcd->self);
>>   
>> +	/*
>> +	 * do not manage the PHY state in the HCD core, instead let the driver
>> +	 * handle this (for example if the PHY can only be turned on after a
>> +	 * specific event)
>> +	 */
>> +	hcd->skip_phy_initialization = 1;
> 
> Wait, doesn't this mess with the phy logic for all other chips that use
> this IP block?  Have you tested this on other systems?
> 

I have not. I asked this in the cover-letter but I guess I should have 
made the patch series an RFC for this reason?

> I'd like some verification first before taking this change as it seems
> very specific-platform.
> 

There's already some platform-specific callbacks for the driver (see
dwc2_set_rk_params in drivers/usb/dwc2/params.c) but this gets called 
too early, before hcd structure is actually allocated. So we either need 
to use some "proxy"/shadow variable in dwc2_core_params and then update 
it right after hcd gets allocated or have another platform-specific 
callback only for hcd (post-)initialization.

Nothing too fancy so shouldn't take too long to implement. Any 
preference? Something else?

Also on a side note, after further testing, USB peripheral mode in 
dual-role mode does not seem to be entirely fixed with this patch 
series, I still have occasional locks. But considering that it 
absolutely didn't work before, it is some kind of progress.
There are also some issues related to USB host mode in dual-role mode 
but I saw those happening before the patch series too. I'll see what I 
can do, really frustrating to work with IPs for which there's no 
documentation :/

Cheers,
Quentin
