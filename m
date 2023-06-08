Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C072864E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjFHR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjFHR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DAE1BDF;
        Thu,  8 Jun 2023 10:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E73C264FC5;
        Thu,  8 Jun 2023 17:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABECBC433EF;
        Thu,  8 Jun 2023 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686245193;
        bh=4MtA9tsIyCjcE08STEz2lRLmjFCiwKtdTt5WhNYC+1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdXJxjHOWhZWznr2tnKWoFBVwvx7MsQXFy4l9K8zGZ0w6WuldAeL2Q8DSJVfh6que
         UzPYJhKosKvVRNs3bRtXiK8Ivfm5Ro9Vbhxh+qbEvwm/J5dDgCwsi2ioeSDyjAyb/x
         X6xmVyVJsqd1GYMNOBID2Q1Ob7HF2RWtCrfkGpIK01mTAdZ8C8ZBkxb5KtEoheo32n
         bbWhrIA/Gm0DNZ4OvUZ8EhKWkd9ufdGTK5v++946Erm/UTinB0c8hSTfQGMZFP992h
         2LiUQbFw1QdMmEGr3mBfCbO+sJVBV9jTXmUaty51O3OQ6PsTHpBIEomH99BMqBZ879
         jHwgxy79tQCfA==
Date:   Thu, 8 Jun 2023 18:26:28 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 2/4] leds: simatic-ipc-leds-gpio: move two extra gpio
 pins into another table
Message-ID: <20230608172628.GI3572061@google.com>
References: <20230524124628.32295-1-henning.schild@siemens.com>
 <20230524124628.32295-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524124628.32295-3-henning.schild@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Henning Schild wrote:

> There are two special pins needed to init the LEDs. We used to have them
> at the end of the gpiod_lookup table to give to "leds-gpio". A cleaner
> way is to have a dedicated table for the special pins.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 28 ++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
