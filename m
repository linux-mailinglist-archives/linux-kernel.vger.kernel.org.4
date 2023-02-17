Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4F69A919
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBQKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:31:30 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F565972F;
        Fri, 17 Feb 2023 02:31:26 -0800 (PST)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:59fd:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 642B8FF;
        Fri, 17 Feb 2023 11:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1676629882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSVqG/P1bg0cS9mihVMuaFTtuuQKiXCyFHg4MNM/Xg8=;
        b=F7NJYLLzlWsKctZwdjKo1I+FO4T0Vl9mxyXEEBpUEfP/1x4EBzb8a9JCy+uIuTCXVdyNCi
        ZOh6EPfMQOPUm4fVMrY4k4aPTI9YHjolnyiUAuFVTaT7S3pc+6Xpp+bk5SAf5/Q4zNT0yw
        OBYVXlSG6piSaDj60jsTisLg1qTuDzPPYVqPjSRZIAG4Wb99YueZMNH1DtwmS6M4YKHO1i
        UJk3vjF4g9GJNZE4Ye3JipkdvT6NBqHGLFPncXtHc6iwEovQNPScX3W0j3ZyfEyuQ8eX6Q
        lfDeiBr7daUxVI4Z5ikaWEmJTLGRLesqTMYm208DTwPIIDrRXZLwFdP7FgluEA==
From:   Michael Walle <michael@walle.cc>
To:     kumaravel.thiagarajan@microchip.com
Cc:     UNGLinuxDriver@microchip.com, arnd@arndb.de,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v1 char-misc-next 2/5] misc: microchip: pci1xxxx: load gpio driver for the gpio controller auxiliary device enumerated by the auxiliary bus driver.
Date:   Fri, 17 Feb 2023 11:31:16 +0100
Message-Id: <20230217103116.2126311-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824200047.150308-3-kumaravel.thiagarajan@microchip.com>
References: <20220824200047.150308-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ GPIO maintainers]

> PIO function's auxiliary bus driver enumerates separate child devices for
> GPIO controller and OTP/EEPROM interface. This gpio driver implemented
> based on the gpio framework is loaded for the gpio auxiliary device.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/misc/mchp_pci1xxxx/Makefile           |   2 +-
>  .../misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c   | 163 ++++++++++++++++++

Why doesn't this file live in the GPIO subsystem? Seems like this haven't
got a proper review from the GPIO people (probably due to the "misc:"
subject). Maybe even GPIO_REGMAP could be used.

-michael
