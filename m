Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA9721AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjFDWwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjFDWwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:52:53 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A30DB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 15:52:51 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685919169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hZu8IphVkXP9p8je5/TGN5Q4I1XkOlHWgIEOsgSzKFI=;
        b=hTvGDqLq6BYRLHbNUcWTKH4QWo4M9RaYlESvNV9Iwq+NqX1w1ikLyKXfcdp7w1IFRJz9ln
        LkcLixRVpKJVJ+HMymmq6j1txO5jrzpetQQkSFXbWnS7KV9C9mGAyUCJXV/bXEE91NXwKe
        P4UjgpkgF1omIvhIrb4N2C15ggHzSuTLfy0kcVYgtVelN5iVXcEgrDGasGAhcYqr7Q+pqh
        wQZ8/7lO9heSsBFaG+qVoYB6b2xtP2kjDfbAkTVZLQ9ScH27MJbxLssFvitD3oxUVNPahv
        DS5R8o/AOX2I9w1X67EDUzI+rII9IBld1c0orGAJAfAL3XwIQALHoKwMZP5uMg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D215DC0003;
        Sun,  4 Jun 2023 22:52:48 +0000 (UTC)
Date:   Mon, 5 Jun 2023 00:52:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] i3c: master: svc: fix cpu schedule in spin lock
Message-ID: <168591905816.3958179.7662256666359712472.b4-ty@bootlin.com>
References: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
 <20230517033030.3068085-2-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517033030.3068085-2-xiaoning.wang@nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2023 11:30:29 +0800, Clark Wang wrote:
> pm_runtime_resume_and_get() may call sleep(). It cannot be used in
> svc_i3c_master_start_xfer_locked(), because it is in a spin lock.
> 
> Move the pm runtime operations to svc_i3c_master_enqueue_xfer().
> 
> 

Applied, thanks!

[1/1] i3c: master: svc: fix cpu schedule in spin lock
      commit: 33beadb3b1ab74e69db2c49d9663f3a93a273943

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
