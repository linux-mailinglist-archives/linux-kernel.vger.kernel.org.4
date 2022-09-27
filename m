Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACCB5EBDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiI0IwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiI0IwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:52:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E6A979D4;
        Tue, 27 Sep 2022 01:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhLjnlzm0XiERrje4l/kXctm/iQeH/9/mECWFZYNJtlc5bvUCR1xkf5RYia4rPpVACvB/DdI2rzYmG9cwfDzOSNT4gbb9Kfy1099+BSRcO7jauWWpdBde/uS9qHgMcrwezVFP0210nkbZbB4d4CLKLAhYxg6p0vCyY5awGgt7PHhCgc9eduE0kJT9m3y73c5voqH9HCZt+OtNB0NFljQQCHrOMKX9Twt6Kc20heYK5vP8qdRBjlrts7aLugNkyR61VLjqCFyWgMacV6ItA5y8fqx7XdUri9h/OkieRs9hZeRPXTuVsKNgrp1664YmM7sH2f8fc+GbLB9lldMMY/AqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SB2LzneWQzJ425qe4BAmgRezAMijmyrY2kafbaRTPTk=;
 b=IKGx7BFT2rZBuAJep54Coww5GQARl0L+MbiTZTHFOiG4pdBC7EYXrHIlTam/qSD0eZhA3+Xjsn2ZqKH1ytS2V5Rflqz0vDq6HWEZN2O5K0vyuHM4Rnu3bdVMds554sKsytQiMZEkA5QbIzEA/Aocbf9Vq7YcsX4gFYhsKTDlrjhELdUk9SQQom3VSZ34EemAt3N/kqEaKDTEnnd4xhMe2EqjiX/IE2R2wTPGF8po2wIJ974BYKyL2ddRKsDPkKM/1QSrs0axwsDv9ha+t14RSuWOrgyb647cTJbRm/MRuGxH5pIfRzmny9CAj4Og460Sgy2tlJsuBoQfBzdWWT4MWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB2LzneWQzJ425qe4BAmgRezAMijmyrY2kafbaRTPTk=;
 b=e7Yw5jUiskBWgaTvYDcbj56v3epee9ys1CPzukuh1pRScjV4ij7+ek/IyGWVsCqwo52KQdVwzLOsBUv1kGAEUcVpEDnhJOZaFtUYQMy5KjRHha/amHv8+zMLaWXkdjODpVxFRKdO/2C4CsUY/j5mKwoVKG/uTRhWgQhogxxQoUEQTXeyZg81SD8aWmUlddqX7mn3vNE70ggiOs/6cFX24YhZvibJtC6s5SuAWiFhWdWxdGyf1lKoZnPBlP79njBHTKIYuJ6OP3ynNr0ZqK1O0zYoB1Io1cXgy5Wd7cnd4qVo2BwbdxC5tDe+qi8RvCjSQSbgxmWFnqpZvWtp5SMH/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 08:51:53 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 08:51:53 +0000
Message-ID: <af9fa1c4-0db1-6776-c362-d375f934422e@theobroma-systems.com>
Date:   Tue, 27 Sep 2022 10:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/3] Input: add `SW_BOOT_ALT`
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        dmitry.torokhov@gmail.com, klaus.goger@theobroma-systems.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-2-foss+kernel@0leil.net> <YyyZRt5j180KzGqc@nixie71>
 <7add41ad-2cff-adef-08c4-dbc02f7c7c31@theobroma-systems.com>
 <Yy3qj432McMJ/5rl@nixie71>
 <953e4d00-110e-b337-3c6c-af008c843046@theobroma-systems.com>
 <YzJYZrw09dXEihnn@nixie71>
Content-Language: en-US
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <YzJYZrw09dXEihnn@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB8PR04MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: ba71b27f-e62f-4074-914a-08daa0658642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2/nG8B0GtQqaA/8qx601i96zvXj3UtpRaFNLLwgs3CBcUuSnyntkapx5FnFR/Hf+LdqrbkbJXnqw6p/LNSfaOtHTHHoekittBTpYA2lJE7VuXOiEsVUmN590/977tkP4Rc5RFMzvYruiNfv3o22EZuwQztd7NqpkCE760nh89fTqPmILWRZGwv5RHPllTM942KPQYtaTzX/hQwRNUhWq/j4B29pUICCyZuXiaVAFnVVW06UFQn3c0A4qFBaVJFTuksZXrCIzHt6K5/aww/aLFEYTSwVouYpQ78MnP7nefqX50Gk7ZCNQGOKioY5wtJ5P0vB+cIOwiLhaBgYAUJ8jUdbaFXyyLkXrxzu+EgT3brp1Lxlhw050RQSdW5nAiEYdEHqSgv8XF6grfCb7fwvG+HHjYBgwmUYOb9o17KPHdKhCRLlvhEbZSyyQGUnZNqTSElGcssenbhao/mgYJWdouM1zTvE4vWwqc6uFTgLmvPQ0FkG1u7JcPf9dboIsOWKzLBOD9XUhBT/NGm6pGstz8dh3BEJTlBPZHk+0gYQbgp0GYVczhCxbWTvX7ho/K++eQNmdgBKIgJSCcepPxy2jpJ0jSf8CEiQDykYZL2OJ4MobnZQO8arFvct05HKrSb8/z5wwI1zNQcFk4OdRUhC5W2Zu1Q0R1WjpwLQcFETCDY9aOMpGJnwgIfLV7fVwakPFgoZF8EWl05OWMU8gswA2+hbVhZhPGrTKQU8cksar7f98ocYR6q1TmDbnKxnSzRdk7kCF9dAe6OFGGQjiVuV3j6+Au7ebqC3jpGe0W7RoO8lCaPpaTWGcGqKpm6ZomeCPraxx9nXrnP+kH/ibjUoSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(136003)(346002)(376002)(396003)(451199015)(6916009)(38100700002)(31686004)(66476007)(4326008)(66946007)(316002)(66556008)(966005)(478600001)(86362001)(8676002)(6486002)(31696002)(41300700001)(83380400001)(26005)(7416002)(6512007)(5660300002)(8936002)(53546011)(44832011)(6506007)(2906002)(36756003)(2616005)(186003)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW1uZEc3UkZZTU5ueGJxOCswWWs1Y1VCaUdaN3RVMkRuUmdvY3Arc0FPUnFV?=
 =?utf-8?B?VFF6SS81aW0vMEFlN2NuMjdYNUZkOVI1NDNzc1krQldSeEQ4UnhjS2dVb1Z6?=
 =?utf-8?B?aGR0UWNIazBXZVRCYVZHMFhMUisrL2MyWENIOWU2QzN4YkNYcGJkd0FPU3Rl?=
 =?utf-8?B?Y3VablZkY0dBNkRQaUwvdDRocm1WUVc0V2hLdXVmeDF6NXZRQTR0S3pjMml0?=
 =?utf-8?B?NWpaV1cxY3Q1WmZuVDhnSEFQVXRhOWpBc1NPNDUxTjNOSXRyOEE1VDVsVmt6?=
 =?utf-8?B?ZDVzUFdaY2Q1OER6ai9BYTRSN3ZEb0g0Vk1OUEZmU0I4bXY3Ukd6QkRXUzUy?=
 =?utf-8?B?aGs1RVNoR1JndXdWZ2s0OVdaUXBUejJnempSWjN6WEFmMktaODJoby9NalNM?=
 =?utf-8?B?ODBaOVNNYVdIVEZuL29xWmJNUnFoZkNEbkUvcnlFWTZncnJDcFBtTkNka2pw?=
 =?utf-8?B?V1VHNkdpNjdDOURnREhxTGx5RnpFVlBzdHUzQmVabjJ2N3FjdHZyVGhLc2I2?=
 =?utf-8?B?MUhtSmRiSXFRUnZxTjVUdkxkV3BuejArckpLMkk1V21EZnUrM1ZOTVcyVzd3?=
 =?utf-8?B?d2ZpTEJhcy9nVEI5VFU0clJmTXozeERtWUdRRGpwbUxsb29kUTZZSElPVHNh?=
 =?utf-8?B?Q3Zya3F1K0MzSVNka0RxSFJ5TVBzTEFZOTByVDdCVzVsSytjSUpYbit6QkNy?=
 =?utf-8?B?VmFnTG1WNnZxQitPWk9pZXdZRUpyNGdyRnkxcWJGUzd2NTdiV05XbDk0WFZk?=
 =?utf-8?B?MUFDanFiSTIwNVhxdE1CM1NROHNjOVo2cFA1MTRVNmpSV21JZHdvTVd6enFH?=
 =?utf-8?B?VHFtNjFTYnk2Q2ZVMXZqeU5oa2wxemxYbWxWT1dkVzh1NHh3ZGFqRTIwNGNU?=
 =?utf-8?B?cTFqZ3Y4NXZRZm54TXVEbzFXOTlrU25kc1B2Qkg5aGFrYW9ScGNZRnZLS0tx?=
 =?utf-8?B?MUdUK256RFo0SmU1dHQycDVNYmRYL2JjQjcweFZDdStCcmJOSWtXL2N4czEr?=
 =?utf-8?B?Mis4dCs3V2dYRHNiZUF4NTk1dzRsSVNRc0RZMXdtZjB0b2wxRWpNWjBoRlBn?=
 =?utf-8?B?YkhRazFIcjNLZ0xnS1AwYXE3YU1JdTVod2o5ZnZCYTdhc3RYMnZNcVVRaFZ3?=
 =?utf-8?B?akVwcFEvYmtTVnAwOWI3ekVGM3pwejZ2cTBXNDVwcEx3OUhlUFI1T3BTaDg5?=
 =?utf-8?B?ZTlnZzR6TmsyT2h6VmRPeDNNdWtTRUZCRTdtMElCb2dtTkt2ZFVxU1RQVUox?=
 =?utf-8?B?RDY2em9VNWE5amNrdnFyRUhraGFGenNjSUo3VkpZRTIvZ1U0eVAxOXhNa1hk?=
 =?utf-8?B?WURLOXRPRzZlZEJLVjlKU1M3aDhCLzFkdlNHaTFPMG5GVUkvZ1pUSms2MWsv?=
 =?utf-8?B?aEUyMExMQW9PRDc2U0JTSWlQZzR2TUFZT3pyMVE1S29yVlMxRTNiTzRuQ0tQ?=
 =?utf-8?B?RHBzVEJqTWpQSUJ6bjRwMWE1ekZMZFFOUit2ZHZZM2JxL2l3WlUxSU8zQW40?=
 =?utf-8?B?a2NYSUpsV0lXUmx6aTltUHdCWkd0cmtHRDB2MWcxZzRFcDl1YTRZdHI1djBw?=
 =?utf-8?B?Tmd4Q3BCWmFzT1h0WFFWRm12aFViaVVleThONC93SGpFS2tDUWh1b2ZKWGhw?=
 =?utf-8?B?aTIvUDhRYmNQVEt5c1BIL2tiSVVUZUZXZHN4RHVlWk0zMEJaWFNwMm9iOFBD?=
 =?utf-8?B?Y3N2VjY0RWxPVUl2YW9QNGllQk1EV1ZBcHlYRzVYSTFnVXQ4cUlHdjBqY0lx?=
 =?utf-8?B?bjRlMW1lSTYwNC84SXlpSmNpVVhZRVpkclAwaFZraTNOaWd0MXkyajlNNGxt?=
 =?utf-8?B?cE9wWllGUTRaNkRBWmh5d2NMMm9ySmVuUEtPWlpDMVBIeE5PbWRjRVBhQ1RU?=
 =?utf-8?B?MGFJRG85T1RTQXExa3dEbTM4cmtTL3hzSW5paTcvMjAxTnRxSjRLYjFpQ21l?=
 =?utf-8?B?RElEL3NFR3Nib0huc2FnQ3RrQ0V0UVF0b3ZBbFpVUjVLbTlTUWZJU2FZeDVE?=
 =?utf-8?B?MTdkQnhJbXRvS3lsSFdwYXdYMkoyUFQ5cnhPbSt4M3ZRUmFSanU2eGRsdlRT?=
 =?utf-8?B?bE1QSnVSV002VjZEVktNc212MGVCOWdYaG5XS3N6M0xkZzFGNThBVnh0Y1Rz?=
 =?utf-8?B?MmZKL01ZMGFZUmJ5Sm1tdllTSW5JSE9adStkWXU2V1dLTGc5RGQ5Nmd2SVY3?=
 =?utf-8?Q?veuzJHj1x+GJnNzWWTU57wM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba71b27f-e62f-4074-914a-08daa0658642
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 08:51:53.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeL2OJ6ZhfaaGqUstSxXqQ2E0yzMxT2AtkvFUf7wnrnh0zLQ8bU3iucZ8mnMvPUMG+XdUIENmBwkpPZ/0rUrMGs8BdskP6yPlpnPUBl/+hm/BljtZOEevr9fCwEC7MNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 9/27/22 03:56, Jeff LaBundy wrote:
> Hi Quentin,
> 
> On Mon, Sep 26, 2022 at 11:37:45AM +0200, Quentin Schulz wrote:
>> Hi all,
>>
>> On 9/23/22 19:19, Jeff LaBundy wrote:
>> [...]
>>>>
>>>> I have this switch on the board and I want to expose its state to the user,
>>>> if this new event code is not possible/a good idea what would you suggest we
>>>> could use?
>>>>
>>>> Note that we already support the same switch but in a different way: https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_tree_arch_arm64_boot_dts_rockchip_rk3399-2Dpuma-2Dhaikou.dts-23n167&d=DwIBAg&c=_sEr5x9kUWhuk4_nFwjJtA&r=LYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=vObtDja6hUlL_kVvKRILCvaQfklw1gl7TAW7cm5_9H_Yi00zkzGV6-D3yzazR2gU&s=0Xo-7CDmMoriaTNn_hJdMwftLlcY-tgopPcgzXfQtJE&e=
>>>> We are just configuring the GPIOs into the GPIO mode with a pull-up, and
>>>> then it's up to the user to use gpiod or gpio-sysfs to check the state of
>>>> the GPIO used for this switch. I don't like this, very not user-friendly and
>>>> was looking for something better :)
>>>
>>> Actually, that's exactly what I was going to suggest. What in particular
>>> is not user-friendly about it?
>>>
>>
>> The implementation we currently have in place for Puma Haikou is just muxing
>> the pins in their GPIO function with a pull-up. Nothing else. This means the
>> user still needs to know exactly which GPIO number is for which
>> signal/event. Not that great. Also does not allow for a consistent user
>> "experience" across modules on the same devkit (different GPIOs depending on
>> the SoM).
>>
>> I had hoped gpio-hog in input mode would expose it to userspace but it does
>> not seem to?
> 
> No, I don't believe that is the case. That being said, you should be
> able to grep /sys/kernel/debug/gpio for the hog node's label and get
> the pin state (lo or hi).
> 
>>
>> Anything to recommend so that we can export a GPIO line for a specific
>> function to usersapce without needing the user to know which GPIO number
>> they should look at?
> 
> If debugfs won't work for your purposes, another option is to request
> the GPIO from a general-purpose platform driver and return one of two
> strings via sysfs.
> 

This board will be fully supported upstream and I don't feel like this 
general-purpose platform driver would be accepted, but maybe I'm wrong.

I didn't know about the /sys/kernel/debug/gpio file just yet for some 
reason, so that's one way to do it, thanks for the info.

Good thing is that the kernel requests this pin in GPIO input mode so at 
least that's one less possible misconfiguration from userspace. Not so 
good thing is that you need to grep in this file and it's not that great 
for scripts :) We'll discuss internally what feels the best to us and go 
for it, thanks for the tips!

I'm wondering if allowing sysfs/libgpiod to access the state of GPIOs 
requested by the kernel would make sense on the subsystem level though. 
I'm sure I'm missing obvious security/HW-limitations pitfalls, but I 
think allowing userspace to get the value of a GPIO input pin requested 
by the kernel would be nice? Nothing for the input subsystem folks though :)

>>
>> While I have your attention, I was wondering about the BATTERY event. We
>> have a BATLOW button, following the Q7 standard:
>> """
>> Battery low input. This signal may be driven active low by external
>> circuitry to signal that the system battery is low or may be used to
>> signal some other external battery management event.
>> """
>>
>> Oddly vague, but the EV_BATTERY event is not really more precise though (at
>> least didn't find more precise information and the introducing commit is a
>> bit vague too on the usage). Was just wondering if there was any specific
>> usage for this event or if I'm using it correctly here?
> 
> Do you mean KEY_BATTERY?
> 

Yes sorry.

Cheers,
Quentin
