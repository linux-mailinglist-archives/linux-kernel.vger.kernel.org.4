Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713D75EB493
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiIZWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIZWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD293B4;
        Mon, 26 Sep 2022 15:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCEBF61474;
        Mon, 26 Sep 2022 22:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38709C433C1;
        Mon, 26 Sep 2022 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664231402;
        bh=daJUsJdpezSteh4PXZTQzO/Wj8zE/TGbRLm95dLUJTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DHO/eYpw22NjkkzgLcbAIgXyvcbjYSZJ8Gj3T05jFCFyi0aO7GG8UKoBFxcxuvhqP
         o95RRqSvAA7W3zfxKvp3vPZhfHADu07j1dDXhUo6VWv433BqZqsqZtHL8Qqvf1J/+Z
         5pbO2KtQBgPPNlOAgZuVToOxwUcoOrU0N98hB+6uGkEqr2lCVTHQ7Fce9t4s13holb
         StpwMxy/maF6OCUGNtfIMUX+wFRWRoECXX3l0xwiQTTa8PfrcLlc2zOMvPVKpVBo4R
         JHaxrrZucjkoygTeLBERXzdneJho4ubHZKqqNv/X042I3VbRDmvmznMXD/j4RwRRSB
         UcahDe+qKfMKQ==
Received: by mail-vk1-f171.google.com with SMTP id r193so1354072vke.13;
        Mon, 26 Sep 2022 15:30:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ZB+TV6xKU9z3ZEDAyi+kFg+yURrL5xVOlbzmG5r6jX7CO41H3
        pJsl+vbvTFoMudS/92iF6Vx0m+Qpnc13GvHQVw==
X-Google-Smtp-Source: AMsMyM5KqIX5xQrSAflubc/OxKMjhvK4ygSQNRjUCGNoqKizrhSfwSJv1m6fk3LqrOdrMBCWPGUO0DHobIE+SXEwLq8=
X-Received: by 2002:a1f:9fc5:0:b0:3a3:44f1:be23 with SMTP id
 i188-20020a1f9fc5000000b003a344f1be23mr10054334vke.35.1664231401156; Mon, 26
 Sep 2022 15:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba> <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
 <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com> <20220912170524.GX4320@zorba>
 <75e803f8-2b25-22c8-0831-e90d0c889da1@gmail.com> <20220913005153.GZ4320@zorba>
 <00850627-7ada-3a02-158c-30f3b8334d51@gmail.com> <20220916225646.GK4320@zorba>
 <b6a43df4-e5d8-06d2-a6b9-3626f2677161@gmail.com> <20220917032610.GM4320@zorba>
In-Reply-To: <20220917032610.GM4320@zorba>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Sep 2022 17:29:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+MmkOP=LWi7GwpsWBVUepfHMRh1hvegCoGOTM+ZsvZjw@mail.gmail.com>
Message-ID: <CAL_Jsq+MmkOP=LWi7GwpsWBVUepfHMRh1hvegCoGOTM+ZsvZjw@mail.gmail.com>
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        xe-linux-external@cisco.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 10:26 PM Daniel Walker <danielwa@cisco.com> wrote:
>
> On Fri, Sep 16, 2022 at 09:47:19PM -0500, Frank Rowand wrote:
> > On 9/16/22 17:56, Daniel Walker wrote:
> > > On Fri, Sep 16, 2022 at 05:47:54PM -0500, Frank Rowand wrote:
> > >>>
> > >>> Maybe you could add a flag or other indicator which would indicate the overlay will never be
> > >>> removed. Then your code could rely on this property to inform on if the author
> > >>> has consider the removal issues related to overlays.
> > >>
> > >> No.  I guess I wasn't clear enough above, where I said:
> > >>
> > >>    "And I will not accept a
> > >>     change that suppresses the message if there is no expectation to remove the
> > >>     overlay."
> > >>
> > >> There are multiple reasons for this, but the most fundamental is that if a
> > >> new overlay is not removable, then any overlay already applied can not be
> > >> removed (because overlays must be removed in the reverse order that they
> > >> are applied).  It would be incredibly bad architecture to allow an overlay
> > >> to block another overlay from being removed.
> > >
> > > So how about an option to turn off removable overlays entirely? As far as I can
> > > tell it's not used currently by the tiny number of implementation I've seen.
> > >
> > > Cisco doesn't need it, and we could have a smaller kernel without it.
> > >
> > > The issue is that the error log on blast is log level abuse in my opinion. If
> > > there's no way to fix it, it should not be an error.
> >
> > The way to fix it is to not have a construct in the overlay that triggers the
> > message.  In other words, do not add a property to a pre-existing node.  (At
> > least I think that is what is the underlying cause, if I recall correctly.)
> >
> > -Frank
>
> Here's the check,
>
>  if (!of_node_check_flag(target->np, OF_OVERLAY))
>
> If the print shows when the modifications is made to a non-overlay, I'm not
> sure how you could construct a device tree where you only modify other overlays.
>
> It seems like this should print on the vast majority of overlays.

There is essentially zero support in the kernel for nodes to change
once they are in use (typ. bound to a driver), and I don't see us ever
supporting that use case. Unless shown otherwise, I don't think that
is a good split between a base DT and overlay either.

What I've said multiple times for supporting runtime overlays, is that
it needs to be restricted to adding/removing whole nodes/subtrees.

Rob
