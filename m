Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A4F670DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjAQXfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAQXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E54B88C;
        Tue, 17 Jan 2023 13:18:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673990298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B62BoXuKja2yXSUTc2wRcK9JxACGJ+igWR23FLUv8oc=;
        b=NOA4LvchfsO8YIXl2kyGT9PjMqeeA1Iz172AG1mCYnGDU+bzkYd6fb2uJhgK9irhGOua28
        11tNfzgVmfZTTu9px2BdIRNni1QU8QJjejedNULa7UylqNFivD3bMLNpsgZ/nWiXgAZRm8
        WAt3nBzbdH/GHHYFcky4LQdhaK6ldzjXfOKVpPTsQY+ny1xiNMp0wpV9lahwccGfZCrQ8r
        vkHA6wTySMD+PUUxXQ7SDa7/klgQ+tNMB/nIpZtK2VlwVuLflq6P+A1AqVrXzcSs4T6xMT
        lf9f66/a7/8YgX8odis5U5Z7OTHQCefEo4E2AQpCAcUdJjHraW5SPAZG8Xzocw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673990298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B62BoXuKja2yXSUTc2wRcK9JxACGJ+igWR23FLUv8oc=;
        b=qgf0K2kHfrQMK7xtgbwsdJYKG/+9y6uekzVRh65BEOPsUMVHlcmEvNjhH/dwo0j2PawyFS
        sxWNTrKN8k15wgCg==
To:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 02/19] irqdomain: Drop dead domain-name assignment
In-Reply-To: <20230116135044.14998-3-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-3-johan+linaro@kernel.org>
Date:   Tue, 17 Jan 2023 22:18:18 +0100
Message-ID: <87a62glv1h.ffs@tglx>
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
> Since commit d59f6617eef0 ("genirq: Allow fwnode to carry name
> information only") an IRQ domain is always given a name during
> allocation (e.g. used for the debugfs entry).
>
> Drop the leftover name assignment when allocating the first IRQ.

Wants a Fixes tag too for the same reason as before.

Fixes: d59f6617eef0 ("genirq: Allow fwnode to carry name information only")

Thanks,

        tglx
