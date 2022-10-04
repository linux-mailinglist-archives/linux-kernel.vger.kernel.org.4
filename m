Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C215F49DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJDTuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:50:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D6458154
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:50:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a2so11018980ejx.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6hkmWBP+HYVSlw8fM7LP0M64hh7i+Xs/CK1D4zburWM=;
        b=ilOoyhBJEA4wl0QVI+l+UqlfFlsBSkdMPqXwzVz1VnOKK9lK6knIiZnGpUdC7Gy9wu
         X2xSQSh5kea2UknxQtmXGvNtrxf4VRvtwWqwjPWdzQ7cjj2P9pfsYyDVjdReXbgniAko
         Uu3EvwgCzMGizXLRmwEoKA3S7SKjld/vncJGjmLEaEmipGbd3laD1rlq7unwq14CRlLq
         WRs94wLv+yAyqJbVLD+LYrILGRk658Q2lUvUXO3om1qx1ykSzvf1NvaDDIx5QjJeTsjt
         6Rf3iRcDCZSlDnDxMcv8UJJNYjPLKdSzk+paD8rh8kk8KdWGTuGJVlX8D/M6d7u952Sg
         rUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6hkmWBP+HYVSlw8fM7LP0M64hh7i+Xs/CK1D4zburWM=;
        b=UJ7cJa28q7KTbptgxeIa4wR5lERya8rGjkNV32usH2uhK5sZg+0E0VkUwN7WV/3/Iq
         0QbUZa8yV61Icu4uUsLqjz9r4MmzRrR8pnhWVJ3GbnEEM/xc/F2uXPH9P3lCYw/KZqk3
         TU/Ko5e1IN8Y1U+FpHAo9sx28c3uB3LLIEVVlyCwTTVTgAQ4PV6mchSzW7Qf3kZePp/a
         Hs3napjFHgRnUSBuT/fn1Zh+amXtCCSHq0qWWhmkaB282FLdwGwNxTl1jeOKj24IBujO
         qd2z/VXdU8w1mOjUhlGTuvfWpEY9EfAViJzUa3i/q402ia/cNYAYSD4TRtPZ2TF4zYNi
         8ktw==
X-Gm-Message-State: ACrzQf0nycoXLNjn4VwNw87F8YP6OFY8o9+t8x2puZzYQK3DegJZvmv3
        4/FHmgCs8KLC1xbOtkgVXhPk2q3noYwVQSMTKoO8/g==
X-Google-Smtp-Source: AMsMyM6orKgk/Apmho+6PscggAHwdSeykF0rYq7e76qZXAmTSmmU9/rxFVFvFTC8FIaE1hdjNT+yuE6dM7tyBlnt8HM=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr20585891ejc.440.1664913036724; Tue, 04
 Oct 2022 12:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <YzN6A9Y20Ea1LdEz@google.com> <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
 <YzwtG8CT9sTCqQQk@maple.lan>
In-Reply-To: <YzwtG8CT9sTCqQQk@maple.lan>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 21:50:25 +0200
Message-ID: <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 2:54 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:

> > We need to know if i.MX is shipping device trees stored in flash,
> > or if they bundle it with the kernel.
>
> This part is frequently found in add-on boards so it's not purely an
> i.MX-only question.

Oh

> IMHO for not-in-the-soc devices like this the presence of in-kernel DTs
> isn't enough to make a decision. What is needed is a degree of
> due-diligence to show that there are no obvious out-of-kernel users.

OK I think this is a good case to use a special quirk in this case.
I actually envisioned keeping piling them up, and that they would
not be innumerable.

Dmitry, could you fix this? Just patch away in gpiolib-of.c.

Yours,
Linus Walleij
