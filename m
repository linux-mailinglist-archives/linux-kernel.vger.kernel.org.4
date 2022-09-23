Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990285E8240
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIWTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiIWTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:02:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F42311D0C9;
        Fri, 23 Sep 2022 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=shcg4WjPwUQd4grLAK6y7B//HQOlI365zxAI+CXvxxY=; b=RS4B0wtrtJLyhr1dcWtKXBsjbe
        K89o5e0i5uHjdOzta7PHaf+vUCW7v0D4iSptCxPJGUAnn6+zSJgx8mPRNHZrAl51sr+pjVYoNrRVP
        pGkDn73DXmMSUsnnF2tVAWMyWECJ95MVnmhEDtoaER3Jo60Ysij3/+tetpd9ekFtbXm3Y893djlyv
        iPlJ1Fp6fLtvK4IPee8Le9DpCuQHA3aUzvUoycULuEZ7YMJyZFIa+jaPiNPflxOQDfkbEVYfdkgkf
        diXpBtEM2k5cqG0EpW3oCDFZmcBAOGgA72/HdSuo/T021yyXXzqN58/TWjtwHiGIsGXtkMfOPFKFW
        ISrkoYJQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obnw3-005Tle-8J; Fri, 23 Sep 2022 19:02:03 +0000
Message-ID: <f5830658-9cd7-4d44-6fd6-d031da1a3442@infradead.org>
Date:   Fri, 23 Sep 2022 12:02:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/7] docs: Rewrite the front page
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-3-corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220922204138.153146-3-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 9/22/22 13:41, Jonathan Corbet wrote:
> The front page is the entry point to the documentation, especially for
> people who read it online.  It's a big mess of everything we could think to
> toss into it.  Rewrite the page with an eye toward simplicity and making it
> easy for readers to get going toward what they really want to find.
> 
> This is only a beginning, but it makes our docs more approachable than
> before.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/index.rst          | 150 +++++++++++--------------------
>  Documentation/subsystem-apis.rst |  58 ++++++++++++
>  2 files changed, 111 insertions(+), 97 deletions(-)
>  create mode 100644 Documentation/subsystem-apis.rst

I don't see a kernel version listed anywhere on the front page
(maybe it depends on what theme is used?) at
https://static.lwn.net/kerneldoc/, so I think it needs something like
this.

--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -18,6 +18,8 @@ documents into a coherent whole.  Please
 documentation are welcome; join the linux-doc list at vger.kernel.org if
 you want to help out.
 
+This documentation is for Linux kernel $(KERNELRELEASE).
+
 Licensing documentation
 -----------------------
 

The line numbering is probably off a bit, but the big problem is in
using $(KERNELRELEASE). Would using $(version) [with 'version' coming
from conf.py] work here? Nope, that doesn't work either.

-- 
~Randy
