Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAA74575A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGCIdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGCIdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3498DD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6030B60E73
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF6FC433C7;
        Mon,  3 Jul 2023 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688373194;
        bh=X5VfDnbqCcPJEZik/4j9K5nnRYzFSOO4lymDpqs6bqA=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=ABiQRjEtnpqBUsrN0fT5t5WyoQYRxurLc2aJy8jwEC0Kg63sfYBlkQDe/GA1u2+uz
         lYsMNXbV1fmxmte/IZIU3JcncQgW1VYMfAY3oeeGboGsfMKigQCQ8f1/bNS3FpWOlt
         jA3bgB4274bAYsXgILl1F3IKyUkeYu8/7mRaiy4iMmtfzrvybQhZpcN4t7Li+LafjK
         dPP8TJk6VpSKoUIogbRPhuZ2rfNZLGLn5ZiVINsH4sa77P6ufD/gNilnWapftR3J+V
         QhZBwelnhyADe3wbRDRwd+p0mAH8oFRM+SwYQE6lcHVeS0NsUuv3zuBb8bSpJ39zLc
         Z3ffwEX8cN3xQ==
Message-ID: <b24c27d0d32ca8ca4c58773e2d45b8a1.mripard@kernel.org>
Date:   Mon, 03 Jul 2023 08:33:11 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Mans Rullgard" <mans@mansr.com>
Subject: Re: [PATCH 0/3] clocksource: sun5i: clean up and convert to
 platform driver
In-Reply-To: <20230630201800.16501-1-mans@mansr.com>
References: <20230630201800.16501-1-mans@mansr.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, "Chen-Yu Tsai" <wens@csie.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 21:01:25 +0100, Mans Rullgard wrote:
> The first two of these patches remove a bunch of duplicated code/data in
> the sun5i hstimer driver.  To keep the diff clearer, the first patch
> introduces an otherwise pointless struct which is then removed in the
> second.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
