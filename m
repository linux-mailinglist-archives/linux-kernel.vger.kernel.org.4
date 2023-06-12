Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7054672C5E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjFLN2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbjFLN2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:28:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39676F9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:28:06 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB2891EC040F;
        Mon, 12 Jun 2023 15:28:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686576484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=njf9YHC8JISZLfbCzwCUNJGQ9a0WijUKe4PV7A1Cj7Y=;
        b=c0lec0OEfa9fGeUWHGfJ9kvAWIOj7TZVdy5kgV15D+YsYk5U+mMzzMlErgLt3HFbgNKeRe
        Ev1ePej8UMN5xVd/FFuT8zkTIr9POj0lAKIsXXRqg1CCOy+ApEte0vn/63kZ2tAqtfhMtw
        KDcIbLqXikGPcpvj4pcO8aPOSd1c6GQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zjl25ExdrYrz; Mon, 12 Jun 2023 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686576482; bh=njf9YHC8JISZLfbCzwCUNJGQ9a0WijUKe4PV7A1Cj7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBT03tTL3n38+WHrS83EnyYrn9k+7ZLuTVv35cy2GQA+TCpJtFDKVvN9bd/savWQG
         4cANOTBT51+sXYldRVGXF0Fh2vsePuXTHI9uspBvmELagDdV06xgMzEgdNhM0o6t96
         HlRg9AKVM1OKzuaW3vL62LemWwrZL80Efky2EjqXREpNM1Kq/UkJ+pEG0Q7q3hil0t
         FtrHfAJ2tkSZ91RNFKC6RzLCYHHRSh0kM9AS5s8jixhLlu0CCoq84xNpvszQlp77+A
         7vaejbyh7/cARO+fcCtaYAs6RRH5XfUM8eNElS16K0umH/qM+GMog/kkWuuLMJndN1
         F73N2Fjm9e+bQkUNMzi9fNeTFo5h4f6Gbb/+fvDnAPkerzPOzmWTVAK3vjbgtVzVOz
         aSFmpSbCRELHHv1Pig/QAyc/IQeK+XAQLzf9w+WI9fBRd6c64uGP+OObyuYNHVOnJv
         6JPpVnM5Ma88ONUatlpvoqQxNLFk+QrBi/S4N5bIxEJ8ColJMQ6ZkKelz8a4aEa2mc
         Bfq6hTD0uELWh2HC56+ew7ZgoMDQb3cD0AAJPvri1szqjxvEdrDnP5r30b9BVZzNqA
         xiQHp6FMY1Qm9vJmvmDW5L+QxZmLLuN+r0+b8XOpNlq1lxp+hqgXz8ipqID1QU0CUJ
         AuCxaaAvYqEP4a98hYSE1voM=
Received: from zn.tnic (p200300eA971dC5f0329C23fffEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69DA840E00EA;
        Mon, 12 Jun 2023 13:27:54 +0000 (UTC)
Date:   Mon, 12 Jun 2023 15:27:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Laight <David.Laight@aculab.com>
Cc:     Breno Leitao <leitao@debian.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "leit@meta.com" <leit@meta.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230612132750.GIZIcdVmvWkQXu/85B@fat_crate.local>
References: <20230203120615.1121272-1-leitao@debian.org>
 <20230609173343.GDZINid4EgJGnkW7HK@fat_crate.local>
 <543116e1a8cf4b7a8b086c850374f99e@AcuMS.aculab.com>
 <20230612115154.GEZIcG2tWkn8I0+E2t@fat_crate.local>
 <bdcc00582da6454ab7e5778ad108a1d7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdcc00582da6454ab7e5778ad108a1d7@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 12:16:19PM +0000, David Laight wrote:
> I do (and I compile without page table separation),
> but some of the run-time patched versions are not as 'good'
> as compiling the code out.
> It might just be some nops, but maybe it is worse.

"might", schmight, ... other statements without proof...

If you want me to take you seriously, explain in detail the problem.
Otherwise, I can keep on ignoring you.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
