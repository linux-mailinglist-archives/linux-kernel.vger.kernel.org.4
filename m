Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26137616ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKBRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKBRh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:37:27 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A32DAA0;
        Wed,  2 Nov 2022 10:37:26 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id r83so19927550oih.2;
        Wed, 02 Nov 2022 10:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8oloE4DB0KtUh2KaRZAUerbxLYItOoHqFwetle//mM=;
        b=hb16n3MnTWMkPD7O+RccNEhLK7Z0go/KZAYRGXHHtgfVDawXCiB98tRuEgpISEkwau
         ht8OUKrtdRcNtE87+9S4Vd/n1fngv/dZmhbXLRZZnsSRiZddnjb11TkaArPDy4Q9e0m2
         OlHzNPKY/LZN4xhuuAzV79oDLGloVIDoCcnwnrX1DuM3nSMRXDQmJp/YX36kLzTkAUQQ
         OTJ4Gj9G5RfMgbPfAu6QRWy8tdjNIcRK6Ak7SsVYln9Aww5YuesNtTMmKjpjDC323L9+
         7sur9gL5L5uEQacfJxAKVUkXuJ3UU/5VZxupg8R1nBRZZJnIX7X6TjP8vy1N1pkEGZGU
         uJUQ==
X-Gm-Message-State: ACrzQf1pbVx0IddnbnGaIBKURaBp9zE1GNsADx4SvzWod36jVqqj+PUs
        PgjVRLHUQ0khZ50oHi3XOA==
X-Google-Smtp-Source: AMsMyM5m8ic0ua/GSoABaPgBAMZXvHgG/1e8yf1ZDlcC6h/CYEKpe+9mslEsZo5CKhpgU4xU0wAuVw==
X-Received: by 2002:a05:6808:1487:b0:359:fa85:880 with SMTP id e7-20020a056808148700b00359fa850880mr11667456oiw.74.1667410645403;
        Wed, 02 Nov 2022 10:37:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v11-20020a4aaecb000000b004807de5c302sm4662713oon.17.2022.11.02.10.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:37:24 -0700 (PDT)
Received: (nullmailer pid 8029 invoked by uid 1000);
        Wed, 02 Nov 2022 17:37:26 -0000
Date:   Wed, 2 Nov 2022 12:37:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        phone-devel@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: qcom: add sdm670 and pixel 3a
 compatible
Message-ID: <166741061956.7260.7478977756040774653.robh@kernel.org>
References: <20221101235722.53955-1-mailingradian@gmail.com>
 <20221101235722.53955-3-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101235722.53955-3-mailingradian@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 19:57:20 -0400, Richard Acayan wrote:
> The Snapdragon 670 and Pixel 3a initial device trees are about to be
> added. Add the compatible strings for the board.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
