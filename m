Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD87220FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjFEI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFEI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:27:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09AB8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:27:43 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C8921EC059E;
        Mon,  5 Jun 2023 10:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685953662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5ESqb6au3zflhH6aVF9c/3u2j+kWDm9X4n6YuYgBbC0=;
        b=LVjDtREzG4ISSfs9QMyMB+Y+FVHrrKWxQeidNLy3ZP6zRFBWr8XzcmjQ6gidYx6Y5cG6/V
        FI0n5PzF/6ylxpSmcAyksTW7f4odqctbQQghj9F+8QuoJWe1EgO8i688mEZLQBTlAqEBSa
        ztLzEw7TVkRXBv/XvRfh4SbUXkj5ne0=
Date:   Mon, 5 Jun 2023 10:27:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        xiexiuqi@huawei.com, x86@kernel.org, liwei391@huawei.com
Subject: Re: [PATCH] x86/microcode/AMD: shrink the size of amd_ucode_patch
 array
Message-ID: <20230605082737.GAZH2cebuy4a4JPGhL@fat_crate.local>
References: <20230605071256.1813504-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230605071256.1813504-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 03:12:56PM +0800, Zeng Heng wrote:
> About the commit <7ff6edf4fef3>, the amd_ucode_patch is expanded as
> two-dimensional array. When CONFIG_MAXSMP is enabled or CONFIG_NODES_SHIFT
> is set as 10, this array would occupy memory up to 12M.

So?

That's a conscious user decision I presume.

> Here we allocate amd_ucode_patch array dynamically in need instead of
> static declaration.

Looks weird at a quick glance.

Anyway, I have a series which gets rid of those arrays altogether
- I just need to finish it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
