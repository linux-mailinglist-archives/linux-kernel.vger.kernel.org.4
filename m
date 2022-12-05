Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4064306D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiLESbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiLESbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:31:12 -0500
X-Greylist: delayed 620 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 10:26:56 PST
Received: from smtp-out-12.comm2000.it (smtp-out-12.comm2000.it [212.97.32.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97926AFD;
        Mon,  5 Dec 2022 10:26:56 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-12.comm2000.it (Postfix) with ESMTPSA id 024E7BA10E3;
        Mon,  5 Dec 2022 19:08:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1670263752;
        bh=s9xvT9QJ++he7kg+7ITHZewgZ6NKoOKKzsBGG+A5AzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gjFV2BX/su1Ecg6HJzd18+TwytswlAj17WYH/MOf3o0rpS/Lh+tM0huNKwzLNyNbE
         DMqvHDqKMufWAIGAQUmE+rfPXB+ztbidi/Y5dH0UZVYVjNezGGAzh6jJ1vivzlhcuT
         bEM6N9IEN+UkQwBqoD/QrXnxdjzeqAFl/FscGlBbXBNYkU1FTIRf3Jl6RPJRXSTcUg
         zxDasfDid2ujoe+hE+hOSL8DirobUevTDp8HVuIpipHHgSBAi7+Qo0K8Sq34gMd5qK
         jj8XK6G3+a8ZiuMLScCHEkVR4LhXnl1exaUCNNrRTQs6mCpX6h1Jml1BUOb7XsyRZ0
         SBiJhrY/j2CVw==
Date:   Mon, 5 Dec 2022 19:08:53 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com, afd@ti.com, khilman@baylibre.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/6] Add support for TI TPS65219 PMIC.
Message-ID: <Y44ztV+2j4krM8mp@francesco-nb.int.toradex.com>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104152311.1098603-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 04:23:05PM +0100, Jerome Neanne wrote:
> Hi everyone,
Hello Jerome,

are you planning to have also gpio support added to the driver?

Francesco

