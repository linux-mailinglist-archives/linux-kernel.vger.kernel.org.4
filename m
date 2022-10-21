Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07F6607D36
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJURKQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Oct 2022 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiJURKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:10:09 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB095E7B;
        Fri, 21 Oct 2022 10:10:05 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1olvWv-0007gs-Dp; Fri, 21 Oct 2022 19:09:57 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     ardb@kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, sboyd@kernel.org,
        Corentin LABBE <clabbe@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v10 00/33] crypto: rockchip: permit to pass self-tests
Date:   Fri, 21 Oct 2022 19:09:53 +0200
Message-ID: <4780296.31r3eYUQgx@diego>
In-Reply-To: <Y1KctXMZ1+c5uQqd@Red>
References: <20220927075511.3147847-1-clabbe@baylibre.com> <Y1KctXMZ1+c5uQqd@Red>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. Oktober 2022, 15:20:53 CEST schrieb Corentin LABBE:
> Le Tue, Sep 27, 2022 at 07:54:38AM +0000, Corentin Labbe a écrit :
> > Hello
> > 
> > The rockchip crypto driver is broken and do not pass self-tests.
> > This serie's goal is to permit to become usable and pass self-tests.
> > 
> > This whole serie is tested on a rk3328-rock64, rk3288-miqi and
> > rk3399-khadas-edge-v with selftests (with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y)
> > 
> > Regards
> > 
> 
> Hello
> 
> Gentle ping since it is a month since this serie was sent and no comment was made (except some reviewed-by).
> So I think it is ready to be merged, probably thought the crypto tree.

ideally everything _except_ patches
 26 +27+28
would go through the crypto tree.

So if possible I'd like to pick up those (clock + arm64-dts patches)
after the crypto people are satisfied with the driver changes.


Thanks
Heiko


