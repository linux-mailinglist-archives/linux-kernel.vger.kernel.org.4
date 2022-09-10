Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1EB5B479F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIJRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIJRRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:17:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8C63BA;
        Sat, 10 Sep 2022 10:17:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so8343759wru.6;
        Sat, 10 Sep 2022 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DA72L+KG252i9kApPGBzXI/xo+bqFuMURZhWoNRsroA=;
        b=JLymezzOYumyEv8r/QBXmcL1h5IjSPtVoJwAul4iBSUf+wL52Gx3Wto17WNCmj1flr
         XV8rdxJqC/isFai9msy52ZIg0dKS/6MFsWSs4dBo3gXHySO7zmZ71aJ89GMj05Vkpl73
         nctHddOU8TZFlfBBTWxkCFlXL3RnBeGRqz5TG3MZ4g5mmdadwSTdsLjsjoDLSX3Kurzx
         S99309l+g6ixooBW/huTKsygdBTQsSwVRy4vi5DiacOyBgVRa9PBXFlMc2Sme0+8S8sf
         EM5GLztxDRU3NhNX1OeG9Qo+bWCN87OdadzTFHI/kw5RKVITTXcHLUunoudpX3Y0gaH9
         G1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DA72L+KG252i9kApPGBzXI/xo+bqFuMURZhWoNRsroA=;
        b=ifJ8ZDUd2s8K2w39MRsY5auoIKh3J0b3djfe+l8NbwFpjMptR01hucq1Vjl7fVsrSD
         xHu5g3WAYTY9umtPWhL1LP2ErXMg9m9sFySQEfCDxFPoqWhVDoROboQ+qy4Q/V66eM55
         jxmoYcySmprw/ounbl4mN71XDjMkIzSjxDB9jZ9npu5Nd0g5rfZYaFRyN58+hQVERhhu
         V8nDAHsDJgCGVvjsIW5ZJtQHoF+iVjJLOihUwvnlIrtIJfatI2TQPHB7vGrKXGkjfGEI
         mHrxz+Eo67ywadV5W/rcVPjqVe1jiggBFV2+ZKI0df+3JK5cHQT0IiaY9ErctWhhZihj
         /T5Q==
X-Gm-Message-State: ACgBeo2yw1rlxXDEMgsNu5949Z5+m+oVxF9xPz9acS1bAFIKTEoaA26p
        JuiXBDRgdHnO+N40i4rcdqZarXLmA3h1x/QCiSU=
X-Google-Smtp-Source: AA6agR5lQZ4TiPO6i2gR9pxcRxg3gi1IiN9ge5ynKwSZ6rQfoYbRb3AOY+FFkH7xzGRVadzq7K8VedRzHzbg1mFXOZw=
X-Received: by 2002:adf:f64e:0:b0:228:b49b:20f1 with SMTP id
 x14-20020adff64e000000b00228b49b20f1mr10990941wrp.59.1662830240409; Sat, 10
 Sep 2022 10:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220909175522.179175-1-sebastian.reichel@collabora.com> <20220909175522.179175-13-sebastian.reichel@collabora.com>
In-Reply-To: <20220909175522.179175-13-sebastian.reichel@collabora.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Sat, 10 Sep 2022 20:17:09 +0300
Message-ID: <CANhJrGMd_4pK0Avbngggs3BJme7WgrkhzvJ+VbL7-JYri37Dow@mail.gmail.com>
Subject: Re: [PATCHv3 12/14] regulator: expose regmap_find_closest_bigger
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pe 9. syysk. 2022 klo 21.21 Sebastian Reichel
(sebastian.reichel@collabora.com) kirjoitti:
>
> Expose and document the table lookup logic used by
> regulator_set_ramp_delay_regmap, so that it can be
> reused for devices that cannot be configured via
> regulator_set_ramp_delay_regmap.
>

I am always in favor of adding helpers to be used for common tasks. I
am not demanding this (so please ignore my comment if you feel so) but
I guess finding the "closest bigger" from a table is not ramp-delay or
even regulator specific. I believe something like this might live
under lib - if exported.

Anyways, and whatever it is worth:
Acked-by: Matti Vaittinen <matti.vaittinen@mazziesaccount@gmail.com>
for exporting such a helper. (Or please disregard the ack if acks are
reserved only for maintainers - It's just a sign that I think this is
a good idea [even if it could live in lib])

Yours
    -- Matti
-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
