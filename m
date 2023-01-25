Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05A67C0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbjAYXfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjAYXfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:35:23 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994D82915D;
        Wed, 25 Jan 2023 15:35:21 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 265FD1C0008;
        Wed, 25 Jan 2023 23:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674689720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QL2lAticZtJrl6Ut+RfysjAr2qS39Nr2NcnJ1ZwoshE=;
        b=mdXEZclVlbneX8HlDXN0XULFrPmOEli4aV3pt67msUddr+mCKNvMms8/eK6+K97krqOzrW
        8DPXG5QP2iafhD6cqW6Mt82FanWfIS3hLf+hvEo42oBg5xRcqcFTStEKHX6wNvNmGfQlcq
        eIJ4RoGlFFxiOyXl7mOCvXL71lAWWbNfnrFel9c68x/EAYkrow9m6FI5fBiI3LpS6CB7z2
        t3sfKMNxzO1AeI9cMXwW2Ug+u4dgOzZpCDnuo5pm3qVorWQ0JpkNlKAWzGkfTe3t/pWZFP
        xcLMeyyy818+KVNc7S7Bkh0tAzvgPG2I1YqkFPJxiWrAq4rlvhUIJo4y8s+1IQ==
Date:   Thu, 26 Jan 2023 00:35:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hugo Villeneuve <hugo@hugovil.com>
Cc:     bruno.thomsen@gmail.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: remove pca/pcf2129 from
 trivial RTC devices list
Message-ID: <167468969598.288988.1125530596774069310.b4-ty@bootlin.com>
References: <20221220152237.1125178-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220152237.1125178-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 10:22:37 -0500, Hugo Villeneuve wrote:
> pca/pcf2129 devices can also have the 'reset-source' property, so
> remove them from the trivial RTC devices list.
> 
> 

Applied, thanks!

[1/1] dt-bindings: rtc: pcf2127: remove pca/pcf2129 from trivial RTC devices list
      commit: 947e8876c0426971c34c422569c29ec02d711bb3

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
