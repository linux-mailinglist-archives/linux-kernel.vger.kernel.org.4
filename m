Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D1A693362
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBKTuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBKTuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:50:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACCFEB5A;
        Sat, 11 Feb 2023 11:50:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ml19so23453314ejb.0;
        Sat, 11 Feb 2023 11:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NY0lTq6XRFzWeK6BauAkw8Er4oDHGUHF8zMRIiJVIw=;
        b=jdJMcq8JEf21/rWEpQtsdAz4Udz0L0X+BIZY6WBynjAiuyo6NtpeKVoD9HrkC0d3qK
         x+uTVszRsHVkrEBeiqo7t/qRuo56o9mkKAxf06Ry5lqQo+F5MrZMSCaoCPrbVv3W2Ri4
         f5PQOulBBLhJ4j4QoZuugaVLSIxflGcgbFwg9QDLBLb8gMz4eg9BWbZTpQqY++U+MHy2
         W6Cg5Lx4OfPVy4fgKDjtN7xMcqA/e+AS+fbLBkGJ+Tv2Ox4esUCQ6tcks2THK6Mo9dR3
         Es+yGqNoOm9gt9U38Il4gGZfV4yXesN2mC4meJ1x1QXKOQMIbXwemHwzFc/FL7/1AXs3
         kRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NY0lTq6XRFzWeK6BauAkw8Er4oDHGUHF8zMRIiJVIw=;
        b=iZJIxxzA6mZDOqUcusO9ap/KAfIKLw+WqW0gvySyj/Su2MNpeFe7xQVqxYhfguGKu9
         hFO/hJ72+9fcR9PaAYF57ISd5wFuIU3JRv3W1Ls8OCJ/55k7GjPKUgcWoK9/xyhsi7/c
         gEkGq2/2bP8AhUHet1QIuhMznASQGvQUKyQ7xulwSAgD6ooHFLuiBpOEu7sO5Mey/q9v
         ue7agdCmCODDJWwrhE7Dt1VbDoAJJqkERhvHMKRIi8QqKqUVi60KzUEY6N73ZH1hReOJ
         tSNAfi3Rbl72CcAxNT1wAsGfX/73j+DVb1IWzg5C4Ux1FInw4ko7UjhHceY/VX0AYjdr
         Ptsg==
X-Gm-Message-State: AO0yUKVYDvwygiNTPOg2DK058QoaWl6KpRNAxHgm+x5E4PCeKx0RCLdT
        Exn5YRINoezdlvRFJ7pzfz4SGp76m/+JM0xWDVY=
X-Google-Smtp-Source: AK7set8RNi1bP5tZb7wWagCdIiM6a34gDYLNL8M+gVIgqsCY6CtOYw2JFNZy8IfbS4oNq7GMIfY5dz2l5s7fqg5+3QQ=
X-Received: by 2002:a17:906:241a:b0:877:a0e4:4cce with SMTP id
 z26-20020a170906241a00b00877a0e44ccemr2606921eja.4.1676145019357; Sat, 11 Feb
 2023 11:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-4-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-4-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 20:50:08 +0100
Message-ID: <CAFBinCCXYHkovYALUAj+1rkos1bzXfa2_JOqpnHsW3NSrpnw9Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] arm64: dts: amlogic: meson-g12b-radxa-zero2: fix pwm
 clock names
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>, devicetree@vger.kernel.org,
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

On Tue, Feb 7, 2023 at 4:08 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Fixes the following bindings check error:
>  - pwm@2000: clock-names: 'oneOf' conditional failed, one must be fixed:
>         ['clkin4'] is too short
>         'clkin4' is not one of ['clkin0', 'clkin1']
>         'clkin0' was expected
>  - pwm@7000: clock-names: 'oneOf' conditional failed, one must be fixed:
>         ['clkin3'] is too short
>         'clkin3' is not one of ['clkin0', 'clkin1']
>         'clkin0' was expected
>  - pwm@19000: clock-names: 'oneOf' conditional failed, one must be fixed:
>         ['clkin2'] is too short
>         'clkin2' is not one of ['clkin0', 'clkin1']
>         'clkin0' was expected
>
> Fixes: d747e7f76a5f ("arm64: dts: meson: add support for Radxa Zero2")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
