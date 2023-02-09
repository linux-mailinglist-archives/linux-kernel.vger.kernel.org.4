Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39838691363
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjBIWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjBIWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:32:25 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA82594E;
        Thu,  9 Feb 2023 14:32:19 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2C2E560004;
        Thu,  9 Feb 2023 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675981938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JaQiS2dN/M9fx40zrUI8U35PZY0eiH2r+XHNp2QEkyM=;
        b=NZYoCZwY2/rlseuwuWlnTCO9CdtQS+Q9kmH37wdSrXN/RzH1eOt3C7/5K2pq3/nWB1hq3p
        pmvflfixFNGxrJTzev9LA6QGtO7H3YfAj5c2MZ8343EiZgHF4Yy1ngldh05zFU9ZiTE8CP
        Y2e4IipiNOTmpxpDZM/fcQX6XcRtRFO1l4WDHSOfdRVl7MAnT0mcSm9RI+5t7wcJbxoht5
        iSs5ak3qj/VC326MZT0o0QGNePGA8qJAEgUYKLVmvZUgCdK909aMvH/LHx3cuW0lZpb+T1
        hke2PI4zaXHWSSdSPUXDn2f4tk/SwD5kXgbwKmkybElXBZi8zCerYCKEFYcNjQ==
Date:   Thu, 9 Feb 2023 23:32:16 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] rtc: moxart: switch to using gpiod API
Message-ID: <167598191742.1657202.12721365142557883643.b4-ty@bootlin.com>
References: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201054815.4112632-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Jan 2023 21:48:13 -0800, Dmitry Torokhov wrote:
> Switch the driver from legacy gpio API that is deprecated to the newer
> gpiod API that respects line polarities described in ACPI/DT.
> 
> This makes driver use standard property name for its gpios
> ("rtc-*-gpios" vs "gpios-rtc-*"), however there is a quirk in gpiolib
> to also recognize legacy names and keep compatibility with older DTSes:
> eaf1a29665cd ("gpiolib: of: add a quirk for legacy names in MOXA ART
> RTC").
> 
> [...]

Applied, thanks!

[1/3] rtc: moxart: switch to using gpiod API
      commit: 2985cda83b8107213e108f95c3cb8caa0da74918
[2/3] dt-bindings: rtc: moxart: use proper names for gpio properties
      commit: e8c9efd5d52f1da1c9e012466b9df94a38cc1c00

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
