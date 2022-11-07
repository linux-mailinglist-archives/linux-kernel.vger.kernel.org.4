Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A176261EEA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKGJUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiKGJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:20:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117FF5AF;
        Mon,  7 Nov 2022 01:20:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D89B60F69;
        Mon,  7 Nov 2022 09:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE90C433D6;
        Mon,  7 Nov 2022 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667812831;
        bh=IohQRHyGWeft5/zFcaoSpTCgQ1fp32d/mBaMOehI0iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3ce1B0+BJ5nN98fzPunOzYTXdhR+jiBqHcXII6WIR/xcqhD+X1MF8Kpsh9f8xuxF
         JRZc3DNGQY7stIqdNJqut73aXN/1vNFbS8LbdHyahl27S4CDHobC/r3YrMTQPd/0yr
         WnoV8NTlcnoY/lSpkBvhPwiHA3/vKBG47w1N6KVuVr6u1oZXXfRmJcyfTO7M6qTkuo
         Cf6OLCPqMuoCT/TZn/iT3N2+kxxodIkvBUo4XOvAeY9Q0pyT0C4rdQA0wb/AGqOxWV
         H7FrvsjHkYDBrXF74mbTIs40HiyREhCnq/WNgaiJ2Tb9nPw/MG/FWvgfU64Un4T6J+
         hKDfu+ukG64fA==
Date:   Mon, 7 Nov 2022 09:20:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: mfd: syscon: Add nuvoton,wpcm450-shm
Message-ID: <Y2jN2s9hfVBNc6Y5@google.com>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <20221105185911.1547847-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221105185911.1547847-5-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Nov 2022, Jonathan Neuschäfer wrote:

> The Shared Memory interface (SHM) is a piece of hardware in Nuvoton BMCs
> that allows a host processor (connected via LPC) to access flash and RAM
> that belong to the BMC. The SHM includes a register block accessible from
> the BMC side.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
