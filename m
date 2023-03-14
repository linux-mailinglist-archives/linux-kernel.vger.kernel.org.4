Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F266B8FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCNKYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCNKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:24:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD7734000
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:23:34 -0700 (PDT)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0250E1EC03CA;
        Tue, 14 Mar 2023 11:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678789404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a7dsEeTHB0IpjY+M706JQUGeBy6C6E0uYjJJoB2VwB4=;
        b=cr9bJcWE3F8Smp3J+f5hM0nYdBZDwoKtOvLI+aKUFgzIV1iE7IskQgWMae/gLwHD0N+7ch
        Clk3KlyRRa5KNMhpCdSvST46AHf0RJu9epQsj2Cdt9G2tmQyVTwfr207dOlm1tY0GZMZzz
        2Ja5nOaWyLVejQxkrDHrDbbPnXK58ZU=
Date:   Tue, 14 Mar 2023 11:23:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG REPORT] arch/x86/include/asm/uaccess_64.h:119: Error: junk
 at end of line
Message-ID: <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
References: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:12:13AM +0800, Jingbo Xu wrote:
> 	gcc (GCC) 6.5.1 20181026 (Alibaba 6.5.1-1)

Looks like you should complain to whoever patched this gcc and broke it
in the process. Unless you can reproduce the issue with an official
compiler...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
