Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEAC69F6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjBVOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBVOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:36:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9577EC4;
        Wed, 22 Feb 2023 06:36:10 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A78EBFF803;
        Wed, 22 Feb 2023 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677076569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jfv631A7z7opi86ckRp4p4jIxNAotG1HsdzHjt+sXa0=;
        b=QasKyJ/9HWrhNan4N8JLlknOpecbnWj+nt6fBNPApK30ZIOcDCgZsziUxRwMYxXxdxDzmg
        69NfID8TEMzbz7AegduMWOhdC51U5QnM74BuiUS0GdCl9Sg9OrFSoPjoFx3i0wwDhHrSlJ
        29oonPeJXfGBfE2YX9S1eOiwcaEoi2rIrkrzI3etp9PBl83SykGwk+FfcTfoSFJe552qlr
        G1kCIKAwCwj1kZlFeKM1TAdT1pMi3r1qrqeBvmAJ9iDiJGRAIjJOYT2TyQhW8nFtqS4nyV
        BbWNgR2jsEmgXLniZpS2Go/iKOi5VsKqNSr8cOTt7yxcPyfr2AQueM+vk82I7Q==
Date:   Wed, 22 Feb 2023 15:36:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v2 0/2] pcf85363: support for quartz-load-femtofarads
Message-ID: <167707630224.29068.14526797617173488842.b4-ty@bootlin.com>
References: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Feb 2023 09:18:13 +0100, Javier Carrasco wrote:
> These patches add support for the quartz-load-femtofarads property in
> the pcf85363 device driver and new bindings for the pcf85263 and
> pcf85363 Real Time Clocks.
> 
> The driver has been tested with a PCF85263ATT RTC and a CTS3-32.768-12.5-20
> oscillator that needs a 12.5 pF load capacitor. With no property
> support the 7 pF default value leads to at least 2 Hz output frequency
> deviations, while setting the right value the deviation decreased to
> 0.15 Hz. These measurements were made with a high precision oscilloscope
> (SIGLENT SDS5104X).
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: rtc: nxp,pcf8563: move pcf85263/pcf85363 to a dedicated binding
      commit: 1b2f85a8bac67b9909f2ee4be1bc11548a7aeaf3
[2/2] rtc: pcf85363: add support for the quartz-load-femtofarads property
      commit: fd9a6a13949af81062f4cd04f2c1b28ca5311e71

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
