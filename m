Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509CF701B70
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjENDxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjENDxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E13268D;
        Sat, 13 May 2023 20:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7042C6102E;
        Sun, 14 May 2023 03:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DABC433EF;
        Sun, 14 May 2023 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684036421;
        bh=c9y3MzvKG6368TWAsexddKavVV0MrnxBgSehsTYxysQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNasPCavzXFJIywXpP6FWjqmfjZcdqWwZ7LG3aubjZu4jxZor6uJnqfotKKn3pSRK
         Wa56CVM3WTbnLLWSsnH8F9QRR3djsMPn7nvumAqFW0AhgEB/5AA8D8RD/04NwuRcsj
         VoiDSN7ZFf3C6ctFs+4Aaf+HmByB1z3TN8Nw0IkAQzZ/tRqFApGh002QKEAjBsJEsF
         WiKyQBkfl8lgA7LtHKklVMw75fqOrZGR9EGzzbDoOSYJ39tQ6/iX5vObRUFjb3Ove0
         kg5rycpmXdEAPyzbQ5Pgctl6ndKLPciv3t05QlB+X3HnyG7lspRDBMUQNIlEWa/uM/
         yAQ0lxrzf1cLg==
Date:   Sun, 14 May 2023 11:53:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: add missing cache properties
Message-ID: <20230514035332.GQ727834@dragon>
References: <20230421223206.115528-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421223206.115528-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 12:32:06AM +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>   fsl-ls2080a-simu.dtb: l2-cache3: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
