Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C66FFCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjEKWjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjEKWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:39:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CF2525F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:39:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-335a61eb904so537655ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683844749; x=1686436749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=IK8Qf/ccLJxU+5T+78cr9mYEA3NHlKtpeo4eLEHDI+LKnIqxq0+CgI4jg+IqNtrCKD
         wJvm9j5b6LmPMSHfGoH30tM7uDVOPfCSh/tIE6TNWwbOXKCE/5Mbb069QWjY6wkFJUKH
         CoOQ9Pw1e2D7/iMrENQ9k5oWe9xpUs6bVT7DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844749; x=1686436749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=UrjkGqI25xWKFsn3gSIe3QIFFd5XFlae7bsmiEKkC/eYXAB7c4Zfk9mh1Of9YH13/6
         XuRBEKdOpZ2+Wt2SDYJ7zzuA7Op62PrBJadKGKUXcdyaoUEVeu+FEqihDneLtoROwn1T
         IDoLzSwMmWby8HWXldtb/j6trGZgj5nMSzpHJo8nm+4Rnuoltbwz3Fy6C0v93O01qbpZ
         /TdYvt16/hEF++Z/KYWHYYif5MBba08lJwWmpdc/JlG7hDBLP2ppHIPcqQWjOr5vTnqV
         MX9NRIr16JjyCC7BIcms+xoPVAX0P6rmBsEgq+F+ajy3AvxmNnIIt8bOP91o9EXKznyl
         dpsw==
X-Gm-Message-State: AC+VfDyBq3lZNyqpIOTqfrT8RKYnKE2nnnTGLMp01rBff2WMsm/8dM0E
        cEQ170Fu+sfyBElwCABXJKKyF++DzcV1Z0yfw7KBWg==
X-Google-Smtp-Source: ACHHUZ7wqSLEyaaLGQp6CBfVVzxbKSYujepzzVu4d/1ybnzNbLqJzfDbXtwCcob4wHBhXZeVBoSrdMMDDPykJa1Dsbw=
X-Received: by 2002:a92:c563:0:b0:330:af65:de3d with SMTP id
 b3-20020a92c563000000b00330af65de3dmr13357ilj.11.1683844749308; Thu, 11 May
 2023 15:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
In-Reply-To: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 11 May 2023 15:38:57 -0700
Message-ID: <CAODwPW_au3i3JVAr5zfFB7ZQYrYNhG33gZ8iysijQDWK+PL98g@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: mediatek: mt8195: Add mediatek,gicr-save-quirk
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
