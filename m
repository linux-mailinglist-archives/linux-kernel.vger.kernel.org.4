Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53D761DB3B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKEOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:52:19 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD8FAFC;
        Sat,  5 Nov 2022 07:52:18 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id a7-20020a056830008700b0066c82848060so4045305oto.4;
        Sat, 05 Nov 2022 07:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DoovjTJROPf6fM2d6KbXfBg+AzBsvogq3b4O78GD5fc=;
        b=k4Oq2EREibB3tNVPklG5Agk3fkwFW3u2cp/H9pGI9GLu5qo5fzTgWtfbYp49NYZzRI
         mIVh8OMlTMuoUrgOjr+2dfsRPcb5ZlSxtM6DxYZjijWOfXvekiZ0nDt18gLUg+60ZOMd
         oW8FoZQLpB3oFVlK9JXXNLSiDN8msKt/L6ULIBJxS8mn5nybvBGpL7rHh2Kzq3uzMmAP
         mjHaFNcR7YzDOXYzEtXQlmJcYUUn3iyxSJv053Ba4RVRs/WXgGQFnTvMGrzqo7/qD20A
         x17g2rs2cIcVuVDd76GJoLHhkExGbCT8kvoNG5EyzvJP3a13Xk/qMW/YQ+aKzZzk0P64
         pjOg==
X-Gm-Message-State: ACrzQf19yORFaTA2jpTmVwOe/rIQqiuoCigfKXWU+qe3ckFO4+BXivEp
        p0h+by0P2Nrh4SX9AQYfIdHDs8ytoA==
X-Google-Smtp-Source: AMsMyM7ctCunns3BMIghObU2ApaO5yOV/1suuvtsTcyoWTfq/xmUWqLoqyUTo48J6DKebXvozOisyw==
X-Received: by 2002:a9d:4b85:0:b0:66c:9226:75b0 with SMTP id k5-20020a9d4b85000000b0066c922675b0mr3999606otf.365.1667659937513;
        Sat, 05 Nov 2022 07:52:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y77-20020a4a4550000000b0049e9a4b2dd4sm655355ooa.30.2022.11.05.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:52:16 -0700 (PDT)
Received: (nullmailer pid 27960 invoked by uid 1000);
        Sat, 05 Nov 2022 14:52:16 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <20221105092500.12145-1-linux@fw-web.de>
References: <20221105092500.12145-1-linux@fw-web.de>
Message-Id: <166765939212.4158869.5881767839110614067.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: pinctrl: update uart/mmc bindings for MT7986 SoC
Date:   Sat, 05 Nov 2022 09:52:16 -0500
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


On Sat, 05 Nov 2022 10:25:00 +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Some pinmux pins of the mt7986 pinctrl driver is composed of multiple
> pinctrl groups, the original binding only allows one pinctrl group
> per dts node, this patch sets "maxItems" for these groups and add new
> examples to the binding documentation.
> 
> Fixes: 65916a1ca90a ("dt-bindings: pinctrl: update bindings for MT7986 SoC")
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> sorry, messed up email-list, so resend it
> 
> v3:
> - squashed version from sam
> - v2 was ack'd by Krzysztof, but sams patch included updated emmc-names
>   and different structure for uart to allow 2 pingroups
> v2:
> - wrap on col 80
> ---
>  .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 46 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: pcie-pins:mux:groups: ['pcie_clk', 'pcie_wake', 'pcie_pereset'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: pwm-pins:mux:groups: ['pwm0', 'pwm1_0'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.example.dtb: pinctrl@1001f000: spi0-pins:mux:groups: ['spi0', 'spi0_wp_hold'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

