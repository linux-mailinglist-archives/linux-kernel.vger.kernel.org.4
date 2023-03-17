Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6626BF38B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCQVII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCQVIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:08:05 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B835EDF;
        Fri, 17 Mar 2023 14:07:54 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id o12so2874504iow.6;
        Fri, 17 Mar 2023 14:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679087274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lanIB1szt8MtylotU2nQbMUDpg9VHn1naeaW6kMvt/0=;
        b=I+/Dc5exYrrNzH3tmM49HhTUhWHwvgHjhapd6qI2KwmnPRNQoTrhIevEEfK+QHVX1p
         E+92Ss2vFVu9v8JWdZVnyH2USlmqk/layNi/qPj41Kn61zjBxn1qiN+u8lhPlHh1fuIb
         DLQ7dNFOxFhHsB28NsolABSOthINghQI4aeRbyKrF/qab8Ni+Ntq+cUu7u0OP3Sy8JU4
         f4iRe0uUrtSJbeQ6IJIC5H58J8TcghdSp3opqUu8o0r2/w3LV09OuI/1ChoEI93D5u88
         vyum6EO3Y19DwT5xodTPdmfxsvkGaR8FUVpffw5iN3Hb4DRFRwXQCrFBuBTazIo04+nH
         pRzg==
X-Gm-Message-State: AO0yUKUBDpSps+Dubm/vBCLTn+3jst36MpvJYwkR28jF5Bf/kwjgDCYu
        NIDZUKwn4+3Yd5s/7PuvYg==
X-Google-Smtp-Source: AK7set8bsxIdAGAS0ZxHVkPEgM8I8dvNA5d8n4Jg8HW19qx33blg2l6vBUF5O0mulVz8sbfhgK8IQg==
X-Received: by 2002:a5d:844c:0:b0:746:1c75:233a with SMTP id w12-20020a5d844c000000b007461c75233amr472892ior.20.1679087273864;
        Fri, 17 Mar 2023 14:07:53 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z38-20020a0293a9000000b003e43da36e1fsm1024392jah.12.2023.03.17.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:07:53 -0700 (PDT)
Received: (nullmailer pid 2807406 invoked by uid 1000);
        Fri, 17 Mar 2023 21:07:52 -0000
Date:   Fri, 17 Mar 2023 16:07:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 02/13] dt-bindings: mailbox: qcom,apcs-kpss-global:
 fix SDX55 'if' match
Message-ID: <167908727153.2807347.6662120433582674568.robh@kernel.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
 <20230314080917.68246-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314080917.68246-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Mar 2023 09:09:06 +0100, Krzysztof Kozlowski wrote:
> The qcom,sdx55-apcs-gcc is followed by another compatible (syscon), thus
> the 'if' clause must match by contains.
> 
> Fixes: 0d17014e9189 ("dt-bindings: mailbox: Add binding for SDX55 APCS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml   | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

