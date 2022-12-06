Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C287643A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLFAtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:49:19 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1171B7AD;
        Mon,  5 Dec 2022 16:49:17 -0800 (PST)
Received: (Authenticated sender: alex@alexyzhang.dev)
        by mail.gandi.net (Postfix) with ESMTPSA id A77A0240003;
        Tue,  6 Dec 2022 00:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexyzhang.dev;
        s=gm1; t=1670287755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A+PjSyDCFr/3XIz4V2NNmkUhvkPTvwX282wMPuLzm4c=;
        b=BiGcc39XIdtvKnCQ/6EtcVS/7ZIkJ5gExJpoA3tKerelRAQIRZpNaj5rH9gnmpiqO+s/I1
        HsP+0P40ua6+Tw8/8VStvpPczvol/NhkAyGuWHmjI+E8UQbyJ9MukNYQE7GDB9D3epYXU7
        KF8DyO2U0Q/U21CfgTHRl/1YvdrKKUWGsHgtkfi4H9TgC+aV5qsUiVp2BtmWlQxwGt/viT
        B1h40uhDxieOgwqInRs+pShLhG1LHgfdTNn7yn7KVaE0PU7SrmmEY9qRdIJMZnn6wey2gY
        tovVyW78yNW0dEJ+BnNQ5vUU3niqL073VdMT0v4Fre9D8JXOm8TfFC6L4FJKZg==
Message-ID: <1dc9d0ba-4836-dfc6-8bf2-322ce3b5c24d@alexyzhang.dev>
Date:   Mon, 5 Dec 2022 16:49:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
Content-Language: en-US
From:   Alexander Zhang <alex@alexyzhang.dev>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        benjamin.tissoires@redhat.com, openglfreak@googlemail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110174056.393697-1-jose.exposito89@gmail.com>
 <e1daf0a9-b699-affd-0d14-e46981733096@alexyzhang.dev>
 <nycvar.YFH.7.76.2211141509340.6045@cbobk.fhfr.pm>
 <d08049f2-443b-f769-cfde-629cdfb96fc0@alexyzhang.dev>
In-Reply-To: <d08049f2-443b-f769-cfde-629cdfb96fc0@alexyzhang.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 11/19/22 11:01 PM, Alexander Zhang wrote:
> On 11/14/22 6:10 AM, Jiri Kosina wrote:
>> On Thu, 10 Nov 2022, Alexander Zhang wrote:
>>
>>> Hi José,
>>>
>>> On 11/10/22 9:40 AM, José Expósito wrote:
>>>> Hi everyone,
>>>>
>>>> About 3 months ago, Torge Matthies sent a patch fixing an issue with
>>>> his XP-Pen Star G640 [1].
>>>>
>>>> His patch changes the IS_INPUT_APPLICATION() macro to accept
>>>> HID_DG_DIGITIZER. However, it looks like it is not being merged because
>>>> of the possible side effects that changing that macro could generate.
>>>>
>>>> This patch aims to fix the same issue but using a more conservative
>>>> approach hoping that the bug can be fixed.
>>>>
>>>> Torge, Alexander, could you test it and confirm that it fixes your
>>>> issues, please?
>>>
>>> I tested the patch on commit 4bbf3422df78 and it fixes the issue.
>>
>> I will add
>>
>>     Tested-by: Alexander Zhang <alex@alexyzhang.dev>
>>
>> to the commit; please speak up if you disagree.
> 
> I'm not sure if you're still waiting for a response from me but I'm fine 
> with that.

Is there something preventing this patch from being merged? I'm not very 
familiar with the kernel development process.

Best,
Alexander Zhang
