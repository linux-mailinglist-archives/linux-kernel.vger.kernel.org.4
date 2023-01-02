Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6265B4E6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjABQNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:12:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4F0B1DA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:12:51 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F06181EC02FE;
        Mon,  2 Jan 2023 17:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672675970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x7rLbZXo7OxZxpV0g9xNWHdBUSxM9KFRoLhg4kOvceE=;
        b=mkfMuDwM+wplxOHS+QdDcbogSORUrY+mFrYuOdn+xldbOEgbPYmNiTzdMO8NjfGaRKhIKT
        OGlzBMaaeYENdojZiV3x2BlRoxFPDgu85kEHrrN3bjiaexuD8XxDNBPZmd/Fb0oPYPjANx
        l4kzCJbJ5g+hsa4nFKkOwuyAbJMuIIw=
Date:   Mon, 2 Jan 2023 17:12:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
Message-ID: <Y7MCgS9Ix7qcLdct@zn.tnic>
References: <Y5oy0vwZQAwzkDkr@zx2c4.com>
 <20221214203454.337299-1-Jason@zx2c4.com>
 <20221214213015.GA16072@ranerica-svr.sc.intel.com>
 <Y5zRTqDmjeJzjeFf@zx2c4.com>
 <CAHmME9ojkPUV-acD8o1rFsfR+f7URG8PW44GUUt8WUK0O=KD6w@mail.gmail.com>
 <Y7L4n0imic1ncHhe@zn.tnic>
 <CAHmME9rMTNQ+hZPG1cbpP2zA6Cq3-f=gXXPF3=WYhQWicEYV4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9rMTNQ+hZPG1cbpP2zA6Cq3-f=gXXPF3=WYhQWicEYV4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:59:08PM +0100, Jason A. Donenfeld wrote:
> Rest of series is intended to go through random.git tree, so it'd be
> useful to not have to carry this there -- less pain.

Ping me when the time has come and I'll ack it so that it can go through the
random.git tree too. Provided there are no serious conflicts but we'll cross
that bridge when we get to it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
