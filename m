Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4170B6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjEVHhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjEVHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:37:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592F3B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:37:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5621a279cbbso48964937b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684741060; x=1687333060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOQE4VDyp9QIs6NnGgNh52U8dycaA6C3cQQrIeSpbrg=;
        b=PmRtzZjd/eb9Y0P++rxNgxg/Oc5DASz5+rQJjU5EAJMmbpOLYi90eqSsYjl1Fh1tp4
         hmqMtIHuqXlH9dcoz89vrxb7CU6FjHHjf81IORoo8hLRDhqxbWvilYFdWlu+8n+2S76y
         WhOA+K70xWiW65fFZdfz/ByBGrGCez3rkyxJOBylHoezUrOw24z2gk5+8i+KaVqibDxS
         O8YH2hY0OEBKm79jKnw718EutuBzTa62OXFZZIYCTgkLTusiSsOwwKtb95P2KkngrlSt
         Hybi9xBTPRdsctyktMzhRegEWN4pMqqSLzorNznU88QNAVgom9URAc617gjleWu2bn2Z
         s7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684741060; x=1687333060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOQE4VDyp9QIs6NnGgNh52U8dycaA6C3cQQrIeSpbrg=;
        b=ZboA0c9RyzcjUDwEiFahKvY80D24CLsqeb1LsnIaibhIWiM0CGunrgEpeljMdZhVKJ
         2rGShlPS909zHj1z1zJZGSn+VSVubgKZXpQL97tyws7ZZcVMgTCgF4nHJAL6nYYYIedI
         7lyzAPm+0IEcLyb7/rQAjTsz3SyXOCp7/y9JOl1ulmBcoqiVzMe03u1D79vRjyCkE6hv
         JhomctI4Fh1VVM4x4RTMq0qRHoLSR9iUL2x1TzKg6WqJOidUtPylQQnmv8wctmmTamO9
         KSvbNGKftag8C1jj6NUhdg2Y+jq9JAufAVboA721/TSd32y+sWi/Iwyb3hb8//on0EYq
         ooZA==
X-Gm-Message-State: AC+VfDyjvW3LNJghu7JTlTmTZTbxCNWH3xcf9sURxSAduNs2leyQxjc2
        XHuh83QyEOfsT0feEb6kKnbnNsBZy/vfu9YuQlcNIg==
X-Google-Smtp-Source: ACHHUZ4OlwL4eFt5zi+AsH8sIY8nmp4Gyo36E4mPxBwVrmJ1xabFq8GLNTy4Q8brmKGEiTqA8kpTFdMqSZoEtMrb9T8=
X-Received: by 2002:a81:7406:0:b0:561:be2a:43fa with SMTP id
 p6-20020a817406000000b00561be2a43famr10697543ywc.7.1684741060509; Mon, 22 May
 2023 00:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683719613.git.noodles@earth.li> <cover.1684258957.git.noodles@earth.li>
 <7691a35155cf644c2efb02c282c5ef007a6570fa.1684258957.git.noodles@earth.li>
In-Reply-To: <7691a35155cf644c2efb02c282c5ef007a6570fa.1684258957.git.noodles@earth.li>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:37:29 +0200
Message-ID: <CACRpkdbgL68SRwMs5-TDre8OBZpAtXeMGrBsQrEs8B-RO+X8Lw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: gpio: Add GPIO3 for AXP209 GPIO
 binding schema
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 7:47=E2=80=AFPM Jonathan McDowell <noodles@earth.li=
> wrote:

> The AXP209 has a 4th GPIO, so add it in preparation for support in the
> driver.
>
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
