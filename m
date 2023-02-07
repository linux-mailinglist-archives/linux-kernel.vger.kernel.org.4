Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261868E058
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjBGSoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjBGSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:44:20 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDA91E9ED;
        Tue,  7 Feb 2023 10:44:17 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id bd6so4470527oib.6;
        Tue, 07 Feb 2023 10:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF05XBm5StkoRZebgzW+5UFs5ZcFAhyv80kCZkRUAKk=;
        b=RQM43QYANsh6n8TjUTZzlujikH6YlAkjNBPP28+/TfHQSUtc7IdaQ5EbY04ncJqCMh
         o2lKBDoszWWQ901v8BeLPrIAHY7zARJkWOa1G/Y3ajs4Aai2+fzWZ62wN4IiMhg2ZtU6
         iNviUIqITn4blXtSqiAYPKZyyG9hJRgKQxz/MEgMqzxzcdTYUkp9bcHcolnsaKVPOo9N
         7jcLyiTx8zQiSQDfG/9pzkAj+JEkSszLXxDVeDB8zDV87bbiDHfTJCsKHNFrswedI962
         1gZdtKYUT0mGAhv9/IaC2KOoOVo38qXBKTAwBJo6J6fY2ui7oZ1+Zkn8M+q2qqiZCsKD
         ghlA==
X-Gm-Message-State: AO0yUKWzGdzDC11RM3ogzAA9Zb8XKKv2GP73eK7BHj3lSZJet2qqzhu0
        R0YpABaX1yfqbO7FQNpURg==
X-Google-Smtp-Source: AK7set+AFJ9CMlKOl1fPlpTwwkum/A3wyh9BV9nr5T0Bia18RR2erkyWqWTpSnNcv8ypn9y4hENlAg==
X-Received: by 2002:aca:1918:0:b0:367:6fd9:408c with SMTP id l24-20020aca1918000000b003676fd9408cmr1795362oii.44.1675795457117;
        Tue, 07 Feb 2023 10:44:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a05683022cc00b0068bcf7995aesm6821095otc.64.2023.02.07.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:44:16 -0800 (PST)
Received: (nullmailer pid 3956646 invoked by uid 1000);
        Tue, 07 Feb 2023 18:44:15 -0000
Date:   Tue, 7 Feb 2023 12:44:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: phy: Add qcom,snps-eusb2-phy schema
 file
Message-ID: <167579545552.3956607.9337813365247017487.robh@kernel.org>
References: <20230207114024.944314-1-abel.vesa@linaro.org>
 <20230207114024.944314-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207114024.944314-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 13:40:19 +0200, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 PHY. Add a dt-binding schema
> for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> There will be a binding check warning from Rob's bot because of the tcsr
> clock bindings missing (dt-bindings/clock/qcom,sm8550-tcsr.h), but that
> is expected as the header is already merged through Bjorn's clocks tree.
> 
> The v4 version of this patch was here:
> https://lore.kernel.org/all/20230202132511.3983095-2-abel.vesa@linaro.org/
> 
> Changes since v4:
>  * none
> 
> Changes since v3:
>  * removed blank line, like Rob suggested
>  * dropped quotes and reset description, like Rob suggested
>  * dropped the RPMH_CXO_PAD_CLK clock and the ref_src clock name
>    to match the schema
>  * fixed filenames of the includes in the example (sm8550-gcc and
>    sm8550-tcsr)
> 
> Changes since v2:
>  * none
> 
> Changes since v1:
>  * dropped the "ref src" clock
>  * dropped the usb-repeater property
> 
> 
>  .../bindings/phy/qcom,snps-eusb2-phy.yaml     | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

