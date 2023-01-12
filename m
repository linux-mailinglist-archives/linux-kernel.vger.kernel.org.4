Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E9766858F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjALVg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbjALVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:36:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939B758D33;
        Thu, 12 Jan 2023 13:27:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso16151463wms.5;
        Thu, 12 Jan 2023 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQ1D5UHr4tggTsAIC/Qawu9eWnHs++i/i+4IgFLa5Fw=;
        b=hktHdGS8fjL/kAij+ShBbKkzIj2DX4IeZwG+91HsnQGKf9BjwXH25fl46yt6QgbcEZ
         dmfTzOcDhAiTRS+DOw8t0NNS7o2z3LWT2EQVCDBQXjryxipoiYYUFSMUoRPrsu8Bjw68
         7oTIyZXFzZ1z4eQ+R3ziNiRiprFldf6k9DDL3XVIZE7p7R+DaIWlF5741UZf3zeb60kE
         gOTVWs1qky+rvf2lIvNEUzIPpOVFL5VVni7fh9hxWUB1/JSkeEdgsd0lBAfyylezmWve
         QZoodcGMs9F+rrl//E8U8si+5AMME2dFINVfuQHSXJYbjgTdZEJC7Z4wONm8skVmr1L3
         Aw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ1D5UHr4tggTsAIC/Qawu9eWnHs++i/i+4IgFLa5Fw=;
        b=Wma6MZwhMKCL+iq3F2xXD7yrF36CFvhApPkqUHqplWenS3nGWtKVC9Zs3CVYKGRGwW
         FvZyXlHP+FK17yL1DCKpPGP3c5raW5VB07K0oMKUyHPAKArTyCqLmY0GyQnwvWrY/Rl5
         LFVo8GlUdsBx+wmjQ9dCGuL23wOW20BrD+ndVsrAYmCF7AV0pYZYS1L5PhcTgq/mLKp+
         z5AH5/xVUdh4JZoMqwzoe59InM00ddnOzR+TGVkiPMQfPL8/jkT7RoHFgwLT0o6qWEtj
         TTiLU+YT3oknh1r6tUarKl6IXAHnpEgo8YcWZ3xu1iq0Gw2+m7HNsXnsEkgAyputv/RZ
         LcRA==
X-Gm-Message-State: AFqh2kptVhMk+PypTR0w6WLbD921Vt4WvKilCpqAEvREmubjhkScxmCf
        FyvvEq1Hnxxm5YkvsUn9ANq/x02rW7g=
X-Google-Smtp-Source: AMrXdXtQnJrnUij3Vwfvj8mzp6AXzARTTmYdUixlVR2SbeVZiq8jg1v6Uj2Hnt2dBY2MkArqeey85Q==
X-Received: by 2002:a05:600c:601b:b0:3d3:56ce:5693 with SMTP id az27-20020a05600c601b00b003d356ce5693mr55607798wmb.17.1673558869896;
        Thu, 12 Jan 2023 13:27:49 -0800 (PST)
Received: from ?IPV6:2a01:c22:76ef:5d00:a043:7bec:4d7a:60ff? (dynamic-2a01-0c22-76ef-5d00-a043-7bec-4d7a-60ff.c22.pool.telefonica.de. [2a01:c22:76ef:5d00:a043:7bec:4d7a:60ff])
        by smtp.googlemail.com with ESMTPSA id u2-20020a05600c210200b003d98f92692fsm1101375wml.17.2023.01.12.13.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 13:27:49 -0800 (PST)
Message-ID: <7c4aa0d2-d8e9-416b-b2ad-f5c3c8ea33de@gmail.com>
Date:   Thu, 12 Jan 2023 22:27:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
In-Reply-To: <CACMGZgZY4Zb+3vHUDAS0+3r55K4_J40dtbsTPTFZMd6duBikpQ@mail.gmail.com>
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

On 09.01.2023 12:52, Peter Suti wrote:
> On Wed, Dec 14, 2022 at 10:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 14.12.2022 14:46, Peter Suti wrote:
>>> With the interrupt support introduced in commit 066ecde sometimes the
>>> Marvell-8987 wifi chip got stuck using the marvell-sd-uapsta-8987
>>> vendor driver. The cause seems to be that after sending ack to all interrupts
>>> the IRQ_SDIO still happens, but it is ignored.
>>>
>>> To work around this, recheck the IRQ_SDIO after meson_mmc_request_done().
>>>
>>> Inspired by 9e2582e ("mmc: mediatek: fix SDIO irq issue") which used a
>>> similar fix to handle lost interrupts.
>>>
>> The commit description of the referenced fix isn't clear with regard to
>> who's fault it is that an interrupt can be lost. I'd interpret it being
>> a silicon bug rather than a kernel/driver bug.
> Unfortunately I can't confirm that the referenced bug is in the
> silicon for the original commit either.
> However a similar workaround works in this case too which is why I
> referenced that commit.
> 
>> Not sure whether it's the case, but it's possible that both vendors use
>> at least parts of the same IP in the MMC block, and therefore the issue
>> pops up here too.
>>
>>> Fixes: 066ecde ("mmc: meson-gx: add SDIO interrupt support")
>>>
>>> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
>>> ---
>>> Changes in v2:
>>>       - use spin_lock instead of spin_lock_irqsave
>>>       - only reenable interrupts if they were enabled already
>>>
>>> Changes in v3:
>>>       - Rework the patch based on feedback from Heiner Kallweit.
>>>               The IRQ does not happen on 2 CPUs and the hard IRQ is not re-entrant.
>>>               But still one SDIO IRQ is lost without this change.
>>>               After the ack, reading the SD_EMMC_STATUS BIT(15) is set, but
>>>               meson_mmc_irq() is never called again.
>>>
>>>               The fix is similar to Mediatek msdc_recheck_sdio_irq().
>>>               That platform also loses an IRQ in some cases it seems.
>>>
>>>  drivers/mmc/host/meson-gx-mmc.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 6e5ea0213b47..7d3ee2f9a7f6 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -1023,6 +1023,22 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>>>       if (ret == IRQ_HANDLED)
>>>               meson_mmc_request_done(host->mmc, cmd->mrq);
>>>
>>> +     /*
>>> +     * Sometimes after we ack all raised interrupts,
>>> +     * an IRQ_SDIO can still be pending, which can get lost.
>>> +     *
>>
>> A reader may scratch his head here and wonder how the interrupt can get lost,
>> and why adding a workaround instead of eliminating the root cause for losing
>> the interrupt. If you can't provide an explanation why the root cause for
>> losing the interrupt can't be fixed, presumably you would have to say that
>> you're adding a workaround for a suspected silicon bug.
> After talking to the manufacturer, we got the following explanation
> for this situation:

To which manufacturer did you talk, Marvell or Amlogic?

> "wifi may have dat1 interrupt coming in, without this the dat1
> interrupt would be missed"

I don't understand this sentence. W/o the interrupt coming in
the interrupt would be missed? Can you explain it?

> Supposedly this is fixed in their codebase.

Which codebase do you mean? A specific vendor driver? Or firmware?

> Unfortunately we were not able to find out more and can't prepare a
> patch with a proper explanation.

The workaround is rather simple, so we should add it.
It's just unfortunate that we have no idea about the root cause of the issue.

> Thank you for reviewing.
>>
>>> +     * To prevent this, recheck the IRQ_SDIO here and schedule
>>> +     * it to be processed.
>>> +     */
>>> +     raw_status = readl(host->regs + SD_EMMC_STATUS);
>>> +     status = raw_status & (IRQ_EN_MASK | IRQ_SDIO);
>>
>> This isn't needed here. Why not simply:
>>
>> status = readl(host->regs + SD_EMMC_STATUS);
>> if (status & IRQ_SDIO)
>>   ...
>>
>>
>>> +     if (status & IRQ_SDIO) {
>>> +             spin_lock(&host->lock);
>>> +             __meson_mmc_enable_sdio_irq(host->mmc, 0);
>>> +             sdio_signal_irq(host->mmc);
>>> +             spin_unlock(&host->lock);
>>> +     }
>>> +
>>>       return ret;
>>>  }
>>>
>>

