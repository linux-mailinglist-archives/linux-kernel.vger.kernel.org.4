Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3472E875
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbjFMQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbjFMQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:20:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3CF1BD4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:20:31 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0338D1EC082E;
        Tue, 13 Jun 2023 18:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686673230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tpbtbXyLeQYoLfjUcfgWm4OL4rdUxKumNwgJovBAftA=;
        b=UVPQiP8H404iX31axmzImrOcg+fISSDz5kPPB7+EOfrZ8DUfBQMW7LAciGFTkI2njgUAuc
        R26qSoCgmI+vom3KYyYsj2co4SppwqSJo+97/2lmqp9gW+2qkTMp0wgetXy/4T7eKPodOR
        z7sFm2vWSAB+SdQDF7EE1x2+XihHf+k=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hiMaSmtiDnCj; Tue, 13 Jun 2023 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686673228; bh=tpbtbXyLeQYoLfjUcfgWm4OL4rdUxKumNwgJovBAftA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/vbW1a2cxNfP15bcVqqkE4imL/myChbLXIb2gnwUYDfp8NoJkgE3JlOcXpFz3gTG
         xLV4LkJJ1oPHUKqPtVQc+j8QC4LB1BK+sHXqkJts37VLLBHIso4U4lQhlUbjrxX0O3
         CVTIrXXryQfzVZnOqn0WPWwspcJVlL31C+MSe/BH+gbQDMcwdBdAxQt9DViz5f/Fhu
         CD32EcsQ3+10uE6vW6dbavDvoThQcfPSM8sUrMXnHrPuV2iBpHCpZ5EokYMxnK1hEx
         dhqLV+CwZQ7A77lzXBXQdNDLws+FqP6UtFzMmQYb2cZkwxVogNmBp8yRIQxCQQxDfi
         ErGoQTLcGzkyLWfANcNbaGAph0HrMfUPdymTuDEzDmaOKqldeP81OO9xqBF2id7D7A
         fQmvHxxlyutsWfIcYrgIWCRnbaHS3bxMWf3UB57WcOcVZr9WvhlZyqJ4WMg8P4/UBp
         GqUOSgzH/JzJExqnUYlmOB0Ufb1Kho9bjGEpaI2jYi/8UeLXC8xRjqGUytpiNf5y3q
         N1sbZTCRF8jv5pJPE3nQcsLXzT7wI9flmoTJwIXNOBIEXspZZYFgrHDT382/uUs/mK
         n7hZLRmm1w5rn8FBkBsge5jsPT7ogEKRaCGPjHwc75iTb81PYAQWCV8QwxBGDaO9Gy
         n9Q5c0rERtxUe7Ke/L1MWsKo=
Received: from zn.tnic (p200300EA971Dc5F7329c23ffFeA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f7:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D839B40E01E8;
        Tue, 13 Jun 2023 16:20:20 +0000 (UTC)
Date:   Tue, 13 Jun 2023 18:20:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     pawan.kumar.gupta@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230613162015.GCZIiXP1g3L83pNLGU@fat_crate.local>
References: <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
 <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
 <ZIdJs0F8Ow4sV27r@gmail.com>
 <20230612170532.GOZIdQXLYZCGKZQFXv@fat_crate.local>
 <ZIiTKttkucqiE8wJ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIiTKttkucqiE8wJ@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 09:02:50AM -0700, Breno Leitao wrote:
>  Is it OK if I send a patch that would disable these mitigations if
> CONFIG_SPECULATION_MITIGATIONS is set to "no"?

Isn't this the direction we're going to?

So yes, I was suggesting exactly that - add those mitigations to that
submenu so that they can be controlled with config options too, like the
others.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
