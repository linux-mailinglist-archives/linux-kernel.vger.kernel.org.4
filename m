Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08660100E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJQNR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJQNRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AB4D4E5;
        Mon, 17 Oct 2022 06:17:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g1so17437908lfu.12;
        Mon, 17 Oct 2022 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8f3juetbbIK9+sE1IMVow5EXJigoRRHopSwZQaiqEuA=;
        b=ZEMhZctbicqtfyN4suejkU9riZToXgpoawJQplzWnBKl0OKfJcTQMRFWVX/QxnHkH5
         cuet5YLnCpr2Vur5HPTVjA0tzpUhnG3d9UZ5umwv46xFhAwk3gMh5Hqc+91OCbbz8w4D
         mPzRMBDydmbWa9JEqjqwXz8Eiz597Pgj+3S6Fh+lW7dEfR+7VPYU8tnLMYUlkat79GfW
         sdVTFFPv63WpeOy0HB1Sz1eF/krGtgl3uSYBCnYnLD3OonIF9GDlTFgECxtiPrfg9s8s
         7fsNPTdoXS/hRywb6xubNOc0/XroC4JoUy6LKmPmflM8Jqs9lGo1eXOd1s/tpOwagq9v
         1Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f3juetbbIK9+sE1IMVow5EXJigoRRHopSwZQaiqEuA=;
        b=WExMaq0rQ5lCB6V5JysZce1bcNb0mga2EqaFijoPbWQXUphQvr8LaeQfVqNjxenuH5
         HNj7nxh4cg/qa7J50j+Tj3VLHuqK2U/FEpiJIjA4fLd6TC7+4HWDSvKJF+q+TC/JtNlp
         Wcto8MWDhJlFbtTySXUpP6N6+Exc0GWcmDEP5lTOQbJETXEu3+Clk/OFISGu7B8CncgJ
         GQkuGWEomW0MTdVYtuJPOUzmLXjoapbJ9GTpODLKOqas/4u9Lrxlanu9hUuQGv/m7jxh
         273Hlqg7SQg/In5VI7IDHjXwf2Eo7oGeckuMjP41fT9fogBOl1iqA9iOyViaO1B3PXjI
         uOTQ==
X-Gm-Message-State: ACrzQf0/B2PG6VAxNjB/zI583ZW/5LF+FyWKlAqxtae8Yr/K5RTkq5EK
        o5EzXAbZtfFxz9sljHf4WtscCrWnw46Edw==
X-Google-Smtp-Source: AMsMyM6h1hv1LZota/V7Zmjl1AftsHGjC2eO1Hppob2WxI5u8rlUge5LgcdsdImwkRWhYD1VpJfD9A==
X-Received: by 2002:a05:6512:487:b0:4a2:2977:3a83 with SMTP id v7-20020a056512048700b004a229773a83mr4099820lfq.88.1666012635416;
        Mon, 17 Oct 2022 06:17:15 -0700 (PDT)
Received: from razdolb (95-31-187-187.broadband.corbina.ru. [95.31.187.187])
        by smtp.gmail.com with ESMTPSA id p3-20020a2e7403000000b0026df5232c7fsm1490717ljc.42.2022.10.17.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:13 -0700 (PDT)
References: <20220927222152.132951-1-mike.rudenko@gmail.com>
User-agent: mu4e 1.9.0; emacs 28.2
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Pagano <mpagano@gentoo.org>,
        Arec Kao <arec.kao@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Marek Vasut <marex@denx.de>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add Omnivision OV4689 image sensor driver
Date:   Mon, 17 Oct 2022 16:05:41 +0300
In-reply-to: <20220927222152.132951-1-mike.rudenko@gmail.com>
Message-ID: <8735bmwpwo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-09-28 at 01:21 +03, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:

> Hi,
>
> this is the third revision of the Omnivision OV4689 driver. Main
> changes in this version are (1) mapping physical camera gain to
> monotonous and mostly linear logical gain exposed via corresponding
> control and (2) reporting consistent pixel rate and hblank. These and
> other minor changes are listed below:
>
> changes in v3:
>   - set 1st patch title to: "media: dt-bindings: i2c: document OV4689"
>   - schema: drop clock-names
>   - driver: use dem_clk_get(NULL)
>   - schema: remove maxItems from powerdown-gpios
>   - schema: make gpios optional
>   - driver: use devm_gpiod_get_optional()
>   - driver: remove __ prefixes from function names
>   - driver: switch to .probe_new
>   - driver: remove of_match_ptr
>   - driver: add and use enum ov4689_mode_id
>   - driver: make xvclk optional & try to get frequency from ACPI
>   - driver: drop #if defined(CONFIG_MEDIA_CONTROLLER) in remove
>   - driver: use ARRAY_SIZE(ov4689_supply_names) instead of define
>   - driver: remove unused controls from struct ov4689
>   - driver: use 504000000 instead of OV4689_LINK_FREQ_500MHZ
>   - driver: compare link frequencies with menu array clock-frequency
>   - driver: replace |= with ret = ret ?:
>   - driver: merge power on/off into pm callbacks
>   - driver: use actual clock rate in ov4689_cal_delay
>   - driver: set up controls after writing register table in s_stream()
>   - driver: remap sensor gain to linear and monotonous logical gain
>   - driver: set pixel_rate to 480000000
>   - driver: set HTS so that we have 30.00 fps and fix HBLANK reporting
>
> changes in v2:
> - bindings: reword descriptions
> - bindings: move clock description to clocks property
> - bindings: add data-lanes and link-frequencies properties to port
> - driver: validate media bus configuration when probing
>
> Mikhail Rudenko (2):
>   media: dt-bindings: i2c: document OV4689
>   media: i2c: add support for OV4689
>
>  .../bindings/media/i2c/ovti,ov4689.yaml       |  134 +++
>  MAINTAINERS                                   |    8 +
>  drivers/media/i2c/Kconfig                     |   14 +
>  drivers/media/i2c/Makefile                    |    1 +
>  drivers/media/i2c/ov4689.c                    | 1027 +++++++++++++++++
>  5 files changed, 1184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>  create mode 100644 drivers/media/i2c/ov4689.c

Gentle ping. Anything to do on my side to get [2/2] reviewed?

--
Best regards,
Mikhail Rudenko
