Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763CD6E9A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjDTRAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjDTRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:00:33 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9328107;
        Thu, 20 Apr 2023 10:00:14 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1879fc89f5eso434162fac.0;
        Thu, 20 Apr 2023 10:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010014; x=1684602014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC1knULcd6KabTMiS4cXiXXe6gVupFzizQt47kvZr1Q=;
        b=dF1FwIJ0ou0d3ayYVplx992dWBMKLoq4Tvt/QlVT0RCutuwKfSNFygxfBj+GssEop1
         SnxMYQO4EncJqYyd4pHDSJt1I0cRBW5g5ZTx+7PivlrMork/InSPfmFmZKzS9qen+wdY
         KDsGGepgKgicw9JnLrVgs0i6EgpK/UuNgX/N1yxUFYuUU/c8Tj4iMx/pz3wbd8N/hTtw
         v2w2JKlJlezAxL9LzwhIDmf/EbXcQeQaJmJPkuJ5OrToIrEWlF198Au/YtkCzjagGZQr
         TYVGIXcORZRkMGXyYrsK2CFHiLTKRVXiQefZ55N/75YpUfi0Qkn3COOBZXHTNGJhzgZT
         p8Lw==
X-Gm-Message-State: AAQBX9fnD1iR00FC9MOHGNlA9XZkPJMSAZhp4QUfVv65aexL0U0+sYL2
        Eec2nQYv0XKv0ChQMP3mxA==
X-Google-Smtp-Source: AKy350Zkid3K7ZYXAj8/cAuJgUzeJWjBOQsOyR+U1IzfGcxYXk7UsPEh6YBKe1O+NLZ/IWAzO5RuQQ==
X-Received: by 2002:a05:6871:297:b0:187:7b68:2521 with SMTP id i23-20020a056871029700b001877b682521mr1930680oae.36.1682010013960;
        Thu, 20 Apr 2023 10:00:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c19-20020a05687093d300b0018b12e3a392sm892173oal.42.2023.04.20.10.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:00:13 -0700 (PDT)
Received: (nullmailer pid 3015906 invoked by uid 1000);
        Thu, 20 Apr 2023 17:00:12 -0000
Date:   Thu, 20 Apr 2023 12:00:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH] media: dt-bindings: qcom: camss: correct unit address
Message-ID: <168201000524.3015737.5862969014939069811.robh@kernel.org>
References: <20230420072442.36308-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420072442.36308-1-krzysztof.kozlowski@linaro.org>
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


On Thu, 20 Apr 2023 09:24:42 +0200, Krzysztof Kozlowski wrote:
> Match unit-address to first reg entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml | 2 +-
>  Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml | 2 +-
>  Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml  | 2 +-
>  Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

