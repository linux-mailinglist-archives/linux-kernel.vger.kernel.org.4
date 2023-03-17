Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EB06BF51A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCQWZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjCQWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:25:30 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781AD4C6C7;
        Fri, 17 Mar 2023 15:25:23 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 63B2C240005;
        Fri, 17 Mar 2023 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679091922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9AEMYwgLyNAWh0oOLMextsjEa+S7d1bTa13dOoTNxy4=;
        b=TjBHYT/1qlSQUSzDZTqcchdp3B2CrRjWSdiNsbAXpTSG6lDs6/h7D0e5Gf+iqLJjGi29ze
        XxRpw3CnnI+hfGzg7roYKwXGQyiugmtwOehC7NMg5z4giMNlQyOD7tgVzOWQfp4PQdyPHJ
        wb0m31Wgf+aeOuywJnAAPMc8wd+5//xbfpg9LMHMXHduI6ERF5JEca+ibeV1ksG/tpvs3k
        t46MBeWsXsOb8ums6Vvo/pvnCUDAMybHwFa8pTkkbhegvxIcCRHpsVECv1Jg6HuT7cOM43
        fCpfHv/W9Pp6ThGTboH7nhfrIuqhvbPNhAXEaLgNv9WhMqnLBULGDzIdkEA7bw==
Date:   Fri, 17 Mar 2023 23:25:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 0/2] rtc: pcf8523: standardize code
Message-ID: <167909184547.118295.6616908281532052497.b4-ty@bootlin.com>
References: <20230315082021.2104452-1-javier.carrasco@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315082021.2104452-1-javier.carrasco@wolfvision.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2023 09:20:19 +0100, Javier Carrasco wrote:
> A series of patches have introduced coding-style issues that make
> checkpatch generate a number of easy-to-fix errors and warnings.
> Furthermore, some cleanups and refactoring operations left an
> unnecessary OR operation behind. These patches claim tosolve
> these minor issues.
> 
> Javier Carrasco (2):
>   rtc: pcf8523: fix coding-style issues
>   rtc: pcf8523: remove unnecessary OR operation
> 
> [...]

Applied, thanks!

[1/2] rtc: pcf8523: fix coding-style issues
      commit: b48cc753c017d1f5c6e317538205d40e70d04f3c
[2/2] rtc: pcf8523: remove unnecessary OR operation
      commit: dc87fad6448fc574456516404469c0c2c48d642e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
