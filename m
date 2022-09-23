Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451E75E81F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIWSpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIWSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:44:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8C03ECD7;
        Fri, 23 Sep 2022 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KuiMXesKGfJiWErvIH2Wnk9SB3SRaAZkfT43/NCQskQ=; b=j1uLjhFi9cHkexHB5Z8HfvfvNw
        xX30xzuhLNW3i6rlCd2wo1kevk3y5ERGIHhZgGobNi9MDbojeBXCtLn5AeVs7/f5Y+QrNrxTdcgey
        98Cmvljqk/5BNqfszFZ0+8HJibmkGelUBz69qk09wF+oeUQrg4gbn6WZ32iE3xTQnh43rlg6gQWW7
        OgGgEB9oJErIaQA1WZBgIRWWxyw6wVdsaqHAfTMupiLOx/Rja4K5yB739oDyAuslJHHytQFlHaPYk
        Pycgy7J0iQJEl9uPFg+Ah6t8+2yQIQUAe6tb9N5foiH2CKWjJytkpnOPEtzgZUtHW9bjbIYEwPBpL
        HA4AiB6Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obnfP-005Nix-JD; Fri, 23 Sep 2022 18:44:51 +0000
Message-ID: <a22ed923-754a-b757-e0ca-87b6d6e6e8d2@infradead.org>
Date:   Fri, 23 Sep 2022 11:44:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 7/7] docs: put atomic*.txt and memory-barriers.txt into
 the core-api book
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-8-corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220922204138.153146-8-corbet@lwn.net>
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

Hi--

On 9/22/22 13:41, Jonathan Corbet wrote:
> These files describe part of the core API, but have never been converted to
> RST due to ... let's say local oppposition.  So, create a set of
> special-purpose wrappers to ..include these files into a separate page so
> that they can be a part of the htmldocs build.  Then link them into the
> core-api manual and remove them from the "staging" dumping ground.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/core-api/index.rst              |  3 ++
>  .../core-api/wrappers/atomic_bitops.rst       | 18 ++++++++
>  Documentation/core-api/wrappers/atomic_t.rst  | 19 +++++++++
>  .../core-api/wrappers/memory-barriers.rst     | 18 ++++++++
>  Documentation/staging/index.rst               | 42 -------------------
>  5 files changed, 58 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/core-api/wrappers/atomic_bitops.rst
>  create mode 100644 Documentation/core-api/wrappers/atomic_t.rst
>  create mode 100644 Documentation/core-api/wrappers/memory-barriers.rst


When I look at https://static.lwn.net/kerneldoc/,
I want to move these 3 from "Other documentation":
Atomic Types
Atomic bitops
Memory Barriers

to "Internal API Manuals", then I saw this patch...
Maybe I am misunderstanding. Is this patch supposed to move those 3 items
from Other or not?

thanks.
-- 
~Randy
