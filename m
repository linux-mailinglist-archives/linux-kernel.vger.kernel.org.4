Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D056561E147
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiKFJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKFJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:23:59 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DBC754;
        Sun,  6 Nov 2022 01:23:57 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 0E3C3216;
        Sun,  6 Nov 2022 01:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667726637;
        bh=Q6rA6QGxk4YR7vZUSMP3iZf8lpV6fi2XiRCc0+f8lyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8sLcxslhia5fk7j7nWLtocYLbLxI7C+mepSmRLlSSBtFMII+h/gi7mrXc9E/2lYt
         jkYkcyd3TNsi4kVGpRmgOz8HpsOrDlBmpaYrqrgYYKwrTgx4jf04u0w8a5GTJJrKDh
         80JbCw2oCYBUp45IlW2aZxfLkQohm3M4V1WUJmds=
Date:   Sun, 6 Nov 2022 01:23:55 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, soc@kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
Message-ID: <Y2d9K1KGM8BcR6Rn@hatter.bewilderbeest.net>
References: <20221105013321.2719-1-zev@bewilderbeest.net>
 <20221105013321.2719-3-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221105013321.2719-3-zev@bewilderbeest.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 06:33:21PM PDT, Zev Weiss wrote:
>This is a 1U Open19 power shelf with six PSUs and 50 12VDC outputs via
>LM25066 efuses.  It's managed by a pair of AST1250 BMCs in a redundant
>active/active configuration using a PCA9541 on each I2C bus to
>arbitrate access between the two.
>
>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>---
> arch/arm/boot/dts/Makefile                    |    1 +
> .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 1094 +++++++++++++++++
> 2 files changed, 1095 insertions(+)
> create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
>

Hmm -- actually, after posting this I realized that the repetitive efuse 
nodes could be expressed in a much more concise and much less tedious, 
error-prone manner using a preprocessor macro or two; I'll send a v2 
with that approach instead.


Zev

