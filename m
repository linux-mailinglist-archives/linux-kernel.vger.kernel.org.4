Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B36C652C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjCWKeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjCWKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB4337544;
        Thu, 23 Mar 2023 03:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB93F625C1;
        Thu, 23 Mar 2023 10:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC146C433EF;
        Thu, 23 Mar 2023 10:30:25 +0000 (UTC)
Date:   Thu, 23 Mar 2023 10:30:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 03/14] arm64: reword ARCH_FORCE_MAX_ORDER prompt and help
 text
Message-ID: <ZBwqPrYgE/YdHkXC@arm.com>
References: <20230323092156.2545741-1-rppt@kernel.org>
 <20230323092156.2545741-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323092156.2545741-4-rppt@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:21:45AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The prompt and help text of ARCH_FORCE_MAX_ORDER are not even close to
> describe this configuration option.
> 
> Update both to actually describe what this option does.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
