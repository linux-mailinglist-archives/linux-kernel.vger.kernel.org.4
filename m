Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF16D69DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjDDRJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjDDRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:08:56 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FFD94;
        Tue,  4 Apr 2023 10:08:44 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id r14so19039427oiw.12;
        Tue, 04 Apr 2023 10:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaNiABUcvVtmqheZOblHu0qpT7KFyONMzcxJR5viS78=;
        b=UR42Xl+s+zzAo/Ayti0JAOpjf1ZiPhVWuwdz9u2f3ETTAq5FVJ2DqUbjdzWkabu2TC
         cKk+CV9j7UdjvAUN2lfb/ul9Y+JuT5NT6kXeU0UlhqhHl+CWyvOKwE7NyF/BEmJpxVgB
         p1gtdDsGwjv9Qpl06vx4W/TffIGxi4JSfNaLWgOdef2mZLY+97mHwx93al8i9Vdt0Fue
         1q9wWoxtBzhUSpHgXsHCaxOZxQJ8xuqVRRmH6g/5ziCcm4t6iOEzGpono/ngY/YyuBwq
         3/2u2rzNg0Q/hgXGSYVWEnZ47W2QzLLaqtOnfYZ3AfdqUhuBn1GkRP8VTBCrFFojLjhJ
         PrQg==
X-Gm-Message-State: AAQBX9fSqUnH4MSJ+eMw2Pz9Feh7b3SWqbB0gu8n1PX1IZp1X+bIeDZX
        9QWjj/iKR8ubIi+t2olENg==
X-Google-Smtp-Source: AKy350YfBZrfqcW8PEMfVNBBRRfK7rLxbfeh5SefSwbtVkxAw/f8hlOJB1kpUb6wE9T+az73emC35w==
X-Received: by 2002:a05:6808:c8:b0:384:1e0c:fbbf with SMTP id t8-20020a05680800c800b003841e0cfbbfmr1455403oic.40.1680628124037;
        Tue, 04 Apr 2023 10:08:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z127-20020aca3385000000b00383cc29d6b2sm5358287oiz.51.2023.04.04.10.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:08:43 -0700 (PDT)
Received: (nullmailer pid 121579 invoked by uid 1000);
        Tue, 04 Apr 2023 17:08:42 -0000
Date:   Tue, 4 Apr 2023 12:08:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mailbox: Drop unneeded quotes
Message-ID: <20230404170842.GD49361-robh@kernel.org>
References: <20230322173449.3970718-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322173449.3970718-1-robh@kernel.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:34:48PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   | 4 ++--
>  .../devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml   | 4 ++--
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml    | 4 ++--
>  Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml   | 4 ++--
>  Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml  | 4 ++--
>  .../devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml  | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)

Applied, thanks.
