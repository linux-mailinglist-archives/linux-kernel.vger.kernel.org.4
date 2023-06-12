Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF272CB05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjFLQIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLQI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:08:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424CC19D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:08:19 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45E8D1EC072D;
        Mon, 12 Jun 2023 18:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686586097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zrbsNxDnJRtTxc6c9QhYYJ2Bz3vlWauuasGnY6lhGN0=;
        b=SnepkEK/854n1WRAhIIJdcoJiJpWCatl5E2vHwPg3Dbq8r1bjR/3ByGQLafEmgGVMuzP2q
        SqmbLc4CYQfmZvVVLbpNVgIU13FbczKNes3y5pyJc/tIHUmUrrrD7CQ1sGTjucjBqke6ty
        QG8DQ3STLbZ5rUS4fDcT6Gp1EB1hhY4=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id exUKiuxAec4K; Mon, 12 Jun 2023 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686586095; bh=zrbsNxDnJRtTxc6c9QhYYJ2Bz3vlWauuasGnY6lhGN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWEqEHu/YjaFqfs1wPsnotJYCXGKwcxXL8FFlacICirBtm0JOmEAcQsshWY0IOjqq
         qtTrYrDTFv2Ai9k+PZJZge+PVbNilCJC2/VLmbW2ju99K5cB67esvTtqsCnX4iEL31
         5AN85imAnhrWfZ/Ri1NJcDcPnQdtrV90rEVbyHGLQ/S89h29WtW4NmXfoAapHKOFKd
         BhTv6iducRQZrCy6fY14h3PNxEbweXm56NjLk5pNSMEGm8g7ofqs2T9wdha2IvF03A
         FeiNzN8vOW+syS5gYkjBDnqMvd1aLCqCwiIJnocp2ez4NSdtYJK/JRkrFiUBL1myS1
         FbLqIWbtdhaSNX424Yzqa0Q6RFnkMJUK/MTc0kgVVxyUoO5cv8Jfjke+kKGbACX+oA
         zMfnwG9jCTl6QmFaeBldO5SzrlbC2XD3uGF+1MPMAECfYXEZWN+c4pItP7TREN6Hmt
         aY+iNXg3bHgnwC1bzuzdPDWg2+jpRNF7b4bsLq5kBLx04sgpBaPl7VVa9OLn5gSFAz
         ZOAWKElvl+KoHKLX2I1Q5cl1HDxCBoUiQhCNqanHmeDVoDyL8EGmY/2jre/3irt0ei
         gTpRMY+ycBnnesibhmgnTeaRcWO60CWIQHw7qQiGLlIuE2nQ+vBjtrytIQAukG0x0+
         Eiaf64bvmwG7ALBnwgkMwYNE=
Received: from zn.tnic (p200300ea971dc5F0329C23FfFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11C6E40E01E2;
        Mon, 12 Jun 2023 16:08:08 +0000 (UTC)
Date:   Mon, 12 Jun 2023 18:08:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIcoss0r/898/CpH@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:16:18AM -0700, Breno Leitao wrote:
> Sorry, to waht menu specifically?

CONFIG_SPECULATION_MITIGATIONS

It even has the proper text in there, warning people.

menuconfig SPECULATION_MITIGATIONS
        bool "Mitigations for speculative execution vulnerabilities"
        default y
        help
          Say Y here to enable options which enable mitigations for
          speculative execution hardware vulnerabilities.

          If you say N, all mitigations will be disabled. You really
          should know what you are doing to say so.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
