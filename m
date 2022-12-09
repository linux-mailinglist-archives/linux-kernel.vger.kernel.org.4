Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4E648927
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLITn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLITnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:43:15 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1434265A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:43:13 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id y18-20020a0568301d9200b0067082cd4679so31832oti.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9qpGkCKgXFOxyU0qgXKRH6FfvuG/EK32TWwswTaP7I=;
        b=VCvZEgfeVcxEuLxl3Vf5Aaks+on/Rcc8HKaX1HLy/QSsD6aqVJFvZAnDM6Z+6zOjAY
         NXsjqttOBwq90zvzEVBuVkhWkAw12xJwEJ27uYZeGahjyvg4oxOMXNMrHVgjwkMHOy7U
         q7mVU/0ZmkK+L+UkUJi6gXLn5/fys1utHHWzEm2uUz5YVF5qxaGqavGD4aAACrLHHa1G
         fNNwtld9ZOmKUm+9bPcpv2UAvi60XZpWzlHsIxw+m43XCVCE30aOHBvc+2Lze6dvk3Dv
         O/zkJQIVshLbGso8sSpfGoLnC5QKv7i+jy0DYQ/8c4QW/6k0es2Bc0Ant1UxUx4aMbKq
         /QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9qpGkCKgXFOxyU0qgXKRH6FfvuG/EK32TWwswTaP7I=;
        b=KpPenSwxXr3QXzGzEzM88t00Wl3KFipo4E5yUU3zMgOAwS3pJ5zxLhQRQ9TTVjJ4lv
         w5zTdM2Kj77P5iGeRZHf3OHSIdPFSOZ3P61SwNzPBF91MuAsCmoaEb++ZgfxvtrI4zfV
         K+JoNlNqRm6P367ObTNHHrQVvPEQm/PEGOXlsekoh+OBwPIC9TYkDAIHBlkJluhmAZIx
         DJcEM9PjSj0K16jSuUrBx5uOHOJUDLeItsB2YQfycRSKPmMmYmqXAWFh5uvCzCGdCggO
         m9y3c3Ejdparl0irJCKnHyz3EvuOMYG9yuv75AtGCVh1sejswZYM3WKfYltI0zy3cvGj
         /42A==
X-Gm-Message-State: ANoB5pn4luWgG7XryneoDCAm7opvtgnolsV3pBXMPBeVLmJ1CxJrFT6u
        GQ8MwVI1YyuacXMfL9dFU8tLSMGkydOMeTkreniecg==
X-Google-Smtp-Source: AA0mqf47WmKbtF1kED/nFngCYB/0TEw9NEOJd2hDLnd+RmsXi7mcactDbtQgm3+cVxMjBYmPRokv5kdngvfOmJcg71M=
X-Received: by 2002:a9d:7ad5:0:b0:66e:9c3c:8fb6 with SMTP id
 m21-20020a9d7ad5000000b0066e9c3c8fb6mr11040141otn.338.1670614993297; Fri, 09
 Dec 2022 11:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20221209171629.3351420-1-robh@kernel.org>
In-Reply-To: <20221209171629.3351420-1-robh@kernel.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 9 Dec 2022 13:43:02 -0600
Message-ID: <CAJe_ZhesrurLB6NK_sVLxPN1vRLtJ8LcoR-7-fmdKZ8Fg=nTFw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: Convert Fujitsu MB86S7x GPIO to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 at 11:16, Rob Herring <robh@kernel.org> wrote:
>
> Convert the Fujitsu MB86S7x GPIO binding to DT schema format.
>
> The "socionext,synquacer-gpio" compatible was not documented, but is
> compatible with "fujitsu,mb86s70-gpio" and is in use (in u-boot
> Synquacer dts).
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
