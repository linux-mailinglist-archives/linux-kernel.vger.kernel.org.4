Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CE608EC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJVRPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJVRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:15:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6754677;
        Sat, 22 Oct 2022 10:15:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so9490693wrr.3;
        Sat, 22 Oct 2022 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEdRsgVqCkcKz4eZ7jkOylFepk0zkXtGkfANql0O2yY=;
        b=eDHT+PdTkIpoA25cMakJH7LwzPhBP3+NLqYVcxGoKNV/kY/iRn4XvItq9CASOMKBhz
         8V/Q5Wqq6WzKuKE8ScZ+DAXjp+EBhgNKy7dKLvxM1kQG9BlY8NWyjzcvy0+cLXZgtnVb
         z7WxJ8m58IsjgXN3ijExpHHd2iUYYxS3AVmCfnLA2qPNV/Ybn9TlyKZ25+if9XxIaDKH
         UuFFNYliJYaaporq2xKqMbW8/5hRTL+LNUAkt2YxETG7l8Y1jVepQDxsJPVx7aRQ9WPq
         U613c1blBAGUs7IDXWZlxY9p+TMh3I3tFTTwNStYXmpiQmyY8tK8QmZg47xBDocB2COn
         RVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OEdRsgVqCkcKz4eZ7jkOylFepk0zkXtGkfANql0O2yY=;
        b=264gNRmwis7kijoprGHI3FTUEhi/GhzEzG9cspA0CUcxjgELtSeHuC6MovbwIkS9a/
         lpeiJjlzqMJ/Lck3bAZCGX2DhSU/IguFfN8r50oF5xx7YoFGFcBIRXwFZi1BPLu62wsB
         wZdS/bO8oTQNWQeeWv6TunsW45GlUvTj2kvwe6albCEhcRxPcTkwOchdSwoJvIfL9PNT
         b7k9gDmCfPogZQWaPPIEFbYKJ4O7pT/Lft1mpB4UADTOBcpmz34mNgG8XTJqSuaKz8dS
         CN9WNQ/yZTHc1a2QZLH6OK4pvVgjhZkThQFje7rlrTEQ5mtBOQBKrNrubsfYu/qklXYU
         8tfw==
X-Gm-Message-State: ACrzQf1a/JXunOfHLbQCTYpbfEh7x6BNf4fgCzw4thiiJnAhQxtXx+VK
        3WMqhYbaEBzWRNRG3+G9oiE=
X-Google-Smtp-Source: AMsMyM5GACKMhemPzQfhXeK8J8ZeCfuB8vay27pyTEULvy/cKHgyGpAjBE0I36JUTkg7zlSZEqPa1w==
X-Received: by 2002:a5d:5142:0:b0:236:5d8d:6254 with SMTP id u2-20020a5d5142000000b002365d8d6254mr2649278wrt.514.1666458906363;
        Sat, 22 Oct 2022 10:15:06 -0700 (PDT)
Received: from localhost (188.29.215.65.threembb.co.uk. [188.29.215.65])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b003b4a68645e9sm3341141wmg.34.2022.10.22.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 10:15:05 -0700 (PDT)
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
 <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
 <ROSYER.QTJF8J14H2YX1@crapouillou.net>
 <6f2c7a0b-b68b-fc42-1a82-2b69c114823f@wanyeetech.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Zhou Yanjie <zhouyu@wanyeetech.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
In-reply-to: <6f2c7a0b-b68b-fc42-1a82-2b69c114823f@wanyeetech.com>
Date:   Sat, 22 Oct 2022 18:15:05 +0100
Message-ID: <UQ597w4FmzOT8p76tdRPhzECStUpFmYe@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Zhou Yanjie <zhouyu@wanyeetech.com> writes:

> Hi Paul,
>
> On 2022/7/13 =E4=B8=8B=E5=8D=8811:07, Paul Cercueil wrote:
>> Hi Zhou,
>>
>> Le mer., juil. 13 2022 at 22:33:44 +0800, Zhou Yanjie <zhouyu@wanyeetech=
.com>
>> a =C3=A9crit :
>>> Hi Aidan,
>>>
>>> On 2022/7/9 =E4=B8=8A=E5=8D=8812:02, Aidan MacDonald wrote:
>>>> @@ -400,6 +402,7 @@ static const struct i2s_soc_info jz4740_i2s_soc_in=
fo =3D
>>>> {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .field_tx_fifo_thresh=C2=A0=C2=A0=C2=A0=
 =3D REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .field_i2sdiv_capture=C2=A0=C2=A0=C2=A0=
 =3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .field_i2sdiv_playback=C2=A0=C2=A0=C2=
=A0 =3D REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
>>>> +=C2=A0=C2=A0=C2=A0 .pll_clk_name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D "pll half",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shared_fifo_flush=C2=A0=C2=A0=C2=A0 =
=3D true,
>>>> =C2=A0 };
>>>
>>>
>>> Since JZ4760, according to the description of the I2SCDR register,
>>> Ingenic SoCs no longer use PLL/2 clock, but directly use PLL clock,
>>> so it seems also inappropriate to use "pll half" for these SoCs.
>>
>> The device tree passes the clock as "pll half". So the driver should use=
 this
>> name as well...
>
>
> I see...
>
> It seems that the device tree of JZ4770 has used "pll half" already,
> but there is no "pll half" used anywhere in the device tree of JZ4780,
> maybe we can keep the pll_clk_name of JZ4770 as "pll half", and change
> the pll_clk_name of JZ4780 to a more reasonable name.
>
>
> Thanks and best regards!

Actually, the clock names in the DT are meaningless. The clk_get() call
matches only the clock's name in the CGU driver. So in fact the driver
is "broken" for jz4780. It seems jz4770 doesn't work correctly either,
it has no "pll half", and three possible parents for its "i2s" clock.

Since the driver only supports the internal codec, which requires the
"ext" clock, there isn't a problem in practice.

I'm just going to drop this patch and leave .set_sysclk() alone for now.
I think a better approach is to have the DT define an array of parent
clocks for .set_sysclk()'s use, instead of hardcoding parents in the
driver. If the parent array is missing the driver can default to using
"ext" so existing DTs will work.

Regards,
Aidan
