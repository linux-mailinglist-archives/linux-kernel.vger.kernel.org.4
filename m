Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24159655218
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiLWPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiLWPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:33:17 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E4F2;
        Fri, 23 Dec 2022 07:33:16 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id C52257E2AF;
        Fri, 23 Dec 2022 15:33:11 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671809595;
        bh=5GHBD7JurI3VoO08C91HciXDHvmDolhMleVtvLbr5tw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MsXlMEvsmV7zUNBGM8HeJ/dtPAs8X4457iYsIxMpf4ez+y9nGyU42odPymo1I9TRe
         RSxmw6E4NRYb3fCR5m71d+8lq+/1g83oJsCV4Vx+K9Ky9NK0g9zUgXHPAfNoM0gViR
         dEAK3pEGOVBAPjpIOkOheuVsopcbYynZ+2gyzy2sB6eZ4P19Bb76h33XMn+0wOxmnX
         tgY7MYsJY48SlDAcI+WuiZd0w7IFa24KcMdDmlwHJ5qiF5tA59vL/1d+/NY43Wruh3
         1vWGP3ygDMG3L5fpy7uU1Vxz4yPKDbQCnC8Bt/+EKXQP4/SrgZnTMfcEbBEIuPcj2y
         959lYD1J1t7OA==
Message-ID: <16b2cfeb-23c6-1e7d-aa51-e7f585dbf1ae@gnuweeb.org>
Date:   Fri, 23 Dec 2022 22:33:09 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 0/2] clang warning cleanups
Content-Language: en-US
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPICA Mailing List <devel@acpica.org>,
        LLVM Mailing List <llvm@lists.linux.dev>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20221223142419.3781410-1-ammar.faizi@intel.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20221223142419.3781410-1-ammar.faizi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/22 9:24 PM, Ammar Faizi wrote:
> Hi,
> 
> On top of Linus' tree. This series fixes clang warnings.

Sorry for the noise. It turned out I messed up my clang compiler flags.
I forgot to do a "git reset --hard" before recompiling.

This has nothing todo with the upstream kernel. Please ignore.

-- 
Ammar Faizi

