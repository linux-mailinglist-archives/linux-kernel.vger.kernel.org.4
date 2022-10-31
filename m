Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00E6141F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJaXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:49:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF05F66;
        Mon, 31 Oct 2022 16:49:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s196so12031977pgs.3;
        Mon, 31 Oct 2022 16:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtSyeHeLvKwwxtU0oKKaUmty6E8Ll59rUEslMaWX0ew=;
        b=EqqrJ2/D+WPfHi87zSwMrXiL5g9koV8rAoMZ9GhhOfGr0TrVFtVcL6Xg/6c5KPd05W
         N8CENYp27DnAuZR4D3B4p/G2mtgSkI1K048ZcREifSA/8Wcat6rW/d2vXAxsyLTAZe4p
         Op9/X+L279UyhnXivmkkKsmG087aDCHP7IzojUoTpH8uKvthm9yaUPamBG1Wsrq3AUgj
         SB9JVUtd35Ju95d4Kz7e4uD2mNKrIRZ5aWhggmsYDM1futnyQpczuLeyCdWRds03wtcL
         UrmpKhEXKlyf620Z1FfIrcFx912SdrGghdUIMforaoEG3Jh8u4YMk9bbG5quYteEJAJz
         OEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtSyeHeLvKwwxtU0oKKaUmty6E8Ll59rUEslMaWX0ew=;
        b=4z1ayeXMTcWHGLGpYy9trp5wlm1wqYW2iVWy9DUdTWGe2ATq62MDUdFfBXqkLbM4ru
         AhE5jyqTA7QtJJEjGYHnHyxkMVKZe4OwgbkzQmTueIcgWJNac1YnyH5Qd+AC9kaT82pe
         a7eHDi7P0lcv5pg2IxFE0mtC/Yia2daUxtAnjNt1n0bSefBu12j8XK/qXvrBxTh4aPgQ
         G41rBTWEw7oxPb5h2ZM/FeTxXe4nW/qYY4e+/MbIK/wflWT1CA9oBEaWRcWS7LzZOdsn
         78mjzIKKwNjr6XvwKzogyb7fefx1/GdD1S1fXFnEL7ArLIQkqDOqX9rXKbKJ37ccqjyz
         RtAg==
X-Gm-Message-State: ACrzQf3Ms1JPu//DFZJgQM9NvIsLeBYILfAkOgcq4C8BF/DU4YsnK3SK
        J/6GlIRzDIV7Aiez1jKPye0=
X-Google-Smtp-Source: AMsMyM6/zv7Ymxlb97cwlTS61ftfAX+fN1DVFl6js7slcpFR1t4e1llvyniBrl0BU4t4YAOHFZl2TA==
X-Received: by 2002:a63:4753:0:b0:462:b3f0:a984 with SMTP id w19-20020a634753000000b00462b3f0a984mr14496000pgk.501.1667260174125;
        Mon, 31 Oct 2022 16:49:34 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x6-20020a626306000000b00565c8634e55sm5141014pfb.135.2022.10.31.16.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:49:33 -0700 (PDT)
Date:   Mon, 31 Oct 2022 16:49:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, shawnguo@kernel.org, rydberg@bitmath.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10 2/4] dt-bindings: input: Add Cypress TT21000
 touchscreen controller
Message-ID: <Y2BfCkVhE9GNdjWI@google.com>
References: <20221026114908.191472-1-alistair@alistair23.me>
 <20221026114908.191472-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026114908.191472-3-alistair@alistair23.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:49:06PM +1000, Alistair Francis wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
