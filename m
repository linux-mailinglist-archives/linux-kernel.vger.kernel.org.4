Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58475B92A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIOCZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiIOCZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:25:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B248EBA;
        Wed, 14 Sep 2022 19:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FCE3B81D5E;
        Thu, 15 Sep 2022 02:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C034C433D6;
        Thu, 15 Sep 2022 02:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663208723;
        bh=DQdYvm4gHQ2HiNeRIU1kRsiNIz8EjW/A285YWUqULzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UN3olh1QPPRsS7euylq9wdzIceFii8blDsKxgfyURpEP5ck4MaGaaCy4rtXEY9pJR
         URqToh3uurq5cEpATX9dotdWcoAvrY3JasMLYNU/N+/LoARagns8YJIIOFCBQ3AjL+
         EtvubqlEgvgujyo+SpxmHOTgFRU5P+0C2v9Sn+jF78y7XhMD4dPQ40vMIQCeeUyfP9
         Puk/frVo8tqBmbohHRN8LOT9MDbEOQ+NMHqrHAb+gHQWZxF+OR0FamP9RJTAYE+S8K
         UrGmaXFMOwxFivhb5F5qX3pqQD993TbH+CDZnj0ukdyr8+ILy+J4sr3xK7GOUsmXjF
         vjQJp04bRX3Mg==
Date:   Wed, 14 Sep 2022 21:25:20 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: MAINTAINERS: add bindings and APR to Qualcomm
 Audio entry
Message-ID: <20220915022520.kke2t6sylo27jmgd@builder.lan>
References: <20220907102311.38428-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907102311.38428-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 12:23:11PM +0200, Krzysztof Kozlowski wrote:
> Extend the Qualcomm Audio maintainer entry to include sound related
> bindings and the Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
> IPC driver, which is tightly related to the Audio DSP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0350effebe8f..453dc6fd0b80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16710,6 +16710,9 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>  M:	Banajit Goswami <bgoswami@quicinc.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
> +F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> +F:	Documentation/devicetree/bindings/sound/qcom,*
> +F:	drivers/soc/qcom/apr.c
>  F:	include/dt-bindings/sound/qcom,wcd9335.h
>  F:	sound/soc/codecs/lpass-rx-macro.*
>  F:	sound/soc/codecs/lpass-tx-macro.*
> -- 
> 2.34.1
> 
