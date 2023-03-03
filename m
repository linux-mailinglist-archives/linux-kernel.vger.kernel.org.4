Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A661A6A9D88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjCCRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjCCRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:22:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB7B47412;
        Fri,  3 Mar 2023 09:22:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v11so3380413plz.8;
        Fri, 03 Mar 2023 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677864167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZ0yRbLHd3Wr71an5cQHd2FCNjUUsIkuTpqCSXw/Mqs=;
        b=UCXMER65x2eX6yEL3Pt43jiBjYYiB/jIYcaG8Ou5AfG1RqRhNPCRNWJ8zAuhZCJL6O
         7CGWfNPajJutK9syRpLG0/oOXZpuey/pg99Mt5+BjBXBedehXbRsAqNx30YYUYbfmwPv
         SFzZiVDSwWojo1Pt3gafso/ztG9q99VMCAf2aujAPffw/Ev2wM0e7JAZgJV/5Cmsy8EJ
         NPcFWUWKnDl6tvj6rTSQ3gLGnxkvQ6h30QC5S5+FywnkRG+VU2pkDUF5ly24bmb9FXSc
         tc3c6nF/rIHBZ91QjAzQjZsdLaZkVC6fakukOQliUR9W1kONo9LN+rp2TT3RpqNkwSWL
         N6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ0yRbLHd3Wr71an5cQHd2FCNjUUsIkuTpqCSXw/Mqs=;
        b=TDo0bzM53v5QdK3jE83Njx7VMttB2FaSU0DBeJnqx41zayPjrfz74zvdHqfbaIozIi
         mUAoTdA1c0eBvMJFJLYKIubHqIO2r7uA247saaGvFrK6+s1xnO6YhzGwZ9o47B6f9IAb
         VpOiJGNJVjJ3kJCoxuUnYrDFOlR60VLPR4aJUVlalHt5n0fjJHq+N4TLUqsV93H35cwV
         tLVnAou+nTZ8pvyjXEjKGwgLwkYGUoYLDZHfnCAEiHpDs2jGQcZXujD6MiU5ehI9dZxY
         2GZfiuvrhPMX72SRaR9e8XrrFsf2NiXCMzTCDY+kPbW+Pdf8izVCU7acCKzOD8L7UQLX
         2Jdg==
X-Gm-Message-State: AO0yUKW6CQaadOddBVb/Bsk1GuCD22ESZgVSQbktvvA0/xAYibH9jrsB
        lzF4jEBtYfXX3utK0FIoDqE=
X-Google-Smtp-Source: AK7set+IB3Yt0j0YIA+R51E769nb/1irAbj4f/cTxpNdNFvFocHb4l/Q9POMMArw9LIy+kjyznGH1g==
X-Received: by 2002:a05:6a21:6d9a:b0:be:a9c7:5d12 with SMTP id wl26-20020a056a216d9a00b000bea9c75d12mr3372411pzb.18.1677864166572;
        Fri, 03 Mar 2023 09:22:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e16-20020a62ee10000000b005d791692727sm1875473pfi.191.2023.03.03.09.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:22:45 -0800 (PST)
Message-ID: <667f007f-1cb0-7e89-242a-c41823e82bee@gmail.com>
Date:   Fri, 3 Mar 2023 09:22:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] serdev: Set fwnode for serdev devices
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel-team@android.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302023509.319903-1-saravanak@google.com>
 <2cc752fb-a25d-0789-0fad-54b99f08ced7@i2se.com>
 <CAGETcx_nCdm2WYLC7h1s8i9tnHc_LcHk2oZUQ0sUDr-PBsUWDg@mail.gmail.com>
 <faad8810-7aa4-e122-f497-73553feb8bcd@gmail.com>
 <98f5abe2-3d25-661a-a2b8-a50e2d27f085@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <98f5abe2-3d25-661a-a2b8-a50e2d27f085@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 03:57, Stefan Wahren wrote:
> Hi,
> 
> Am 02.03.23 um 18:51 schrieb Florian Fainelli:
>>
>>
>> On 3/2/2023 9:20 AM, Saravana Kannan wrote:
>>> On Thu, Mar 2, 2023 at 9:01 AM Stefan Wahren <stefan.wahren@i2se.com> 
>>> wrote:
>>>>
>>>> Hi Saravana,
>>>>
>>>> Am 02.03.23 um 03:35 schrieb Saravana Kannan:
>>>>> This allow fw_devlink to do dependency tracking for serdev devices.
>>>>>
>>>>> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>> Link: 
>>>>> https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
>>>>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>
>>>> since this fixes an issue on Raspberry Pi 4, shouldn't this be 
>>>> mentioned
>>>> in the commit message and providing a Fixes tag?
>>>
>>> So RPi 4 was never creating a device links between serdev devices and
>>> their consumers. The error message was just a new one I added and we
>>> are noticing and catching the fact that serdev wasn't setting fwnode
>>> for a device.
>>>
>>> I'm also not sure if I can say this commit "Fixes" an issue in serdev
>>> core because when serdev core was written, fw_devlink wasn't a thing.
>>> Once I add Fixes, people will start pulling this into stable
>>> branches/other trees where I don't think this should be pulled into
>>> older stable branches.
>>
>> That is kind of the point of Fixes: tag, is not it? It is appropriate 
>> to list a commit that is not specific to serdev, but maybe a 
>> particular point into the fw_devlink history. Given this did not 
>> appear to have a functional impact, we could go without one.
> 
> i was under the impression that this issue breaks at least Bluetooth on 
> Raspberry Pi 4 because the driver is never probed. I cannot see the 
> success output in Florian's trace. Something like this:
> 
> [    7.124879] hci_uart_bcm serial0-0: supply vbat not found, using 
> dummy regulator
> [    7.131743] hci_uart_bcm serial0-0: supply vddio not found, using 
> dummy regulator
> ...
> [    7.517249] Bluetooth: hci0: BCM: chip id 107
> [    7.517499] Bluetooth: hci0: BCM: features 0x2f
> [    7.519757] Bluetooth: hci0: BCM4345C0
> [    7.519768] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
> [    7.539495] Bluetooth: hci0: BCM4345C0 'brcm/BCM4345C0.hcd' Patch
> ...
> [    8.348831] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
> [    8.348845] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
> 
> I just want to make sure that 6.2 doesn't have a regression.

My configuration uses hci_uart as a module, and it would always load 
fine, but I suppose I can make sure that even built-in this works 
properly. Give me a day or two to test that.
-- 
Florian

