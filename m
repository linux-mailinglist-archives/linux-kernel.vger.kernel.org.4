Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8B61182D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJ1Qww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJ1Qw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:52:27 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A851AA262
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:52:16 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3701a0681daso17671407b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JFuZCHp6RPG0OZ+ZcxxiWhSMU9E34XF2yS0NNOUPKoM=;
        b=fqPTWnUuuck0bAxRjaW+t2+TNbmZRCzTB/mgIBtEByZSJ5rEB0x+gt6p8YULIDMmIo
         QJd/YrVYMoP7ZmrNzykTvlYWJUjGde5jgd0lm+NgNhmAwMUNAjRhhWb0JCULKjglLPfI
         wSGtrvHKTq7jeAxq42+CL6FCbx0fKEugliZOo5bRuV1bL5tVHZkgBVdVH6E3A9TidzSc
         hcpyvVGDtcA7tJYS2ah5C5rRuFFhvszme2WH8clxRaplmpfCF3VL+fdfZ2s2HLRWl+HA
         eL0/fWb6+IjvzUNetxTZuxNR0qANnOSnlAMm0ogoBoTpJZgN7DGrCjlPJ1gI0B2moZLk
         7clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFuZCHp6RPG0OZ+ZcxxiWhSMU9E34XF2yS0NNOUPKoM=;
        b=ndcaM7166TRvssvKgC1Y/MTXr6ifTBY0mRcw5ThtqYPhIOTiyd2Q76e7KGj3aWAMil
         iMhPL7OrJ6VrU5pNzxNqIruWnpaFYb8WEjIXVX9ASsHKMZzgyFayDAYyy+7eb0I281t1
         GlZVaSTic+9AQGH5y+kDDffUXxKI9eZ++Np/O/p9o0OqNiGqSEprTviixSGGHy6m/Qr0
         J3nC0ZIBfM84L0BZWaHof73f8bKma04VFqUw4QOr6L3G4pY/vDKP9cHnDlgigP1A4VNb
         xhJZS5E1UBweLNw/5oOZCFDple9Dq6tfNp9uSc50tNBAKSa4QlcVY4d/jFZStun21NRi
         2rxQ==
X-Gm-Message-State: ACrzQf3FbaQZ9sGaZrJlBNtB8lqsbAxVm42PtUWvU5/OAOUWB6g25feC
        +zwiqLsA7Lj4yKJMryep2zIaWFJ2X04MnjsPQauQsQ==
X-Google-Smtp-Source: AMsMyM6vjerUWgxxTrEsm3O1K4kgea+m/v98N6LpjqhoWL/YTXSYhqV+cegvXn3NJBWoYQcPrP65gYAr7BtftOd8w7I=
X-Received: by 2002:a81:4f89:0:b0:36a:f09f:73fc with SMTP id
 d131-20020a814f89000000b0036af09f73fcmr312625ywb.487.1666975935785; Fri, 28
 Oct 2022 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221028160733.1390230-1-ajye_huang@compal.corp-partner.google.com>
 <20221028160733.1390230-3-ajye_huang@compal.corp-partner.google.com> <Y1wApOeV7OoQzkt5@sirena.org.uk>
In-Reply-To: <Y1wApOeV7OoQzkt5@sirena.org.uk>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Sat, 29 Oct 2022 00:52:09 +0800
Message-ID: <CALprXBYf-V=gidvNpoRraPdJgdrYaCoCcJPhgAmx6UX5wUXzxw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ASoC: mediatek: mt8186-rt5682: Modify machine
 driver for two DMICs case
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark Brown,

On Sat, Oct 29, 2022 at 12:17 AM Mark Brown <broonie@kernel.org> wrote:
> Also do we really need the of_property_read_bool() there?  I'd have
> expected that devm_gpiod_get_optional() would be handling that for us.

You are right, it is unnecessary to use of_property_read_bool() there
, I will remove and send the v2 version, thank you.
