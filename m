Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA861049B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiJ0VkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiJ0VkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:40:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457B13912E;
        Thu, 27 Oct 2022 14:40:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g12so4346969wrs.10;
        Thu, 27 Oct 2022 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kplaoMazxKidoLai17lzJFKrm+ggKGLDvODhBftX+wU=;
        b=oPiuoekbwhwKXHFb5AmCssEdvNL7SNFddy8tJxJCaE+txA18j5X/+j0j2mP+IAIDXF
         CwP8rZa1pKbkJNCI7kxVzt6iok+hVMpjrn34DesLErkBF5+Rc7bpWTaMdDV7ffZg8A2o
         YpC9kinR5OsMSG84DmhpvChpUgtX3eKY1ZQqwn3A/xMK+EcdRHsSKejCsOlRcxNAnnxc
         pMEgXCxydQzNy/WaW1lSLRCMCIjy15DNcPLuxCgCjnea9F4RAbM17SoAKa+H8D5qDW6m
         OhK07bjLobSzGROMuHc/weHsNU43jSV26cL3qibmkTWyK5+2ow51Q15QLCBUQw3+qQdY
         G9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kplaoMazxKidoLai17lzJFKrm+ggKGLDvODhBftX+wU=;
        b=2JDf3d5Z4EEeQ+GvzdWB9yKo7VkSKYOLvEGqbjlx3DZ7SbYEFIWXvjisDy9+rtyk96
         gB893De/bdfC9o1RVLrDiaFBAhoNAtMW85bjMn3RHO3eNDXMvSC3ZQ6d1x5zQeuKyUA8
         fkSr6qfKNCSwKicN7A7rwTdf+J/95jRRcaFKi+a4pk+Xek3nhefolLrfRa1tzn3YT95O
         CemvQAb/ibvwVmWOPGwjIq9UTgPxrv4AOryGUR2axxkPOzNCLRqos5RrK+WKIKBC42Ms
         OZ2qGA/CaJhQIeiJLL2C2i1OrWMsfdS4B3dYuWq6ggr4NZ9AyinuBtDJ4bTImDkXX4hJ
         i9Ug==
X-Gm-Message-State: ACrzQf1dC/7Z2k8S+Zj3ZF9uBqcgxOLiOunkQ05zKTJv2FZPVsmz7v4T
        v3a73jEbfw4DX+yNuaO0idLVc6o76EkNj223
X-Google-Smtp-Source: AMsMyM4LEOu2JgM/1ksroFHO5oD3JxplIcMMR6sdnKnz+fbYV3Ir9xVvCvGVx+BvIKSwJdYW/MAA/Q==
X-Received: by 2002:adf:f051:0:b0:236:70db:20d9 with SMTP id t17-20020adff051000000b0023670db20d9mr15151151wro.91.1666906802738;
        Thu, 27 Oct 2022 14:40:02 -0700 (PDT)
Received: from localhost (94.197.8.221.threembb.co.uk. [94.197.8.221])
        by smtp.gmail.com with ESMTPSA id w8-20020adfde88000000b002366f9bd717sm2476810wrl.45.2022.10.27.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:40:02 -0700 (PDT)
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
 <20221026194345.243007-2-aidanmacdonald.0x0@gmail.com>
 <0GWEKR.T961XCYIYOL52@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] clk: ingenic: Make PLL clock "od" field optional
In-reply-to: <0GWEKR.T961XCYIYOL52@crapouillou.net>
Date:   Thu, 27 Oct 2022 22:40:02 +0100
Message-ID: <sWPMeZZ7NP5UXWBsE8t41AGkBkpYIgpG@localhost>
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


Paul Cercueil <paul@crapouillou.net> writes:

> Hi Aidan,
>
> Le mer. 26 oct. 2022 =C3=A0 20:43:40 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> Add support for defining PLL clocks with od_bits =3D 0, meaning that
>> OD is fixed to 1 and there is no OD field in the register. In this
>> case od_max must also be 0, which is enforced with BUG_ON().
>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>> ---
>> v1 -> v2: Simplify od lookup in ingenic_pll_recalc_rate() and
>>           enforce od_max =3D=3D 0 when od_bits is zero.
>>  drivers/clk/ingenic/cgu.c | 21 +++++++++++++++------
>>  drivers/clk/ingenic/cgu.h |  3 ++-
>>  2 files changed, 17 insertions(+), 7 deletions(-)
>> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
>> index 861c50d6cb24..3481129114b1 100644
>> --- a/drivers/clk/ingenic/cgu.c
>> +++ b/drivers/clk/ingenic/cgu.c
>> @@ -83,7 +83,7 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned lo=
ng
>> parent_rate)
>>  	const struct ingenic_cgu_clk_info *clk_info =3D to_clk_info(ingenic_cl=
k);
>>  	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
>>  	const struct ingenic_cgu_pll_info *pll_info;
>> -	unsigned m, n, od_enc, od;
>> +	unsigned m, n, od, od_enc =3D 0;
>>  	bool bypass;
>>  	u32 ctl;
>> @@ -96,8 +96,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned l=
ong
>> parent_rate)
>>  	m +=3D pll_info->m_offset;
>>  	n =3D (ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, 0);
>>  	n +=3D pll_info->n_offset;
>> -	od_enc =3D ctl >> pll_info->od_shift;
>> -	od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
>> +
>> +	if (pll_info->od_bits > 0) {
>> +		od_enc =3D ctl >> pll_info->od_shift;
>> +		od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
>> +	}
>>  	if (pll_info->bypass_bit >=3D 0) {
>>  		ctl =3D readl(cgu->base + pll_info->bypass_reg);
>> @@ -112,7 +115,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned=
 long
>> parent_rate)
>>  		if (pll_info->od_encoding[od] =3D=3D od_enc)
>>  			break;
>>  	}
>
> I'd add a space there.
>
> With that:
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>

Already done; the space is there in my outbox and on lore.kernel.org.
I think you might've accidentally removed it. Stephen's already
applied the series anyway, so...

>> -	BUG_ON(od =3D=3D pll_info->od_max);
>> +	/* if od_max =3D 0, od_bits should be 0 and od is fixed to 1. */
>> +	if (pll_info->od_max =3D=3D 0)
>> +		BUG_ON(pll_info->od_bits !=3D 0);
>
> I don't think this first BUG_ON() is needed, if we do a good job reviewing
> patches. But I don't care enough to ask you to remove it.
>
> Cheers,
> -Paul
>
>> +	else
>> +		BUG_ON(od =3D=3D pll_info->od_max);
>>  	od++;
>>  	return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
>> @@ -215,8 +222,10 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned lo=
ng
>> req_rate,
>>  	ctl &=3D ~(GENMASK(pll_info->n_bits - 1, 0) << pll_info->n_shift);
>>  	ctl |=3D (n - pll_info->n_offset) << pll_info->n_shift;
>> -	ctl &=3D ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
>> -	ctl |=3D pll_info->od_encoding[od - 1] << pll_info->od_shift;
>> +	if (pll_info->od_bits > 0) {
>> +		ctl &=3D ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
>> +		ctl |=3D pll_info->od_encoding[od - 1] << pll_info->od_shift;
>> +	}
>>  	writel(ctl, cgu->base + pll_info->reg);
>> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
>> index 147b7df0d657..567142b584bb 100644
>> --- a/drivers/clk/ingenic/cgu.h
>> +++ b/drivers/clk/ingenic/cgu.h
>> @@ -33,7 +33,8 @@
>>   * @od_shift: the number of bits to shift the post-VCO divider value by=
 (ie.
>>   *            the index of the lowest bit of the post-VCO divider value=
 in
>>   *            the PLL's control register)
>> - * @od_bits: the size of the post-VCO divider field in bits
>> + * @od_bits: the size of the post-VCO divider field in bits, or 0 if no
>> + *	     OD field exists (then the OD is fixed to 1)
>>   * @od_max: the maximum post-VCO divider value
>>   * @od_encoding: a pointer to an array mapping post-VCO divider values =
to
>>   *               their encoded values in the PLL control register, or -=
1 for
>> --
>> 2.38.1
>>
