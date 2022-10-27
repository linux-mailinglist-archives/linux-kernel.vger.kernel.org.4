Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896E960FAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiJ0Oue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiJ0Oua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9E57DF4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFE262355
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EDCC433C1;
        Thu, 27 Oct 2022 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666882229;
        bh=n1rJZlFMT8eg/kIkV0yjijV6324185bQ0NxuEcnFO58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5WR9aZymhyAVL6W+ByZudBrmFRBeFjLXgLF/5/EtKXkFjR8Gy/65qQgTCQnr6jgG
         eV0d5dDeWq9jUho9jO5UdAprMJc/JP/AP0LObIGJE32N/Hkn1q7o8rBO2JqyBI2u0I
         ZGY0+vz7MxX1o37LtvMIrWPBr7R+5HVq1Q9Gqd1I=
Date:   Thu, 27 Oct 2022 16:50:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanju Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v5 2/6] staging: vt6655: refactor code in
 s_uGetRTSCTSDuration
Message-ID: <Y1qaskO7AN7nqc9R@kroah.com>
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <0e6a307052d3a354a850a502e509f46baccdbe1e.1666849707.git.tanjubrunostar0@gmail.com>
 <Y1pNJMvl89jgq9qz@kroah.com>
 <CAHJEyKVpK=BSkuM_RmJ+eUYApYJig8wfqDP4nM=cou_0mThHuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHJEyKVpK=BSkuM_RmJ+eUYApYJig8wfqDP4nM=cou_0mThHuw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:09:52PM +0100, Tanju Brunostar wrote:
> On Thu, Oct 27, 2022 at 10:19 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 27, 2022 at 08:59:04AM +0000, Tanjuate Brunostar wrote:
> > > refactor long lines of code in the function: s_uGetRTSCTSDuration
> >
> > Please write full sentences.
> >
> > Also please read the in-kernel documentation for how to write good
> > changelog text.  Specifically look at the section entitled "The
> > canonical patch format" in the kernel file,
> > Documentation/SubmittingPatches for a description of how to do this
> > properly.
> >
> > Do this for all of the patches in this series.
> >
> > thanks,
> >
> > greg k-h
> 
> Hello Greg
> the file does not exist in Documentations

$ cat Documentation/SubmittingPatches
This file has moved to process/submitting-patches.rst

> Also, I had to make the sentences shorter because you said changelog
> text was too long.

You had too long of a single line.  Wrap your lines.

Look at all of the changelogs for the driver itself as examples.

thanks,

greg k-h
