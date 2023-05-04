Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631456F7208
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjEDSlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEDSl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:41:29 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973D4C22;
        Thu,  4 May 2023 11:41:24 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 567092C8;
        Thu,  4 May 2023 18:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 567092C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683225682; bh=M+B8SLm2PMpcta7Rti3FG8GJchHOrmHgx3npRi99b0I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D8F8e1r5FZCihfpZZlw2+z+byrsjbVr+sas/C2TEgJm3BqSuhVyHZ93EDR0L3qJTA
         P6h8rPVfEpJKtEzLiApFxuSMAAeF243cOrEEci9zk8bbKSUZeuDt4eQESBOUNT7puk
         mcBaITpCCjH0tMh5lfSNvPxn/gj3KJiHwmeEFFxbga4pQT7UvWVVdUyvN/N+R8CZk2
         K1/gTctWIWUzf+eWgjq7fi02VApwtsOvabN3M+6TlCSXmtFPmlX6X7bBmQHH8eJPHx
         DY5c4bbfCkBT3czlY9m3tBy1sNxrvfQgQwZGyHgBqvRGx6MV5VtVx1c0F6Z4bLwzOH
         rHTIezs2tF/SQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        "open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v3] docs: directive `alias` for redirects
In-Reply-To: <20230504180210.727364-1-costa.shul@redhat.com>
References: <20230504180210.727364-1-costa.shul@redhat.com>
Date:   Thu, 04 May 2023 12:41:21 -0600
Message-ID: <87ednwndm6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> and several redirects for moved main arch pages
>
> Problems:
> - The documentation lacks hierarchy
> - Relocating pages disrupts external links to
>   the documentation and causes confusion for users
>
> Benefits:
> - Users can easily access relocated pages from external resources
> - Using redirects frees up options for reorganizing the documentation
>
> The solution:
> - Introduced directive `alias` which declares previous path of
>   a moved document as the argument.
> - Redirects are implemented with Sphinx extension rediraffe_redirects.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> ---
>
> Changes:
> - complete new implementation

I honestly don't know why you keep throwing versions of this at us.  In
the absence of observed problems, I don't see the value in adding
infrastructure that we have to maintain going forward.

Please stop with this for now.

Thanks,

jon
