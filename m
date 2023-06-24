Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1304B73CBC4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjFXP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjFXP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:59:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219B1AC;
        Sat, 24 Jun 2023 08:59:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so3480559e87.0;
        Sat, 24 Jun 2023 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687622373; x=1690214373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxD3mnsyxsM9A/pK/r4bmilX/vIQZZ/iBExyMlW0hWI=;
        b=CdxPGMxddVeIEqvQbb6zVuOBbZtFYaa46/5i1pb94WXHhCEK8ugsf1ZTdByvsXJ9of
         dBth1XXjCG2yJj5u+9HOPMcVNny4WjJUpJgz0CobZcjC57wmrTKxEEuHYVy04+piY0my
         0p3mWYKl94I53iWEvqGMeEL8nIXLm0EE9+75vrzyC6zTHek0kGWZufe35BAdQ4eChRqU
         qHRBezqnI7fzTqgEEboO8aNRTdgc+DTRyAyov2bQ4f2T2EeHOPixlNqOufs6J7eDbIPC
         IG2TQn8AXJNmpRter5Aqx1JRrxJnLdBscufmaqzPjzt750Hj1vkRRiKAhho2hC76ShVe
         R+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687622373; x=1690214373;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxD3mnsyxsM9A/pK/r4bmilX/vIQZZ/iBExyMlW0hWI=;
        b=JMBmNVPNSAvtfcsbcmsL6eT0FeNF11Dp57lSRzNGlCUGieE4NQT7drsM8hQ2/DyfmJ
         6Buvdbxwx+QDrpO8QnlJQz6vCP2C1iypWhNSEjynAsH/FZZYnvbpPd/fVf/kifvq8K4Q
         TzSTjXK5kqNyKgXTWfZ1lAAxvrPWSeTAX9ddTke0so1QwdnfmByN1MLgOgvMlazFFRq4
         TldKctk83tfiRhksg2NUwLkA23+0OI2hzC8UTuoYKOV9xX4sMUoXC1LmHD4wWV1qbcqE
         mIJNvsqKyTCGxoitNirZvS0Nrhm4mgZdQanGo6by7q1ToslLszqR1U/1Se/5l7PAWSc2
         XTXA==
X-Gm-Message-State: AC+VfDwOiA798UaV8ERujRARLOm7T/VFKBwCmUMf4Weo3syEUpVFKWNT
        hHSJN8QzVPpmKO1D+WBdY54=
X-Google-Smtp-Source: ACHHUZ7WNyxGMyfLzLSOkyJb4r3sDazr+QBWvq4tE/boVMXXeJq4RitMkVuWZUYRRMXR8/WZubyoMA==
X-Received: by 2002:a05:6512:3c89:b0:4f8:78a8:bfea with SMTP id h9-20020a0565123c8900b004f878a8bfeamr5774392lfv.16.1687622372625;
        Sat, 24 Jun 2023 08:59:32 -0700 (PDT)
Received: from [192.168.1.100] ([185.8.126.245])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004fad16596fasm31748lfp.21.2023.06.24.08.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 08:59:32 -0700 (PDT)
Message-ID: <a0d74f3f-4208-d7e3-7eed-481a06b13308@gmail.com>
Date:   Sat, 24 Jun 2023 18:59:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 6/6] meson saradc: support reading from channel7 mux
 inputs
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
References: <20230623022334.791026-1-gnstark@sberdevices.ru>
 <20230623022334.791026-7-gnstark@sberdevices.ru>
 <CAFBinCBv993Xv_wk9fE-U0Tw2mzTB1z22Tj6x8Uy1rRw_dztng@mail.gmail.com>
From:   George Stark <stark.georgy@gmail.com>
In-Reply-To: <CAFBinCBv993Xv_wk9fE-U0Tw2mzTB1z22Tj6x8Uy1rRw_dztng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin

Thanks for review

On 6/23/23 09:16, Martin Blumenstingl wrote:
> Hi George,
>
> On Fri, Jun 23, 2023 at 4:23 AM George Stark <gnstark@sberdevices.ru> wrote:
> [...]
>> Meson saradc channel 7 is connected to muxer that can switch channel
> I think that this should read: ... is connected to a mux that ...
>
> [...]
>>   static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>> @@ -245,6 +280,11 @@ static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
>>          MESON_SAR_ADC_CHAN(INDEX_CHAN_6),
>>          MESON_SAR_ADC_CHAN(INDEX_CHAN_7),
>>          IIO_CHAN_SOFT_TIMESTAMP(INDEX_CHAN_SOFT_TIMESTAMP),
>> +       MESON_SAR_ADC_MUX(INDEX_MUX_0_VSS, 0),
>> +       MESON_SAR_ADC_MUX(INDEX_MUX_1_VDD_DIV4, 1),
>> +       MESON_SAR_ADC_MUX(INDEX_MUX_2_VDD_DIV2, 2),
>> +       MESON_SAR_ADC_MUX(INDEX_MUX_3_VDD_MUL3_DIV4, 3),
>> +       MESON_SAR_ADC_MUX(INDEX_MUX_4_VDD, 4),
>>          MESON_SAR_ADC_TEMP_CHAN(), /* must be the last item */
> I haven't had the chance to run these patches yet but: I think they
> are breaking the temperature sensor readings on Meson8/8b/8m2 boards.
> See arch/arm/boot/dts/meson.dtsi where the temperature channel is
> being referenced:
>    io-channels = <&saradc 8>
>
> With this series (this patch and I think also patch 3/6 "meson saradc:
> unite iio channel array definitions") the numbering of the temperature
> sensor channel changes.
>
> To make things worse: in theory we can use meson_saradc to read the
> SoC temperature sensor on GXBB, GXL and GXM boards (possibly on AXG as
> well but I can't recall from the top of my head) instead of going
> through SCPI.
> I have experimented with this in the past but never got it to work.
> Doing so in the future could lead to another channel index change,
> depending on how we decide to go forward now.
>
> There's two that I can think of:
> - update meson.dtsi to use the new channel numbering (I don't expect
> many 32-bit SoC users out there using new kernel + old .dtbs, but it's
> impossible to say for sure)
> - or keep the driver backwards compatible (that involves re-adding the
> channel tables)
>
> What do you think?
Actually we'd have to make 2 patches to meson.dtsi, the first change 
8->9, than 9 ->14.
And if that index exposed externally (ABI like) I'd not change it 
without good reason at all.
So I think to return to double definition of meson_sar_adc_iio_channels 
and keep the driver backwards compatible.

I've just realized another moment with channels defined after 
MESON_SAR_ADC_TEMP_CHAN in channel array.
In dts by default channels are referenced by channel array index not 
even by channel number.
So channel e.g MUX_0_VSS will have the same number (due to enum patch) 
but different index on meson8 and gxbb.
As alternative we can implement fwnode_xlate method in meson adc driver 
and use channel numbers in dts
(probably not in the current patchset).

Best regards,
George

>
> Best regards,
> Martin
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic


