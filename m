Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB2631CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKUJdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKUJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:33:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92CE101FF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:33:12 -0800 (PST)
Received: from zn.tnic (p200300ea9733e725329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e725:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74EC41EC053F;
        Mon, 21 Nov 2022 10:33:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669023191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zhZR9E8D+GE8Df/7fVNIeKOxxDo4AIFGKHQTkCAiLJo=;
        b=ql1XJAVIBV1jB2+IwLffBsii2+SjZLgIcWyIvg1LE8fZfh0cd/kiwZb6e8gxwIAI/oFQVh
        5ZbNyEYZ4f/+cbxypB1Hrb7GwBP9qaAHT0MyhTSdxIRJxlgL9kAgumCQhNwSWoXZ70h45A
        C2568p/CPBNnlPdgk+qoGV4HzHbayZI=
Date:   Mon, 21 Nov 2022 10:33:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, Yu1.Wang@intel.com, conghui.chen@intel.com,
        fengwei.yin@intel.com, junjie.mao@intel.com
Subject: Re: [PATCH v2] x86/acrn: Set X86_FEATURE_TSC_KNOWN_FREQ
Message-ID: <Y3tF0qS3vrRk0eso@zn.tnic>
References: <20221101053019.174948-1-fei1.li@intel.com>
 <Y2kkk+XqBP3u6ObI@zn.tnic>
 <Y3H44Rdi5ari6fql@louislifei-OptiPlex-7090>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3H44Rdi5ari6fql@louislifei-OptiPlex-7090>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:14:25PM +0800, Fei Li wrote:
> ACRN hypervisor assumes:

So ACRN assumes the HV has a good TSC and if it doesn't, oh well, tough
luck.

At least this is how I read this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
