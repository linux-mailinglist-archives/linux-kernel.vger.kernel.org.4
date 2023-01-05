Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9DE65F2AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAER3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjAER2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:28:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9295BA37;
        Thu,  5 Jan 2023 09:26:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ja17so28535866wmb.3;
        Thu, 05 Jan 2023 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv1/J8+zyvFNGrZ+RyXIp/dYj2SMtALFrHtwD8fvn5I=;
        b=mr0SJHApON8ErWUEsLeomS53CPMZKeRZ/isiL8Fa3LIBSyfQZzpLvZKR+gMgSIB6vO
         1Jog/kL+woXJToJND8xnjVNdHBjoYiKgunDdIjmceN150z6azyXXpi3rGc4tqVYmU6iU
         4picHVNy8USrpKP8ymXSl+WNeOQahZTjEsHBo5P7WG+yG6qTpU3zkSQOyZa+tszPrAvf
         7qfL0usDdpKImrBiM0Sb6ncaaCTBTM36BnkT0XMQ4dy02e6EyZ9j9Z7T1LV5JijF2BK+
         FmeZ93LimVqVM/pfr/IQ36yA5qkSmr5+kXUHgMGxvRZECTXHmrHYzqDxdWO8hI562Nwy
         /N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv1/J8+zyvFNGrZ+RyXIp/dYj2SMtALFrHtwD8fvn5I=;
        b=pGwx/4ekM3KAHorMjCkxD8O8ur7r+2zu86w45q2Sy/xbXr9sVbg5DrLCKlX+rlXP3S
         qkOc5B/hKeW+bY571+f3Bb2Jwk8AspZzr/TdWBLemtVk/Txy6+4L5TKBmDe5FW6hpCh7
         OteivPBqL7XKByZ87mUiXO6Wsnq/DcxbKAUuyWnss0B9GMzlpgKDfzKfpgOvQG8739qR
         EwOBKj8UqwX5WehcFNloJucvlbp9juj5KD+txQs2xQT1l8YUzUVK0bqpCsfueXS2jQfS
         okKdgN45274SSnEpweY+Dj/xlhvFhkEPUHnv7F3DvCaVmmesAJ+ah10CYmhgDiFU73f2
         EzGw==
X-Gm-Message-State: AFqh2kocAndcVQFm5cCL9EXPznHPtQJrk+ZHIJ4p314PRZbFhnjP8QWL
        4fkeSzQqzD5N9BzgA5JPa9Y=
X-Google-Smtp-Source: AMrXdXthnyD4BVhaKgGhlEMZZtcIDvQxKdtHMqQniFI1MNlfYh9kPLZbWBFDF/l2e7SoFmey5Gv3tA==
X-Received: by 2002:a05:600c:3485:b0:3d1:ee6c:f897 with SMTP id a5-20020a05600c348500b003d1ee6cf897mr36885853wmq.3.1672939564055;
        Thu, 05 Jan 2023 09:26:04 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003c6bbe910fdsm3692581wmq.9.2023.01.05.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:26:03 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] rtc: sun6i: Prevent an out-of-bounds read
Date:   Thu, 05 Jan 2023 18:26:02 +0100
Message-ID: <8201852.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20221229184011.62925-1-samuel@sholland.org>
References: <20221229184011.62925-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 29. december 2022 ob 19:40:10 CET je Samuel Holland napis=
al(a):
> If there is more than one parent clock in the devicetree, the
> driver sets .num_parents to a larger value than the number of array
> elements, which causes an out-of-bounds read in the clock framework.

Is there any DT with more than one parent? I think more fixes are needed if=
=20
this is the case.

Best regards,
Jernej

>=20
> Fix this by coercing the parent count to a Boolean value, like the
> driver expects.
>=20
> Fixes: 3855c2c3e546 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index ed5516089e9a..a22358a44e32 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -294,7 +294,7 @@ static void __init sun6i_rtc_clk_init(struct device_n=
ode
> *node,
>=20
>  	init.parent_names =3D parents;
>  	/* ... number of clock parents will be 1. */
> -	init.num_parents =3D of_clk_get_parent_count(node) + 1;
> +	init.num_parents =3D !!of_clk_get_parent_count(node) + 1;
>  	of_property_read_string_index(node, "clock-output-names", 0,
>  				      &init.name);




