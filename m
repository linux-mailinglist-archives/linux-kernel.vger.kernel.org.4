Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F962C12F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiKPOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiKPOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:41:59 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB63F04D;
        Wed, 16 Nov 2022 06:41:58 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so489444otg.6;
        Wed, 16 Nov 2022 06:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmTmOBiujjJzMOC34NULLqzGRaBRcGqq+M/PlxPI0qg=;
        b=z978liilT2RAwIoFmc1uvIHwUMgrs8vJjMt0ioB8LTBtIJxfxnWEpLrSXE62rPkUTL
         VQm1+FEkLQ/O7ZbgLaOLlczswlfjrSb/FSALexe8CmPLKiD6PFKTHM7V/CBvLzHGThY0
         2e0Y1uR3sJF/lC4MsDRgt99eD0B4wAKkTsrGE7RIqyOGaD74lzkFVj+NhLTQ/U5UD7bO
         w26MFJEXUQhMvTwy9kDluWf5FoYKKgFQArlGAVwjGfgVK4RVX+bby3YNiywQlKfhpFfO
         smSNTmzXgWgjsLRRqlXBJw45DkPLVRkTVIeFTugV7LUuSNKVELFO4ehlmMej/fNGuUje
         A+yA==
X-Gm-Message-State: ANoB5pltFQ2LsEVMtyMpUMlXyV1Ge6ibXMU+xykjwhSFFAmRkwupD/IB
        MNlySF35HVOPqwBJDP4UoQ==
X-Google-Smtp-Source: AA0mqf6yczlqz0ixYCplthhhPxfTsROjnYiGuRO6OYi37eGwpih3pykOrdiorPCJqKBhxfSpfvob4w==
X-Received: by 2002:a05:6830:6089:b0:66d:8b98:683f with SMTP id by9-20020a056830608900b0066d8b98683fmr7259700otb.40.1668609717543;
        Wed, 16 Nov 2022 06:41:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a056870204600b00136c20b1c59sm8057852oad.43.2022.11.16.06.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:41:56 -0800 (PST)
Received: (nullmailer pid 3820928 invoked by uid 1000);
        Wed, 16 Nov 2022 14:41:58 -0000
Date:   Wed, 16 Nov 2022 08:41:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>, quic_plai@quicinc.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 07/11] ASoC: dt-bindings: qcom,q6asm: Split to
 separate schema
Message-ID: <166860971788.3820869.2449332152697837525.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-8-krzysztof.kozlowski@linaro.org>
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


On Tue, 15 Nov 2022 13:02:31 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the Q6ASM
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
>  .../bindings/sound/qcom,q6asm-dais.yaml       | 48 +++++--------
>  .../devicetree/bindings/sound/qcom,q6asm.yaml | 68 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
