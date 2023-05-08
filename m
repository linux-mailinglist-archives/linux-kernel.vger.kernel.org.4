Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4646FA346
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjEHJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbjEHJ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADAA1A1F8;
        Mon,  8 May 2023 02:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26326196E;
        Mon,  8 May 2023 09:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF88C4339B;
        Mon,  8 May 2023 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683538076;
        bh=xjtpkJFszM9BNKzTaTVwrSPwHtleGTIEPou2QwMYpds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLA3fa/0kDp64fOT1Hd+PK81rCvKxAgPJtioHFS6K6/gX3qgdlddUzap/83sEaE2o
         pUeWDbV6MiWa67vSJlTSUnPW6cbvIcplh96TUwg7nrfxfGnmHABJMelSr4E4EuoMr8
         h8IzaMoaIDwpwYIvFHta2sKD3Xi73Fj6CljsuVvJ3eGEGIQx/n3AzjnP9J6mkrNHIa
         CLBdAAIx1DMGQahTsrjfVzN8Q7rq/Ba603mX1kvd/FMj1XXyduxpirm7tlzHIqK8Um
         7LNIU4XXlRAguFtmYi/f0XpaxNeZP/WO/gDeTGvitzQzAW7vTVyO3Oeccj51pTUkLJ
         Lt9um+WzS+C4g==
Date:   Mon, 8 May 2023 14:57:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, mturquette@baylibre.com,
        kishon@kernel.org, hminas@synopsys.com, Thinh.Nguyen@synopsys.com,
        yue.wang@amlogic.com, hanjie.lin@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/5] phy: amlogic: enable/disable clkin during Amlogic
 USB PHY init/exit
Message-ID: <ZFjAmCcc/35MhcuI@matsya>
References: <20230426102922.19705-1-ddrokosov@sberdevices.ru>
 <20230426102922.19705-2-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426102922.19705-2-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-23, 13:29, Dmitry Rokosov wrote:
> Previously, all Amlogic boards used the XTAL clock as the default board
> clock for the USB PHY input, so there was no need to enable it.
> However, with the introduction of new Amlogic SoCs like the A1 family,
> the USB PHY now uses a gated clock. Hence, it is necessary to enable
> this gated clock during the PHY initialization sequence, or disable it
> during the PHY exit, as appropriate.

Applied to phy/next, thanks

-- 
~Vinod
