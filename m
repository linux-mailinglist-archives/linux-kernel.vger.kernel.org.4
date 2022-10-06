Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF43D5F60BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJFFmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFFmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:42:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87B89812;
        Wed,  5 Oct 2022 22:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74818B81EA0;
        Thu,  6 Oct 2022 05:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773AFC433C1;
        Thu,  6 Oct 2022 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665034919;
        bh=n6c4VvqngC4tq6JMLCIJjyOZ8FbiloEgzYjwG3LxPlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IZKWZ8Ktkq2qWRUa7pcHiU/6//pZB+4vJUfPh6MIPWpRAAnAwb/qRA9PxIaCqBj4n
         IoSAh5YNkcUqvb/pF1oHfzHJhVz71QeoiLJNjfSmAfR7XJG1m+vuylZgh5R26eztJ2
         m43Ye0rXVjyD01Y4gY+8uNebpysWNd48ub2enqsU95U8pEbAkk2FCXComJtHRWmoFv
         ggfxFzcY9nBUsjBJjP/HwvRjwp+Cbk46x3rUxRfYfRdk6vt6g+xZWgmyyY8Xw6Z9z1
         e/9XcHc7Wsqrg6riA7w5O9tRUMrvvtZhjxrrvVLThAaghQVmmQx/GT3229ZI3Th75F
         GOpY7FuH1fglw==
Date:   Thu, 6 Oct 2022 06:41:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 5/5] docs: improve the HTML formatting of kerneldoc
 comments
Message-ID: <20221006064152.0c82a351@sal.lan>
In-Reply-To: <87tu4i9tli.fsf@meer.lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
        <20221004201222.281845-6-corbet@lwn.net>
        <20221005065909.33ba2523@sal.lan>
        <87tu4i9tli.fsf@meer.lwn.net>
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

Em Wed, 05 Oct 2022 09:29:45 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> > Also, when the container directive was introduced? Does it affect
> > the minimal Sphinx version we support? It seems that this was old
> > enough to not require any changes at the minimal version, but,
> > from https://www.sphinx-doc.org/en/master/changes.html, it seems
> > that LaTeX support for it was added only at Sphinx v4.1 on this PR:
> >
> > 	https://github.com/sphinx-doc/sphinx/pull/9166
> >
> > So, we need to double-check if are there any changes before and after
> > such version at the places container is used - or change the kerneldoc
> > to only emit such tags on PDF depending on the Sphinx version.  
> 
> I've tested things as far back as 2.4.5, where all is well.  I don't
> currently have a machine that is capable of running earlier versions;
> I'll need to conjure one of those up, I guess.
> 
> (Either that or just bite the bullet and move the minimum version
> forward!)

I would just set 2.4.4 as the minimal version. This is already
the minimal version for PDF output anyway:

	my $rec_version = "1.7.9";	# PDF won't build here
	my $min_pdf_version = "2.4.4";	# Min version where pdf builds

and requirements.txt also sets to it. Yet, it would be nice to
change requirements to 2.4.5 as the default pip-installed version.

Regards,
Mauro
