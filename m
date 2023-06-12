Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02F72BACF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjFLIfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjFLIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:35:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011F310B;
        Mon, 12 Jun 2023 01:35:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f74cda5f1dso223692e87.3;
        Mon, 12 Jun 2023 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686558939; x=1689150939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDpjBLQGC3gMirLkcnPZdPRPRXte4njImOP0NWtJdEA=;
        b=H6Ey9jTloHjRG1mS9yoFp7ky8frmRUP9qm3Ijv+dOndhI56cD8PHwjddcRnvGovfmL
         7u6uK6716blbkmPwBvIr0cotyJl/+jkpuRDvQNHbD+CQNkdnyfVcEGQ883ThMgbrKKbO
         9k/Yb4b8SdRYZukI/vJmfHKhavI1SZryIvnD7wDgjCLtToqyyXlr9PhQL45YeS2lQry3
         +uoWPZXwb56ukqTmxgoQ0CpPqn0TJc6gx8urk/FO93Bgw8pHv79vlR14dNpYHQrq0/3w
         e0L/p3q/b9nCXmxUgC66q6YNCy/o2dsZLJATRfDlBzl5oiW4klf6q/KrxZIbsnioUgm/
         +H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558939; x=1689150939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDpjBLQGC3gMirLkcnPZdPRPRXte4njImOP0NWtJdEA=;
        b=U+JiyCnxbFIBTeu4lT6WYNP5pRPQ9aB1I5SJIVdejrsJqcckpPvgCSrPxBPMSDBRKv
         g8hPEYeXAjOXwrD73R48ehEbPtIetXwaynoJPuIG7skb5SvbzSSItfycI0xCji+6uvtA
         Gxxg/rOSFzMbncbIoG78kqDpSIcDdp/IT/0x2bkgyKEHhgjhDRZ6IWYFF6sXAHgtx/9u
         93OdmfVAEU7YcTOnT1kBmP3QeesU1+fkBka+msPi7QFe4FKAkSd0UMvf0taim7fBW4ns
         PHtlUq83cfcjCDUVw4E4wgsI0m5vL9W1FtGFZf6DgOEd9cORtt93OAh05CSOfP47Sp/B
         wZuQ==
X-Gm-Message-State: AC+VfDwOJkH3d2rfbq+5oBOTYHsTs59FBeH7k47ofE0EleBZEyKO2oJB
        Li81FDkBLVhALCV1lErlN4nqHv6qM78m+Q==
X-Google-Smtp-Source: ACHHUZ7QYZL5AtYxXYviU5KMKIXtoukGzE0SX6NjEUMs5Z9It2omQJA72i/UdaCfskj/t+1leyf9dw==
X-Received: by 2002:a19:6918:0:b0:4f6:19e0:8ab7 with SMTP id e24-20020a196918000000b004f619e08ab7mr3188712lfc.62.1686558938839;
        Mon, 12 Jun 2023 01:35:38 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id n5-20020ac24905000000b004eed68a68efsm1383548lfi.280.2023.06.12.01.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:35:38 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:35:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Message-ID: <20230612083536.q3sq7w6cyiuxaqtv@mobilestation>
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-3-sebastian.reichel@collabora.com>
 <4c914503-c2e5-a5d8-97af-daaee0b4ec7c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c914503-c2e5-a5d8-97af-daaee0b4ec7c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:24:06AM +0200, Krzysztof Kozlowski wrote:
> On 08/06/2023 18:22, Sebastian Reichel wrote:
> > This adds Rockchip RK3588 AHCI binding. In order to narrow down the
> > allowed clocks without bloating the generic binding, the description
> > of Rockchip's AHCI controllers has been moved to its own file.
> > 
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> 
> ...
> 
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - rockchip,rk3568-dwc-ahci
> > +          - rockchip,rk3588-dwc-ahci
> > +      - const: snps,dwc-ahci
> > +
> > +  ports-implemented:
> > +    const: 1
> > +
> > +patternProperties:
> > +  "^sata-port@[0-9a-e]$":
> > +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
> > +
> > +    unevaluatedProperties: false
> 

> You should be able to skip this patternProperties entirely, because it
> comes from dwc-ahci-common -> ahci-common schema. Did you try the patch
> without it?

Please see my message about this. The "sata-port@[0-9a-e]$" sub-node
bindings could be updated with the "reg" property constraint which,
based on the "ports-implemented" property value, most likely is
supposed to be always set to const: 1.

-Serge(y)

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - ports-implemented
> > +
> 
> 
> Best regards,
> Krzysztof
> 
