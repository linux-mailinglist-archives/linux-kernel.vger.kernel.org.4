Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51C65DC6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbjADS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjADS62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:58:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F6813DFA;
        Wed,  4 Jan 2023 10:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95DD1B8189E;
        Wed,  4 Jan 2023 18:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC6AC433D2;
        Wed,  4 Jan 2023 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672858704;
        bh=3vVdpC5QMDKOjWmTQ/3/rRhszXXRqwxpzpXtVyl2ErM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCRON46YeHs7jNdMfdhH+ALgawFnY0kpHgtnHzibpHnwEad3oX4X0nC2+1J7MMTX6
         2RXIXGRTQpCNMcfQLXZ8m23hB9NTdaZBuUmupfZmg6rDsO3PozDpW5U/g97y1GuTjn
         h/Rxnpxcz3whYsdH+pefrXZit7Zk1TJS2rp2mdxnVRhaCqSHTVxELKMvFPh33j8dru
         zkA+pR1tJ6dR4ev8TktVTJI1kGO34iBW7TGKr+w1orRJQ9cu0Fo2tsECUvFhbJ3Cp7
         wt9Vq0qBTLUwH7G7krR8wIbvTTVT+dtuUHdQFaOi057xHDyk4u/Z2IwzIOLoE3UT/z
         KODpDyecyachw==
Date:   Wed, 4 Jan 2023 18:58:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: led-core: Fix refcount leak in of_led_get
Message-ID: <Y7XMS64+HVcbq+hn@google.com>
References: <20221220121807.1543790-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220121807.1543790-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2022, Miaoqian Lin wrote:

> class_find_device_by_of_node() calls class_find_device(), it will take
> the reference, use the put_device() to drop the reference when not need
> anymore.
> 
> Fixes: 699a8c7c4bd3 ("leds: Add of_led_get() and led_put()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/leds/led-class.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
