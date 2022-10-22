Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA1609071
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 01:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJVXeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 19:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVXd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 19:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B971BDD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 16:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC16960B47
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 23:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD99DC433C1;
        Sat, 22 Oct 2022 23:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666481637;
        bh=bpQqDWzunN8eH2mdrn4dttE6VdzEvMNlZ5h2Yxe82Lk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wyktu+8ed652g2aGSJzZ80/OBE3c0vCBNkHUsDhcf7hPBj9EiusXoN4JL/v3uH92y
         wNyCKQtFk4FZdgSGwLb6g0hXiMzOZBMpCyvdiIjDWF/EcbylBrnXUE2B66LYEFhb2C
         ra5u638TwPSJfBS7/4d6Q67E/SSGuwDT18Fu3sRA=
Date:   Sat, 22 Oct 2022 16:33:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [ammarfaizi2-block:akpm/mm/mm-unstable 146/162]
 include/linux/memremap.h:258:9: error: expression which evaluates to zero
 treated as a null pointer constant of type 'struct folio *'
Message-Id: <20221022163356.f5e08eeefe66fc71845be861@linux-foundation.org>
In-Reply-To: <202210221343.e50d98Ht-lkp@intel.com>
References: <202210221343.e50d98Ht-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2022 13:27:19 +0800 kernel test robot <lkp@intel.com> wrote:

>    In file included from include/linux/mm.h:31:
> >> include/linux/memremap.h:258:9: error: expression which evaluates to zero treated as a null pointer constant of type 'struct folio *' [-Werror,-Wnon-literal-null-conversion]
>            return false;

Thanks.  Doh.

--- a/include/linux/memremap.h~mm-memremap-introduce-pgmap_request_folio-using-pgmap-offsets-fix
+++ a/include/linux/memremap.h
@@ -255,7 +255,7 @@ static inline struct dev_pagemap *get_de
 static inline struct folio *pgmap_request_folio(struct dev_pagemap *pgmap,
 						pgoff_t pgmap_offset, int order)
 {
-	return false;
+	return NULL;
 }
 
 static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
_

