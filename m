Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FCC6695C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjAMLhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbjAMLgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:36:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4D65C92A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 03:24:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4869FCE2075
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52084C433D2;
        Fri, 13 Jan 2023 11:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673609066;
        bh=iL9l6JwSjCPcNTnpmJcqomx1Gqn9VzoUcjYg29IUaJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRJgp36snp9hlTLHxlBNZiXqptbqDJ4+l2drV+yTddyw+6Zinfrs32Px3Vg0kQN3U
         zmwnRjqfkx5n1wRWN/cF2P+CbK+kER91BzZ8PZiTiYmeSdLBLEBiPjw7LlwEt6sW5c
         5aC9Xm+Yf0mG7NMiuK45XT4MS7iLcsto6DFlXwnU=
Date:   Fri, 13 Jan 2023 12:24:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@amd.com>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y8E/Y5sRN/DOpvbi@kroah.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 12:23:46PM +0000, Kris Chaplin wrote:
> Hello Greg,
> 
> > You tell me please.  How has your testing gone for 6.1 so far?  Does it
> > work properly for you?  Are you and/or your company willing to test out
> > the -rc releases and provide feedback if it works or not for your
> > systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
> > anything missing in it that you feel needs to be addressed with a newer
> > kernel instead?
> 
> We have been integrating and testing 6.1 on the Microblaze, ARM32 and
> ARM64-bit architectures over the past few weeks.  These builds have
> been successful and we are able to run our regression tests on hardware
> targeting our FPGA SoC devices.
> 
> We're continuing our tests as new updates to the 6.1 kernel series
> appear.
> 
> Hope that information is of use.

It is very much so, thanks!  And if you can provide "tested-by" results
for the -rc releases, that would help even more to verify that we aren't
breaking anything over time.

greg k-h
