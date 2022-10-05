Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E297E5F5562
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJENaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJEN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:29:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1EBA470
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:29:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664976592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSSwYd6bNGmbm7XR1pdYVuGlgLSwQidyg20JnQan5Iw=;
        b=Cs8k8+OGDvgHiVyruHBqz8gkI4o/qRuqJJrgIV/hlA1ejZjrgawxQSSIMG/+Be/nGr49NA
        rhR/Yd8g+GZqdDI9mxBswpMmHppc6qehVPpCpXVRLdcI7rlahJbug4oY2RDm4aaFrBav6A
        vyk1DFPbv7Dpn6Mv74VjeEDcEzdnLVNG/AZNGtoF+pmyulhaV2zLN7ik7uYx/M96yvqCZN
        shOot6k3zTl/wgEB9kvbdQM5ZumemXu6lbvlr9blqjHpMM2YlzEhs2n48HANMVg3VMonOS
        qEmxWXRGG6zMMa1wuxyPbpnKK3QudcsBfsNRZ+m5tPcTMj7KI4Y00zteCNadKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664976592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rSSwYd6bNGmbm7XR1pdYVuGlgLSwQidyg20JnQan5Iw=;
        b=HAoSXkCh7FSr0W/t57leT0N1I5E1HI27lBWiKB08Ei+FxyO8edwLz2Lp05YIxqBAYLOHNO
        HCJ/a2MGuNjcmjDg==
To:     Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] debugobjects: Print object pointer in debug_print_object()
In-Reply-To: <20221004225817.GA2749300@roeck-us.net>
References: <20220519202201.2348343-1-swboyd@chromium.org>
 <20221004225817.GA2749300@roeck-us.net>
Date:   Wed, 05 Oct 2022 15:29:52 +0200
Message-ID: <87edvmtn3j.ffs@tglx>
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

On Tue, Oct 04 2022 at 15:58, Guenter Roeck wrote:
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Did this patch get lost, or was it rejected ? I don't see a reply,
> and it has not been applied.

It fell through the cracks. /me adds to pile...
