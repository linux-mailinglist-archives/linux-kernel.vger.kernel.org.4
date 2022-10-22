Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09156608C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJVLAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJVK7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:59:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47C55A5;
        Sat, 22 Oct 2022 03:18:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b12so14483522edd.6;
        Sat, 22 Oct 2022 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdufI3Hje46oVXzKveQgMEHAhY/MYqQrs94ILdJz3ZY=;
        b=eUU/j85w3dwp8X3qf7WPl93f2WYeebxlLlOoVDHLru0upvpUCyr3zNuvLppI5kmykg
         sNToyeVPl4CxV90JHZBRA4wrtS2DzsZyOJfQxVcsRrQXgGRqVbe98Blh8wD6Bn8/TkHZ
         2HA5tYLnPBacYbUpaxLKoIWBz2Rpz8cwkpCXUguPmd1jdfKAE2Wxgfdu54cIvARnQboe
         zixa2tKRILmXErh6R3zMa4Yq3Oit0L9MjegqM+NPwQpjFgAMkqWajK++p+G9SPi5PKo6
         LqaeqfEaGjigAd8JfIcWLf1fYGngssZax9f5ajPf2TADkDj5OHYJUNCBB2YYEnO6ataC
         zPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdufI3Hje46oVXzKveQgMEHAhY/MYqQrs94ILdJz3ZY=;
        b=2yVIhEMyNUroL8J8qZ8jMIVIvReguUNw7M1RtUEnfl4EDyWMTJ/xCel637ukffEMs/
         7UqNS5n3GhLtf95nemf6JLyGrgDYfkQxUw6JHjI1VPxum7HC/c/wUxYSa4+jlJQzD9wk
         mI+zUDoymg+eF4pvjOjgT4bDC++ocTw+1gBVB2zFKZFa0kRk3kDT5t3PT3lpUfPS7jwi
         loHUDEUPvVgc/0o9z/AZyBD3NfwdBYlGG3D4ZMxzEp6jK/sZVzjEXcmQLlCPLS+nW9rQ
         ru3RNTLnUxYXF0dYdyciXQeFfSSKzB57RyOk9J5CV6FMwYKsvwJ27zjppcHsqyol1HnT
         qRKA==
X-Gm-Message-State: ACrzQf3OQbun/9Ds1+TlnVPLxanRYGFMxcknGiUsQzQht0zYRnDQ3UUc
        bmjdRu2lQOpMtVaP7bFALb9Xry628fdbC6wKY1c=
X-Google-Smtp-Source: AMsMyM7gp0sIMAuA7hxNeVlUzuW0+59UJAqTcGRUXxnKjlIGK3qUU6iuED0glB4xpGjPuhGXVt0D9ns+7w3RCqY8KeA=
X-Received: by 2002:a17:907:3c81:b0:77a:327a:815f with SMTP id
 gl1-20020a1709073c8100b0077a327a815fmr19834118ejc.422.1666433872323; Sat, 22
 Oct 2022 03:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221022084737.1028-1-linux.amoon@gmail.com>
In-Reply-To: <20221022084737.1028-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Oct 2022 12:17:41 +0200
Message-ID: <CAFBinCBu_-0m9JeAr5kd-v7Z5LTi7w0WmmUYybW_kL4KJXXpOQ@mail.gmail.com>
Subject: Re: [PATCHv3] arm64: dts: meson: Enable active coling using gpio-fan
 on Odroid N2/N2+
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Dan Johansen <strit@manjaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

Hi Anand,

On Sat, Oct 22, 2022 at 10:48 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Odroid N2/N2+ support active cooling via gpio-fan controller.
> Add fan controls and tip point for cpu and ddr thermal sensor
> on this boards. Drop bias-disable from set pwm_ao_d_10 the pin
either use "on these boards" or "on this board"

[...]
> @@ -1982,7 +1982,6 @@ pwm_ao_d_10_pins: pwm-ao-d-10 {
>                                                 mux {
>                                                         groups = "pwm_ao_d_10";
>                                                         function = "pwm_ao_d";
> -                                                       bias-disable;
&pwm_ao_d_10_pins is not referenced anywhere so it seems that this
change has no impact on controlling the fan on Odroid-N2(+).
How did you test this change?


Best regards,
Martin
