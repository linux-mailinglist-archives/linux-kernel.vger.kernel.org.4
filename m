Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038D65E8C11
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiIXMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiIXMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B0B7ED7;
        Sat, 24 Sep 2022 05:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D62612BF;
        Sat, 24 Sep 2022 12:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352C7C433C1;
        Sat, 24 Sep 2022 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664021216;
        bh=EclEpHX49VYDq26eqhYIz6y6CsaMJTKwhdUyP+ZlCJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7jPCelShdsJU6sILi9Z21oQm5K2/9m5pP9G8MHJJWU1KiQhsSxBLFEx5+gVP+ORd
         EPnmyvQtBrdHopJs/+tOAaR91paA7tcRtsCJZpdYMDkyW4AHoSFgtSUDspI7Zw90Qu
         kyrfmJdlCuxPjvlLwNsAo/KCei4P0gzxB3YzLVypdLS+VGNmEsJbkxZdW9WeYIgL76
         6cRwf4KqYAAoNlch0SwaA2cGikN2aR11DsLbacUtsgHyX4zDvJzG3lI4h7qJpFh3W/
         BnkbDZljNxcRR4L1mM2R0ofwhAZy0TI/l/OaAuqFZYuwbQCrE1yAUKvhZgv6a+MowV
         iQFKmemaKqe2Q==
Received: by pali.im (Postfix)
        id 8CEA58A2; Sat, 24 Sep 2022 14:06:53 +0200 (CEST)
Date:   Sat, 24 Sep 2022 14:06:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Message-ID: <20220924120653.dn67vpllge2yy3iv@pali>
References: <20220713200123.22612-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713200123.22612-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
> Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
> Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
> indicate SoC in example.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> index f6d6642d81c0..d2ca008de266 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
>  Boards using a SoC of the Marvell Armada 37xx family must carry the
>  following root node property:
>  
> + - compatible: must contain "marvell,armada3700"
> +
> +In addition, boards using the Marvell Armada 3710 SoC shall have the
> +following property before the previous one:
> +
>   - compatible: must contain "marvell,armada3710"
>  
>  In addition, boards using the Marvell Armada 3720 SoC shall have the
> @@ -13,7 +18,7 @@ following property before the previous one:
>  
>  Example:
>  
> -compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
> +compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
>  
>  
>  Power management
> -- 
> 2.20.1
> 
