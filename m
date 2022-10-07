Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1655F74D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJGHqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJGHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:45:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041FDED23
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74971B82257
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7152C433C1;
        Fri,  7 Oct 2022 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665128751;
        bh=v3W+9woTOyWr+h+GLkBHGsbn6uXHtGbXReW29Eyy4KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNCl1vNSXeLFeIzr7wcvI4XMSIPIqMLIGlqbBHZA+JKctJhXZ60RNNW8B9A2lIeBr
         mnjdHLliHpTQhOk3EnpR8efvlubpsG6eszA/bKfkq1/5PKICUQeJktyO2UZAnsY132
         GukOXm3EVmkWcyBWjQnop0n/uhYCeHku7XUAEkQQ=
Date:   Fri, 7 Oct 2022 09:46:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Yz/ZWBeNZvKenEVM@kroah.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:07:54PM +0530, Kaiwan N Billimoria wrote:
> Greetings!
> I'm working on the 2nd edition of the Linux Kernel Programming book
> (https://www.amazon.com/gp/product/B07RW915K4/ref=dbs_a_def_rwt_bibl_vppi_i0)
> and request your help...
> 
> I'd like to base the book upon as recent a kernel version as is
> feasible, of course, with the caveat that it's a long-term (LTS) one
> that will be around for a while. Currently, the 5.10 LTS kernel's EOL
> date - Dec 2026 - makes it an ideal candidate.
> 
> However, if possible, I'd (also) like to use a 6.x kernel; so, my
> question comes down to this: will a 6.1 kernel release occur soon (I
> heard it should be around Dec this year)? Will it be an LTS kernel
> (again, should be I guess), and, if so, very important for me, what's
> the likely EOL date?

I usually pick the "last kernel of the year", and based on the normal
release cycle, yes, 6.1 will be that kernel.  But I can't promise
anything until it is released, for obvious reasons.

thanks,

greg k-h
