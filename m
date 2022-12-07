Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A236450D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiLGBOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGBOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:14:00 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633C12D00;
        Tue,  6 Dec 2022 17:13:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7387042458;
        Wed,  7 Dec 2022 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1670375636; bh=0ih4CXZV4h1yIADw8dfARqV0yBALDiODB2EOVwhwpNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=wpglg4NsxOMvLQz3QuaNdCzlezRhmLatxQBbxNDsowldbgDtHmIYbZNfrbufXxrNh
         viakgyfDs8Rjw+hyJzxXgHrINKRb3xh2skBusQXUGTy9suJbUttgIDD7/w6hIYEUsE
         9Y0IW7DHUy6UVZzdwqGx0Cpge1dEyoXpQ/EMR96Kvd5PwsWG6LTb9x/oHXx4rgneG1
         o15RsIfi3ZYmG6faDkjFCFgVuc3YYnlhtiGyRAsBNGNvpL98vicWtYrGWUy08kPKt2
         kSd6Qp/lz5bTP5F+FHIiAKUQnmllZTpTv4u31YNfFwE8OmEl3PWF9WNaqQo1C+2Y0W
         LNYwlvE0nZ/Pg==
Message-ID: <9f874026-da4b-c2f9-0a4f-65f514112dcc@marcan.st>
Date:   Wed, 7 Dec 2022 10:13:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] Fix Apple silicon PCIe iommu device tree node names
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221206-arm64-dts-apple-pcie-iommu-v1-0-210c56e48c01@jannau.net>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20221206-arm64-dts-apple-pcie-iommu-v1-0-210c56e48c01@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 07.57, Janne Grunau wrote:
> Hej,
> 
> the iommu nodes for the PCIe ports were added with the non-standard
> node name "dart" instead of the recommended generic "iommu" from the
> devicetree specification. This series fixes this for t8103 and t600x.
> Patches are based on the asahi-soc-dt-6.2-v2 tag in the asahi-soc
> repository (https://github.com/AsahiLinux/linux.git).
> 
> cheers,
> 
> Janne
> 
> To: Hector Martin <marcan@marcan.st>
> To: Sven Peter <sven@svenpeter.dev>
> To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Marc Zyngier <maz@kernel.org>
> Cc: asahi@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> Janne Grunau (2):
>       arch: arm64: apple: t8103: Use standard "iommu" node name
>       arch: arm64: apple: t600x: Use standard "iommu" node name
> 
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi | 8 ++++----
>  arch/arm64/boot/dts/apple/t8103.dtsi      | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> ---
> base-commit: d32c1530c7230b756ca9a6b6cf92ce6e60788594
> change-id: 20221206-arm64-dts-apple-pcie-iommu-7b0d4d5d4329
> 
> Best regards,

Thanks, applied to asahi-soc/dt!

- Hector
