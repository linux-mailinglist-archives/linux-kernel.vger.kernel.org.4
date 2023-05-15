Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F93703260
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbjEOQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbjEOQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F1F2D48
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF1D061FAA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41595C433EF;
        Mon, 15 May 2023 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684167025;
        bh=TVBG7SMjG/1QBhmefl5DQQiASQu3tHuVUA6NbNXGd0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMentvRy93oRz81ozCajb2qMRyRSYjRRNx8uqAdiruTNgSSHS/9LZmSxnBtkjdfws
         7KljeOD29mM2mt1NTNi8wrrCn6OGSqRH7GQugWrDKiTj4VSJz4ORJ3x1FsV7puJdHl
         M8DjYohEISmIFA3WV45xbu0tswFJALMVXQZ8fEmsdUQsK++DzS75Y1RBW8mvAF2TBb
         q3oY2htBQ/+uY1wxGfVo8derx4HXuft/hXYB4MzsCcWeFJNgHf6qAkGOy2k7zJF56R
         5Ua2B6Y+ER3piWCFjtSZeXotboYGYGco4mTVtAmzf+XW4hUrLGnz6oKiMUDtwkU/4O
         AJH2VJDs/ng2A==
Date:   Mon, 15 May 2023 17:10:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] mfd: Switch i2c drivers back to use .probe()
Message-ID: <20230515161020.GY10825@google.com>
References: <20230505132241.1215472-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230505132241.1215472-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2023, Uwe Kleine-König wrote:

> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/88pm800.c                 | 2 +-
>  drivers/mfd/88pm805.c                 | 2 +-
>  drivers/mfd/88pm860x-core.c           | 2 +-
>  drivers/mfd/aat2870-core.c            | 2 +-
>  drivers/mfd/acer-ec-a500.c            | 2 +-
>  drivers/mfd/act8945a.c                | 2 +-
>  drivers/mfd/adp5520.c                 | 2 +-
>  drivers/mfd/arizona-i2c.c             | 2 +-
>  drivers/mfd/as3711.c                  | 2 +-
>  drivers/mfd/as3722.c                  | 2 +-
>  drivers/mfd/atc260x-i2c.c             | 2 +-
>  drivers/mfd/axp20x-i2c.c              | 2 +-
>  drivers/mfd/bcm590xx.c                | 2 +-
>  drivers/mfd/bd9571mwv.c               | 2 +-
>  drivers/mfd/da903x.c                  | 2 +-
>  drivers/mfd/da9052-i2c.c              | 2 +-
>  drivers/mfd/da9055-i2c.c              | 2 +-
>  drivers/mfd/da9062-core.c             | 2 +-
>  drivers/mfd/da9063-i2c.c              | 2 +-
>  drivers/mfd/da9150-core.c             | 2 +-
>  drivers/mfd/ene-kb3930.c              | 2 +-
>  drivers/mfd/gateworks-gsc.c           | 2 +-
>  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 +-
>  drivers/mfd/intel_soc_pmic_chtwc.c    | 2 +-
>  drivers/mfd/intel_soc_pmic_crc.c      | 2 +-
>  drivers/mfd/iqs62x.c                  | 2 +-
>  drivers/mfd/khadas-mcu.c              | 2 +-
>  drivers/mfd/lm3533-core.c             | 2 +-
>  drivers/mfd/lochnagar-i2c.c           | 2 +-
>  drivers/mfd/lp3943.c                  | 2 +-
>  drivers/mfd/lp873x.c                  | 2 +-
>  drivers/mfd/lp87565.c                 | 2 +-
>  drivers/mfd/lp8788.c                  | 2 +-
>  drivers/mfd/madera-i2c.c              | 2 +-
>  drivers/mfd/max14577.c                | 2 +-
>  drivers/mfd/max77620.c                | 2 +-
>  drivers/mfd/max77650.c                | 2 +-
>  drivers/mfd/max77686.c                | 2 +-
>  drivers/mfd/max77693.c                | 2 +-
>  drivers/mfd/max77714.c                | 2 +-
>  drivers/mfd/max77843.c                | 2 +-
>  drivers/mfd/max8907.c                 | 2 +-
>  drivers/mfd/max8925-i2c.c             | 2 +-
>  drivers/mfd/max8997.c                 | 2 +-
>  drivers/mfd/max8998.c                 | 2 +-
>  drivers/mfd/mc13xxx-i2c.c             | 2 +-
>  drivers/mfd/menelaus.c                | 2 +-
>  drivers/mfd/menf21bmc.c               | 2 +-
>  drivers/mfd/mp2629.c                  | 2 +-
>  drivers/mfd/mt6360-core.c             | 2 +-
>  drivers/mfd/mt6370.c                  | 2 +-
>  drivers/mfd/ntxec.c                   | 2 +-
>  drivers/mfd/palmas.c                  | 2 +-
>  drivers/mfd/pcf50633-core.c           | 2 +-
>  drivers/mfd/qcom-pm8008.c             | 2 +-
>  drivers/mfd/rc5t583.c                 | 2 +-
>  drivers/mfd/retu-mfd.c                | 2 +-
>  drivers/mfd/rk808.c                   | 2 +-
>  drivers/mfd/rn5t618.c                 | 2 +-
>  drivers/mfd/rohm-bd71828.c            | 2 +-
>  drivers/mfd/rohm-bd718x7.c            | 2 +-
>  drivers/mfd/rohm-bd9576.c             | 2 +-
>  drivers/mfd/rsmu_i2c.c                | 2 +-
>  drivers/mfd/rt4831.c                  | 2 +-
>  drivers/mfd/rt5033.c                  | 2 +-
>  drivers/mfd/rt5120.c                  | 2 +-
>  drivers/mfd/sec-core.c                | 2 +-
>  drivers/mfd/si476x-i2c.c              | 2 +-
>  drivers/mfd/simple-mfd-i2c.c          | 2 +-
>  drivers/mfd/sky81452.c                | 2 +-
>  drivers/mfd/smpro-core.c              | 2 +-
>  drivers/mfd/stmfx.c                   | 2 +-
>  drivers/mfd/stmpe-i2c.c               | 2 +-
>  drivers/mfd/stpmic1.c                 | 2 +-
>  drivers/mfd/stw481x.c                 | 2 +-
>  drivers/mfd/tc3589x.c                 | 2 +-
>  drivers/mfd/ti-lmu.c                  | 2 +-
>  drivers/mfd/tps6105x.c                | 2 +-
>  drivers/mfd/tps65010.c                | 2 +-
>  drivers/mfd/tps6507x.c                | 2 +-
>  drivers/mfd/tps65086.c                | 2 +-
>  drivers/mfd/tps65090.c                | 2 +-
>  drivers/mfd/tps65217.c                | 2 +-
>  drivers/mfd/tps65218.c                | 2 +-
>  drivers/mfd/tps65219.c                | 2 +-
>  drivers/mfd/tps6586x.c                | 2 +-
>  drivers/mfd/tps65910.c                | 2 +-
>  drivers/mfd/tps65912-i2c.c            | 2 +-
>  drivers/mfd/twl-core.c                | 2 +-
>  drivers/mfd/twl6040.c                 | 2 +-
>  drivers/mfd/wl1273-core.c             | 2 +-
>  drivers/mfd/wm831x-i2c.c              | 2 +-
>  drivers/mfd/wm8350-i2c.c              | 2 +-
>  drivers/mfd/wm8400-core.c             | 2 +-
>  drivers/mfd/wm8994-core.c             | 2 +-
>  95 files changed, 95 insertions(+), 95 deletions(-)

Doesn't apply.

Please rebase/resend and it'll go to the top of my queue.

-- 
Lee Jones [李琼斯]
