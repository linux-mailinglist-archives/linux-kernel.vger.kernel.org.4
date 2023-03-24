Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1986C7E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCXNA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCXNAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2D74C2B;
        Fri, 24 Mar 2023 06:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BACBA62A69;
        Fri, 24 Mar 2023 13:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE51C433D2;
        Fri, 24 Mar 2023 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679662854;
        bh=Nqt8dM+hpeNv7xex2w5Jz9mlfv7En+rUD6nOArTbrfU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XkKdty1KmqYf+xr4pULB63a49jwFSz4wikXpfMiszyg4CgKW0p77VNs5zWqZEz3lu
         cdCIUBrHc3ifEaDSsSMDD2CTU4va2HM7d+AiuIN36n65sAUaeZWMVIDDGyulMem9Gt
         /WFOzSD6Iv+YXF6HMYt5C6zqSzJqKSSFFoW4wkPZf9al9/qKAMY2Gxy5dfIOQJ9tOU
         P+t41lHJTvvGJGjHOWneU/mfB9AJ2LSO3J070RQw1+vNsgu7KlKxK2TDWYnS23unpN
         5gmxn8fossduhJP5Acn1t+pKP66j0TSJfVDt4SrUtBHnKFF6aSQQd114xb8TLdP5MK
         34uFFsJWzNeFA==
Date:   Fri, 24 Mar 2023 14:00:50 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yangfl <mmyangfl@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] HID: kye: Add support for all kye tablets
In-Reply-To: <CAAXyoMPMbYCV7br9DJn_KCq68RLnimockqU0uvsO8maT3ROxTA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2303241400340.1142@cbobk.fhfr.pm>
References: <20230207043318.23842-1-mmyangfl@gmail.com> <nycvar.YFH.7.76.2303101506030.1142@cbobk.fhfr.pm> <CAAXyoMPMbYCV7br9DJn_KCq68RLnimockqU0uvsO8maT3ROxTA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023, Yangfl wrote:

> > > This series refactor kye tablet descriptor fixup routine, by using a
> > > template and filling parameters on the fly, and add support for all
> > > possible kye tablets.
> > > ---
> > > v2: fix missing rsize assignment
> > > v3: fix geometry
> > > v4: split patches
> > >
> > > David Yang (4):
> > >   HID: kye: Rewrite tablet descriptor fixup routine
> > >   HID: kye: Generate tablet fixup descriptors on the fly
> > >   HID: kye: Sort kye devices
> > >   HID: kye: Add support for all kye tablets
> > >
> > >  drivers/hid/hid-ids.h    |   9 +-
> > >  drivers/hid/hid-kye.c    | 917 +++++++++++++++++----------------------
> > >  drivers/hid/hid-quirks.c |  14 +-
> > >  3 files changed, 414 insertions(+), 526 deletions(-)
> >
> > Now queued in hid.git#for-6.4/kye, thanks David.
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >
> 
> Thanks. But seems you missed the last patch.

Weird. Right you are. I have now fixed that. Thanks for catching it,

-- 
Jiri Kosina
SUSE Labs

