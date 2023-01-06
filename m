Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9726265F99D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjAFCkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjAFCku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:40:50 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828D76469
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:40:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y1so344936plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 18:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMReju9ZGtQuchPf6WD9hD7WrRjOmXzq8UOpnjdwzRA=;
        b=EAUzZPDeXGC0d+iZL/kZVthTK5VgGLJSKoIT/mnIxBnVdm5R1Jgr3sps1GVnLSdW6j
         kaglzdd+f63S78qhVEaQWY4kKG3BOcMw8WT+odspW9V1T/J1iROYz4l7IVgMO+K7NMgx
         ViiaVjIM7/j06EpS/snN775i+n+s0VUmaNUd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMReju9ZGtQuchPf6WD9hD7WrRjOmXzq8UOpnjdwzRA=;
        b=PFKF+JlgGgCu8vrQK3IHIZorNmpyiVSnCJc4JgajJ3xzxqs22qA5N5IE1g5chuuYkh
         BoOvyGIhr1l9MrX8hd7mO7QZ1VVOY8bWvFyr7Jc1YgjSlL8wYK/C6jHGVBEwcrGnBUnO
         1nqHGU4cQvyUidOnLMbF7WF5fQTHVPvCSl9kuAonklP6mRK6X+VDk7vtGFGOg8IfEkfs
         dS1p9+qvaBifr/HGHHMhvA1iOvIusEhM3ZtVvjbd/W+jy8bjnHV5viWyeMB9DHHamYgg
         LkwJuhAoD1sIxI4AWwOkzY4i836McWAFvTV9lSC6nP2Wd/PTn10qfvIQzJsKPHelAvjM
         R+Ig==
X-Gm-Message-State: AFqh2koy5wim6WfPh8UPJ5TCLWNVE8erYeAglD2De/TxWiRMsVRZwksz
        hhPeXOPICuwiQvr8dxwXvFKE3A==
X-Google-Smtp-Source: AMrXdXuKsPfttknL+8ufrCvWlfSCXDdcoVO19lKPgv8O+wkjGLNunqK2GGJzXu9n5PG/R4zX/Bdc8A==
X-Received: by 2002:a17:902:bcc5:b0:192:b2d3:4fc8 with SMTP id o5-20020a170902bcc500b00192b2d34fc8mr25830361pls.1.1672972848043;
        Thu, 05 Jan 2023 18:40:48 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b00192fc9e8552sm2117899pln.0.2023.01.05.18.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 18:40:47 -0800 (PST)
Date:   Fri, 6 Jan 2023 11:40:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y7eKK7wKfv6E4NMn@google.com>
References: <20230105053510.1819862-4-senozhatsky@chromium.org>
 <202301060349.wchW6HX9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301060349.wchW6HX9-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/06 03:49), kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> Documentation/admin-guide/blockdev/zsmalloc.rst:19: WARNING: Literal block expected; none found.
> >> Documentation/admin-guide/blockdev/zsmalloc.rst:21: WARNING: Unexpected indentation.
> >> Documentation/admin-guide/blockdev/zsmalloc.rst:22: WARNING: Block quote ends without a blank line; unexpected unindent.
> >> Documentation/admin-guide/blockdev/zsmalloc.rst: WARNING: document isn't included in any toctree
> 
> vim +19 Documentation/admin-guide/blockdev/zsmalloc.rst
> 
>     18	
>   > 19	class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
>     20	..
>   > 21	   94  1536           0            0             0          0          0                3        0
>   > 22	  100  1632           0            0             0          0          0                2        0
>     23	..
>     24	

Thanks.

OK, added `make htmldocs` to my build scripts, time to get used to
the fact that we now make docs. I fixed all the warnings and moved
the contents to Documentation/mm/zsmalloc.rst file of which I was
not aware before.

Will include all the improvements into v2.
