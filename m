Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E7607F88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJUULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJUULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:11:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD543175;
        Fri, 21 Oct 2022 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=JphNfAA2iHfPPFqLGJ1P7kcxgaF4AXUeuQ4B56yMLX8=; b=kXgQ2hifegqvU+i7pUOpYoI7bc
        4F2y/WzAluh3WgqorcWcRrHULr96NkYXt+ttayyvJeo8lh7PK07x96H2z4bj2kFAfTbAK8ub4u/CQ
        1h/gcPu7ETOPAgZ077LqRE7y/xcXLflelt9y4pI7iydkdD+947IyQwsopXWuJPHxXoiPKi3DtxRWq
        mNR3aBK5G9ElJMbi80+mps5/ElRu24FttQpOQpahSls+plW9BjCQ9LBVdDwhzEt3ZZRw43ydKyYrx
        b7G5AuFA/BhbTXybYJ/wMG7Flcmz/X5jwLUgCsM9a2ckO02kS5HqC7NzbHiMdgZXCJFSgUIJWaI7o
        Zscnyv4Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olyMU-009jrY-7z; Fri, 21 Oct 2022 20:11:22 +0000
Message-ID: <55dd0e6d-3d52-fce9-015f-6ebb75cf826e@infradead.org>
Date:   Fri, 21 Oct 2022 13:11:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] package: add tar development package for 3rd party
 modules
Content-Language: en-US
To:     Federico Vaga <federico.vaga@cern.ch>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021101452.1367745-1-federico.vaga@cern.ch>
 <20221021101452.1367745-2-federico.vaga@cern.ch>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221021101452.1367745-2-federico.vaga@cern.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 10/21/22 03:14, Federico Vaga wrote:
> Most, if not all, Linux distributions provides a Linux development
> package which purpose is to support the building of out-of-tree modules
> without providing the entire source tree.
> 
> What ends up in this development directory is a mixture of source
> files (mainly headers) and generated ones (headers, and tools produced
> by `make modules_prepare`).
> 
> This patch is an attempt to generate a tarball archive containing all
> required files to build external modules. It could be than reused by
> packagers.
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> ---
>  Makefile                       |   2 +-
>  scripts/Makefile.package       |  13 +++
>  scripts/package/buildtar-devel | 207 +++++++++++++++++++++++++++++++++
>  3 files changed, 221 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/package/buildtar-devel

Is there a patch 2/2?  I don't see it anywhere.


thanks.
-- 
~Randy
