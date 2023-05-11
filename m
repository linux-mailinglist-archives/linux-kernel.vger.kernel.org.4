Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34926FFCC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbjEKWim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbjEKWif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:38:35 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B9A76B7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-33164ec77ccso615735ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683844711; x=1686436711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=bgglkVrLcpIOyGfwQj/esOxMllAkHXCjEjRGyoziuAKG1QDzP6vqAAzUgt1+LJ+9ZJ
         Ha9KCDI7g2QNDty8fmC1H6UCmCpZeDSbyLU9X3RmLOiOhL/SVRrmbllks5beASUV0ACa
         UzQSTZom/8T2Bla+CZHVWPrPuNzGNYOOyqaxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844711; x=1686436711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=PWMUOBnVI5ZTn4cvaOEVbOPu8nOGYpnqK8VYukYwy0AKBhj9zzFz/y8B8FksB75E9t
         IOduZ5Ez0+rDzwoz5n3OKerQj9YL/CS12p36sL6M5bY72Pdn/FpVdJlmYV4K3Y/Pd26p
         h0onVXnbz684M+41GNb+9ath4WZp1g2/NlVrX07J81dTzqNZhfuyUWzY63OJxZ1zd3dV
         4dDK3dvlD79JEfSvnOHsw6FY1ZrzGzKtE1bOjs9ikoTi+yGq8P1xtum8yeVC1p3/v3eq
         c1yzTsYVY1xNMSaiEEO+0oJkosZRSU+P7b9VHTtPVFNMLveOuM06entm4adMfIjw6NcA
         Tcig==
X-Gm-Message-State: AC+VfDzlkcKE8lhWNVgXVDs0wG88yRc2L8M208/YfmZel1TgJukPgOK2
        BgMXI6xHDkB+Y2VFEoHh6QSaDNx3VVtRUZKsOApZbQ==
X-Google-Smtp-Source: ACHHUZ7vCCWbTAYP16U6tuq3EY4U3PXWute7NLps4i5dXRxX/Gfxf5Ubm2VJtH56zuw8yR1ruIHjnEXfdiodYQ+LhYs=
X-Received: by 2002:a05:6e02:2183:b0:335:4c11:68d6 with SMTP id
 j3-20020a056e02218300b003354c1168d6mr15530ila.7.1683844710963; Thu, 11 May
 2023 15:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid>
In-Reply-To: <20230511150539.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 11 May 2023 15:38:19 -0700
Message-ID: <CAODwPW8f+nG9gTQtDLs_OO1Y29A+znkRwKYLQ-gjYbVLiCL85A@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: mediatek: mt8183: Add mediatek,gicr-save-quirk
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
