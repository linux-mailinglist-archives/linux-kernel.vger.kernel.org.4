Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2075F6072
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJFFJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJFFJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:09:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE397FFB1;
        Wed,  5 Oct 2022 22:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C926182A;
        Thu,  6 Oct 2022 05:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF00AC433C1;
        Thu,  6 Oct 2022 05:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665032960;
        bh=9Y6fMX6PMJcz6b9yDNapMhXEazCMtGL4ldaOkiPsE+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bh6x9Wts3chzXActq8qr/MolFO2NDwOgMpdnFR2Fybpq66K1gQ5OQ2gbkvYHFE53V
         Dz6Btgy7XkjyoKGgAQ9bRxNbuRDV1CSglm8zQihysqcn2uq7aG/nnZoEx2/3LJs542
         YR6GIw6r2IBapDr8mBKmLdiOf0uWGCn48cElIX6bz9ZAigZzqEaja4U+Rew5HBrr1l
         fb1VaiSlhjH53aEOFLN7gbMhNmMcwQ/U1Vgco6kHzsYi5cKoDtAT8AnbTOSK3kBxJ0
         xc5tuUy3r9jo0GjPRva1jpjS6R0Y0UEcvN+Q/h3drtEn7ab81OiNB8hOIG4LQtGpta
         1YOChy93+e5ug==
Date:   Thu, 6 Oct 2022 06:09:12 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] docs: Switch the default HTML theme to alabaster
Message-ID: <20221006060912.2d417ad5@sal.lan>
In-Reply-To: <87h70i9n4i.fsf@meer.lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
        <20221004201222.281845-2-corbet@lwn.net>
        <87o7uqqj6s.fsf@intel.com>
        <87h70i9n4i.fsf@meer.lwn.net>
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

Em Wed, 05 Oct 2022 11:49:33 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Jani Nikula <jani.nikula@linux.intel.com> writes:
> 
> > I wonder if the right way to do this would be to define our own theme,
> > which would mostly just extend alabaster, but would have small tweaks
> > [2]. Where are the Jinja experts when you need one?!
> >
> > [2] https://www.sphinx-doc.org/en/master/templating.html  
> 
> I've pondered just creating our own theme, it's not *that* hard to do.
> It's another thing to maintain across multiple sphinx versions, though.

Yeah, that can be painful. Btw, at least on Fedora, RTD dark theme is
not working anymore (perhaps because Python 3.10 - the extension announces
it up to python 3.9).

I suspect that maintaining our own theme will require extra efforts to
workaround with per-version ABIs that keep changing on both Python and
Sphinx sides.

> I'd be more enthusiastic about the idea if we had a $SOMEBODY who would
> commit to doing that.
> 
> Thanks,
> 
> jon
