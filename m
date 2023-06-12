Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA172C603
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjFLNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjFLNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:32:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE1E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:32:41 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A7661EC040F;
        Mon, 12 Jun 2023 15:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686576760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M8WvkyNjJkr8h4loqT04EVexnrcX1BJj9fmJ/m/uFNI=;
        b=e+AGctKHAz89SxMfUQLQc5bEVMBiLdUbdqK37OdAF2i05S3nuP0dNpvGwiqBA1gwrqFetV
        gK1RWbK5k3DduNjWfvbTWmXRdRknITsAFC8+iuAr1CltODuINMfvOSDukvtCx5rVQ0I1hl
        WPWiDi2gVhBoEs7l+tbKHJMB/qigYBM=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zLpbemDgxUEP; Mon, 12 Jun 2023 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686576758; bh=M8WvkyNjJkr8h4loqT04EVexnrcX1BJj9fmJ/m/uFNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hasGth3iQ4VtIjSp/bvNzxnZejWQioNFjdnfunukaVAiNTqNOu43NETPM37dPSiIb
         7xhYyoRFTqdjj2Dg/Z+blwtheiq6sBIdaNOrQIA6Y56v07mXK7KtbMi+KKmxCgZtHm
         ANJI/kHGM3vtHKcuuN8XGHDaucLsAwii2CojYXrC25q5/Stg320mUcOWwecZJh6Xx9
         HNEFs/FQ4m3di3h81jJoYz7mpWpomF3q0bRoecYQKoEGJRsIEa6jx9H76fEPS7n4hm
         zmrcjaXnrf3yB5PMK055VNe0xT4m7V1RJlC2Vn1Ukx128K0DmAToQXEn4EBjHKnSFt
         B+r5Yq19/Jlls44veBT6tVDAQJcdpWYfVsIB98tKxO89n6+Jwv4Y/YVTzp7cc7ilbw
         Kvr9nVc8Z/GX7gR1P1BkCXa1lQgkFi4qc/nqkTnKSwKbOvGzPNUk0mBjqB/Fey8Pos
         MK9hKs7QG2PE0glUIF0SPit6XRk0JWSpsbPVYBPU/QK+ht7f/1UVlhJv2Oq6bAiIwK
         yLzWUfdHgnv0aHOHwndJrPMtqTIsPZK/8YFwuixe7pDOYsapv20LIyGUJeJsZm3mI/
         9r5aWQ3+Y9gC19i5di3cREfukKxG8YQc1X7nU2XkJxzeAVFhBvLqxgjIq0wrchFn74
         9Ie9ujvJuRs1gxgzJM1bRthk=
Received: from zn.tnic (p200300ea971dc5f0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0377340E00EA;
        Mon, 12 Jun 2023 13:32:30 +0000 (UTC)
Date:   Mon, 12 Jun 2023 15:32:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Breno Leitao <leitao@debian.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIcVoIAQbRl1GTo5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 05:54:56AM -0700, Breno Leitao wrote:
> 1) We keep consistency with other CONFIG options. Linux already has a
> CONFIG option to enable/disable mitigations for speculations
> (CONFIG_SPECULATION_MITIGATIONS), so, this will be a similar one.

So you can get what you want by disabling all those options there,
right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
