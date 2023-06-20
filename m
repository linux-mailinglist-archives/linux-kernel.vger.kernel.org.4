Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F973722E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFTQ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjFTQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:57:23 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD480E68;
        Tue, 20 Jun 2023 09:57:21 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3420ed1a745so20220715ab.3;
        Tue, 20 Jun 2023 09:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280241; x=1689872241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC5LTzrdW72AjRfXsobL8u3UH+veW/fbZ9ZJyUEUeyc=;
        b=HUq7mKQKWf19VJTMTtdEIlIgrZ00Ywq3wZFaiDIVMXwgdMPHSz/HCNpR9Nk9/S5aZU
         UZmQ/U5zRX4A2yXwa23ixgaRzQ1RKwXPaymuVOEe9Mzh6uKSXxtzsBqzuMgUmIGbo/UD
         tBlMs8Ib0Az3ufqNunqkyIl2M30Q4fVDnywdUcg7o4K34gis0PL8O2WtoIYdrGUOiIj4
         dGjUNRCXTElpOSOeqY3rSkIpjgt2lwfvwQw2MqD12VmBVSUoLnAU7VjeFNFvnPCJAEb5
         ZmR9Q5cSJFXXlXibA7aYbWlSqJ1xxi662NDmRQiFIK75z8IOlTgKALPUCqcAc0PvVCmm
         3B2w==
X-Gm-Message-State: AC+VfDx6as3OUzNSkjIdu5yeo3LqOlQho+78oSc8v+HvcYJ6rodLShce
        ch+NqEtJlVW10GCi37Ob3w==
X-Google-Smtp-Source: ACHHUZ6Wepi8qaaAa7+QyMTVgGI7G32JZdMVMM6o+c/Yvv5Tqm/Ued6aJXSw2qrtLL6F4MGXPFOwjQ==
X-Received: by 2002:a92:c806:0:b0:341:c484:1c36 with SMTP id v6-20020a92c806000000b00341c4841c36mr11987996iln.8.1687280240930;
        Tue, 20 Jun 2023 09:57:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p17-20020a92d491000000b0034248a56432sm703724ilg.32.2023.06.20.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:57:20 -0700 (PDT)
Received: (nullmailer pid 3815844 invoked by uid 1000);
        Tue, 20 Jun 2023 16:57:18 -0000
Date:   Tue, 20 Jun 2023 10:57:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Banajit Goswami <bgoswami@quicinc.com>, devicetree@vger.kernel.org,
        Patrick Lai <quic_plai@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 1/2] ASoC: dt-bindings: qcom,wsa8840: Add WSA884x
 family of speakers
Message-ID: <168728023784.3815805.7354509685855772862.robh@kernel.org>
References: <20230616115751.392886-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616115751.392886-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Jun 2023 13:57:50 +0200, Krzysztof Kozlowski wrote:
> Add binding for WSA8840/WSA8845/WSA8845H smart speaker amplifiers used
> in Qualcomm QRD8550 board with SM8550 SoC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v4:
> 1. None.
> 
> Changes in v3:
> 1. None.
> 
> Changes in v2:
> 1. Correct compatible (sdw version 1 -> 2).
> 
> Cc: Patrick Lai <quic_plai@quicinc.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wsa8840.yaml          | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

