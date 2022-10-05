Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888D5F579C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJEPdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJEPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:33:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D968CB87F;
        Wed,  5 Oct 2022 08:33:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7B8C55BF;
        Wed,  5 Oct 2022 15:33:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B8C55BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664983997; bh=VjxDcYciC3lFxrGAlqEZDzTnDHLSelJNt048RkcHBMY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CKsbg6p1hGsHRh88fwMCayEbbLl1FIhuRcldtsWskfVttTXGare9fdMzYhEQGgnz/
         fMJ6oLeBOvySJnVSmR4jkZz6FzXF06EgyhPXzE00VJ0dN9zYgxkbIZsHdBwMe035Al
         0DAONIKXG0uYw/4ZKx1v00OsPvExPvW6FYbTQKWCuZp/e/lQkAk2OBcTKS17eTlhEB
         i/AjwtWrbTQYIFguNJa1trCnx4AWSLacHbotnGr6ivl0XlvW+R5h6v0wB5KJCg9HfH
         9W8ire/xwYFDduFSfOOHIhSekxzKJ87gU/CvxL7aVaP6zEiCulY31lltPOPCMOzSqf
         +OIh2SKnF7GhQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH RFC 0/5] docs: Improvements to our HTML output
In-Reply-To: <20221005064039.2ed74fa9@sal.lan>
References: <20221004201222.281845-1-corbet@lwn.net>
 <20221005064039.2ed74fa9@sal.lan>
Date:   Wed, 05 Oct 2022 09:33:16 -0600
Message-ID: <87pmf69tfn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> I would play with the sidebar options used by Alabaster in order to
> try to make the TOC more useful.

Definitely worth doing; I'm not sure how much flexibility there is
there.

I'd *really* like to avoid carrying our own theme if at all possible...

The right solution might be to actually split the books apart and do the
intersphinx thing; I've not really looked into that at all.

> On a side note, one thing I miss on all default themes is a way to dynamically
> use dark mode. That's btw why I ended adding non-default support for 
> 'sphinx_rtd_dark_mode' (which also requires an external package). At the time
> I added CSS/themes customization support to the build system, this was the only 
> theme that allowed to switch to either dark/light mode. It would be really cool 
> if Alabaster (or some other default themes) could honor the user's preference
> between light/dark modes.

Yeah, Alabaster doesn't seem to have that.  Providing that ability in
conf.py shouldn't be *that* hard to do; it doesn't use that many colors,
though there might be a fair amount of CSS to override.

Thanks,

jon
