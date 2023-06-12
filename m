Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E584972CD99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjFLSNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjFLSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:13:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DCEE69
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:13:32 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9FBD1EC0304;
        Mon, 12 Jun 2023 20:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686593610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KemjcYATQSnwZJl3W6y+qmeLHHLb2n7gw7s7m+Gi6So=;
        b=ZugQp6MfuMwQ1ljhidgLvYDvIi42Kz3wjpVtfGJ8vh+QWS5IsM0Hk8uYuZVc/BLIcvvUoP
        CjckKwv/Tjmx/McvFIz8NMEZ6Y58XCYtTCmkacbNYrgskQC4XmonIM6ntV0QvHUq413qd1
        Zx5DynWEhNGmyC/ADZPoJQCsDQrR8sI=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7m8DI5wYk0rk; Mon, 12 Jun 2023 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686593607; bh=KemjcYATQSnwZJl3W6y+qmeLHHLb2n7gw7s7m+Gi6So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+QJEv8z4uHyD5JGfUKcKC01sZRvn9bp5bZl1vyAbIqL79iEKPi2NNygF7fWd6bfp
         hpU4CNFLiZeReGDF+dYdaB1LJ6hhQoq2a06sWVq65Po7jbOkN+C50oRt8c1VW5SwPq
         zqtDTOScLShnueK7sONMNVzTJHUIwnPSma553bFnspC4UzaxhKb2Rz14fB6b63Gzx5
         PnYV4+4/gw9DeUqufPmCEPMkuFj/oV7nBJ8WlRFLtApBTShEgzQ/vkH3tweFtUqK9Q
         2IZ4K2Oi8XQIsqoffQ7fKt+muBZ+spLEg8RbF5+XkQD0gKnQkcuum06BIKkO1Ip+5C
         ZfES0UYLdaD78Oe1qGsTQFERLs5QmAWhuIPLcgIYN6k7CuXYXPT+uo+LKOdVSkZLrg
         3hE/CkU4ahcQkNnHXykuYt92IKrs/0q8z9fZESkkIAOVhutYLWzYo4QH1rMEx6EkfT
         147o9j4ZpBdOYpIIxfYgffEUjWVPOZ/Z/DU8Hx/ouJ+qzL8oLAm4b2vhhjPPgAa3wq
         hxt36tpKY6vesRpmmtOJcruCFK4WbteRUV88vJ+LzG1TwftJ8OOl8l5pgo01ckcRLQ
         qDgXf+YKeq+OlzO9pAKFPN+pQWselIrOidg6rpPO8MM3B90y8dcsOio9VWCvxEm1/V
         0Ag1gxaDc1eHK1c69ClXsSmI=
Received: from zn.tnic (p200300ea971dc5F0329C23FfFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE7C840E01D0;
        Mon, 12 Jun 2023 18:13:19 +0000 (UTC)
Date:   Mon, 12 Jun 2023 20:13:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Breno Leitao <leitao@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230612181315.GPZIdgO2jz8ZZwU1vY@fat_crate.local>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
 <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
 <3289c90b-afee-67b9-8143-344afd47f1da@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3289c90b-afee-67b9-8143-344afd47f1da@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:06:35AM -0700, Randy Dunlap wrote:
> >           If you say N, all mitigations will be disabled. You really
> >           should know what you are doing to say so.
> 
> I would say:                         doing to say No.
> 
> Was there a typo there?

I don't think so - it reads right to me this way too. Yours would simply
make it more explicit but the "so" is the "N" at the beginning of the
sentence:

"You really should know what you're doing to say so, i.e., the N".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
