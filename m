Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1B66BE74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjAPM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjAPM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:56:53 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE120050;
        Mon, 16 Jan 2023 04:55:42 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id x5so861930qti.3;
        Mon, 16 Jan 2023 04:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM4Jkzp/QAXkO7bnxWsfgCHfESoHq0ivf9TvlonLhmA=;
        b=Mn12KVK09MbH3Hu1oFUpb91/fQq2Ug1Z9ttFJE3HTfHJGykZ7mG6ap34OOqGCy2lIO
         oVVAT0MRRi/epgeph8vkPzVfrN80ql2r64zYNTJbwqb/Dp7EXWMt5vofn82JZ11+Om0+
         xml1FBPmPR13B0I4ZG7n0BZVKu0Bwessyu6ZcyHHBACcmy5BjRfvlE5v3PGCRefzNmXF
         iO0OhvAyuXHt/gmqthfBz7on7BbqLmpb6Uhi/QS7n1e8F6QFo/Jm4QHJNGBc+15UOJ0b
         ukEaqxGA11VkinQIKOPTSopziQfKUhQ1q3Pko80j8xcyg+psu0YbRCXjTD3gWZnCt0ST
         RJgQ==
X-Gm-Message-State: AFqh2kplFSIxWBsblK5BCLSdT/t0TQd6OmQfHXeuQWqvJZ6G8yp8LsrT
        RosIB5m7UUWTFKl6M5GwnYXYDLyJP2VpoA==
X-Google-Smtp-Source: AMrXdXvSek5CM7kko3egK3cIPxxImuMu6Faaui9MMc86ouX0ZA93gouZby3xtrm8yUqdhdm2/f2juw==
X-Received: by 2002:a05:622a:1c0e:b0:3b6:2c74:1453 with SMTP id bq14-20020a05622a1c0e00b003b62c741453mr8833816qtb.61.1673873741673;
        Mon, 16 Jan 2023 04:55:41 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id jr49-20020a05622a803100b003ad373d04b6sm11638024qtb.59.2023.01.16.04.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 04:55:41 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id a9so13476351ybb.3;
        Mon, 16 Jan 2023 04:55:40 -0800 (PST)
X-Received: by 2002:a25:46c6:0:b0:7b8:a0b8:f7ec with SMTP id
 t189-20020a2546c6000000b007b8a0b8f7ecmr4777221yba.36.1673873740621; Mon, 16
 Jan 2023 04:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20230106125816.10600-1-fabrizio.castro.jz@renesas.com> <20230106125816.10600-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230106125816.10600-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Jan 2023 13:55:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZ+wrCmRxjoV-k3zhs1tHHdLr1toBbT2ft+-pVrzMYEQ@mail.gmail.com>
Message-ID: <CAMuHMdVZ+wrCmRxjoV-k3zhs1tHHdLr1toBbT2ft+-pVrzMYEQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: soc: renesas: Add RZ/V2M PWC
To:     fabrizio.castro.jz@renesas.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 1:58 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The Renesas RZ/V2M External Power Sequence Controller (PWC) IP
> is capable of:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins
>
> Add the corresponding dt-bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> v1->v2: I have dropped syscon, simple-mfd, regmap, offset, and the child nodes.
> v2->v3: No change.
> v3->v4: Moved file under Documentation/devicetree/bindings/soc/renesas,
>         and changed $id accordingly.
> v4->v5: Fixed subject line and changelog. Rob, I have kept your Reviewed-by tag
>         assuming you are still happy, please do jump in if you think  that's not
>         appropriate anymore.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
