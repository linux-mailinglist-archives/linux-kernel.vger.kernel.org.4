Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF21C65A369
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiLaJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:48:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7176D2D7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:48:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49A6B1EC04AD;
        Sat, 31 Dec 2022 10:48:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672480101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wereH6LHdBUC9kDDyzTdxHdgO+FIsA0w3UKr8l/p+2c=;
        b=oBEx9t+2nMWbl4wOSjExVFfM8W6KgpgcubJTWInjr+IwcCqV0JFuv7XEmHZwb+Lga+3sSX
        RUvReFUOumoCd7uYviKZSfbIav6sfuiqwrsCg1XUgbcgUs1Zu6em0bOqDl+VF/Xi7tfn2G
        w6FADtP1YWCeqYvWQCi+EkKrVXqJjPY=
Date:   Sat, 31 Dec 2022 10:48:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7AFYKWPRXYs7S4m@zn.tnic>
References: <20221228143831.396245-1-Jason@zx2c4.com>
 <6cab26b5-06ae-468d-ac79-ecdecb86ef07@linaro.org>
 <Y6xvJheSYC83voCZ@zx2c4.com>
 <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com>
 <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y68K4mPuz6edQkCX@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y68K4mPuz6edQkCX@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 04:59:30PM +0100, Jason A. Donenfeld wrote:
> I'll attach a .config file. Apply the patch at the top of this thread to
> qemu,

Hmm, so the patch at the top of this thread is fixing the clobbering of
setup_data.

But I tried latest qemu with your .config and it boots ok here. So how do I
repro the original issue you're trying to fix?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
