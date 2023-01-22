Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67B567721B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjAVTpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVTpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:45:43 -0500
Received: from out-131.mta0.migadu.com (out-131.mta0.migadu.com [IPv6:2001:41d0:1004:224b::83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067431E5E5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:45:41 -0800 (PST)
Date:   Sun, 22 Jan 2023 11:45:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674416739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KgLTxdHTOgbtZQNx5baSrY4zTYjCTjxoM3RFmiywedg=;
        b=EigLJ9iWc4ckwS/9CbQ9/yTnRKhbX2amSAczf72JUpOLt5CKBPNdXuS54it8sj/HJ6xx/B
        KhZcHyDoKPaLoTMcsPAXPKuOyDzi/a5hQBGa6v82QE37YYN5OFwsazjZjxxn1Ox9IXiLcl
        WGfTpHpUk3EZbadh09n0fCUhM6x/YmE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v7 7/7] KVM: arm64: Normalize cache configuration
Message-ID: <Y82SXJDCmXfMFtdQ@thinky-boi>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
 <20230112023852.42012-8-akihiko.odaki@daynix.com>
 <Y8meCFkrVXurXlTk@google.com>
 <86k01gm6ys.wl-maz@kernel.org>
 <Y8wru2IrgHtBIofM@google.com>
 <0ac18497-8392-8ea3-05ee-7f2377a4374c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac18497-8392-8ea3-05ee-7f2377a4374c@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 02:36:39AM +0900, Akihiko Odaki wrote:

[...]

> I was so careless that I missed two bugs and failed to test the last version
> of my patch. It is fortunate that the bugs were caught by careful review
> though we don't have a strong type system (yet).

This is the exact purpose of reviews though! We make these sort of
mistakes all the time, so nothing to worry about. Thanks for your
responsiveness on this series and for quickly respinning it, very
helpful.

> Your tree looks good to me.

Thanks!

--
Best,
Oliver
