Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199F608184
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJUW3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJUW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:29:33 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B7CFF;
        Fri, 21 Oct 2022 15:29:29 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id j188so4815641oih.4;
        Fri, 21 Oct 2022 15:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9X+aTnQzNMOvVqKjqOkGjpdO/OoOq6DmYNhUNkClWk=;
        b=6rjps0Hbzt/Le4XxO3sQyMpudmNzKeqF57zU9S9P16UTDaIdf689E0mFMEC90QgFyl
         dJXZG77FM17a6OMg5GLfDhyN6Ofua/oPuGhh1MK6TaowwsZG2UGC7D2drW9LKfAWpOuY
         KDXD81WTn0nodBpNeccb0Tz1e2j+FNBN7g2QkJQQHt/amYg4mg7OPvohNezz23m1Ui4n
         1q2vfdlZT4K31xmMS5ih/IAYANZIVPuE3eKeM+UthCZNOBEIogQTu7bh7B5PwaOJu4w3
         txGFY4uo5nehhSNJNKnGrXmEX3mB2p2so6Rydyvey5GmmclUm5hZsrkGwMs4RQKZN3op
         3VRw==
X-Gm-Message-State: ACrzQf0Ez78CedGMi+NHO3iSEGU8jbCsUUhyTbBWXn+sH0ClYo0r0q3k
        DARAGMbD+SZuICNwjUmcjg==
X-Google-Smtp-Source: AMsMyM6aYTG/3z+sa/ToyklHJ4yxsV/5Eg3CDKSGCT76AvUVKi7sah5Tr2etsvIrBLGNGJiFZVNDvQ==
X-Received: by 2002:a05:6808:1187:b0:353:a617:6acd with SMTP id j7-20020a056808118700b00353a6176acdmr11657778oil.105.1666391368697;
        Fri, 21 Oct 2022 15:29:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a4-20020a544e04000000b003539686cb7bsm743310oiy.53.2022.10.21.15.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:29:27 -0700 (PDT)
Received: (nullmailer pid 573944 invoked by uid 1000);
        Fri, 21 Oct 2022 22:29:28 -0000
Date:   Fri, 21 Oct 2022 17:29:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: soc: qcom: convert non-smd RPM
 bindings to dt-schema
Message-ID: <166639136837.573897.7269501715676439706.robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v3-4-e5e045644971@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v3-4-e5e045644971@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 17:27:56 +0200, Neil Armstrong wrote:
> Convert the non-SMD RPM node bindings to dt-schema, the old txt bindings
> are now removed since all bindings were converted.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
>  .../devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml | 101 ++++++++
>  2 files changed, 101 insertions(+), 283 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
