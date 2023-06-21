Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D7738D23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjFURce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFURcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB99219B;
        Wed, 21 Jun 2023 10:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D9861647;
        Wed, 21 Jun 2023 17:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F215EC433C8;
        Wed, 21 Jun 2023 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687368750;
        bh=VfqGpYEIglQTk51i33OR5r1TFrQwDJbPB0c/7MTgQXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lL5Wji/oNVr5PUKpng4sRLy9k9e/N1ftHA1H/u/QEfYMDF0txKa82VpDKcAWyENjq
         9nFIxmUQ7OBdkawD4EgQTkdU0NN4WpeZkzIjDP76oY4AVYMD2Ve/9hScaIytGN5BD2
         63jFjGe9ZIQBlCs2KzuYLE97Hv90ScP6yvHeyjp3lBHawrxbcIXXqzcaolcAHyUu20
         RvVg5VUVR7oWBlnMjagDmW4se5Ij8db88LJB5ugxm2M7iT2tlHntQB51Dw55hhjoIb
         69Yw7/LdTsDiPfDCzfXM2Ro0OAaZhHUdyOuQGIWEDkCugjRNycgeL8MQKN9AV3PIG2
         8yytwf9fE/QwA==
Date:   Wed, 21 Jun 2023 23:02:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 1/7] dt-bindings: phy: intel,combo-phy: restrict node
 name suffixes
Message-ID: <ZJM0Kh8+ZzfiFQlg@matsya>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-23, 16:48, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.

Applied, thanks

-- 
~Vinod
