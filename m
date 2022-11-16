Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D562C113
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiKPOja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKPOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:39:28 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C210D7;
        Wed, 16 Nov 2022 06:39:27 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 94-20020a9d0067000000b0066c8d13a33dso10496034ota.12;
        Wed, 16 Nov 2022 06:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiowHcJ1MfORS7VHAIgm0o5kAFmeRPc8RrgjNd7UdFA=;
        b=r3i7aBNiT+b/PMbwMVooGXFc6GZ4H9aehWs4wffVwLKvMWTMkNG2HA2JVyDFLtPGi+
         ePjLHYUGTWcUlJjeJXQiekigwzstnitWzSnDf8Ld2fCohpQNwnErp0MUAXMCQy2a6OH6
         6ofmGLIJa2uPV/WdysZTFbhdplEnNohoG+3qtQU2Tu/xWaAaQGcLaoaQE7m6DHaKAUvM
         F5kofB5iHIIuzuTfoqjgmGoyCwAKlxBX68dUbiJdQpmEkYyZ77PtlMrpPiIszSxshLkc
         00pD+Y8fWLFqGHMdhzKJvy05z8Jdobz3AP/JMN7Be1MrpxUMpfbNzUGuqXNYbdFquIcV
         1Sxw==
X-Gm-Message-State: ANoB5pmS0p79ETlAUwCKY3eQp6nDT+CFyeTo3szF/ZeRlCTlKgtg/YNe
        01LzT2WqbBsZfhYp4+lzoA==
X-Google-Smtp-Source: AA0mqf4y2wvAVlc41qBrXyNrAl0Yy0o00bCnDZSiALjTS7JNRnvMYXYjenLSTMR2DZd/ee6m6ljJtg==
X-Received: by 2002:a05:6830:18c6:b0:66c:312d:472c with SMTP id v6-20020a05683018c600b0066c312d472cmr11107299ote.339.1668609566572;
        Wed, 16 Nov 2022 06:39:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ek24-20020a056870f61800b0013b1301ce42sm8048434oab.47.2022.11.16.06.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:39:26 -0800 (PST)
Received: (nullmailer pid 3817519 invoked by uid 1000);
        Wed, 16 Nov 2022 14:39:27 -0000
Date:   Wed, 16 Nov 2022 08:39:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, quic_srivasam@quicinc.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_plai@quicinc.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 04/11] ASoC: dt-bindings: qcom,q6afe: Split to
 separate schema
Message-ID: <166860954376.3817005.4583146687894570337.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:28 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the Q6AFE
> service to its own binding.  Previously the compatible was documented in
> qcom,apr.yaml.  Move most of the examples from its children to this new
> file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.yaml | 68 +++++++++++++++++++
>  .../sound/qcom,q6dsp-lpass-clocks.yaml        | 40 +----------
>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 56 +++------------
>  3 files changed, 80 insertions(+), 84 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
