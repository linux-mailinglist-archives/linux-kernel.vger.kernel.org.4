Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8DD671870
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjARKCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjARJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:53:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338B15567;
        Wed, 18 Jan 2023 01:04:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CF8861734;
        Wed, 18 Jan 2023 09:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91599C433D2;
        Wed, 18 Jan 2023 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674032698;
        bh=Og++GJb7hTbwoPbP/PbiJ4khLA5V7ZfC8ZOMe7Q2oZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onJ2d5SBJ3KicWcxuISKEZT7OC+yjoOjMYNpXkzOF27Sw+/vekm9D5AVL04vwguKX
         kiwMGVYZ6Snu7m60/z9LjxONpccDUYHmJdKb25OWSMswXpZm2mfnWjLi7fE5XVor6L
         Yv6vF8K8XQ8o/l3tSpkfur4wgRK5MXXKNQKnN1D53/pr4m+SwZ3a44ojPoeTAG4M26
         KVk4aOp6YJE8xmNi6vwBlVUgVp9+c83JN/3xt0s0aYKXoHsPMc1PGC9Z2+8ESRGbPj
         IE4YnyeW6hJ8XQV02EqOuEY740XzYR0IzoAecPbs7FcIhWAIKtpSWLtiazZuqk3MKC
         M1dOIEK7kX6YQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pI4Nm-0001Is-Mt; Wed, 18 Jan 2023 10:05:22 +0100
Date:   Wed, 18 Jan 2023 10:05:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH v4 03/19] irqdomain: Drop leftover brackets
Message-ID: <Y8e2Ut3xayFUcw+f@hovoldconsulting.com>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
 <20230116135044.14998-4-johan+linaro@kernel.org>
 <877cxklv09.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cxklv09.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:19:02PM +0100, Thomas Gleixner wrote:
> On Mon, Jan 16 2023 at 14:50, Johan Hovold wrote:
> > Drop some unnecessary brackets that were left in place when the
> > corresponding code was updated.
> 
> This is really the wrong patch order. Real fixes first, then the
> cleanups and cosmetics.

Yeah, that's what I'd normally do. Perhaps I took Marc's:

	No, let's put the code in shape *first*, then add work on the
	locking, as it should make the patch simpler. Backports aren't
	my concern, really.

	https://lore.kernel.org/lkml/87v8rhwf9r.wl-maz@kernel.org/

too literally.

Johan
