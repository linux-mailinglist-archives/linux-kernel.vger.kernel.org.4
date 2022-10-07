Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6545F74AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJGH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJGHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:25:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA9384E67;
        Fri,  7 Oct 2022 00:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49EF7B82233;
        Fri,  7 Oct 2022 07:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B13C433B5;
        Fri,  7 Oct 2022 07:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665127554;
        bh=nnpVt6M9yW5SyLNWRDgQrv85cE+C9NzyeyQ50jaP/zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOr5OgchARwvo37SPNA6fTIWkvRPQ9JrfEd7CO/DkqIwHS8POD7zCABNpFsU1YMcA
         FemNSHGOmubhAQmKX3qX2NHpzi/9Np2AZE5UG8gB3SceBLHc8/odTle50VlIBu5tRh
         c84PD0fwp8lV/bWEsRWIKFTkQUdGi8BTzjmHgusw=
Date:   Fri, 7 Oct 2022 09:26:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, linux-phy@lists.infradead.org,
        f.fainelli@gmail.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for broadcom USB
Message-ID: <Yz/UqtGD/dthxYJ2@kroah.com>
References: <1665098469-19008-1-git-send-email-justinpopo6@gmail.com>
 <Yz/G0jQxc4c2gzhl@kroah.com>
 <CAJx26kUTzBeNkV_=gEeUYaatBwugT1uFH_b_ggq-fXaJDRBMqQ@mail.gmail.com>
 <Yz/Oik0uXXo0uGk6@kroah.com>
 <CAJx26kVL4nYL2fbHd31ZqpXxEos-nyQ2-GSZbL6FUa5ztAbxXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJx26kVL4nYL2fbHd31ZqpXxEos-nyQ2-GSZbL6FUa5ztAbxXw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 12:19:01AM -0700, Justin Chen wrote:
> On Thu, Oct 6, 2022 at 11:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 06, 2022 at 11:46:45PM -0700, Justin Chen wrote:
> > > On Thu, Oct 6, 2022 at 11:26 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Oct 06, 2022 at 04:21:09PM -0700, justinpopo6@gmail.com wrote:
> > > > > From: Justin Chen <justinpopo6@gmail.com>
> > > > >
> > > > > Al Cooper is no longer the downstream maintainer for broadcom USB.
> > > > > I will be taking his place as downstream and as an additional
> > > > > upstream maintainer.
> > > >
> > > > What do you mean by "downstream" here?
> > > >
> > > Downstream as in internal to Broadcom. Apologies for the confusion.
> >
> > Ok, but then why are these all gmail.com addresses?  Why not use your
> > proper work addresses instead so that we can at least validate that the
> > patches are coming from a broadcom.com domain?
> >
> I believe the idea is we can continue to support as maintainers even
> if we are no longer part of broadcom without having to change emails.
> I believe Florian should be able to comment more. :)

So in other words, broadcom email servers do not allow sending patches
out without mangling the text?  :)

thanks,

greg k-h
