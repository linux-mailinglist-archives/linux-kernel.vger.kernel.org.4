Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A403460BD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiJXWfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiJXWen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:34:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EE031DC0B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:58:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m16so33317703edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wN9xp9CGfEXcy9ZUhAlzmgVvoo8fo5U8S26wHVxg2ig=;
        b=Z5tPB/MLR2TafhpF8u9gg6+4mUEDrIbM8/l6b6PiwDt3kSPDjK4P1YfOkRWdqs/Qro
         NO+r494H7+BeLvSuWYI0eiFg/RNo5UqvlWDanVQy6GkQoQ+1qPzUH1EyQvrr8NQIuZwP
         uzDWKbFyWEfV4n8RiggEt8C+vNFMCUTMsIXef70J7aALkIrLqCdHE6v0xB1pNyRqV4/v
         6V/ouoyqCvtHGeMb19VDYwWQouegiA1xURYKCLZUEx8C/HcUaRToJmuDClKhD7rssocD
         tLyDYVxO7zBjxZhtFsnNSvXUhwhGHU/bK88B+szoy/ZOxCaegqPpzjvkP/YcNnhusk/b
         YizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN9xp9CGfEXcy9ZUhAlzmgVvoo8fo5U8S26wHVxg2ig=;
        b=jbxoq2WUqUBpSB5msjLOE+obWKXn44sjwy9i3cNpt70sxtFuPVKHfV9qB5tIR9T7dJ
         HHYchCez7f7ECn3VQjb41Uc/VcpwQt8qlzcEZQS2qq25DdYDcIELKEw4De43b7YT3uwG
         Dlyt17M42SDory2QgG+2H+Ov/ys69v+Fx7XPJkncuQxbNFeVKUAJdGeyg8ElXpBzg6Ke
         tpvRSPB0jQ2N4Wk2cvST2PMF2bqulKkSTwXbgY+M8e9/S8SuPSiG+9ce0HVABtOvxDR2
         FFFK6pVGzYKNPkWAodD9lh0ljF26lquVhEOkqASaRRxxrN4lmNtql0Qf+0PgsGn8i3YH
         12qg==
X-Gm-Message-State: ACrzQf2NYD3CxaMYcC8S20GHrSVqtNV+da5pnaee6Y085ktf8EQbQpkP
        +JTmt3I7D5WVnk8p1YpqJEeMQgnF+sc=
X-Google-Smtp-Source: AMsMyM60LdtUisTIW1qhUz5mAJHOCvIif9J9TxhIcbQetcBWikOkzFUshJxeZZ3uFv4Yc2lXPC2HEA==
X-Received: by 2002:aa7:d1c3:0:b0:461:c627:2a7b with SMTP id g3-20020aa7d1c3000000b00461c6272a7bmr4653238edp.231.1666615741855;
        Mon, 24 Oct 2022 05:49:01 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b00782fbb7f5f7sm6029329ejy.113.2022.10.24.05.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:49:01 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 24 Oct 2022 14:48:59 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 5/7] mm: vmalloc: Use trace_purge_vmap_area_lazy event
Message-ID: <Y1aJuzlLVGHPYyX4@pc638.lan>
References: <20221018181053.434508-6-urezki@gmail.com>
 <202210240651.gHRa2Tys-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210240651.gHRa2Tys-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

> Hi Uladzislau,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.1-rc1]
> [cannot apply to next-20221021]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Uladzislau-Rezki-Sony/Add-basic-trace-events-for-vmap-vmalloc-v2/20221019-021918
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20221018181053.434508-6-urezki%40gmail.com
> patch subject: [PATCH v2 5/7] mm: vmalloc: Use trace_purge_vmap_area_lazy event
> config: sparc-randconfig-c031-20221023
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> cocci warnings: (new ones prefixed by >>)
> >> mm/vmalloc.c:1789:36-41: WARNING: conversion to bool not needed here
> 
I think it should be fixed by the:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-vmalloc-use-trace_purge_vmap_area_lazy-event-fix.patch

Thanks!

--
Uladzislau Rezki
