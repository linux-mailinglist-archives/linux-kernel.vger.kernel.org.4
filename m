Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0D870CF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjEWAio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEWAO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:14:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2114.outbound.protection.outlook.com [40.107.104.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B910EF;
        Mon, 22 May 2023 16:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk2tIQ2hCFbcmtbBuNaTYISWfB4lrFybCYTJceQQpXUgDtqLaxrqnipFysLK6/KQoIr6an7+XmfhGFxrtECrDifI6uBIy6eKMWJbyA+hWTWXKeHLG0fUP0vLUPfABst/i7TSfUEyQsArPobCyBEfzlqDtpR7VOuZMwp8c/or1w+O5bZno6NQ9amZo+OYZAJ0ArFTYecL4bZUtIigkhFedtpvgWZW0h33jDdvy2rQZgT2vYkQViWV1kLWblammwhK3iA7enMajnlzDscWYLrgUPsvaYFGN0qS1o4BPu6jMgY552YK27czla3plGKMTvoKGKq9KiEpFAkaITWraeC1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsFoTaO9tJClD7omWjpNzsqiSQb2A8C8tCd2VK1FBRQ=;
 b=RghJQFIum8PBgEFGGWUF2otmK2RVpqQO2F7775KIJGxhtMRv5W/CCWknglXnKYwcHxxBDBWyxHBYo2Q5UrBG+UfZktv7PXQZ0jVv8E3cyWpPwUD9ucp95j6XUjdPtiq5vjSeXWSEbAmivsEjx3TkdC7r6wEhPKscyFPj69063Oc4p/j68HkXktDDN8SDIIXYJW8+o7wcSK+TSE7O/hYYiCK2QHdAjWCXbsQuSCCq5wpx5zvMhm+8RfCD9gdMyOHQRYkNxmzHJEOMqD6gQGMXH6FEeMNqPQ0/+zyTcuxC/AKk9YrJ+Eq7zbWi5HOmAE5EJcZ4ojqGxYiNiAPog/TCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsFoTaO9tJClD7omWjpNzsqiSQb2A8C8tCd2VK1FBRQ=;
 b=pCE9Y0QfDCOatBygyKQVmCNXXMvunQupjvObZnXr/iW0jDMmj3RyQMnbZ98Amd73kGRDWXVBSDstyd6teIvSBW3S5YWsdwSehL/eKG1eKcqDk5nAxA4SDb9gqHi/lqch1WwThyLfrsrybIOOsRlwr55Kh+eFVQ2pXkOPaYwPEsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by GV1PR02MB8908.eurprd02.prod.outlook.com (2603:10a6:150:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 23:34:43 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 23:34:42 +0000
Message-ID: <9c2706cf-bce4-05f7-9498-5755c78daaa3@axentia.se>
Date:   Tue, 23 May 2023 01:34:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Content-Language: sv-SE
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
 <20230522172358.bw677efyovbrfwjg@pengutronix.de>
 <abe0b7f7-19de-605b-e1b1-c62930052894@axentia.se>
 <20230522204346.krb37yyzylxokslx@pengutronix.de>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230522204346.krb37yyzylxokslx@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|GV1PR02MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: f280acda-ead5-4d15-1521-08db5b1d1e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFGta/9gw/Bu15PRE4N7G8fJdREH/SJ8GNDebLc21DXyAk7652Jzaoes3lWCxyiazSqIJAERxzpwUbN3Vqfo7w0O6xEA/FgZt0f6zO04O0Goz3MRq0dH84+cbuP2wLQ5MLkx8Blnoh7Ig0F/0vCLsCFl2Lcowmm+avsqGIu6MhKZDFnP5LTLAU/GlE9dtqZwpVFc7mn5FZrbaAFdcy/2/459YhKvF9ngCWpxrcECwjPGT7kq4HUoipYAGTjBsCp2Nb4y1K5+472tfrCsAawWOKzQPneE5NCO5tKvV5elJ1u1qvB1wbAm0GMJTisJ1q9y+SG3sR7z5+/1Q6i3jL5PclsNGLGyTiTYPmAqYd4HgaIMjFWsrxWZekQcCBJxmQaJxfepN5sEtvXotKRfjtNVYObQWVDxLEve8whe0Z9t6n01fBQ63TcBSsJtx1qwQoL2gBmq6AoWFRdldE0XqCuO8PyeQZwVHvYKO/gB4wgXlbmA6h4bFRXF8irksqjb5SOm2nPNzOV/7AClpR2I2ADFQBEe6OcVUZZvrrdBpK3m0RhSOdaypkzrz9knQ1ehaIk5wcr8eImLAtWY3QHB8/1i2AaDz8nP/am7SGofC0A4hODG6nXTIM0vqB5SpU/W8Bs+hEmimq2+HHD5I4Gc9CAVvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(136003)(346002)(396003)(376002)(366004)(451199021)(31686004)(2906002)(5660300002)(83380400001)(66574015)(8676002)(8936002)(66946007)(41300700001)(66556008)(4326008)(6916009)(66476007)(316002)(54906003)(36756003)(6666004)(6486002)(478600001)(2616005)(6512007)(86362001)(31696002)(6506007)(26005)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE55aDE0MTFXYWhYd1BMSVIyZlpNallKQnFYV2Q1b3JxVFhLclJjSnFSaEpv?=
 =?utf-8?B?ZEdsaGFxa1drWXU2R1h4WnFESDNyZjFaQXkyRi85NGVwTGNPR05nR2FPajdQ?=
 =?utf-8?B?ZTNDOER5TDkxbVRMVnQzTDNGcTlpaUVLUzRiTzVIbzJzK3loRENPZkZ6UlJh?=
 =?utf-8?B?MWg0djFpb0x2eWRwYjhNRHhXWWtGV0NCM3pHdWpTRjROMkpiU3dnRG56ekdl?=
 =?utf-8?B?VFBGaDFTdXMxZUw5eXJMb1ljYUlsRWMvSXc3aERLZUFEalJ6VndmYWw4ZStr?=
 =?utf-8?B?eVc1M0RvTDhiN1ZqOGhFeFBESHUvVTJ1aWtOOUlPbk0wOW50bFpNMW1CZ3pi?=
 =?utf-8?B?bkVMYkhxeG1PTHdyQ2Z3Z2U0bzVuSG9XN0R4cjc0WDNkYUhSUURBUHMxNFF3?=
 =?utf-8?B?ZEhraVZ2LzA0VEZWU3ZPaHY5bHdsczhRQzBDN25Hb05oOXY4aVdlWmV2ek94?=
 =?utf-8?B?ZHgzYUlBeFVVVHlDem4zWGFIN3lENnNYNnM2Z3prQXI1QUIwS05LSENxbkQ3?=
 =?utf-8?B?SHV0VnIwNDdDd1gvaWlwTXRBZWkwenpONHVqRW9PUmJkWUhQSkxWSWNNZHR5?=
 =?utf-8?B?Qit0b0F2UklBMDVuVkhrM1krQW5MbzRDV3YzYjVpUk4ralNEU21KQ3pRWnZq?=
 =?utf-8?B?ZW9WcUdUVE9uUkFJK284dC9wSjZiUnE1ODl0SGFtRFIxcU1oSmNlcEFHaDJq?=
 =?utf-8?B?a2IxbldlZUFWOXNrNFFqOG8xS3YyeWwza253QWZkWW9pZlVmZWdaSmJIZmJ3?=
 =?utf-8?B?LzVVK1o0dWtvT3RPNVRwUjVPRmoyeTlYdjAvV1dzdk1uTEFyMGlJaGFnRll6?=
 =?utf-8?B?aFYzUEV1NkRpUXRzRWxyMS94bklwRGZvZFVMRTkzWitjREJtZFBiMi9jS0t0?=
 =?utf-8?B?QitEWDJXSVFQSzYva1VIM2FKTFc5a1IrYUVrT0RrNEdtRnZBODIrcjZhVUNj?=
 =?utf-8?B?R3VtTGlQS1cxeUxCZXU3QlMrc0UremRnd1p1Y3Avd0RCVWF4NmQ0eWpFa2JW?=
 =?utf-8?B?cVd3VG14MVovcEFpbTJKWlVUVU9LWWN1SXVmL3hIMzdjWlU0QkswS3NJUWRN?=
 =?utf-8?B?RnNhVHA5N284MDF2VDRXOTI5YnJoakxYTGozRlNyZzlNeTFvUnV5eXlRYkMx?=
 =?utf-8?B?TlNhVUhtdVNPc2p5SzFBbGEyWHh6RmRLRHVNVUl2dUdZQm1XbFlDNDFZNnFG?=
 =?utf-8?B?d0MwdkM1RlZ5UldxcFhXWFRscTFDTFpkUVN0dmZuVkM2REU3NnM5ZDZtMHdp?=
 =?utf-8?B?cVI4RnppL1Y3cTNvK2FMVWdVYjZaNjNoNFljM2JRK2llTUJLNlBMb1lSem5m?=
 =?utf-8?B?RlM2VlNyeWRqYmhnNDhOWnNZR2xPT0hWSXJHZHFEd0N6YWFNUHJ3cUIvSUU1?=
 =?utf-8?B?TnFRS1R2bzN5SHlydDFHNytrYlV3dFJoY3hRbFhvVHh0YUxDK3M2YmlVZXRx?=
 =?utf-8?B?VVNUaHl4YUZZUlF4ZkhJUnpGNVBhb2dsSUxNREpoQ1kwUzBrclJQMlY0NE9U?=
 =?utf-8?B?bCtMY2NRTElDZXNWTHJhYktYYzRmRmRpaWRNNnpob1d3VElVazFseEplWW5h?=
 =?utf-8?B?Q1NTU0RiaUljUEhUTXJDd3JpT3htODJ2bklaTUJySjFIMzlFZ3VRa0dwVEEw?=
 =?utf-8?B?cWR6b0VSc2pJWE5XU01rd0NWdmxJbFZsa29seThUM1BpVTNDWEJpTWZkT0Ru?=
 =?utf-8?B?RzJ6VmRDeEZIazNSZlhkVkdWL2ZHNlN3c1lpK1Q1RmVOZ2g4UTJnZzFHdHdZ?=
 =?utf-8?B?a1V1TVh3Si9CendxKysrRmZuNzdvNWd5b1pEaVNqZk9QWEQ5UHQreDVjV1JZ?=
 =?utf-8?B?TUpjVktVekFRWEcwZmNYNVdYZmhGekw5Q21GSHlJbE5DN3VlREpoUUpqZHNq?=
 =?utf-8?B?c05OT3RmYzdLSG9aM0RBcXo5VVNweU9aU2FFV1RZdEN5Znh2ZENSaUYxUk5V?=
 =?utf-8?B?OWVLd2l3eDE3ZnVpejBYLzN1ZUdRcmFCZDdCenRDRVplR0ZWQ1pTL3BwVjg4?=
 =?utf-8?B?aVRCN0UyN1BJNXpkZXlKbExVTmtQVzZNd2pVNGFOM3ZRUTlvTmdDak84cjRI?=
 =?utf-8?B?NWZ2bTRKMVhhbXdCc3hBenQxbjBwLzEreThxZURmeUhmSW5KVWd1aEYydkZR?=
 =?utf-8?Q?XIc+AWhROzVZzy6PRXjwxgQZh?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f280acda-ead5-4d15-1521-08db5b1d1e55
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 23:34:42.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYIWCpM6nAN86uqzQ1Xbzsi4xdKFMttRaQa7oE3JQ+jypytNCf7htVHGJWi7K/d9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8908
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-05-22 at 22:43, Uwe Kleine-König wrote:
> Hello Peter,
> 
> On Mon, May 22, 2023 at 09:28:39PM +0200, Peter Rosin wrote:
>> 2023-05-22 at 19:23, Uwe Kleine-König wrote:
>>> On Mon, May 22, 2023 at 05:19:43PM +0200, Peter Rosin wrote:
>>>> I have a device with a "sound card" that has an amplifier that needs
>>>> an extra boost when high amplification is requested. This extra
>>>> boost is controlled with a pwm-regulator.
>>>>
>>>> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
>>>> device no longer works. I have tracked the problem to an unfortunate
>>>> interaction between the underlying PWM driver and the PWM core.
>>>>
>>>> The driver is drivers/pwm/pwm-atmel.c which has difficulties getting
>>>> the period and/or duty_cycle from the HW when the PWM is not enabled.
>>>> Because of this, I think, the driver does not fill in .period and
>>>> .duty_cycle at all in atmel_pwm_get_state() unless the PWM is enabled.
>>>>
>>>> However, the PWM core is not expecting these fields to be left as-is,
>>>> at least not in pwm_adjust_config(), and its local state variable on
>>>> the stack ends up with whatever crap was on the stack on entry for
>>>> these fields. That fails spectacularly when the function continues to
>>>> do math on these uninitialized values.
> 
> After looking again, I don't understand that part. Note that
> pwm_get_state() doesn't call .get_state() at all. Also pwmchip_add()
> zero initializes .state, then pwm_get() calls .get_state() (via
> pwm_device_request() which is called in .xlate()) which (if the HW is
> disabled) doesn't touch .period, so it should continue to be zero?!
> 
> So I wonder why your approach 2 works at all. Do you see what I'm
> missing?

I tried various things on top of v6.3 and you are right. My hunks do
not make a (significant) difference there.

So, I took a step back and can only conclude that there must be some
another regression to find, and I was confused by that other regression.
In short, I was on 6.1.<foo> and everything was fine, and then I bumped
to 6.3 and a process crashed. I went to 6.2 and that same process also
crashed. I then totally focused on v6.1..v6.2 to figure out the problem.
I simply assumed v6.3 had the same problem because the symptom from
30.000ft was the same (that process died). I failed to go back to v6.3
to confirm that it was indeed the same problem as I had found in the
v6.1..v6.2 range.

My bad, it seems I have another day of bisections lined up.

>>>> In particular, I find this in the kernel log when a bad kernel runs:
>>>> pwm-regulator: probe of reg-ana failed with error -22
>>>>
>>>> Before commit c73a3107624d this was a silent failure, and the situation
>>>> "repaired itself" when the PWM was later reprogrammed, at least for my
>>>> case. After that commit, the failure is fatal and the "sound card"
>>>> fails to come up at all.
>>>>
>>>>
>>>> I see a couple of adjustments that could be made.
>>>>
>>>> 1. Zero out some fields in the driver:
>>>>
>>>> @@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>  		state->enabled = true;
>>>>  	} else {
>>>> +		state->period = 0;
>>>> +		state->duty_cycle = 0;
>>>>  		state->enabled = false;
>>>>  	}
>>>
>>> I don't particularily like that. While state->period is an invalid
>>> value, IMHO enabled = false is enough information from the driver's POV.
>>
>> This was the preferred approach of Thierry, and given the number of
>> call sites for pwm_get_state with a local variable, I can sympathize
>> with that view.
> 
> I looked a bit more into the issue and think that pwm_get_state() isn't
> problematic. pwm_get_state() fully assigns *state.

Right, the only way pwm_get_state() can be problematic is if bogus values
have made their way into pwm->state earlier. Which is what happened for
v6.2.

>> At the same time, fixing drivers one by one is not
>> a fun game, so I can certainly see that approach 3 also has an appeal.
> 
> What I don't like about it is that the output of a disabled PWM doesn't
> have a period. There might be one configured in hardware(, and the
> .get_state() callback might or might not return that), but the emitted
> signal has no well-defined period.
> 
>>>> 2. Don't try to "adjust" a disabled PWM:
>>>>
>>>> @@ -656,7 +656,7 @@ int pwm_adjust_config(struct pwm_device *pwm)
>>>>  	 * In either case, we setup the new period and polarity, and assign a
>>>>  	 * duty cycle of 0.
>>>>  	 */
>>>> -	if (!state.period) {
>>>> +	if (!state.enabled || !state.period) {
>>>>  		state.duty_cycle = 0;
>>>>  		state.period = pargs.period;
>>>>  		state.polarity = pargs.polarity;
>>>
>>> In my book code that calls pwm_get_state() should consider .period
>>> (and .duty_cycle) undefined if .enabled is false. So this hunk is an
>>
>> I agree fully. This feels like a good hunk.
>>
>>> improvement. Having said that, I think pwm_adjust_config() has a strange
>>> semantic. I don't understand when you would want to call it, and it only
>>> has one caller (i.e. pwm-regulator).
>>
>> I believe it's for a case where some bootstrap/bootloader has configured
>> a PWM in order to set up a regulator for some critical component, and the
>> kernel needs to cake over the responsibility seamlessly, or everything
>> will take a dive. I deduced that from the description of pwm_adjust_config:
> 
> If it wants to take over seamlessly, it shouldn't call pwm_apply_state()
> at all?!
> 
>>  * This function will adjust the PWM config to the PWM arguments provided
>>  * by the DT or PWM lookup table. This is particularly useful to adapt
>>  * the bootloader config to the Linux one.
>>
>> But what do I know?
> 
>>> So another option would be
>>>
>>> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
>>> index b64d99695b84..418aff0ddbed 100644
>>> --- a/drivers/regulator/pwm-regulator.c
>>> +++ b/drivers/regulator/pwm-regulator.c
>>> @@ -368,10 +368,6 @@ static int pwm_regulator_probe(struct platform_device *pdev)
>>>  		return ret;
>>>  	}
>>>  
>>> -	ret = pwm_adjust_config(drvdata->pwm);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>  	regulator = devm_regulator_register(&pdev->dev,
>>>  					    &drvdata->desc, &config);
>>>  	if (IS_ERR(regulator)) {
>>>
>>> and drop pwm_adjust_config() as a followup?!
>>
>> As described above, I think that might be too drastic?
>>
>>>> 3. Zero out the state before calling pwm_get_state:
>>>>
>>>> @@ -115,7 +115,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>>>>  	}
>>>>  
>>>>  	if (pwm->chip->ops->get_state) {
>>>> -		struct pwm_state state;
>>>> +		struct pwm_state state = { .enabled = true };
>>>
>>> I wonder why you picked .enabled = true here but = false on all other
>>> code locations.
>>
>> Silly typo, soory.
>>
>>> Also you don't seem to have 1271a7b98e7989ba6bb978e14403fc84efe16e13
>>> which has the same effect and is included in v6.3 and v6.2.13.
>>
>> Right, approach 3 felt so ugly and intrusive that I didn't bother to take
>> it beyond the problematic commit (and hinted at that further down: "It also
>> needs a rebase from the culprit commit"). Having said that, 1271a7b98e79 is
>> not enough, or else I would never have noticed the problem in the first
>> place. I don't think the hunk in pwm_dbg_show() makes any difference for my
>> case since I heven't enabled debugging, and a double-check confirms it:
>> After 1271a7b98e79, zeroing "state" in pwm_adjust_config() is enough to kill
>> this regression.
> 
> That really puzzles me because pwm_get_state() fully overwrites state.

I only verified that I had no problem /with/ my change. See above.

Sorry for wasting time.

Cheers,
Peter

> 
> Best regards
> Uwe
> 
