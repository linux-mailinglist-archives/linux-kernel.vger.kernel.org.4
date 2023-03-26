Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5196C9899
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCZXAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:00:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CDF55AE;
        Sun, 26 Mar 2023 16:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAC50B80D64;
        Sun, 26 Mar 2023 23:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1A0C433EF;
        Sun, 26 Mar 2023 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679871650;
        bh=x6Z12fR83Gq7xvHh4mr/kK1h0Pqkf36AjClyCalvXdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGfFZOdeUl4Q3V2nqRr8Faa166YY3OMTZvTTTKGep0HBYvNL0t8UoBVascmOqEEaf
         nY2njkFdimiBcdxkLLFmaTBtR8e6Lcce5ytX75LGlib2rSXCCHebF0d5XGMr+27OaX
         oYsogxgI8rkquV0yXO7jn5+4to9HCCojzktZUbihun88ds5DLsK2MpNo6x4l1P+Qfi
         4Qk5tINCyUsUx+tYHp/2+k85iYk+G2JF5i7d+p6sSlgia8jrY19MGMURnnVWvnLYE8
         DmYE2oztHeB5TRT/XHIEQlzHlspsh4gO6AXvCgn1o4wR5OQ3fIBRuZwhThd34wwcd8
         oOYTYrPt1LEOA==
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] riscv: dts: canaan: drop invalid spi-max-frequency
Date:   Sun, 26 Mar 2023 23:59:41 +0100
Message-Id: <167987156176.153791.15260217411572025430.b4-ty@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230326164751.104789-1-krzysztof.kozlowski@linaro.org>
References: <20230326164751.104789-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=436; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=0zFLew1NsRZR2Xph0On5u79GHzMJx5S7s4zUw+ZVKAU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCkK5yKv3fpp3PKfge+Mu/UylUM/q/aYckkXvth7skRmT a8HU92RjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzEVJWRoSFMuHy3icO+syvV Wuv2/5vwVNCB//EXdw6N4+3XxV+cvsTwV8pLiztfOmpJ+w6VWZMWnDpTc2H5QuW4j1einyRwuy9 pZQQA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Sun, 26 Mar 2023 18:47:51 +0200, Krzysztof Kozlowski wrote:
> The spi-max-frequency is a property of SPI children, not the
> controller:
> 
>   k210_generic.dtb: spi@50240000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> 
> 

Applied to riscv-dt-fixes, thanks!
I'll make sure to add a test for the !mmu dts in CI too.

[1/1] riscv: dts: canaan: drop invalid spi-max-frequency
      https://git.kernel.org/conor/c/8056dc043d7f

Thanks,
Conor.
