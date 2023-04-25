Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A96EE6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjDYRcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjDYRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:32:48 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD672A2;
        Tue, 25 Apr 2023 10:32:46 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-14-243-nat.elisa-mobile.fi [85.76.14.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Q5Tbb1zXFz49Q1p;
        Tue, 25 Apr 2023 20:32:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1682443964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lbrxOnN4RUlQpF+DUNLaZwqcHrQk40EoKmo3esYa/jA=;
        b=U1KQ948AdfqrPZ7fcQPrqJkibPgm3Hh27BClFMsbmHXbSFN0YhjvSyhbc9PM+On/mOuRG9
        esUoYinab/eeOC/GSIuAElNvjmYjD9pL+OUE6wlH4EJYW7W++reOcq4NiuzmHuKEw3iJ9a
        sJCKjLZYkODyuSx5lANzhrj1zVMr5Bj2sjCgRIqN/xhVY/8tpHvHdfR+kFAp/FzXJeJK+T
        ONOmGA4AdL28sRibkvOpCeoqx+xoofWMkiph3X3pG+n6gVFQpi49QgdHzO71Nu8mLJfC1c
        s2XgNgzAY4QzjSJV+vaGG/Zc8HJbXY0JBvJ33ePYlTkHDfnOLiwecuMPugXmxA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1682443964; a=rsa-sha256;
        cv=none;
        b=nbr+6nkvzNhF9bpjcjoCKKgredwk0TYz0M4hiJPRHi3HaDWDmBJzdY3N5zZPBjWy11oXGd
        +N1jArD5Z3I9rJW14NQeDveRIi7A7NpBkc1L0Zwz0bSm7eBTsz9Pd0QB7lPsL3t6YVi0GJ
        RPHCVSiCHu9xBGLhR1dLZtn5ULgwe+pVSq8dpD5CeqKUNUhIFdD79A1ktB5KfENbakUhIR
        FbLeCzAXUKFFPK12vcW4O47X3g66Gq17B2zTPMu/MosfQ4zaITzhiLp7xK1u2oHWSyDt6f
        XmjvzWm9zyx+tT9JGcuF3hvgv3BJq6z+/83oTk83WMjsDVbZmZY+8opjvLBFbw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1682443964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lbrxOnN4RUlQpF+DUNLaZwqcHrQk40EoKmo3esYa/jA=;
        b=Xv694WbwM5khTimG9/hw/LL0UCGAwhLbA69rA1ApcmS3Tc7g/Gm5GUGQqNEmvA4eJZn2VI
        6Diqhl7TpmveruuOGt3Jo1Yk3qDsI4YO1pmiISLLZGHyPlGHtSlEZunEctTQNUo1t0BBT4
        KQQ0WH/SMF+UDwUOr0gYm/0YoWSO7n5xmqv8WAbkQ2G508J45N5c5QcNv/seSRqn4ffQMD
        fRWjvzXMz47yrsXbQJo41dpChV8ZkAaaITwdzJZnrB/WRrR5M3Pq/d8DWp3omwgeYKQb50
        mOW/cl+AybV+DFxk1P2t+q9nYIQNDd4ylrYe3zw5mydn9qNhIzOeYy4ufxHFSA==
Date:   Tue, 25 Apr 2023 20:32:41 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems GPIOs on OMAP1 boards are somewhat broken after:

commit 92bf78b33b0b463b00c6b0203b49aea845daecc8
Author: Andreas Kemnade <andreas@kemnade.info>
Date:   Fri Jan 13 21:59:22 2023 +0100

    gpio: omap: use dynamic allocation of base

E.g. on OSK1 the ethernet IRQ cannot (omap_gpio.0) no longer be requested:

[    0.277252] Error requesting gpio 0 for smc91x irq

Also the tps65010 (still using static allocation) will now conflict:

[    0.400726] gpio gpiochip5: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.400848] gpio gpiochip5: (tps65010): GPIO integer space overlap, cannot add chip
[    0.400970] gpiochip_add_data_with_key: GPIOs 208..214 (tps65010) failed to register, -16
[    0.401092] tps65010 i2c-tps65010: can't add gpiochip, err -16

I think this change should be reverted until the board files and other
gpiochips are fixed accordingly.

A.
