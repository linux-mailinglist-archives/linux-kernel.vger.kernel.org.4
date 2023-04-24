Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805636ECCFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjDXNTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjDXNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7EB4C03;
        Mon, 24 Apr 2023 06:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15BA7621F1;
        Mon, 24 Apr 2023 13:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AD7C433D2;
        Mon, 24 Apr 2023 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682342265;
        bh=1bjBPfMWe41SrwWBHJA8b+cuFagXovY/8xXMOfGqALw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUqjDNpyXAto4bPAxYOHNhos/RYhKs0K5ARUpHcNz8LkfKDDokOINx3EC4Uq/LiUk
         Rv8RQYb9jg8wKPNRgC6JB5F42nWjmSwg7GVSfXOKkf4+tKogajI4nzMxhBjbhrWCZ/
         BPAHL0+SSaLEbSly+rzrgIVURj6HMfjupxSBDlr9ALkhReAUNu+RIbypN6YNWDOYEN
         GODc3VfnJRV1hX4Gt/QguQY92/lyx629LRdSZTCLfLXgrtqzxeV+uzc0XWi93AODCP
         nvJ5UmpLz8TONg/3Hp0lca3gaQ/RfZijpMn0VEwm0RbrDLt1OFPBaNh9siM0STQSH6
         X7RSIjNi7bCLg==
Date:   Mon, 24 Apr 2023 14:17:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <20230424131740.GE50521@google.com>
References: <20230419111806.1100437-1-andreas@kemnade.info>
 <20230419111806.1100437-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419111806.1100437-3-andreas@kemnade.info>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023, Andreas Kemnade wrote:

> The device provides 6 channels which can be individually
> turned off and on but groups of two channels share a common brightness
> register.
> 
> Limitation: The GPIO to enable the device is not used yet.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/leds/Kconfig          |  14 +++
>  drivers/leds/Makefile         |   1 +
>  drivers/leds/leds-bd2606mvv.c | 160 ++++++++++++++++++++++++++++++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 drivers/leds/leds-bd2606mvv.c

Applied, thanks

-- 
Lee Jones [李琼斯]
