Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09E660C7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJYJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJYJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:24:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E342E0BE;
        Tue, 25 Oct 2022 02:20:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e20-20020a05600c449400b003cce0107a6fso626999wmo.0;
        Tue, 25 Oct 2022 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEUmIwCaCeFQJYLB9XXcHphXCrocOr1on/UtIhygxzc=;
        b=mQXWym3RJyi+Tij4sSu/GS27r0Cneg2tW5uOlDbb3WFc9GVVbrnFPZbGJPlf3y14QB
         uU9wSVbYvot2JIGy3cG+spIxzkOR09KAw+hCk8Vcn8KpZmsclQhCqclbJvl1bqnzwDVj
         KFTkQ2JLcNw0SgQ8oi4cOBfT+d3Mq0C8KfNRsye5V/7R8ZU+e0TkHDhIp2m+S8trEgsP
         P8WnqFhxKmYs/a1iIca4oTUIjsRVLgqZtCpCTb77kAKjpFM0It9/7ELOQyYKO6xNoPzW
         T6vf7HEl/9N7OvEMEKUeRyzOGbnwl7mEE8K9PRzFSHXEyqilxIbvOhVLlb0bzI7skPF8
         3Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
         :subject:cc:to:from:references:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cEUmIwCaCeFQJYLB9XXcHphXCrocOr1on/UtIhygxzc=;
        b=3FQ2DMK363UsmCiV6mJ4QhvRNXypPci+t6rpkFTzaqZWI3DNKfiNxDZHxZLkk53qFN
         Pet1H4kRk33pOlb+BtqHNdCwGl9CGsX419+dkqMCjmSDXYsPEwO9FYXFhmbGBl0MBK9n
         VAgw5Czur1D9u+AZGsy+EPAOSqDrE52rpONdGflqxADoChr2owe03oTPvsBeZF8ziosr
         DsNwEegUFZ1FV0McP/TrBZ9bofz8vaoS6Ah/MvW+R1ZIixKRMsWGUBLZOftz+ZWuPL/G
         eeVa2H0gqeeHbrGWvEi//vMKaItJ1eIktXV4Bc3SYScJE1ZVWKJkp5T281ta1FAw6JAI
         IYjg==
X-Gm-Message-State: ACrzQf2akcYcsc07kf7pDNd77ZnrRaXK/EtGVLWZJJoDjd2sGn52tS05
        HMVgLjUtcVdnfARgqFiXjRYHrmolMnf8Tw==
X-Google-Smtp-Source: AMsMyM47fuuFRCblEyHXGL0NpNVuqqL7TkQX3Otqp+SL2+fsl4H6B2S+4I6GpUV4dEoCZ22tiNfbNA==
X-Received: by 2002:a05:600c:35c8:b0:3c8:33dc:c262 with SMTP id r8-20020a05600c35c800b003c833dcc262mr13013520wmq.206.1666689610718;
        Tue, 25 Oct 2022 02:20:10 -0700 (PDT)
Received: from localhost (188.29.212.253.threembb.co.uk. [188.29.212.253])
        by smtp.gmail.com with ESMTPSA id v26-20020a5d591a000000b0022cd96b3ba6sm2424205wrd.90.2022.10.25.02.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:20:10 -0700 (PDT)
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
 <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
 <0269b850-f33a-7aa9-a3eb-83655bd4e19a@wanyeetech.com>
 <ROSYER.QTJF8J14H2YX1@crapouillou.net>
 <6f2c7a0b-b68b-fc42-1a82-2b69c114823f@wanyeetech.com>
 <UQ597w4FmzOT8p76tdRPhzECStUpFmYe@localhost>
 <HQ76KR.B1PM87E2GIYZ1@crapouillou.net>
 <JRrsX7Q4m5FUeeBs2yKTRMe5Ihaso8gi@localhost>
 <DQD9KR.BW8U6333OSCP3@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Zhou Yanjie <zhouyu@wanyeetech.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name
 SoC-specific
In-reply-to: <DQD9KR.BW8U6333OSCP3@crapouillou.net>
Date:   Tue, 25 Oct 2022 10:20:10 +0100
Message-ID: <ebyFOPJskfdtIoKsYnqp2IcYTMYA1ESE@localhost>
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
> Le dim. 23 oct. 2022 =C3=A0 14:29:24 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> Paul Cercueil <paul@crapouillou.net> writes:
>>
>>>  Hi Aidan,
>>>  Le sam. 22 oct. 2022 =C3=A0 18:15:05 +0100, Aidan MacDonald
>>>  <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>>>>  Actually, the clock names in the DT are meaningless. The clk_get() ca=
ll
>>>>  matches only the clock's name in the CGU driver. So in fact the driver
>>>>  is "broken" for jz4780. It seems jz4770 doesn't work correctly either,
>>>>  it has no "pll half", and three possible parents for its "i2s" clock.
>>>  That's not true. The clock names are matched via DT.
>>>  Only in the case where a corresponding clock cannot be found via DT wi=
ll it
>>>  search for the clock name among the clock providers. I believe this is=
 a
>>> legacy
>>>  mechanism and you absolutely shouldn't rely on it.
>>>  -Paul
>>>
>> What you say is only true for clk_get() with a device argument. When the
>> device argument is NULL -- which is the case in .set_sysclk() -- then
>> the DT name is not matched. Check drivers/clk/clkdev.c, in clk_find().
>> When the dev_id is NULL, it will not match any lookup entries with a
>> non-null dev_id, and I believe dev_id is the mechanism that implements
>> DT clock lookup. Only the wildcard entries from the CGU driver will be
>> matched if dev_id is NULL, so the DT is being ignored.
>> If you don't believe me, try changing "pll half" in the device tree and
>> the I2S driver to something else. I have done this, and it doesn't work.
>> That proves the name in the device tree is not being used.
>
> Well, let's pass them a device pointer then.
>

Yes, I'll do that when I revise the patch.

>> I agree we shouldn't rely on this, it's a legacy behavior, but the fact
>> is that's how the driver already works. I'm dropping this patch because
>> the driver is wrong and needs a different fix...
>
> "How the driver already works" is a bit misleading, I never saw this
> .set_sysclk() callback being called, so I can't really say that it works.
>
>>>>  I think a better approach is to have the DT define an array of parent
>>>>  clocks for .set_sysclk()'s use, instead of hardcoding parents in the
>>>>  driver. If the parent array is missing the driver can default to using
>>>>  "ext" so existing DTs will work.
>> As much as I like this idea there doesn't seem to be a mechanism for
>> handling a free-floating array of clocks in the DT. Everything has
>> to be put in the main "clocks" array. That makes it pretty hard to
>> figure out which ones are meant to be the parent clocks.
>> Do you know of any way to do this generically from the DT? If there's
>> no way to get away from a hardcoded array of names in the driver, I can
>> at least add a device argument to clk_get() so it'll use the DT names.
>
> In jz4740_i2s_set_sysclk():
>
> #define JZ4740_I2S_FIRST_PARENT_CLK 2
> parent =3D of_clk_get(dev->of_node, JZ4740_I2S_FIRST_PARENT_CLK + clk_id);
>
> is how I'd do it.
>
> The DTs all have "aic", "i2s" as the first two clocks. It is even enforce=
d in
> the DT schemas.
>
> Cheers,
> -Paul

Sounds like a plan. I was hoping to avoid adding CONFIG_OF back
considering I removed it in an earlier patch since it was unused. :)

Guess it doesn't really matter for this driver since the Ingenic
SoCs need CONFIG_OF anyway.

Regards,
Aidan
