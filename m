Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326B35F6337
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiJFJDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiJFJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:03:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0657A67461
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:03:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so3100904eja.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1yddKYac+3X7pcirMtwSeEtzvk1L8p2YF/xQufQ19P8=;
        b=SWNuVdxF51axUdgt0ko0fJT6zIZhBshW50rRpZrMwl697SOQn7tseTweQefqvLQAcv
         OOcPUHDdvIkdC4kOeEnyAyInACdkhpkhPLfpYV/lJTN507mhFrxXA+DvgQ+yauMMVUWO
         nNxJCe1R50v/saJ+oMWdHRGlwtmwUmbl4t64XwgDnF+W/4newn74BxLGDt3/meEmQzAZ
         5ZUlM0yF3ciy7Xcqqo6bjBqXBtJ1WTI0A86T7apbGmMMYbaR8GNpP3MfH13CZdkX2rlV
         gK1WzySLAbwehIBjc9LCnB7nCCscby/rS7/vY7Pn62qDTu1ehUYrkdXYzK8/dF6wygjh
         L2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1yddKYac+3X7pcirMtwSeEtzvk1L8p2YF/xQufQ19P8=;
        b=UDalO5fJc96Yzlcx0V4GERNTzKGARWv8+mJEvcXToobBw7O0hGOwxEK/1r/RDsrMA2
         B1srCi8aczaWSZVRrERg2dPgEPQ+pT6ABK9cHbrJ1dIzPVnih4G3aMlz6rW4ylge05UQ
         yUeLB8EKMZNu5B5OsvVebNvTFD+ItZUFz4dWrqqgKx/NtX1MtldtLkBPZg3Agmnmz3wg
         5FKo9u+i9qggcZ5OPJG0ves9Jz7gKLO7b9p1Obo4nGlfZPe6pt+Hbcalc2dh0Mpye/bs
         rVfEPs7d2Nxujjbf7MQ8qXQpHD7VP1Z5RN0UEf7UIbJoOzARWNWhPaW1LS4scWuOWSBA
         53Aw==
X-Gm-Message-State: ACrzQf2Ry4RTZwFa6IRjtN/DgZDDcPvZDRB/zTwek1wmV7ML5TpGp7OG
        cJtBvKXEzZq6OLqnTT1EZEpjiqsnhdgfyi+e9exsig==
X-Google-Smtp-Source: AMsMyM5LyK8I/k//MgZDRg/DTE1jan/OXiYFcGl/lh1ZAAwpTB6ll4P4/NUvwUDZQKoGma/VN0owmFcpI+wwFuDf4UQ=
X-Received: by 2002:a17:907:2d0b:b0:782:76dc:e557 with SMTP id
 gs11-20020a1709072d0b00b0078276dce557mr3018467ejc.690.1665047007502; Thu, 06
 Oct 2022 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <YzN6A9Y20Ea1LdEz@google.com> <CACRpkdZF9TVA3+3pgjqm_cnhfPO6p0oOT=2jrqFafMCHe2cwDg@mail.gmail.com>
 <YzwtG8CT9sTCqQQk@maple.lan> <CACRpkdZ-DfZKgCOHaKn1UZ8vVwy1dEiFBBDNdxu6VNzrUdeEtA@mail.gmail.com>
 <YzyZJSwy9xsy69WL@google.com>
In-Reply-To: <YzyZJSwy9xsy69WL@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Oct 2022 11:03:15 +0200
Message-ID: <CACRpkdYecQPUd-evVpOpMLY1XUa87kP4i+E694QfTtDbEarJfQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
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

On Tue, Oct 4, 2022 at 10:35 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> > Dmitry, could you fix this? Just patch away in gpiolib-of.c.
>
> Sure, I'll add a few quirks. I wonder what is the best way to merge
> this? I can create a bunch of IBs to be pulled, or I can send quirks to
> you/Bartosz and once they land send the patches to drivers...

When I did it I was sufficiently convinced that I was the only one patching
the quirks in gpiolib-of.c that merge window so I just included it as
a hunk in the driver patch. If there will be some more patches to that
file I guess some separate patch(es) for gpiolib-of.c is needed, maybe
an immutable branch for those if it becomes a lot.

Yours,
Linus Walleij
