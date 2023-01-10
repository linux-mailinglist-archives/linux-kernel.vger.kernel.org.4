Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1A6642A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjAJN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbjAJN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:58:47 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6C5F7C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:58:32 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 194so9577438ybf.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oFZwRY6uBLBZuERv09QJDFRGTgg+VDphnUtXg9PxNVs=;
        b=dl1jEucuqI5UQ9nBOsumkthDB4PfRmN3wVSlcmlvbjubyaXxhwoQ7Exr6BgRMLd3Yo
         P0sufSV6uSsrNZD49qZPiPEnlGyGxMNqEZrgNsnyKlOYRdG6DdsMn7Lfg0JybwCZj0vi
         MyIqe543F2JLZt0XdMGGP4/ox3OeZqQUmQTVSMB5Q778gXqGTJAWY2SVpZ5lMspwnfNz
         vigfWaQcd9yxjRSF2feHGUfQZPA1naqqYrUl/uzEAwoCcxqiFFEVAWeleDuNEoqxwWre
         3s07ItqpkVuBScfPpaZpgKfi7qbEYt17ypOVoxxHKyqZKRFHbhSlqyktHV/Yh3L+1siH
         E4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFZwRY6uBLBZuERv09QJDFRGTgg+VDphnUtXg9PxNVs=;
        b=3G4AXKQSmgigIX8GSlFKQJ7dif8/xKpQCg/lHToWOnXt3zLBw/Jb3QtpFYKVHGEk7v
         PKG+fQR/bgLCwmNHaUZfq78DDqsnqUKg2zHtHkmbAjv73Y52+VJO5dmRYURt0l7QpqZy
         YCYxeoVJYHgqE9gLsSfaWl4K9rtUOLCaw/GeviLSTeQA4A14VgsREl7PTAnWamq40Rll
         X31qFFlve3o/2WTuv+Om2Yp1n2HgySIrf2wC1HUpqf9g4NmmochbnPLEkqS2gmKIJwFD
         kF2M47PzdZPgpW0c9dmvbhH0jvVz8aBBSbQEPdR2oK8ylDPh7EmZxRKp/zppMMqd3S4R
         fgfA==
X-Gm-Message-State: AFqh2krJcQkDveLPk8TJe5FxL9zu0wRSmLO0PR2i8FLb2ni35Ro/KHJ2
        TSTsWYPhysFsI8QR5z8juuIYa9yBp9zfU2AtrmVQTA==
X-Google-Smtp-Source: AMrXdXtOECa1Nex6QNZ4s6NPdbEMGaCsgxgZn2oFye7UY6Yw2EAr94MI/GfGgzcchhu1QTDe4tNi6+wPyE/Ue6w6WxI=
X-Received: by 2002:a25:606:0:b0:709:9335:236e with SMTP id
 6-20020a250606000000b007099335236emr6135998ybg.288.1673359112123; Tue, 10 Jan
 2023 05:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20230109155801.51642-1-sebastian.reichel@collabora.com> <20230109155801.51642-5-sebastian.reichel@collabora.com>
In-Reply-To: <20230109155801.51642-5-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Tue, 10 Jan 2023 19:28:21 +0530
Message-ID: <CA+VMnFy3CbspUFwGv9VGuDPE3ffNJFj1fwH-1qkhMX0rWgYbwg@mail.gmail.com>
Subject: Re: [PATCHv8 4/7] dt-bindings: arm: rockchip: add initial rk3588 boards
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 at 21:28, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Add DT binding documentation for the Rockchip RK3588 EVB1,
> Radxa Rock 5 Model A and B.
>
> Co-Developed-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Reviewed-by: Jagan Teki <jagan@edgeble.ai>
