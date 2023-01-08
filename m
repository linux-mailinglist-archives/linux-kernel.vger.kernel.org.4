Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F46661802
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjAHSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAHSUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:20:30 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D729E;
        Sun,  8 Jan 2023 10:20:29 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id u8so3871502ilg.0;
        Sun, 08 Jan 2023 10:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCF24kvwnDirsu9YZTz/RqF9dQpoAZvAvJOB2z5H1qg=;
        b=BPkb6jvrWNYFGMGBkdcHWIpfBnzwk9698B9wwnb2C/Q8s2IpGGh4B1EOZOooGgk/NT
         4TTGkDwjX4n/P+N+x2/nxDY6j0xQenjhRIGwYmXXk8rzjW+lbN7/9P7yJ0j3edSRTcNz
         yi4cSrpXo0f9iVRG6Kbn9Kfhn2EDfWKAwncYAqF80qcKQ7Ywi/03uDq0FyZui4HYX73+
         DVf7OaPvcJ+26J93Bnn1Mtfyt8LSwbSy83WWOpLp90i0rFZyMH5NRkgvF0Y8EbJqhete
         LQhzkVoWrRcc/wWvq/xOa/dqYJ0rlFVS2XlgkbjbBbYLnMKpcUFyYNWbHqCnW1tdjAOk
         6icg==
X-Gm-Message-State: AFqh2kpac6I8KzaPEdTQccM5M/aVanECQxkUiV6fP5FlydLllmNMrqzg
        +eO/wsXvpV2E0Sa6Xzf7q1Voo9ksNg==
X-Google-Smtp-Source: AMrXdXtRJIrMu5P+uyr5WZ3fUyL3Gu4eQQb5uB+VJkf/vjY3S9lpeIiLkuzepuyphgqrMad+FKH24w==
X-Received: by 2002:a05:6e02:489:b0:30d:a7d5:d8fe with SMTP id b9-20020a056e02048900b0030da7d5d8femr693927ils.2.1673202028564;
        Sun, 08 Jan 2023 10:20:28 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id p30-20020a02b01e000000b0038acb163042sm2169792jah.19.2023.01.08.10.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:20:28 -0800 (PST)
Received: (nullmailer pid 165378 invoked by uid 1000);
        Sun, 08 Jan 2023 18:20:25 -0000
Date:   Sun, 8 Jan 2023 12:20:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 2/8] media: dt-bindings: qcom,venus: split common
 properties
Message-ID: <167320202510.165319.12382003003945556007.robh@kernel.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
 <20221227144102.79391-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227144102.79391-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Dec 2022 15:40:56 +0100, Krzysztof Kozlowski wrote:
> All Qualcomm SoC Venus bindings share a lot of properties, so split
> common part to re-usable schema to reduce the duplication and promote
> unified style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/qcom,msm8916-venus.yaml    | 35 ++--------
>  .../bindings/media/qcom,msm8996-venus.yaml    | 35 ++--------
>  .../bindings/media/qcom,sc7180-venus.yaml     | 32 ++-------
>  .../bindings/media/qcom,sc7280-venus.yaml     | 35 ++--------
>  .../bindings/media/qcom,sdm660-venus.yaml     | 35 ++--------
>  .../bindings/media/qcom,sdm845-venus-v2.yaml  | 35 ++--------
>  .../bindings/media/qcom,sdm845-venus.yaml     | 35 ++--------
>  .../bindings/media/qcom,sm8250-venus.yaml     | 35 ++--------
>  .../bindings/media/qcom,venus-common.yaml     | 70 +++++++++++++++++++
>  9 files changed, 102 insertions(+), 245 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,venus-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
