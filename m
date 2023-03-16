Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633F6BD1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCPN54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCPN5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:57:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912DB79E6;
        Thu, 16 Mar 2023 06:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8CD362049;
        Thu, 16 Mar 2023 13:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1296C4339C;
        Thu, 16 Mar 2023 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678975073;
        bh=mRVraXG1c/CEhy9wpd6MLIO1dzMVaHuDpdKdGQvunpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/LGx3XEkKPYTXBvhvHfws/Qv9nY5drI96ftRwGs6kdNR3v3xA3tw6hCdBJiITV7u
         wbe9b2nCbHAuDdPRJakmRese/FnxCIyJ7WXGfLr2ZELlbpu1jG9P3LUfrgj04xOnSw
         I/oBevm6UCcnmS9AVkepDgMzDH+p0XoFJxcr+o0YmdRbD+84gte2oG56chalsULEQr
         Jp2rY/kSjgfWz2TBqjlOHk9p/Bv/1WgwuVUzyhlUf0nXnFLvVNPdHMQm99pvtpkZ3W
         OGN/BMsA2foMd3CMkFKp+nwEjIkw6J5hz04H9jw5YUP8euvzUsBvZHARBM1G2XBb4V
         pasmBf9HD9rNg==
Date:   Thu, 16 Mar 2023 13:57:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/9] dt-bindings: mfd: Add TI-Nspire misc registers
Message-ID: <20230316135747.GC9667@google.com>
References: <20230308165557.2242-1-afd@ti.com>
 <20230308165557.2242-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308165557.2242-2-afd@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023, Andrew Davis wrote:

> The TI Nspire devices contain a set of registers with a seemingly
> miscellaneous set of functionality. This area is known simply as the
> "misc" region.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/ti,nspire-misc.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml

Applied, thanks

--
Lee Jones [李琼斯]
