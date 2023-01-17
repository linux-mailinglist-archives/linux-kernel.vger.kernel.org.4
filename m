Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4A670DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAQXfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjAQXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049F38039;
        Tue, 17 Jan 2023 13:19:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1f5gUXW4GdEJ2AELrjEeeLKUWa1ivUIeoHpyGlEGpk=;
        b=BkU3Rw+8ut8ppbytKf+MibQd+Et2Aa3VO2WYxbtoKvAm7D0BMdq9bHWQ89nAiei+wCAA17
        AvNOLZnLNSjozxFEwHAHHRcZdGkNmxxuoIM2+SQQm4JeW4KWBZ4j2W0iGMi8iBZK9eW19Z
        9098Nog8XyJPEs4kCwyvW6UjF24EwjmhrmCRs6XotbJB64rt522YOd17hNaBN6OP8YFKx4
        b2oPkCPJr6MDledvDNlK/Mm1iQGgbCm16rkXa7DCfkhbb6cMzncijQcPZHq0aWF9Jy9wO6
        1/855I4mWlRjMm4hPJ7z+eM3s4DyzKkfBJTOqI74Ra9rC1ikylqgySJYElaGGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1f5gUXW4GdEJ2AELrjEeeLKUWa1ivUIeoHpyGlEGpk=;
        b=/dYMbeIHTnnYv/uIPBuybXtYmTYtzKQRsgissq2UwZbB+wl0riRj7okBMmnoFvB+r2b+0x
        5mfhEZCpRaaZBxBw==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 03/19] irqdomain: Drop leftover brackets
In-Reply-To: <20230116135044.14998-4-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-4-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:19:02 +0100
Message-ID: <877cxklv09.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> Drop some unnecessary brackets that were left in place when the
> corresponding code was updated.

This is really the wrong patch order. Real fixes first, then the
cleanups and cosmetics.
