Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91217671617
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjARIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjARIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:20:31 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F86F8B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:48:02 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id l139so37115513ybl.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3lsVmwWpUbBcZLhC1PgXubVGuc7DZUQhVqbV9/Kjs9g=;
        b=Xb1rOdJA8KqYKynuQGkZtv9Xa3vI+W9rpQTtbkR9Yp9J0GVcDZKjAi7aKombg3nAQo
         kzPVXnCK6NE+R1DpzebUHvgQxqhqOqfK5lYu6/3h3rwKCeW7v7SimfoR7BgGCMz+RHLm
         du4DpsiBKEdrpktvKTUDLPb6Z4FDOo5290XMPN8TXtQ2w08/+f34T1SZNJ1ypELbLYZ5
         WnZfoMnIcFMP/LHTZ1/M3xEvSR6szPEW6Ua3GnIZY+W8nZywkq/etFzmai7llrbJheO2
         CayT6L5ENJe+THXD6qlGUoxGHW/3vAcPdW9ezdRZ2wqAGxKa71yGp7guH5ZygmPjXknf
         2iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lsVmwWpUbBcZLhC1PgXubVGuc7DZUQhVqbV9/Kjs9g=;
        b=RrAFgFQ9Xk3Xry+InII03JAlnBiW3Y69vhrQsjcCCmxvvzYeU4XUnxP6yFLhg0VRhj
         EtnV1NGBa14GRMh8cSFHvE94oRIGjkOUQxMsTr2t7SuL7WkOgP6P3EpfBb/iLbot2H8W
         xtczHWmInJOsyhbmDHq2T7Qeb/XJEdPhlLjJZYIf9TJkkT7ApKaKeE0lZUGFB30taTx7
         urpbcO24ZGhq7pCORHoXh3zziJ3qb1lHRXc8xJayqgZMOpFxJepmP3kr8z+E1eaktSuZ
         wq6+U6s42kHagysbLVouL2J4dNmsL+WFQnB2KgB03GhwmN5Xg2sxqgWRHYEzaqH8hQxm
         AdTw==
X-Gm-Message-State: AFqh2kp9Xta+sK5/CI7W/QkkXdG6oxmgpNaIvZGm5CSKfv+sO64JKF+K
        XWO+YfILWCQjvHxt6pP9JqpZuSufDRCdRu/8f3n9hw==
X-Google-Smtp-Source: AMrXdXsXwout0TrOcTOdN6y5F8uwNzphuPk9mcVCrUGLySs0iZEnk/drbasiu8yUy96SDbaiCFBajMK4mNLyshjjU64=
X-Received: by 2002:a25:9d88:0:b0:7c0:acd2:6300 with SMTP id
 v8-20020a259d88000000b007c0acd26300mr634228ybp.520.1674028081450; Tue, 17 Jan
 2023 23:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20230103-gemini-fotg210-usb-v1-0-f2670cb4a492@linaro.org>
 <CACRpkdaE+b_=6mecuWe4EUfYP9C3j5cXZXMO0s2t7Bf3eMtV_A@mail.gmail.com> <Y8ebS2lMvXs6LSZl@kroah.com>
In-Reply-To: <Y8ebS2lMvXs6LSZl@kroah.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 08:47:46 +0100
Message-ID: <CACRpkdZxo7TWBanzfLTEqo9E5Ajk23Z4Y-R_qDaVG2crKfcKVA@mail.gmail.com>
Subject: Re: [PATCH 0/7] usb: fotg210: Various improvements
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 8:10 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 18, 2023 at 08:03:59AM +0100, Linus Walleij wrote:
> > On Wed, Jan 4, 2023 at 12:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > This is some gradual improvements to the FOTG210 dual-mode
> > > USB host/gadget driver.
> >
> > Been two weeks, something I should change or are these good to
> > go?
>
> I dropped the series from my review queue due to this comment:
>         https://lore.kernel.org/r/9bbd5343-30bc-1146-3296-2c3a43b9a91b@linaro.org
>
> so I was expecting a new series, is that not the case?

You're right, I've dropped a single word and resent!

Yours,
Linus Walleij
