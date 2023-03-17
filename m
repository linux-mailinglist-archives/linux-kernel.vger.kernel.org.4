Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA726BF51B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCQWZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjCQWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:25:06 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F003E637;
        Fri, 17 Mar 2023 15:24:59 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AC5BE1BF204;
        Fri, 17 Mar 2023 22:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679091897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWeyOM+1DFGA5ZYxkqTje/egSngX2AXYQ3M3X3bGLhk=;
        b=aqdLxUxxNX33AQ4IbvcvJifJya9dSJKxzPiHpGRQ90BymbBGGxKcGCixSCxQc1wZoqI479
        5TXdksj84yeGCmBttDrP8uTVWtIK+RZs5otpg7MBDUHXA9G8SFSlP3SUuGIvJzZle+gae1
        kgJalDwje4D6A+9zeGs6WM4sxn7NP5HMLnDsRg7Kisr4gncls9op3CfCO7hBUZhcYbLnQv
        DF9lnSx75Oozt43lTe+Sh7f/MRF7ViGHR12sFQUDEoIq6tbuEDRDQkKV0aLxnVOHijwAr2
        JUH01/ES6M29skfI+1NyYVveliU8E3Nd2Hpq/kIYDo3DcMxIbU0+hCdq5LHS8A==
Date:   Fri, 17 Mar 2023 23:24:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] rtc: ds1390: mark OF related data as maybe unused
Message-ID: <167909184547.118295.10849905962315462307.b4-ty@bootlin.com>
References: <20230311111226.250922-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311111226.250922-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Mar 2023 12:12:26 +0100, Krzysztof Kozlowski wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
> 
>   drivers/rtc/rtc-ds1390.c:216:34: error: ‘ds1390_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> 

Applied, thanks!

[1/1] rtc: ds1390: mark OF related data as maybe unused
      commit: cca1e2f790703bb22b56d94c5efc66c1d9517b21

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
