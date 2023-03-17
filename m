Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59416BF514
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCQWYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCQWYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:24:42 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685C2A16C;
        Fri, 17 Mar 2023 15:24:39 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 09008240003;
        Fri, 17 Mar 2023 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679091877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0OG2eaOObi0PzZt0+t2besR/iKhbzTY5ALzdFFyevY=;
        b=JgK00V2AS8CuZZf4I/+xdpe6jTIH8nz/1NjI+1CkNJ/sXmWfH0E+Lai1TZihXvz7Sz88oj
        lhCyDSpCvrjO+CCI6aQ5kidTGbEhmBNRST81njj7UlY8lwvGoCdbavph7T7U9OKoNhcCid
        RcwY8t4EyGt8qjRCCQtcUGMmS5jb0BgCdjZbXiZNb25Iqsi3TfrZOxXX/cliUh5YAzjICi
        g/ckgNGhMB836iopiWd1cnE6kO7A4Ei2px3NGDjY28RIlFJNqwrWraADczLxYJUfBEzjxl
        2Y15/4YubpaTa09auHVI2VL0Pv1gCAQb40I2eExWgJDfNzqbaTnqgVLcReFpyQ==
Date:   Fri, 17 Mar 2023 23:24:36 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] rtc: omap: include header for omap_rtc_power_off_program
 prototype
Message-ID: <167909184546.118295.7733746268968792038.b4-ty@bootlin.com>
References: <20230311094021.79730-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311094021.79730-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Mar 2023 10:40:21 +0100, Krzysztof Kozlowski wrote:
> Non-static functions should have a prototype:
> 
>   drivers/rtc/rtc-omap.c:410:5: error: no previous prototype for ‘omap_rtc_power_off_program’ [-Werror=missing-prototypes]
> 
> 

Applied, thanks!

[1/1] rtc: omap: include header for omap_rtc_power_off_program prototype
      commit: f69c2b5420497b7a54181ce170d682cbeb1f119f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
