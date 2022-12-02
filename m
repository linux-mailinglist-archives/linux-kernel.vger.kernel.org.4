Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3264063F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiLBL6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiLBL6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:58:47 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B589B9D2FC;
        Fri,  2 Dec 2022 03:58:45 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A69705FD0B;
        Fri,  2 Dec 2022 14:58:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669982322;
        bh=1bW2bgaIvS3N//TCaKftg3kWnKGtCH+WclvdEKjJFm0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=q81I/LfbxDUUYskEWIv+fkXYjVhZBLXv4Z2dAd18zJwOKiKNMkz/eN6gLSbZyGin+
         rxMiv727OFFLFLoomXzSyYybLq8AsBv4IvrnUEX4taji7W1ZBPLov7YHwgkyRjnsT5
         lGoRlMuKWMe64IMfaP1+MIN0y0gkNTfD4e6a0Wft+RQE7/7R7LwecBkTTHoOHefKfC
         nkSP2U6lTciSBIDpwLGX61TGIJkLRHBkr2bmFINflYpn7QVxiD2qe2+yAa3rnnAPCK
         fiUg6oTgz8kc6oSsh+tUiyENSOnHhmn80NE+XKY6f8f8g3CsKCzvEMwcSMf1fiuJEY
         ZIrMvnqdrDOOg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 14:58:42 +0300 (MSK)
Date:   Fri, 2 Dec 2022 14:58:41 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 06/11] clk: meson: introduce a1-clkc common driver for
 all A1 clock controllers
Message-ID: <20221202115841.xg3e56st7mk6lmbz@CAB-WSD-L081021>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-7-ddrokosov@sberdevices.ru>
 <1jy1rq6nje.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jy1rq6nje.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/02 07:44:00 #20636821
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:36:50PM +0100, Jerome Brunet wrote:
> 
> On Fri 02 Dec 2022 at 01:56, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > Generally, A1 SoC has four clock controllers on the board: PLL,
> > Peripherals, CPU, and Audio. The audio clock controller is different
> > from others, but the rest are very similar from a functional and regmap
> > point of view. So a it's good idea to generalize some routines for all
> > of them. Exactly, meson-a1-clkc driver contains the common probe() flow.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> 
> I think you should leave this out for the initial submission. It makes
> harder to review.
> 
> In some case, these factorizations actually the maitenance harder.
> 
> There is also the s4 that is coming up. It looks similar to the A1 as
> well.
> 
> Let's wait for both them to land, see how it goes and then we'll decide
> if a factorization is appropriate.
> 

Jerome,

Sorry, let me double check a little bit that I get your point correctly.

Do you mean due to s4 development in parallel it's easier to have own
probe sequence for each driver in the first stage (until A1 and S4 clock
controllers not merged to upstream) and after think about some
"generalization", right?

...

-- 
Thank you,
Dmitry
