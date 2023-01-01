Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6577E65AB95
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 21:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjAAUor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 15:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAAUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 15:44:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC52BC4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 12:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=DrCAFGVYy0paehgXNcAKlB7IMc/OmKWFcz3wujZ4XAU=; b=YgGlGiHJblbHxF0oBGRr4q4sjP
        L6hjsZ30Plg2RGIRuCLvXF88lTrYlDZyW9Y6ODVAOz3yp2pM2wkyy1f0XxyBPIHltXMlxvcfFPk+O
        OeWXxbpeGqCC9cwkgtQz+y+/tq/Qts4y7P64GEvAv6vTcZIjZiZAr2xBZ7IAZ/7H5+JUCybv4ju1R
        2l2TOmVctXEV3E1e8cMEqdfmVoJ71k2YDO+K7RPaqYuX9GuyQrgvTEGCnZfpEwF1SSsn8/15BkTvK
        6xbP6hIwQn4MPFtxoOPuIalBc2bICQqEAAwwV7zkHfykw9WSHwrpw0DOhyCtZ+GMbAGR38rOb+7L0
        QuklFhbg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pC5C9-004rzP-5l; Sun, 01 Jan 2023 20:44:37 +0000
Message-ID: <cddcae6d-41d2-1b71-4785-b9c454e54c0b@infradead.org>
Date:   Sun, 1 Jan 2023 12:44:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: how to build a single module
Content-Language: en-US
To:     "J. R. Okajima" <hooanon05g@gmail.com>, masahiroy@kernel.org,
        mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <25966.1672603613@jrobl>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <25966.1672603613@jrobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/1/23 12:06, J. R. Okajima wrote:
> Hello,
> 
> In linux-v6.2-rc1, "make brabra/module.ko" to build a single module
> doesn't work. It compiles the C source files and produces .o, but the
> final 'modpost' returns an error.
> 
> $ make fs/aufs/aufs.ko
> 	:::
>   LD [M]  fs/aufs/aufs.o
>   MODPOST Module.symvers
> ERROR: modpost: fs/aufs/aufs.ko: filename must be suffixed with .o
> make[2]: *** [/proj/aufs/aufs6-linux.git/scripts/Makefile.modpost:137: Module.symvers] Error 1
> make[1]: *** [/proj/aufs/aufs6-linux.git/Makefile:1996: single_modules] Error 2
> make: *** [/proj/aufs/aufs6-linux.git/Makefile:373: __build_one_by_one] Error 2
> Command exited with non-zero status 2
> 
> 
> Is it related to this commit?
> 	f65a486821cf 2022-12-14 kbuild: change module.order to list *.o instead of *.ko

Hi,
Please see
  https://lore.kernel.org/linux-kbuild/CA+icZUW9MewkPJKwd4gA+pKADypseiCT0uYyVvFDTura7CzHog@mail.gmail.com/T/#t

Does that fix the problem?

-- 
~Randy
