Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5068261EF69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiKGJoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiKGJo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:44:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774017A94
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7204860F76
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391D1C433D6;
        Mon,  7 Nov 2022 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667814266;
        bh=9V75wj3uPBt3cv/U48+tKOHtH/lTqk0QW5rA11fFnsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRqS5YabwdSoMxjR+1+9nwMhPW/nhzbA55TAMg8HVCcnCtAm6scaWmwtQFNTpBirq
         JDLMPdHmzTGfdFxKqAGsXIbOBtghiotO2bXfIEN8hufnbIwIv9Y8hxr4qX8B7eNHNH
         zsQlViJD2Y0llAfU0BzIlPiIGMuOPSTNzi2tCVQE748Vm/dUvBMYjhyb9anKML/wCn
         BzlGf0fU40b9O37BjR9Ge5b9TPiG7V9LRSZ6hdcR9NhhaREJuH2N9bMQn/EkTgloF7
         RP+FzKw7M6/LET/b3NYunfNGJCX4g2qOh9MC4Lr0nAEPhym/iDswBO7agrAq/UGQQD
         dUInmtdt2xfqw==
Date:   Mon, 7 Nov 2022 09:44:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/28] mfd: Remove #ifdef guards for PM functions
Message-ID: <Y2jTd+rDYIdz5t5t@google.com>
References: <20221023094852.8035-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221023094852.8035-1-paul@crapouillou.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Oct 2022, Paul Cercueil wrote:

> Hi Lee,
> 
> Here's my V3 patchset that removes #ifdef guards around PM functions.
> 
> V2's patch [01/30] which introduced the new PM export macros have been
> merged, so it's been dropped from this patchset.
> 
> That's pretty much the only change since V2. The other change is that
> the patch to the 'intel_soc_pmic' driver was dropped since the driver
> itself was dropped.
> 
> All the remaining 28 patches are untouched since V2.
> 
> Cheers,
> -Paul
> 
> Paul Cercueil (28):
>   mfd: 88pm80x: Remove #ifdef guards for PM related functions
>   mfd: aat2870: Remove #ifdef guards for PM related functions
>   mfd: adp5520: Remove #ifdef guards for PM related functions
>   mfd: max8925-i2c: Remove #ifdef guards for PM related functions
>   mfd: mt6397-irq: Remove #ifdef guards for PM related functions
>   mfd: pcf50633: Remove #ifdef guards for PM related functions
>   mfd: rc5t583-irq: Remove #ifdef guards for PM related functions
>   mfd: stpmic1: Remove #ifdef guards for PM related functions
>   mfd: ucb1x00: Remove #ifdef guards for PM related functions
>   mfd: 88pm860x: Remove #ifdef guards for PM related functions
>   mfd: mcp-sa11x0: Remove #ifdef guards for PM related functions
>   mfd: sec: Remove #ifdef guards for PM related functions
>   mfd: sm501: Remove #ifdef guards for PM related functions
>   mfd: tc6387xb: Remove #ifdef guards for PM related functions
>   mfd: tps6586x: Remove #ifdef guards for PM related functions
>   mfd: wm8994: Remove #ifdef guards for PM related functions
>   mfd: max77620: Remove #ifdef guards for PM related functions
>   mfd: t7l66xb: Remove #ifdef guards for PM related functions
>   mfd: arizona: Remove #ifdef guards for PM related functions
>   mfd: max14577: Remove #ifdef guards for PM related functions
>   mfd: max77686: Remove #ifdef guards for PM related functions
>   mfd: motorola-cpcap: Remove #ifdef guards for PM related functions
>   mfd: sprd-sc27xx: Remove #ifdef guards for PM related functions
>   mfd: stmfx: Remove #ifdef guards for PM related functions
>   mfd: stmpe: Remove #ifdef guards for PM related functions
>   mfd: tc3589x: Remove #ifdef guards for PM related functions
>   mfd: tc6393xb: Remove #ifdef guards for PM related functions
>   mfd: intel-lpss: Remove #ifdef guards for PM related functions

Applied 00-27, thanks.

-- 
Lee Jones [李琼斯]
