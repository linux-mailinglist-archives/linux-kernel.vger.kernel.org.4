Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612FE74CB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGJFEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjGJFEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61045CE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D4860DFD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC6DC433C8;
        Mon, 10 Jul 2023 05:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965463;
        bh=wLMroGPULZUjbw782B5mi/csrrk5pQAsUhuCq7oZYns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6COD0MsRHcaGmGjaNmMuHbyX7Gw8YBKkDCGHVGl4rWZuQE78GcfT12RJAJIIxvuh
         K7q8Z9pRE8+BoUzQR1/iNnUsE3RncU4tGIqTvbl6RMv8h34BP6H8LR16em1bgbTMHI
         h+HnuoNXaKhIJT2sQcQVfCDFnXu9Jt43qUs/ZKmfTqZcFHwi2zTgswrn3qxF1W6h46
         fxjKnX201W5cQil+/tVeOZSH2EbUZr3v++ATmH46vwlFpSJGY4xzsxTim4kze7aYRz
         ByG0u8a7kvm83pOsj1zdU0t154yW3kSmdFy0mzi1ribGhRh1YPGDdYQIUkxrtMLDN/
         h1bUPOQhaHO9Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 1/6] soc: ti: omap-prm: Use devm_platform_get_and_ioremap_resource()
Date:   Sun,  9 Jul 2023 22:07:07 -0700
Message-ID: <168896565988.1376307.16796533400852606191.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705122644.32236-1-frank.li@vivo.com>
References: <20230705122644.32236-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 20:26:39 +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied, thanks!

[3/6] soc: qcom: spm: Convert to devm_platform_ioremap_resource()
      commit: 7bc1cfaee1f03008e8b1fd29e621cb50a9512263

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
