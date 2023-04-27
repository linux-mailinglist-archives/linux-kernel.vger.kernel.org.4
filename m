Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410E46F0E62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbjD0WmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjD0WmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:42:15 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E7CC0;
        Thu, 27 Apr 2023 15:42:12 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B7872E0007;
        Thu, 27 Apr 2023 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682635330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuOyXz5JVpVmfnHiWfsKmhETCfXaasy0XMv5v+E9ol4=;
        b=X8BBH/TSW/xzv5EVaVXh6SXzBU6yfzv5Nbk9TyUIoIsdEO3kNgx5Ug06FwhVYAGNCqBX5T
        sZGFMq9v4HMx2GTXA9cZyWfrx1UId2Vm4sSN3MvKXPlPwDcr0y2jUtWBr9mGssCdERNRH6
        tJONXuxx3e8YA556mCr+urM7Rjs4rvuK0kRnJBqjyrBC1s5hS2dCvcAw/XIlC205fth9BN
        xwpgkmh88iNMc62UqVswueX7Vo4brA1XDHu/6Aug8lJ9PwR3gnFK5kJSKSAdnEEqWoS8nR
        OxTcIvDOOTK0jp87fYqhMTLPV24LFk+HOU4tcGpeay5o72p4NvhhLhAjn4uTFw==
Date:   Fri, 28 Apr 2023 00:42:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/4] rtc: ab-eoz9: constify pointers to hwmon_channel_info
Message-ID: <168263530235.78879.11958237032842726405.b4-ty@bootlin.com>
References: <20230407150306.80141-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407150306.80141-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 17:03:03 +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> 

Applied, thanks!

[1/4] rtc: ab-eoz9: constify pointers to hwmon_channel_info
      commit: 4c3f19ce70d7a008953a8d2e9584a20c328699c6
[2/4] rtc: ds3232: constify pointers to hwmon_channel_info
      commit: e4133995fe80251ad2abb0261745ea27ab97c2e7
[3/4] rtc: isl12022: constify pointers to hwmon_channel_info
      commit: a176de9fffcb97ee885b2ade3dbb23dc9be33b29
[4/4] rtc: rv3032: constify pointers to hwmon_channel_info
      commit: eaa9cec95de9405ee7400e8888e6d3d42173df28

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
