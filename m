Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26E5F6062
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJFFEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJFFEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:04:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C997AE51;
        Wed,  5 Oct 2022 22:04:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A07A7B81EC9;
        Thu,  6 Oct 2022 05:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295E2C433D6;
        Thu,  6 Oct 2022 05:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665032679;
        bh=M2hkFm3NEhtCTBMuaEz71ajk6MNoytV33Do8Ujc6its=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5XeGlgpsnNADXnWvqJGjMfFmKCW50R/sdSCE4HpJx2uNuEU7SxVmSgN+fmUwYGYW
         TmlBFrPmI35bYLdeRD6vHealSC6Y6uUwLBXnPAsMefSsZ/lh3MLiu9aeUR45Wm0oQn
         zba63xa+asKrRF9BmXpLsILsKAk/EmBTQBwXStruXUH6U7JipWLBYa45uMCuQs2CWo
         2FI6XXi/LkBqQ43wUHPg9OoQFo49O+V7oNWRo0NE0f3gjVXh7etVZuHag0cbcAh1Xl
         E+Pa1q8EbnA87Kw+HYnvRu/P6SN10mqVPC6URuAwX4+P8tdYLio5SmZfqXJ4XF1xwz
         QKRfNpIG7H3FQ==
Date:   Thu, 6 Oct 2022 06:04:33 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH RFC 0/5] docs: Improvements to our HTML output
Message-ID: <20221006060433.38023ecd@sal.lan>
In-Reply-To: <87pmf69tfn.fsf@meer.lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
        <20221005064039.2ed74fa9@sal.lan>
        <87pmf69tfn.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 05 Oct 2022 09:33:16 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab@kernel.org> writes:
> 
> > I would play with the sidebar options used by Alabaster in order to
> > try to make the TOC more useful.  
> 
> Definitely worth doing; I'm not sure how much flexibility there is
> there.
>
> I'd *really* like to avoid carrying our own theme if at all possible...

Yeah, agreed. 

Btw right now if you don't have RTD installed, it will already fallback to 
classic Sphinx-native theme, on a non-optimized way, as it will be using the
CSS wrote for RTD.


> The right solution might be to actually split the books apart and do the
> intersphinx thing; I've not really looked into that at all.

Yeah, we've been postponing using intersphinx for quite a while. Perhaps
we could start supporting it. One expected advantage would be to make
life easier when building just a single book, as intersphinx should keep
the cross-references working and it should not produce extra warnings due 
to references that belong to other books.

> > On a side note, one thing I miss on all default themes is a way to dynamically
> > use dark mode. That's btw why I ended adding non-default support for 
> > 'sphinx_rtd_dark_mode' (which also requires an external package). At the time
> > I added CSS/themes customization support to the build system, this was the only 
> > theme that allowed to switch to either dark/light mode. It would be really cool 
> > if Alabaster (or some other default themes) could honor the user's preference
> > between light/dark modes.  
> 
> Yeah, Alabaster doesn't seem to have that.  Providing that ability in
> conf.py shouldn't be *that* hard to do; it doesn't use that many colors,
> though there might be a fair amount of CSS to override.

RTD dark mode [1] solves it in runtime using a CSS with:

	html[data-theme='dark'] body {
	  color: #bfbfbf;
	}

A JS sets "data-theme" to dark in order to activate it in runtime[1] with:

	    document.documentElement.setAttribute('data-theme', 'dark');

It also comes with a .py file that selects the default.

But yeah, there are a fair amount of CSS to override.

Also, I suspect that maintaining it can be a challenge. Not sure if it
worth the efforts.

[1] https://github.com/MrDogeBro/sphinx_rtd_dark_mode/tree/main/sphinx_rtd_dark_mode

Regards,
Mauro

