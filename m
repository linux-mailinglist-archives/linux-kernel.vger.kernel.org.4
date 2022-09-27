Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420265ECF57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiI0VfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0VfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:35:19 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AAF2BB08;
        Tue, 27 Sep 2022 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=PDR3r9o/jLyp7gsKkv7+GSdo7+M7ZkytJP4A8PtoWAI=; b=Lk3LGgTb08No5NRzGqWSR6k1TZ
        zfLt6hiNWyqI5CdfUASMlGoV3yz21/vpX4XjYigMsnjKQ5herGxVQ4DszGgqxspavNfzTfTp6/zDs
        mqgIgmAjVd5H5d2jCK0FO0vZvMe4+i6lmDqBMXeVCQ9wcdNyt3AObpMu5AZJKbm5e2uk6JZSRsIh3
        ODQZ14q/h+frLjtYUNEQ0k+Y6LyU0BRWIYbZP7rJayGD2+4YcvkFB1qmvldo1DL3/QVBFn3s8uAvr
        pl7/XCL6t9y5x3z2ewlQ0I/v+0Agmhdy7GtYbiFQ/8oVi5+HTvf1DwR2kIalbX84drlkogMAGFx7H
        Twa2qkzg==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1odIEG-00C1Wx-4h; Tue, 27 Sep 2022 23:35:00 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1odIEE-000VRP-0Z;
        Tue, 27 Sep 2022 23:34:58 +0200
Date:   Tue, 27 Sep 2022 23:34:58 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH RFT 0/5] crypto: rockchip: add crypto offloader V2
Message-ID: <YzNsgjPFwVEDo4E4@aurel32.net>
Mail-Followup-To: Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220927080048.3151911-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927080048.3151911-1-clabbe@baylibre.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-27 08:00, Corentin Labbe wrote:
> Hello
> 
> Rockchip rk3568 and rk3588 have a common crypto offloader IP different
> than rk3228 one.
> I started to work the driver for this IP on a rk3588 based board, but this SoC
> is still not upstream.
> So it is why I send this serie asking for test since I own no rk3568 and
> I need to be sure datasheet is right.

I did a quick test, and it doesn't seem to work. I get:

rk3588-crypto fe380000.crypto: DMA timeout
rk3588-crypto fe380000.crypto: DMA timeout

That's on an ODROID-M1 board, so with the set of patches I sent
yesterday to support it.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
