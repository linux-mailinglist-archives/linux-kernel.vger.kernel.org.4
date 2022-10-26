Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B614660DE93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiJZKF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiJZKFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:05:54 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F4B3137B;
        Wed, 26 Oct 2022 03:05:51 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ondHU-006UUy-SN; Wed, 26 Oct 2022 18:05:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 26 Oct 2022 18:05:41 +0800
Date:   Wed, 26 Oct 2022 18:05:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin LABBE <clabbe@baylibre.com>
Cc:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        ardb@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v10 00/33] crypto: rockchip: permit to pass self-tests
Message-ID: <Y1kGdWyYPtcgQPtd@gondor.apana.org.au>
References: <20220927075511.3147847-1-clabbe@baylibre.com>
 <Y1KctXMZ1+c5uQqd@Red>
 <4780296.31r3eYUQgx@diego>
 <Y1jkqiYjXT30/hk5@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1jkqiYjXT30/hk5@Red>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:41:30AM +0200, Corentin LABBE wrote:
>
> Herbert any thought ?

Please let me know exactly which patches you want me to apply.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
