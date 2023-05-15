Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087397029DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbjEOKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbjEOKBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:01:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5791BC6;
        Mon, 15 May 2023 03:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A426132E;
        Mon, 15 May 2023 10:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916A0C4339C;
        Mon, 15 May 2023 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684144861;
        bh=jYcWwKZuueWRNNyKZFfxQRcJCjkdXElOS5YH00Ft6Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrNCAOZl/zbGqvBOpep8+a47DX2ubK24EfiPiU6/mQCZtRi9YtwHI1LveszTbtMJb
         axgyhKi6onXUs67tCx/jjQb5fvnXHRxiNj1IwvzEKUJdVoCmiKof9Pajx0tcTCa3tr
         pRcoXUF4J0RSOMVefE7PjxeADJS5LGWFRGnTOOquc4XCfNeQ2LFjL2djG+fefCDuNn
         g/13Q6uxNpEFcrBVMOdP3x8uZhWSURmq51+3Of/+LuYdXhOLzE9ho5770iPfPIUYw/
         y1xOFlwzEZcuCtT4FWfjXlsMHmQ9KTKHFNoDyJFW5YVxSuxZILS9q/FEM27VC/ZBEJ
         2OaXvx9GDfe1A==
Date:   Mon, 15 May 2023 11:00:57 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the leds-lj tree
Message-ID: <20230515100057.GG8963@google.com>
References: <20230511090443.359b120b@canb.auug.org.au>
 <20230511085144.054125a0@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511085144.054125a0@aktux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Andreas Kemnade wrote:

> On Thu, 11 May 2023 09:04:43 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > The following commit is also in Linus Torvalds' tree as a `different
> > commit (but the same patch):
> > 
> >   fea27b037127 ("leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver")
> > 
> > This is commit
> > 
> >   8325642d2757 ("leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver")
> > 
> BTW: and also:
> 
> 3808b8424b476 ("leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver")
> 
> it went in probably by accident through both led and mfd pull requests for 6.4.

And now it's queued up again.

Sounds like it's definitely going to be applied then.

Must be a good patch. :)

-- 
Lee Jones [李琼斯]
