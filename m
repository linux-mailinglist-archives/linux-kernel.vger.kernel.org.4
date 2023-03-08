Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E36B1598
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCHWtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCHWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:49:37 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAC5D1AF5;
        Wed,  8 Mar 2023 14:49:26 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id a23-20020a4ad5d7000000b005250867d3d9so15774oot.10;
        Wed, 08 Mar 2023 14:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2TpnogMj4vUPaTlq7bpoDp3iLB6FDUzALqa0LC9Px0=;
        b=V/HpQpiCQQUZ0qjDQyXRYg/FuvJjkUDCfI74QgPuSFVIL6LABE1wxLaE0WHyKRNPPO
         tc9syNSWG0Y18ZdkkhgKaDFynPgfANJjAKwpPH55sSY/6qgSg5f4qWbh7M1Jxngnu10L
         n3eESqFGU4vevT06m0qwooUvFRdPw074Rc2delV4Ge35GpiHK1GGD8kB9i3gix4OeW/L
         oFMBi6ZK2X1vcuz9YIZI4vl/vCD7+lFHqDMhGbW4XfX/KrDdhq+wwAt3tkhn+Kv46IA8
         zN9fs2FHdMuRE14th6EbX759F+zXHdVBukAGdPPYZZnCZDYyPrMmcd9kl/GyLh7BeQGv
         nZFg==
X-Gm-Message-State: AO0yUKWdOA2Ad8STC82bQhESQJz2AE9oV5L0XaeEtJHrsnRUYIJlJ128
        2nzb87dYoiGB7LeqdOYpbQ==
X-Google-Smtp-Source: AK7set8wFQCgQWACR9OuJZlNvOHih3Bj6M1zc2HG87rzCgIHYQRwdUMJEe+BZ3n169lN51V1SvrCaQ==
X-Received: by 2002:a4a:b149:0:b0:525:4e79:8715 with SMTP id e9-20020a4ab149000000b005254e798715mr8320919ooo.8.1678315765466;
        Wed, 08 Mar 2023 14:49:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m29-20020a4a391d000000b00517a7ac36c8sm6745239ooa.24.2023.03.08.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:49:25 -0800 (PST)
Received: (nullmailer pid 4013517 invoked by uid 1000);
        Wed, 08 Mar 2023 22:49:24 -0000
Date:   Wed, 8 Mar 2023 16:49:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpmh: combine PM6150L and
 PM8150L if-then
Message-ID: <167831576358.4013320.10159171018922729938.robh@kernel.org>
References: <20230305173535.18046-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305173535.18046-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 05 Mar 2023 18:35:35 +0100, Krzysztof Kozlowski wrote:
> The supplies for PM6150L and PM8150L are the same, so they can be part
> of one if-then block, for smaller code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../regulator/qcom,rpmh-regulator.yaml         | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

