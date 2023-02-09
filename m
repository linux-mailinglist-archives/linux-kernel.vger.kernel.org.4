Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2792D691393
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjBIWkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjBIWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:39:16 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB1F6BABE;
        Thu,  9 Feb 2023 14:38:47 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 796CA100004;
        Thu,  9 Feb 2023 22:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675982325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlmlRq1SwmIoi67aUVNcS7ctofjzfmDlTqR+bZ6hmVg=;
        b=GyHZle2edxB4Pl2ob6GyRhceamq4ZPeyBsxTMi8lsmZdGLJwLEYKtxnGFCrcg59J7qdMyY
        fGL/E+WH29LnkgMXcjHndhwpe6NHCCAsxOEhzA4NKuNtpP3DXKXMOQ08Nw1zyL4qCQZyYM
        EcEAwnT/hO2LFwAIIrmuH8BQu4VBpKqS8t3enrSHDDkHtlqCFD0upMQk4CH6ThbYZ34Gv4
        Aic9WnwO5hAne8ECWhy3bAqDJwU69QHIUld+ZDUWZIoIXDjiSmbJmhaFeUGXXtZwFsaJSl
        rbn9M0rP9BTkO5qQgf+O8IvWnqp3nJ7X8RyHdMSbI1ltH/e+4ox2Q/Ay1yV7jA==
Date:   Thu, 9 Feb 2023 23:38:43 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net
Subject: Re: [PATCH v3 0/4] rtc: jz4740: Various updates
Message-ID: <167598230483.1658778.17605710915150090375.b4-ty@bootlin.com>
References: <20230129120442.22858-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129120442.22858-1-paul@crapouillou.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Jan 2023 12:04:38 +0000, Paul Cercueil wrote:
> Here's a revised patchset that introduces a few updates to the
> jz4740-rtc driver.
> 
> Patch [1/4] used to break ABI, it does not anymore.
> Patch [2/4] did not change, patch [3/4] is new.
> 
> Patch [3/4] has been updated to use dev_err_probe(), use __clk_hw_get()
> instead of looking up the parent's clock by name, and will now register
> the CLK32K clock when the #clock-cells device property is present
> instead of doing it based on the compatible string.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: rtc: Add #clock-cells property
      commit: 4737a703528c769c4fde6b68462f656f91f4ad99
[2/4] rtc: jz4740: Use readl_poll_timeout
      commit: d644b133f78d6d8efd36f7b1703bebca09036f0b
[3/4] rtc: jz4740: Use dev_err_probe()
      commit: ff6fd3770e9687d7b849a0e826a32563bfcb98da
[4/4] rtc: jz4740: Register clock provider for the CLK32K pin
      commit: 5ddfa148de8cf5491fd1c89522c7cad859db8c88

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
