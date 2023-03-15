Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002A86BAC44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjCOJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjCOJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:36:12 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCCF61A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:36:09 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-53d277c1834so356166457b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678872968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYQoOskS+fbvCREhTpPzMDMuJWMQA/zd7RgkP+TyrM0=;
        b=IQN/hY56AbzZ1v2FNrGKUmXjBUm+cmnyDS6LJ1GMiRmH1s6fI7E3mQs9CP1LWCfVP1
         h1Ig6rWIWGZ6Uui0rrAERUJMswRoZTiXS6BjtL4PsrONzJkeYRpdh/Oij44FVXpPdhLa
         U70GNF6Ggj/OYTWlhdHy+ppyU3tEVKA8+CdUQIcoyJmB2cwJ3qIDzvVuh4Dd9Dj8QIK4
         4Iv+eFEL1FUlyfxOWTIOYABtdbDa4dv6+O/fAizrqtML9621qRECcljq7DSUdzYc1yXY
         QejbhKMIgmAqy6hSLZ39y3qyKMig7JYxK54ljrnNUwSNRZG4uTe6g697VkNtlWe5UMdM
         lC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYQoOskS+fbvCREhTpPzMDMuJWMQA/zd7RgkP+TyrM0=;
        b=HpGxKMahV3A0csXkEnMMN1fFa3P31l1bvI0HcKzw/+75SqgQ4I0LWiefppztHOuatz
         wDtkFRHPy5j3W0jzNKYHXzA9aNTzgr9ugMg+ol3+ak3cisz4S1W09B9Cp11zif/yc369
         besUlY5dU5zRs0cvRwER9UZ8Eee5FYPivJq8IqCnfL4pjMo3mEEPTB/WbqaJ/6g54xfq
         5zZhHnoH8csT0ith7dfmjHVcvVRe6S2UNFEPl3LK4ZdeBr0R6XFAYy5Mk0WLam627R7B
         D/GrFunI27sPD4CvaXQNCB+oP+nwmym3uvKn7oYR3hRnwsUvg1aQVD0/Q4GlRxHl3vaB
         V1Aw==
X-Gm-Message-State: AO0yUKXFQqWXFDT90aXSbBffyYLlb1uJokF+ziouTmnd50wjfVB4kxpj
        fRUG73Ja4Gh1PcVCz5lvxxh3xUJZAWpOfuJaCiwnCQ==
X-Google-Smtp-Source: AK7set9G1e6Y6bwnztfxt/btqXMvwl4/wb2VsLK7KvPZgdg17nAVO2TJC+1fSD6PY4UewmkcTq3WBx4R9IGiqLo9n3o=
X-Received: by 2002:a81:ae4a:0:b0:541:8995:5334 with SMTP id
 g10-20020a81ae4a000000b0054189955334mr8175964ywk.3.1678872968658; Wed, 15 Mar
 2023 02:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-19-45cbc68e188b@baylibre.com> <CAAOTY_-wEzu6JavEAyRo8njOLRMq3i3wEcemNsuMaK00W9QqpQ@mail.gmail.com>
In-Reply-To: <CAAOTY_-wEzu6JavEAyRo8njOLRMq3i3wEcemNsuMaK00W9QqpQ@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 15 Mar 2023 10:35:57 +0100
Message-ID: <CAFGrd9pa3c3eZcuGg7AmHL8kOAkyx96hwjwnMuO-G9BR1ORJ_w@mail.gmail.com>
Subject: Re: [PATCH 19/21] drm/mediatek: dpi: add support for dpi clock
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 13 mars 2023 =C3=A0 16:21, Chun-Kuang Hu <chunkuang.hu@kernel.org> =
a =C3=A9crit :
>
> >
> > +       dpi->dpi_clk =3D devm_clk_get_optional(dev, "dpi");
>
> For MT8365, DPI clock is not optional, so make sure that MT8365 DPI
> should have this clock.

This should be check and notified at build time thanks to the
device-tree binding. Do you prefer this?:
#IF MT8365_SOC
    dpi->dpi_clk =3D devm_clk_get(dev, "dpi");

Regards,
Alex
