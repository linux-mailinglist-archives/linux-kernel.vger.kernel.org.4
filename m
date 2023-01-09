Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348266626F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjAINZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjAINZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:25:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824F6A1AA;
        Mon,  9 Jan 2023 05:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35FA7B80DDF;
        Mon,  9 Jan 2023 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620C9C433D2;
        Mon,  9 Jan 2023 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673270740;
        bh=WLCkoNqzrNs3kRbpwkEEPg9hY53dRJBCOL38nuzEWrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RaEVJ3rKOR6PjdMowGEElmV08dW1C8qNwCK2a0kcga4idr0xVKMbFkq/TKKwvhUPo
         viWPNRav9Sqpm8Ekl51gl+Lp87xok+C/3YziupRmUBRYhkZa8FuHLbuJXhaTVgNZIe
         Jg8sp8EqYAm9FtZjBgkbne9a8ZQGhvdkPipgjPnj6I2gqcHO8bOcqvBPJnfPceJtaX
         IcnouQEGDR/W5r6mfzIhqoxiUqQ+Zx6E/z96gOypN9leOPRIFSuZPXKXevUPgDdrQT
         qIZbM/T12lKicZl7ZKp+g2Yu5sVLI6istDW3RCWty+lNIE4yz7zFRcpMAcLnUfVFVj
         d7b/bGt6tdMbA==
Message-ID: <58d5ed4e-d373-2f95-1c9a-b4479da4d39d@kernel.org>
Date:   Mon, 9 Jan 2023 14:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH V3 0/3] Convert Unisoc GPIO bindings to yaml and
 add support for UMS512
Content-Language: en-US
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230109072106.2176048-1-chunyan.zhang@unisoc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230109072106.2176048-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 08:21, Chunyan Zhang wrote:
> V3-resend:
> - Added Reviewed-by from Rob Herring.
> 
> V3:
> - Removed a example from sprd,gpio-eic.yaml;
> - Added '|' at the beginning of description blocks;
> - Added Reviewed-by tags from Krzysztof Kozlowski and Linus Walleij.

So I wonder why you did not use CC list from scripts/get_maintainer.pl.

Please rebase your patches on some recent kernel.

Best regards,
Krzysztof

