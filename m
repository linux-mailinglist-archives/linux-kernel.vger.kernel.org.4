Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20A46732FF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjASHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASHxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:53:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034485B80;
        Wed, 18 Jan 2023 23:53:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s21so1772990edi.12;
        Wed, 18 Jan 2023 23:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWviBnBumLa3lo5dwVP+uotrksiLTeP+2ci/rlH33Ks=;
        b=T5UxcrAvnlPwErYlYjaaCYCHK0tvutr+16i5q64bp4X1NZwevZYx+vreTJhv2pUhE3
         PBP/12VMv1h5nn0IC9NZwOoC2SlFQ5Ure1efJaReQ3zkyaNSv8H3Mxy00iTKb/L2KkKW
         VO3KEXIunNHVjNryMqxlAuWlaDnkaKJGRQ3QmqxpchlyrjhDS17RaG43TIcNHtrC3fT3
         pxBvPHF1CPX4M3m6U8ZfDk8wN+Xu2L0FyiF9cj9FctU2yX42yXY9NpH8bQvTDSBnrPuo
         PAtxU836CAuLPcgCcC7FNUgQ0UA6g9JtcKOlNHkPGv1/J1zQlJVJLuUQAox1zNmUjDTJ
         Vgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWviBnBumLa3lo5dwVP+uotrksiLTeP+2ci/rlH33Ks=;
        b=eDiq/52CcK+wBLu44YSD6pg6D889clDj4bBbrbkAbnDgJzzbK2mAnl3XDQXCiq7Jyo
         A28p4fteyPsrN8gicFfDyM7IU04p2ywEZocT9nO7suUaSvTkwjbol5TiXlYh8B3WB1vE
         UtP0FrDnsg95tuACFRDbcVxEC7CE9JtubY3n9vx5DndWtdeKU5wTvicpMDcAdZjFN6ni
         kB5MhkNrh2smWpQ5p3RS0CiNNiuPtFFxOVUpLVll8RYJbj2tPgjtQ2Rvm2OSqjQOWYTS
         9S9azTzpLh9B520xe05x2TkGj0ZjFeQp9X5qjwjrwphfVrSu6WKR+A9N9FN5J5PjmsLz
         XQxg==
X-Gm-Message-State: AFqh2kopAXVuFSJ0vKSjXRXgW/lN3plpkPJNPAoLXjM4ra279XnXLfko
        ATtGxl89Hl0Wk2gvaBlvtR0=
X-Google-Smtp-Source: AMrXdXtC1FhLxOa5uddlJTrPG2c8t/oFYkLbKvmlT6Q60PgvJzzurTbjwq5gdVLJM7BwN/R3/hD20A==
X-Received: by 2002:aa7:c44d:0:b0:46c:b919:997f with SMTP id n13-20020aa7c44d000000b0046cb919997fmr870882edr.17.1674114823272;
        Wed, 18 Jan 2023 23:53:43 -0800 (PST)
Received: from ?IPV6:2a01:c23:c477:4300:6902:d630:fe6:8186? (dynamic-2a01-0c23-c477-4300-6902-d630-0fe6-8186.c23.pool.telefonica.de. [2a01:c23:c477:4300:6902:d630:fe6:8186])
        by smtp.googlemail.com with ESMTPSA id w1-20020aa7dcc1000000b0047a3a407b49sm15278976edu.43.2023.01.18.23.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:53:42 -0800 (PST)
Message-ID: <e40f8fec-58b0-cb93-7858-6ac143b83747@gmail.com>
Date:   Thu, 19 Jan 2023 08:53:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Peter Suti <peter.suti@streamunlimited.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
 <20221214134620.3028726-1-peter.suti@streamunlimited.com>
 <c6863a3e-8855-50fe-25cb-0b38bc3a05e0@gmail.com>
 <CACMGZgZY4Zb+3vHUDAS0+3r55K4_J40dtbsTPTFZMd6duBikpQ@mail.gmail.com>
 <7c4aa0d2-d8e9-416b-b2ad-f5c3c8ea33de@gmail.com>
 <CACMGZgaS7z2YoViA3jV-gVBvASSq1maiGj_6hfrJQ3zr69esgQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
In-Reply-To: <CACMGZgaS7z2YoViA3jV-gVBvASSq1maiGj_6hfrJQ3zr69esgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.2023 14:32, Peter Suti wrote:
> On Thu, Jan 12, 2023 at 10:27 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 09.01.2023 12:52, Peter Suti wrote:
>>> On Wed, Dec 14, 2022 at 10:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 14.12.2022 14:46, Peter Suti wrote:
>>>>>
>>>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>>>> index 6e5ea0213b47..7d3ee2f9a7f6 100644
>>>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>>>> @@ -1023,6 +1023,22 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>>>>>       if (ret == IRQ_HANDLED)
>>>>>               meson_mmc_request_done(host->mmc, cmd->mrq);
>>>>>
>>>>> +     /*
>>>>> +     * Sometimes after we ack all raised interrupts,
>>>>> +     * an IRQ_SDIO can still be pending, which can get lost.
>>>>> +     *
>>>>
>>>> A reader may scratch his head here and wonder how the interrupt can get lost,
>>>> and why adding a workaround instead of eliminating the root cause for losing
>>>> the interrupt. If you can't provide an explanation why the root cause for
>>>> losing the interrupt can't be fixed, presumably you would have to say that
>>>> you're adding a workaround for a suspected silicon bug.
>>> After talking to the manufacturer, we got the following explanation
>>> for this situation:
>>
>> To which manufacturer did you talk, Marvell or Amlogic?
> 
> Amlogic
> 
>>
>>> "wifi may have dat1 interrupt coming in, without this the dat1
>>> interrupt would be missed"
>>
>> I don't understand this sentence. W/o the interrupt coming in
>> the interrupt would be missed? Can you explain it?
> 
> So the "without this" part of that sentence referred to the patch.
> Which means that without the patch, the interrupt can be missed.
> 

Did you ask Amlogic for the root cause of the problem? Silicon bug?

>>
>>> Supposedly this is fixed in their codebase.
>>
>> Which codebase do you mean? A specific vendor driver? Or firmware?
> 
> The vendor driver from openlinux2.amlogic.com handles SDIO interrupts
> a bit differently. It uses mmc_signal_sdio_irq()
> 
This is the legacy API for SDIO irq.

>>
>>> Unfortunately we were not able to find out more and can't prepare a
>>> patch with a proper explanation.
>>
>> The workaround is rather simple, so we should add it.
>> It's just unfortunate that we have no idea about the root cause of the issue.
> 
> After doing a more long term stress test, it was revealed that this
> patch is still not sufficient, but only masks the underlying problem
> better. Reverting 066ecde fixes the issue fully for us (verified
> overnight with iperf).
> v1 and v2 also fix the issue, but v3 does not correct the bug when
> WiFi is stressed for a longer time. And therefore it should not be
> used.
> Could you please give us some advice on how to investigate this further?

When talking about v2 of the patch, it includes a number of actual changes:

- hold lock from start to end of interrupt handler
- if SDIO irq was disabled when entering the irq handler I see no change
- if SDIO irq was enabled
  - disable SDIO irq at start of irq handler, no matter which type of interrupt was received
    -> means disable SDIO irq during irq handler even if some other interrupt was received
  - if SDIO and another interrupt source flag is set, leave irq handler with SDIO irq enabled.
    Not sure whether that's intentional, you can use the small patch listed below on top of v2
    to check whether SDIO irq still works ok or not.
    

At least to me it's not clear which (or all?) of the changes are needed to work
around the problem. So you could check whether SDIO irq still works fine if you
remove a single change from the patch.


diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f4b102b85..711431706 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -994,6 +994,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 			spin_unlock(&host->lock);
 			return IRQ_HANDLED;
 		}
+		irq_enabled = false;
 	}
 
 	if (WARN_ON(!cmd))
-- 
2.39.0


