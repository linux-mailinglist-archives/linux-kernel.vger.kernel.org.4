Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC4696D14
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjBNSiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBNSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:38:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747629411;
        Tue, 14 Feb 2023 10:38:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF57961838;
        Tue, 14 Feb 2023 18:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A869C433EF;
        Tue, 14 Feb 2023 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676399892;
        bh=zt9X2BlD/QOFBvRUFyEoYRvv/imLE4lhcxhq2FsN23c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c2AxS9jdnAKlYBFm3nSbGQDuJ0oGooeAZsCyLpqVsNLok/afypKqCjByA/SahuY5Y
         S9fNSdimTPh/1S3wd0K69PKmTBTltQ/M5tQhKn+dKEoOcaazHFoPmcCFYaV3cOsD19
         Z13ioOcCI8ZaAwkvWDXi1Ji55Wkh4783uSCfm9CX+wWiWF2mr9gIA3lZfbd71xx7tV
         pDV0kGrcqSiCQAuINQpz/v/ozifElLMSzPqU+zIAVx6/LzY+wiTsgGwiQ3ck7+bRK7
         2TH4gMeHX3xsLCu0rIDXgf0ur8W6Cpw+xWDiQWkLp2Hz3sijjiAvbFQVQ0v9NaqH+i
         YUHR4tVDCkzuQ==
Received: by mail-lj1-f172.google.com with SMTP id a9so19409929ljr.13;
        Tue, 14 Feb 2023 10:38:12 -0800 (PST)
X-Gm-Message-State: AO0yUKV2fNlydsD2xJxS4suhMfA6WNxKb6DiDh76Q443V0P2yKYOZtfS
        UwPYsgkTzbtTRbmM3aocfVCr8BMVLp/eyShSxxw=
X-Google-Smtp-Source: AK7set+CEG1WyNimA3QHERrbdHXEAIa/PyvekCI7ilROesupJOlW3Q4HK3XV52LdR4NIHD6WF+TSUEv1MtZSJfbRjm4=
X-Received: by 2002:a2e:a36a:0:b0:292:8597:6142 with SMTP id
 i10-20020a2ea36a000000b0029285976142mr495470ljn.5.1676399890282; Tue, 14 Feb
 2023 10:38:10 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZJvXpCt37nQOoe8qd1EPUpfdMM1HwHk9tVO8HdU_Azhhw@mail.gmail.com>
 <25578.37401.314298.238192@quad.stoffel.home> <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
In-Reply-To: <CACsaVZJ-5y7U5xqwL9bof69EKbTk+wrHWFcBFYyP_BwVSt+CNA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 14 Feb 2023 10:37:58 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4XPqY18k4DB2YXqaNgABp3HYYQtS7u0bGfjBcTgkpXkQ@mail.gmail.com>
Message-ID: <CAPhsuW4XPqY18k4DB2YXqaNgABp3HYYQtS7u0bGfjBcTgkpXkQ@mail.gmail.com>
Subject: Re: RAID4 with no striping mode request
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     John Stoffel <john@stoffel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

On Mon, Feb 13, 2023 at 1:12 PM Kyle Sanderson <kyle.leet@gmail.com> wrote:
>
[...]

> >
> > > The benefit of this can be the data disks are all zoned, and you can
> > > have a fast parity disk and still maintain excellent performance in
> > > the array (limited only by the speed of the disk in question +
> > > parity). Additionally, should 2 disks fail, you've either lost the
> > > parity and data disk, or 2 data disks with the parity and other disks
> > > not lost.

I think I understand the high level idea here. But I think we need a lot more
details on how to implement this, and what the system would look like.
Also, I don't quite follow why the data disks can be zoned devices and
still maintain excellent performance.

> > > I was reading through the DM and MD code and it looks like everything
> > > may already be there to do this, just needs (significant) stubs to be
> > > added to support this mode (or new code). Snapraid is a friendly (and
> > > respectable) implementation of this. Unraid and Synology SHR compete
> > > in this space, as well as other NAS and enterprise SAN providers.

Assume we figure out all the details. I will be happy to review patches in
MD code. But I won't be able to develop this feature myself.

Thanks,
Song
