Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680DE623631
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiKIVyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiKIVxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:53:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6216551;
        Wed,  9 Nov 2022 13:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5F861D0D;
        Wed,  9 Nov 2022 21:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9C2C433D6;
        Wed,  9 Nov 2022 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668030797;
        bh=PrXPuXwUUBkDI5D0DaFW76OD0IFm6T2SflV4GZ2Q03U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bw/fcaXaU4Ze4jADGDsiUDfenIIltXPXDVKXyGOM7Zz0N8yWlx4aPIkSvQmG/mK7H
         QzrnVa5QVsjjD+Hz6/uPDcxURaJQYgzOMzSflGncOrEeki4J1Xce5Ox+UAc2+8vWaB
         7z2I+K4l0AqcgkIh8BmstJFpSd3pppYhUqrXNeW1aBVvhlGnEOSlIn3mMyLEsXsCZX
         AF+s7M+HDhRj1za5yAyqAAJurGOrDg3oKUolUoHgfWjbWuSkxoVpW1tYmqUvsyaCVb
         lsoKPzISZoWeMMOudV4353T6rrSNPc/WtWLI63dr376UEdIDRXxIMPVDst5gQ42XNJ
         O4FzmSBRONjWg==
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: (subset) [PATCH v11 0/4] Microchip soft ip corePWM driver
Date:   Wed,  9 Nov 2022 21:52:52 +0000
Message-Id: <166803072013.1609016.4163434263140050032.b4-ty@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221007113512.91501-1-conor.dooley@microchip.com>
References: <20221007113512.91501-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 7 Oct 2022 12:35:09 +0100, Conor Dooley wrote:
> Hey Uwe, all,
> 
> ~6.0-rc1 has rolled around so here is the promised v8v9~.
> v11 is based on 6.0 stuff still & there will be a change to the dts
> patch in v6.1, but I did a test merge and there was nothing to resolve.
> I'll take the dts change myself just to be on the safe side.
> 
> [...]

Applied to dt-for-next, thanks!

[1/4] dt-bindings: pwm: fix microchip corePWM's pwm-cells
      https://git.kernel.org/conor/c/a62d196e8988
[2/4] riscv: dts: fix the icicle's #pwm-cells
      https://git.kernel.org/conor/c/ac2bcd194cc5

Thanks,
Conor.
