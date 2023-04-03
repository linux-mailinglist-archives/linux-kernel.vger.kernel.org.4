Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B3F6D540D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjDCVzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjDCVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:55:37 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98425E0;
        Mon,  3 Apr 2023 14:55:34 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pjS8z-00025Z-W2; Mon, 03 Apr 2023 23:55:18 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Chris Morgan <macroalpha82@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan
Date:   Mon, 03 Apr 2023 23:55:17 +0200
Message-ID: <4981873.LvFx2qVVIh@diego>
In-Reply-To: <642b134c.4a0a0220.1d01a.5990@mx.google.com>
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-3-cristian.ciocaltea@collabora.com>
 <642b134c.4a0a0220.1d01a.5990@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 3. April 2023, 19:56:26 CEST schrieb Chris Morgan:
> On Mon, Apr 03, 2023 at 01:50:52PM +0300, Cristian Ciocaltea wrote:
> > Add the necessary DT changes for the Rock 5B board to enable support for
> > the PWM controlled heat sink fan.
> 
> Honest question, but should we be adding this to the board file if not
> every device has a PWM fan (they all have the socket for the fan, but
> not the fan)? For example I have a passively cooled case that doesn't
> include a fan.

We also set up the sdmmc host without knowing if the user will plug in
an sd-card ;-) .

So especially in the case where there is a dedicated socket for it,
as you write, we should definitly add it for the board.

By the way, am I correct in thinking that patch 1 and 2 are actually
independent of each other? So I'd just pick patch2 for the Rockchip tree
(as we do have a text-binding) and you can handle the yaml conversion
in a followup or whatever?

Thanks
Heiko


