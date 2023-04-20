Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC36E9D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjDTUhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjDTUho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:37:44 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304D10E0;
        Thu, 20 Apr 2023 13:37:43 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38dfa504391so869257b6e.3;
        Thu, 20 Apr 2023 13:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682023062; x=1684615062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8FJdD4kjLm/hVjdcv73QbssVlPxYomGy/qXm+SYTd8=;
        b=jjMTU78rL6pZsR236cBp5EHEV6DbCNXrzSnZL6KUytIlwHAlZvljfBS5VV25omRsU1
         sPBofaFqqgc2gjPW2SMqvombxUU7lINeVZ0O86GSFvUm7eyVl2YLFioe7zJFVAelXep/
         SuDnDljnHC3T098GGi/jOVcRzD7C2YPFvUvLYaYYS1liK7lPex3zOgyMi4KqlIqqrH3q
         MEseO8bsYu76hXjGLRsvndM1l3D1zUR80j4txvvFnzF3mfJqDZ2meGWl8qziKXLNOR62
         D+hblVXj7nC22B+1KSS5xk/yWktWoi5ihBtUWsTDA63wmfpl2C1DFLO91sDXCcxT1u5U
         lblg==
X-Gm-Message-State: AAQBX9cBgt6KKVrjSmiU6GHo3OGGVrCKbszonrZ2ymVdDfiGgnSjuvR7
        DVcY6WUXpAIAH2eoTgU0Vw==
X-Google-Smtp-Source: AKy350bS7On3P2idz+6zujSpiV6+igakBQK6inZE10KuPexfzZrc6bXmNRnKOEAjYNpCXhI4DPhCIw==
X-Received: by 2002:aca:502:0:b0:38c:6997:ca18 with SMTP id 2-20020aca0502000000b0038c6997ca18mr1525896oif.46.1682023062465;
        Thu, 20 Apr 2023 13:37:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l83-20020acabb56000000b003646062e83bsm952774oif.29.2023.04.20.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:37:41 -0700 (PDT)
Received: (nullmailer pid 3459023 invoked by uid 1000);
        Thu, 20 Apr 2023 20:37:41 -0000
Date:   Thu, 20 Apr 2023 15:37:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom: Drop unneeded quotes
Message-ID: <168202301515.3458100.10435265872091186659.robh@kernel.org>
References: <20230327170205.4106310-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327170205.4106310-1-robh@kernel.org>
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


On Mon, 27 Mar 2023 12:02:04 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml     | 4 ++--
>  Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml     | 4 ++--
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 4 ++--
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 4 ++--
>  Documentation/devicetree/bindings/soc/qcom/qcom,smem.yaml    | 4 ++--
>  Documentation/devicetree/bindings/soc/qcom/qcom,spm.yaml     | 4 ++--
>  Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml   | 2 +-
>  7 files changed, 13 insertions(+), 13 deletions(-)
> 

Applied, thanks!

