Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD30A6617FD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjAHSS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjAHSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:18:16 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027672E8;
        Sun,  8 Jan 2023 10:18:14 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id o8so3850698ilo.1;
        Sun, 08 Jan 2023 10:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qhxtUq7YNJ7bl3pCYJbfdTHCaAMCit6bh55+/X+rmU=;
        b=4TwODypv1pnOx//3N5uVFxg7bNVq7BuCVVD7sudY2QTbTShsWblCdwpKFgx2M0YpXA
         wfDRBsTh2DNdwU2yR35Oxvp9UvydQt0J6LGzNFABWm1svCyO9ycjfMdi2ZJkJrdTYLA0
         yV20XMnTYxLF70fwjo4sz/h7ex8Sje+Xl3W4tx65M+EL/yTAhBM43Lw5BQ2GCsd5JJll
         Crlj5l1PhQ/XuDVHAUH9KAcmcrBeyc9b5v2CUDjcNiTrXid7gf3Pc6tnqUWoxsHKeJK5
         yIbaFd2ibA/UVo4qiYLr0R2T//dmVLkChFe4TzxyLjQ/g8QQkh+4IjPPk58yVFh5KWQ6
         ZKsg==
X-Gm-Message-State: AFqh2kpjhKoKynx5XWgbfEc2Alsf4kBuCRWCVDe8onLMWaw/1v5nJiYG
        nTI1kPBjKdpW3TcXrvLNMqbYv2E2Fg==
X-Google-Smtp-Source: AMrXdXuvuxlOZv43Hc7jd8DEjfpKrIPqUnXGxYvEFgPC7BV1GuYTYK2rTUEp1jqzy7R/MWzKXM/rdA==
X-Received: by 2002:a92:cc92:0:b0:2ff:f702:e446 with SMTP id x18-20020a92cc92000000b002fff702e446mr38179990ilo.13.1673201893158;
        Sun, 08 Jan 2023 10:18:13 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id l14-20020a92700e000000b0030c27c9eea4sm2038878ilc.33.2023.01.08.10.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:18:12 -0800 (PST)
Received: (nullmailer pid 162937 invoked by uid 1000);
        Sun, 08 Jan 2023 18:18:09 -0000
Date:   Sun, 8 Jan 2023 12:18:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/8] media: dt-bindings: qcom,venus: cleanup
Message-ID: <167320188857.162862.16846104706244476575.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:40:55 +0100, Krzysztof Kozlowski wrote:
> Cleanup the Qualcomm SoC Venus bindings:
>  - Drop unneeded blank lines and quotes,
>  - Fix indentation in example to 4-space (to match DT schema bindings
>    style),
>  - Add SoC name in each title.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/qcom,msm8916-venus.yaml    |  51 ++++----
>  .../bindings/media/qcom,msm8996-venus.yaml    | 103 ++++++++---------
>  .../bindings/media/qcom,sc7180-venus.yaml     |  61 +++++-----
>  .../bindings/media/qcom,sc7280-venus.yaml     |  93 ++++++++-------
>  .../bindings/media/qcom,sdm660-venus.yaml     | 109 +++++++++---------
>  .../bindings/media/qcom,sdm845-venus-v2.yaml  |  71 ++++++------
>  .../bindings/media/qcom,sdm845-venus.yaml     |  69 ++++++-----
>  .../bindings/media/qcom,sm8250-venus.yaml     |  83 +++++++------
>  8 files changed, 316 insertions(+), 324 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
