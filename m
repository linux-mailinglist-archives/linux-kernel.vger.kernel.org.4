Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCD705DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjEQDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjEQDKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:10:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612995;
        Tue, 16 May 2023 20:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4AB636E3;
        Wed, 17 May 2023 03:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06150C433D2;
        Wed, 17 May 2023 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684293002;
        bh=CvgKMPZQolVfURyUe01p1pbE6VTWA4kAeN43nJikG/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OHX/f4RBRpR3oy+7N7fFsxyvDaRurBylxoSDfwLuGU4hPIbBLCRvRWpzRKsbPUC98
         5218G5vbpvK0Dn9rt61WJ8NlmcdgD9vjO1AnAcCcp88qbOUxSik6MFvAnJDBNs2nTU
         NOGklEn1oqLpcVRBhF/vtPJOh4V9l+yBTLTjTxSGFkghoXT7E8jKiX1XVB++V+6JK5
         w7u9t8uPdotDydWqRS23huvPMbcQLJ6NF+OsZdhacHXlWT1ubr0gl8QTqhwSHIGTzV
         5zmSNa50rjkj/M42gWdRFr7HfVrKp16ameaTFLIXQR98OlzX2YkCYkfQPAo3eanpui
         gDnEqEk1hl1Yw==
Date:   Tue, 16 May 2023 20:10:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5] dt-bindings: net: nxp,sja1105: document
 spi-cpol/cpha
Message-ID: <20230516201000.49216ca0@kernel.org>
In-Reply-To: <20230515105035.kzmygf2ru2jhusek@skbuf>
References: <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
        <20230515074525.53592-1-krzysztof.kozlowski@linaro.org>
        <20230515105035.kzmygf2ru2jhusek@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 13:50:35 +0300 Vladimir Oltean wrote:
> On Mon, May 15, 2023 at 09:45:25AM +0200, Krzysztof Kozlowski wrote:
> > Some boards use SJA1105 Ethernet Switch with SPI CPHA, while ones with
> > SJA1110 use SPI CPOL, so document this to fix dtbs_check warnings:
> > 
> >   arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb: ethernet-switch@0: Unevaluated properties are not allowed ('spi-cpol' was unexpected)
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Is my instinct that this should go to net-next correct?
