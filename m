Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0D655215
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiLWPcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiLWPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:32:07 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB92F2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:32:04 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 763BD7E24C;
        Fri, 23 Dec 2022 15:32:01 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671809524;
        bh=uo/xsVnttb2jWkDE2U/ni1nHRBdoNN4e9lSz511tlT0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Tc86R6GdkvF4nuPGhsXBNccpcC1mtUiG1cUS3eWvgaFYsl70o1jvR0Btum7kzg45o
         SSCqxjxraGVHYtN2wJZtvKV+3x5h7oA+8CppdFUu6DA7JMWZJz9/sQyJUltWQ8A+wi
         Y9E5rzR/kK1b/2IXahsT2KKuwh5BREvh9xtnSDObJ4OwHC5LELOSDcnj/W5Q5aKFLe
         gaZxfVtprGr/zHIOpfgZT23sIupXm0k20lm554hNwXqaCc3SoMZ7eOsm7IYa5+yK7v
         k+fb+N0E8y4BR3sTivT5obuWoaV/q1kJSPhh9Ra5MDCySSx18Metqsmbql9XMnZZnG
         0i0csUsY6ELhg==
Message-ID: <7f61b046-c6f2-1dd6-98e9-e5b49b3c7dde@gnuweeb.org>
Date:   Fri, 23 Dec 2022 22:31:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        LLVM Mailing List <llvm@lists.linux.dev>
References: <20221223145137.3786601-1-ammar.faizi@intel.com>
 <Y6XDAiMAMLniR9PG@kroah.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v1] driver core: Silence 'unused-but-set variable' warning
In-Reply-To: <Y6XDAiMAMLniR9PG@kroah.com>
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

On 12/23/22 10:02 PM, Greg Kroah-Hartman wrote:
> Ick, no, that's horrid and is NOT ok for kernel code, sorry.
> 
> Please fix the compiler, this is not a "fix" in any sense of the word
> and is not going to work at all for kernel code.

Agree.

Sorry for the noise. It turned out I messed up my clang compiler flags.
I forgot to do a "git reset --hard" before recompiling.

This has nothing todo with the upstream kernel.

-- 
Ammar Faizi

