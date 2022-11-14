Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31764628B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiKNV2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:28:48 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849F118E3E;
        Mon, 14 Nov 2022 13:28:47 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E4AD3FF808;
        Mon, 14 Nov 2022 21:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668461326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OhAg2dg5Cr0mXaVo9Fds0vDov9wb6UjxSDea3jeHuQk=;
        b=cfK2VnXF4YudB5XszoDd434yXRITcnTBUTTPDKvIhlJQQPuiQQ+sXfrSUNMheXQj8ZKBHz
        hAv2LomY1SzSdBin7+T2bfpgHdnBXu/3NKzQkR0DCOvaIYLS3w/3n8J0RqQ3nPoq4tMg2P
        LaTKWyZ2x9zqOfAspmJuyQnliXRClGRecl4Wu1WXe53aYXHBrapaUIXCJ4UB5c70Xpp4jb
        DuSJ6wBB+ns35Nx03o02QUz9KAdwADj4wXkNB3KFh8pizDs5eY68SYGJKIMOSalQAI+Bcn
        KLjmrCpr3SZUFk/S+umGcP47zdFRHGoEoK/q2uN9DaK9duHHZpCz+KRz5yQ0FQ==
Date:   Mon, 14 Nov 2022 22:28:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, kernel@collabora.com,
        linux-rtc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: (subset) [PATCHv2 6/6] dt-bindings: rtc: convert hym8563
 bindings to json-schema
Message-ID: <166846130108.2115004.17300234137040825586.b4-ty@bootlin.com>
References: <20221024165549.74574-1-sebastian.reichel@collabora.com>
 <20221024165549.74574-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024165549.74574-7-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 18:55:49 +0200, Sebastian Reichel wrote:
> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> Schema format.
> 
> 

Applied, thanks!

[6/6] dt-bindings: rtc: convert hym8563 bindings to json-schema
      commit: e00a89527a497cd49436369b05459be55cb922ba

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
