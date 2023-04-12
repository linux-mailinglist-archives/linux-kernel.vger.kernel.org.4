Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083386DEB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDLGIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDLGIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927F59F7;
        Tue, 11 Apr 2023 23:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79540629DE;
        Wed, 12 Apr 2023 06:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86941C43445;
        Wed, 12 Apr 2023 06:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681279684;
        bh=DWLhw1m7G/zDwGl58pvMw6CRHHf4fXFZpnYnHVebmn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPl++0dVtjTPkdPzi4t+qT1kvKQf7yPfO9/JBYyroyYkXPr9AYxHNAzNtoq+4zY/u
         d7azs/MB3YmHqCtnbvsauXQxJd3IJpyB/BHfhzAdBSocOT2xCyUznFCptfavQC+zdQ
         47eSidZILu03XJidqwbAg69SAWZ3wVZOnu6Uv5Mc=
Date:   Wed, 12 Apr 2023 08:08:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: firmware: Clarify firmware path usage
Message-ID: <2023041252-scorebook-unboxed-36f5@gregkh>
References: <20230402135423.3235-1-f.fainelli@gmail.com>
 <87y1mzcq9y.fsf@meer.lwn.net>
 <1f4b874b-bd1e-17ff-51dd-19bf2d73214f@gmail.com>
 <ZDT39frTIqpX5p9O@kroah.com>
 <87wn2i9i3l.fsf@meer.lwn.net>
 <db25c4cb-e786-d17c-d82a-c2450f4226a2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db25c4cb-e786-d17c-d82a-c2450f4226a2@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:21:31PM -0700, Florian Fainelli wrote:
> On 4/11/23 15:20, Jonathan Corbet wrote:
> > Greg KH <gregkh@linuxfoundation.org> writes:
> > 
> > > On Mon, Apr 10, 2023 at 04:12:32PM -0700, Florian Fainelli wrote:
> > > > I was not sure whether it was on purpose or not, Greg, will we break
> > > > anyone's use case if we strip off \n from the firmware path passed via
> > > > sysfs?
> > > 
> > > I do not know, sorry.
> > 
> > I would be amazed if anybody is putting newlines into their firmware
> > path; that would be kind of a silly thing to do.
> > 
> > That said, I've been amazed before.
> > 
> > I'll go ahead and apply the docs patch, but it still doesn't really seem
> > like the right fix to me.
> 
> I will submit a patch that strips off newlines from sysfs provided firmware
> paths and if this turns out to break someone's use case it could still be
> reverted, sounds good?

Sounds good.
