Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C664DF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLORSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLORSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:18:31 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862F3F079;
        Thu, 15 Dec 2022 09:18:30 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id c129so5897723oia.0;
        Thu, 15 Dec 2022 09:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMHhXWTTp6UgjfJoBooqERO4qzeBzJ4Ybspx5GpnKmg=;
        b=m7lf/Rr3drIkhV/CNvk6vxFoYxXARCanBcWdYtUl/lOCHBhISaIeGtgaXC7uy+7/Zk
         bGmvHVdNfB8hEKFQZT83vbUITTSM9ixGFKmMvANuHT4boYxA2pkDosl6y84MxZWjRcF/
         lqVmXzdov1CCpNDlcTxlGXFuhmGY9S0EVHsUfMTShSyOQsKx0ZmdqjUebMRhcvw5J+7i
         6GyHEKSTd+0vnB2FMzv2jpDftiN8RSHWtB8LZbFUTQLDjMA0sEYciwU0MQq5Jxp8Vch2
         DAQNcTjYek4wk0b6z9viDDRULgnyoqXWbVe6vLHFmZtZshJ+Y7gXry1ISO/nrd2NZs2t
         otbg==
X-Gm-Message-State: ANoB5pn80R9mC6BT7SNSQAgif9Bqxb8A2Gpbz/T+VPI5hGejAbUk7AVo
        rXrsnJvhKIa9pV8uTJlFOg==
X-Google-Smtp-Source: AA0mqf5XfA3zxc+5ZxBe2ya2mCyhdOllqwELfGwKGsgMvPo8HdPp/02ZtsMWGNGcZ0ROEY5bNsv2lA==
X-Received: by 2002:a54:4417:0:b0:35e:6f1d:eda9 with SMTP id k23-20020a544417000000b0035e6f1deda9mr10093953oiw.53.1671124709625;
        Thu, 15 Dec 2022 09:18:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k6-20020a544706000000b0035173c2fddasm1225147oik.51.2022.12.15.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 09:18:29 -0800 (PST)
Received: (nullmailer pid 230394 invoked by uid 1000);
        Thu, 15 Dec 2022 17:18:28 -0000
Date:   Thu, 15 Dec 2022 11:18:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 0/7] Initial rk3588 DT
Message-ID: <20221215171828.GA153741-robh@kernel.org>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214182247.79824-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 07:22:40PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> This adds initial rk3588(s) DT including two different board
> devicetrees. All required driver changes have been merged into
> the respective maintainer trees. There is one warning from the
> DT check:
> 
> $ make CHECK_DTBS=y rockchip/rk3588-evb1-v10.dtb rockchip/rk3588s-rock-5a.dtb
>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb
> /home/sre/src/collabora/rode/linux-rockchip-upstream/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb:
>     ethernet@fe1c0000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio',
>     'power-domains', 'reg', 'reset-names', 'resets', 'rx-queues-config', 'snps,axi-config', 'snps,mixed-burst',
>     'snps,mtl-rx-config', 'snps,mtl-tx-config', 'snps,tso', 'stmmac-axi-config', 'tx-queues-config' were unexpected)
> 	From schema: /home/sre/src/collabora/rode/linux-rockchip-upstream/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> 
> This is for gmac1. gmac0 has the same properties and there is no warning. Also
> rk3588s (and thus the Rock 5A) has only gmac1 and there is no warning for the
> Rock 5A. It looks like for some reason the referenced "snps,dwmac.yaml#"
> is only checked for the first node. I think it's a bug in dt-validate.
> Also the same issue can be seen with rk356x.

I believe the issue is fixed in v2022.12. I didn't reproduce it. The 
problem is with disabled nodes. In some cases 'required' failing in turn 
triggers unevaluated property failures. So we now filter out both 
errors. But that's still not enough in some cases, so the only thing 
that works is just removing disabled nodes before validation. That's not 
great if it is something where the bootloader enables the node and also 
means whomever enables a block for a board gets to fix the issues.

BTW, I do also see this warning:

arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb:0:0: /i2c@feaa0000/rtc@51: failed to match any schema with compatible: ['haoyu,hym8563']

Rob
