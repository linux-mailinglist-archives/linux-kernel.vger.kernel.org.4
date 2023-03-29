Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57006CD9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjC2NFG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 09:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2NFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:05:04 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED71D2;
        Wed, 29 Mar 2023 06:05:01 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phVTx-00048M-Cs; Wed, 29 Mar 2023 15:04:53 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Shreeya Patel <shreeya.patel@collabora.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jamie@jamieiles.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: rockchip: Add rockchip,rk3588-wdt
 string
Date:   Wed, 29 Mar 2023 15:04:52 +0200
Message-ID: <4256207.ejJDZkT8p0@diego>
In-Reply-To: <157937fd-0af7-4ff5-8430-2f956c7aafba@roeck-us.net>
References: <20230328210048.195124-1-shreeya.patel@collabora.com>
 <20230328210048.195124-3-shreeya.patel@collabora.com>
 <157937fd-0af7-4ff5-8430-2f956c7aafba@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Am Mittwoch, 29. März 2023, 14:47:34 CEST schrieb Guenter Roeck:
> On Wed, Mar 29, 2023 at 02:30:48AM +0530, Shreeya Patel wrote:
> > Add rockchip,rk3588-wdt compatible string.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

just the usual question who is expected to pick up the binding patch?
Should I just take it together with the dts-patch or do we wait for
a watchdog-maintainer to pick up the binding alone?

Thanks
Heiko


