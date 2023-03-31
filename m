Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0D6D1FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjCaMFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCaMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:05:35 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE24A1C1F3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:05:31 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54601d90118so255161917b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680264331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBertetORVW57D4Qn1kS8HxfnJyMQ3NfyoVt6rJXeWw=;
        b=jJYKQuohc4q23MSrpDjfNbvItKi4OeXxV/JiVsMH1u69/oc+hhZnHl+qafU/eiH4n6
         fW+LnLnJ1EbzJrlZrmw27H30jZAlcHuAElxlUoo5p2XHokmFvACqJ/swhGjAQ3WNqWco
         DumOcwmKSRpfirCl6ztX/cQNURZ8+AB/lp1zGF80Ul/QKpbuTucfgL8kH8y1HF+8j+9+
         yq8jO/0GALbIjk7DOXxP5cnYW/SuxOZ/j+PBe9ZNyRhAoEyiR6ye1iP69ZbVcGpU3a+3
         nSQ1Lhe98iMsb8F3ZOh6VIDOIfw5wXQQjHoL6I9b4Rp0OkH3q45tYXLqlUmlP+IGCdL1
         6oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680264331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBertetORVW57D4Qn1kS8HxfnJyMQ3NfyoVt6rJXeWw=;
        b=U/Rj7n93relb2noLH5J7eflCBjU445izdGfqOzyjwwFtM2/8w9p0UsxVG6CaElrUTX
         j/YPu2cBHJdis4wX1fB9TJ6zFfjgEhkjqbz/Isej7Lh5uvMXaZhhV3vn8l7deiwECKYo
         tI4E+NLus9ZcViIDNd6h3YgnYEZ1TU3UMtEyfvATGDe5APgi2twofn60MfkXU7lVJMIo
         QGSVl+X0VgJEKOxGdIr+c9bVW/RRRhjTOwiONjRC67uBIGApXcGJOH3Ll6aYD8JscUrE
         KNVaq/8nh4SGJ33gOj7ZxvjkP8GE4SzypOfM40sx5Ju5HFnIfyfxqbrywHsXPzqGHXkJ
         Ua+A==
X-Gm-Message-State: AAQBX9eoCQ3j4VRIgUnwWVPohnzAFOjdQ4B8S/NjxK7b2CdoyhecPG2w
        m8GXuc0+guBzl27TOmMrKYCNRldKl+ZW8hycAQ9B/w==
X-Google-Smtp-Source: AKy350alOUKFv8JHxb8OmChOgvitPrDAx4h8WLR3fhEV2ib1x87O1DkuqB5uGPeBCLNGixpUYQPibS7V5oz35p99nco=
X-Received: by 2002:a81:ad5d:0:b0:540:e744:13ae with SMTP id
 l29-20020a81ad5d000000b00540e74413aemr12477767ywk.3.1680264330881; Fri, 31
 Mar 2023 05:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-16-0003e80e0095@baylibre.com> <8c917be2-e15a-921f-aaa9-b8753d2463de@gmail.com>
In-Reply-To: <8c917be2-e15a-921f-aaa9-b8753d2463de@gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 14:05:20 +0200
Message-ID: <CAFGrd9oPKn84yK2VpfJQRd1HbBTwq87Fuc6=Uw3uaeLjm89=8w@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] arm64: dts: mediatek: fix systimer properties
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias

Le jeu. 30 mars 2023 =C3=A0 19:34, Matthias Brugger
<matthias.bgg@gmail.com> a =C3=A9crit :
>
>
>
> On 29/03/2023 10:54, amergnat@baylibre.com wrote:
> > From: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> >
> > MT8365 has a SYST timer (System Timer), therefore the compatible node
> > should be "mediatek,mt6765-timer" instead of "mediatek,mt6795-systimer"
> > (which corresponds to ARM/ARM64 System Timer).
> >
> > Plus, register range should be 0x100 instead of 0x10.
> >
> > Finally, interrupt polarity of systimer is LEVEL_HIGH.
> >
> > Fix the above properties accordingly.
> >
> > Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>
> Patch looks good but does not apply cleanly because of previous patches t=
hat I
> didn't take and need rework. Please resend the patches I didn't queue wit=
h the
> comments addressed.

Sorry for that, I forgot to drop this patch since it has been already
fixed in the Bero's series [1]
I will drop it for the next version

[1]: https://lore.kernel.org/all/20230309213501.794764-4-bero@baylibre.com/

Regards,
Alex
