Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D033662C127
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiKPOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiKPOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:41:13 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10CD3E0B7;
        Wed, 16 Nov 2022 06:41:12 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id q186so18672135oia.9;
        Wed, 16 Nov 2022 06:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brFdIdCSdk4c1YSRoT9/yP4QBCF0DsdC9qEoiJM3U6Y=;
        b=rjL3ukfZDpCnsHr2AxBgbZJ85o6uKC+YouXi+Tupn5a6a+3hHwmNhsFRgamf22HXpt
         9gmHZTWtpusX9wje8KQJ1gP41zd6Sx+SkHcXw7grZ5zHAfEwj4lQFYN9WsPo2C1htlON
         s4Wx7MvRLiJC4ecRqjbeHigVM7hHLCIuBVMwHjFYbYtbK/SKF5Y7QOxIr10HbkMWWYaj
         huKMTBs07a8TqJpaKPhUFT2p6mq9JCTyhbKPikirSQNtoCsn05V7cxswVOcMY+FC2m4L
         TQtYJRlgS4inJt6EpsZINqenBZl1+/F4boDYwiYxg7CIkbIePnjdZDf+Wdh8HD3v7Drt
         vOaA==
X-Gm-Message-State: ANoB5pkR47HfMiyQO+1NBbAKmTQwMaQTuGhdAu3Zlckt++qjBg10aWer
        Ca0x/emt8c2i8TR1A5DN0w==
X-Google-Smtp-Source: AA0mqf7+/UJK9Rx8C+CNmeAkmoblIIOsTe0/ISsySmnlpZyhQKA3ZFwJ9qcXsacwOiZcSoOb7j4fLw==
X-Received: by 2002:a05:6808:1446:b0:34b:7532:2d0e with SMTP id x6-20020a056808144600b0034b75322d0emr1779463oiv.109.1668609671847;
        Wed, 16 Nov 2022 06:41:11 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y13-20020a4a980d000000b0049e9aacbd3asm6002743ooi.16.2022.11.16.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:41:11 -0800 (PST)
Received: (nullmailer pid 3819889 invoked by uid 1000);
        Wed, 16 Nov 2022 14:41:13 -0000
Date:   Wed, 16 Nov 2022 08:41:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        quic_plai@quicinc.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 06/11] ASoC: dt-bindings: qcom,q6adm: Split to
 separate schema
Message-ID: <166860967257.3819826.11515888453674367702.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:30 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the Q6ADM
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
>  .../bindings/sound/qcom,q6adm-routing.yaml    | 22 ++------
>  .../devicetree/bindings/sound/qcom,q6adm.yaml | 51 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
