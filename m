Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C586FFCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbjEKWi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbjEKWiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:38:52 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DDE59C6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:42 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-335a61eb904so537555ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683844722; x=1686436722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=D1FyFhLQwaDejOigqWLk+GuyULBq7LZgABB5i2e5+IKmmWCfxwSTJT3DQuSmKwKjd8
         e3jhl3HKPDcYXl9986gGkAGRHMQQZJGQk97gBFA8DDgNTtenpBsRUNX6l23eGj3nmZiF
         Ps7NGOVGb2IR8BW+825K4FT0AQX2T3+wgvhKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844722; x=1686436722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=KmCp6FF6u3EA1z00rPtid8dtRqqgxIZNJXD/D56w16r1qIZnJI/2W32fp4BcDiPcwl
         oTkEvMeHQh8TEswQsIxQK5qp+uVlgGIYxO2G/FkvJDXhj8VV1jtjsR2YxubHBo6qqnok
         Xk9Vj+pcG26jKt96r6/c28Tpf1g6nnyrgfadrjlaXq+9P9mWBDS0k9SU4UEqjAPC6SUr
         8WBFFsRf4uPiB23W1/V6HSciOamSavOk/ikyiBqsZZjV01tJ+dmtZWNjnmsaUlyIzSUQ
         wrcilURfgaA5yfEeihI3aBwfXZCn+EevRtO88Y310DK95CSwbmS9vOp17XVoFlfMtBkA
         KD9g==
X-Gm-Message-State: AC+VfDwyhYy8jBckaPNjw8u8GvPA8ikG2y04HIjWCqLLtqRuu/R8CaNm
        ssoTslP8lV4SlfCs8Ka86m3Vg56yx+IO8FKOLikloQ==
X-Google-Smtp-Source: ACHHUZ5s2SSlvAKm0yJCbow0T1hR5Nz2BqU0NUPOjYkRbNoZ1N11ksD1vWehbac9D31CrZPeMvxv/rSrw7qS62xLZeQ=
X-Received: by 2002:a05:6e02:1c4c:b0:331:4df0:8196 with SMTP id
 d12-20020a056e021c4c00b003314df08196mr14030ilg.13.1683844722057; Thu, 11 May
 2023 15:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.4.Iaa0ee05cf0362540fda50dd6a0d87ee35dccd88b@changeid>
In-Reply-To: <20230511150539.4.Iaa0ee05cf0362540fda50dd6a0d87ee35dccd88b@changeid>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 11 May 2023 15:38:30 -0700
Message-ID: <CAODwPW9zj6SAbBjk8c91sTOtzzAceJ+=kaMuMOqDYv4Q8JLDyw@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: mediatek: mt8186: Add mediatek,gicr-save-quirk
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>
