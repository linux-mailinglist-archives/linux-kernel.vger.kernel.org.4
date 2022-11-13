Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A19626FFF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiKMOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 09:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKMOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 09:01:00 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967225C7;
        Sun, 13 Nov 2022 06:00:58 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id b124so9147272oia.4;
        Sun, 13 Nov 2022 06:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKsttX7dR/kj4LzS1HqgSrInqnD5E8Kl3NokubvYYsw=;
        b=yV0GP9Rn2CklXDGpiWKpZ9vywaI8ocGi79JrpwEpqDkudikZ6GuzoD92ZP546qicMa
         lQubosd0KiNF46adqa8+Xd2CMYh4DUqvYur14lx6GY0fRPKzLHGwA4q1hUdezKcNqb0M
         PkfAJRj+jeLhBA0VEl/UrQzW2A3niQFfCSs4NxtnnypQk99TeXmQpQfUTcyrw5Z3Let7
         HqxR80Y2WXj4jJ/wOpEVLQRrRsv7IKtT/IG/0HHDD3GTCJAA4Iiu3igFzSL5YmzwGaM2
         Z4hSCN8+QrYDEavQokn0ehks7GnWDKjlMqAwbwhz63mccSdH/eSKzRRndPzrPmyAgXE4
         6WwA==
X-Gm-Message-State: ANoB5pmukel8Ro33A1eWBbbQxipLsjkVbZUxxNJ3PB5Tnw4OFDWFuPdQ
        wMgkTMG1P/9YQH8pd0CfLQ==
X-Google-Smtp-Source: AA0mqf7sBsExjDIonPC+fh7PURcCdxGNOaw+XYBJlszceX2eXK+nZPWs46yN6CXtpbCaWJArJ/pPnA==
X-Received: by 2002:aca:4487:0:b0:35a:7dd3:cfa7 with SMTP id r129-20020aca4487000000b0035a7dd3cfa7mr4228912oia.226.1668348057762;
        Sun, 13 Nov 2022 06:00:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t30-20020a056870609e00b001417f672787sm2958000oae.36.2022.11.13.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 06:00:57 -0800 (PST)
Received: (nullmailer pid 3392130 invoked by uid 1000);
        Sun, 13 Nov 2022 14:00:59 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Lin Jinhan <troy.lin@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Olivia Mackall <olivia@selenic.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
In-Reply-To: <20221112141059.3802506-2-aurelien@aurel32.net>
References: <20221112141059.3802506-1-aurelien@aurel32.net>
 <20221112141059.3802506-2-aurelien@aurel32.net>
Message-Id: <166834780489.3385723.11805626394561676880.robh@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: RNG: Add Rockchip RNG bindings
Date:   Sun, 13 Nov 2022 08:00:59 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Nov 2022 15:10:57 +0100, Aurelien Jarno wrote:
> Add the RNG bindings for the RK3568 SoC from Rockchip
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  .../devicetree/bindings/rng/rockchip-rng.yaml | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/rockchip-rng.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rng/rockchip-rng.yaml: properties:compatible:oneOf: [{'const': 'rockchip,rk3568-rng'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
./Documentation/devicetree/bindings/rng/rockchip-rng.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/rng/rockchip-rng.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rng/rockchip-rng.example.dtb: rng@fe388000: reg: [[0, 4265115648], [0, 16384]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rng/rockchip-rng.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rng/rockchip-rng.example.dtb: rng@fe388000: clock-names:0: 'clk' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rng/rockchip-rng.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rng/rockchip-rng.example.dtb: rng@fe388000: clock-names:1: 'hclk' was expected
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rng/rockchip-rng.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

