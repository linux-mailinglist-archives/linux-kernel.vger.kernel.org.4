Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3A6391A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKYWzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKYWzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:55:41 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F40F317FD;
        Fri, 25 Nov 2022 14:55:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fy37so13091173ejc.11;
        Fri, 25 Nov 2022 14:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cSQbE6DTU1OTWIo88z37u8F7NPhgsW2MN2Tg59pPOXc=;
        b=aLDxlgkJMAfQKJ/PsFzHPhylnPEW+gDKATHZAOerYca/LjJYpDbVG0zBfNLwnHmLxS
         V7P6bwrlFa00RdChbApUzhy95iu88EJnnce3uGOIRDVWQQXPRe72zG3yy6/y3QuY5joM
         G2FaBbnUYKJO57ZVyOyphLqVeohgiZskhZIs7FkkmeXgNyPfClUS90ADJnHV3vg1zt0z
         uoz/FBdInhZnMYPYaAgjN3ralRBltlkg1kw+j4I5DYh1tr7fty7iLiJsE4Bq3ZluOCY8
         ClMUj/Y3nD6Xcegq/zRHCF9sI0No/rp8D+ww1VFygNJcHYDzLkrSbngRLiMoMWvRyXYP
         VpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSQbE6DTU1OTWIo88z37u8F7NPhgsW2MN2Tg59pPOXc=;
        b=Zj9+oWXOj/JWCWdy3TNTtVchFTJ0FVf1ik8Fh9FH8vR0Tf7BhyJSm2A8RMz3XeKBqE
         0Ar7IVNP79NLEEwxYhWsCQvGdPlIjWGgxpw3xt1DN3ecFoj+a3/7sA2pbL1+9kw+60t8
         INQcdV32aLMO2BUK7tkjUrS1O6O63Fm1AjgCE5Cb41HhBAtk/iT09bQTjZYJ97ZRbxtB
         9ESq+ephMLQl7qjd0AAO50sNZTqOi0nexyOsgV8n9OClqBKbVt6XaWAksbZyhF5dziST
         GSPQHoN/uG3Ctmc6pxESEcdUkDGDo1M9zCS7oKs4ssNlCn7s39hNOR3Lf4ipz3co2QiI
         J6Cg==
X-Gm-Message-State: ANoB5pnHmQtuhnMfpPT/tTWC0u5eShQjv0BwXh1W1UTyIjgX0cIIJIL7
        ecf2DAA/ep1Ae9ez7/3SkvzkAgagCVY5FTsd31Y=
X-Google-Smtp-Source: AA0mqf6TwkgpJ8rCH+EA5o8FW6/bDGwDyPkwIt+kioEMwalKVB9sy6wWTCae8gr3PFM8J9sWSbhDQw+IVh5lHIHTtKs=
X-Received: by 2002:a17:907:a709:b0:79f:cd7c:e861 with SMTP id
 vw9-20020a170907a70900b0079fcd7ce861mr33281694ejc.339.1669416937103; Fri, 25
 Nov 2022 14:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20221125144141.477253-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125144141.477253-1-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Nov 2022 23:55:25 +0100
Message-ID: <CAFBinCCHQXqEwQU=BWfXj-iTJXXQ6_Hr_2rokzrmFzGF7nrgyg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: align LED node names with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Nov 25, 2022 at 3:41 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The node names should be generic and DT schema expects certain pattern:
>
>   amlogic/meson-sm1-bananapi-m5.dtb: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thank you for this patch! It's:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
