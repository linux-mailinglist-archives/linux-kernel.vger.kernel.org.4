Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D26728430
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjFHPvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbjFHPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:51:39 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BBA30CB;
        Thu,  8 Jun 2023 08:51:15 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33c1e7743b7so2497575ab.1;
        Thu, 08 Jun 2023 08:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239457; x=1688831457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRQC4OgZDaTBHSW8m3eG90dzJGexIFtWmfi4L+bdesA=;
        b=OndB/T3vY9wHSl4/KPR9Kk0ixALCA7vlWGJtKlzgHi4/Zc5+B5k52tgVX14szldufa
         LYP9tMC6m55W9C9lyNCRpgdvwFINhoIRbwra3Y0lhRUT01plgc46RM0jsrHsUsj3ho/G
         NFqHRQWxH01vTPxDZ07x2vkkXcc9cUiHZiJP70awTYbz9r5cQEweP5H5VgIYVAritvJv
         481BhpxwuIBL9Qvnjk3qPwifE/UdxPM6Ez6tXWDkbILFu8Jm650z24rjIwoLp9RKS3Sn
         iuV7etIbzjEfEln1eZX8tKkjAw43zazjFLrm3uMAD2nJXRN/ggk6w2obe1yLbvBaKI9B
         k/5w==
X-Gm-Message-State: AC+VfDxu7bhwgALxJ8NgN3nrF0NlZ+AfiEoYtlC45JesiejPemKzp9qu
        fZ30LRb2GsV/chRgTOmJLNuos5gA+g==
X-Google-Smtp-Source: ACHHUZ4KdtP7B0K35g9g2K55S0pWZubuUZObu+/WrGAbX05bjn09RmOtNLrc/mKutrgbMrrY6Pp7VA==
X-Received: by 2002:a92:d48b:0:b0:32f:80a1:2e44 with SMTP id p11-20020a92d48b000000b0032f80a12e44mr10946917ilg.9.1686239456801;
        Thu, 08 Jun 2023 08:50:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n9-20020a056638120900b0041669a9fb62sm336525jas.131.2023.06.08.08.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:50:56 -0700 (PDT)
Received: (nullmailer pid 2758255 invoked by uid 1000);
        Thu, 08 Jun 2023 15:50:53 -0000
Date:   Thu, 8 Jun 2023 09:50:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: misc: qcom,fastrpc: drop unneeded quotes
Message-ID: <168623945199.2758191.11717541361019434391.robh@kernel.org>
References: <20230607184147.420352-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607184147.420352-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 07 Jun 2023 20:41:47 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!

