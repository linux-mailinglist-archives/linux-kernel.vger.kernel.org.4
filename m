Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B715EC6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiI0Orl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiI0OrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:47:21 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C0E1198;
        Tue, 27 Sep 2022 07:41:41 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4McMl23XQVz9sSg;
        Tue, 27 Sep 2022 16:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1664289694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hle7BXW0DUOW9Dhwj4zOfO58W0Wl815wU0dQKnC8baA=;
        b=j5e+8GSMEO7nezCrj45vqLoO195JT6QX20VJfjMRJj5b1fepM3ePY4OBU6mPp3tFF83Z4o
        gzeZpAlrjvB//3JSy3naubVVLaidvqXqgW0gPndMkDYhDSlexNbja53e2rfYn9s04Jnjc3
        9e8S332IH33RbmSV9QxPwXn28MQAGLFGAZWjTLWX/l/Fq30HfvxrgZQPHmZhiP7uDgx5j8
        QbW/lAChnm/kpjKB1Vulc3iln+ZVvVx+lALXgPrBRSJ9UzGZ2FLB4nDGYxQy3Gzd20uD2Y
        9BeCn55yOuHMooJzGeAYMDMSempOFHziFWzUVZ3ERJVvO/kppV3yQm+EhSr8ug==
Date:   Tue, 27 Sep 2022 16:41:33 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Ian Pilcher <arequipeno@gmail.com>, pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kabel@kernel.org
Message-ID: <31201714.100945.1664289693879@office.mailbox.org>
In-Reply-To: <20220926162503.451320-3-arequipeno@gmail.com>
References: <20220926162503.451320-1-arequipeno@gmail.com>
 <20220926162503.451320-3-arequipeno@gmail.com>
Subject: Re: [PATCH v12 2/2] leds: trigger: Add block device LED trigger
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 797efdee06b3c2a1f3f
X-MBO-RS-META: ya4tm8j7hnw34jssnnmbrbc6wfxuyi7q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Ian Pilcher <arequipeno@gmail.com> hat am 26.09.2022 16:25 GMT geschrieben:
> 
>  
> Add "blkdev" LED trigger to blink LEDs in response to block device
> activity.
> 
> Add LEDS_TRIGGER_BLKDEV (tristate) config option to control building of
> the trigger.
> 
> Signed-off-by: Ian Pilcher <arequipeno@gmail.com>

For this series on 6.0-rc7:

Tested-by: Tor Vic <torvic9@mailbox.org>

> ---
>  drivers/leds/trigger/Kconfig          |    9 +
>  drivers/leds/trigger/Makefile         |    1 +
>  drivers/leds/trigger/ledtrig-blkdev.c | 1220 +++++++++++++++++++++++++
>  3 files changed, 1230 insertions(+)
>  create mode 100644 drivers/leds/trigger/ledtrig-blkdev.c
>
