Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772455EC2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiI0Mak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiI0MaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:30:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E7901BB;
        Tue, 27 Sep 2022 05:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A912FB81BB9;
        Tue, 27 Sep 2022 12:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B380C433D7;
        Tue, 27 Sep 2022 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664281808;
        bh=B989o/0f4mwoW5XHVjIM92nokqZCKAPHz/bfsK5HlUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rfZ9j3sIbnp6HZ/sJW6QSaLs4foWtLDb9JfRvJu+bkgdSVAC6mFW9BKzOoERcot+w
         Vhu4CVQmmH7WzEqwXajdI9WeZhb8VUm4XiOZo5EkZBd9faUZugv7eY3ml7gmn1pZsR
         zdiYe+2AvwBGstwfNEWAa7DwZ9nm23bW+5zIkxvkd020EjucuBoXFEVv5AYlFOiPY+
         wLAphp4AMIGDqisgMQdU327uhh2p1+F+7ppLySucYScxN1DtunTTTuUev7ZuSY/fC5
         7qNPxb3klKbkwByFk9nwvxSMne3iyUeVmyljGbyKqVbLrOYIuNvme80Skp8k5/QQzk
         p8GpViFMiv98A==
Received: by mail-vk1-f170.google.com with SMTP id b81so4856540vkf.1;
        Tue, 27 Sep 2022 05:30:08 -0700 (PDT)
X-Gm-Message-State: ACrzQf3k5YB01IXTBagAfPqfvv9yj9kjRXFzb/0J9s2cm1vPK7DI94Fj
        uQh1GDOXbgofTuZm9pz7DZcPjaM0AisvbwVuaQ==
X-Google-Smtp-Source: AMsMyM7YcDr8vEyieBj3wyBHJA5MqjsHZ8xa1SO2PDwt6RYMiyJoTNIWExRnJrVDPIaik81nft1IMZnQb/bFEJUSjwY=
X-Received: by 2002:a1f:240f:0:b0:3a3:7b48:81cd with SMTP id
 k15-20020a1f240f000000b003a37b4881cdmr11080755vkk.19.1664281807155; Tue, 27
 Sep 2022 05:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220918094915.19567-1-yuanjilin@cdjrlc.com> <20220926185852.GA2581083-robh@kernel.org>
 <YzJaIolrTarQ4Qdn@debian.me>
In-Reply-To: <YzJaIolrTarQ4Qdn@debian.me>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Sep 2022 07:29:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKb595eUCL6k6yjGm=wn9AbcyvcKiD71jEw0M_y=+UVsA@mail.gmail.com>
Message-ID: <CAL_JsqKb595eUCL6k6yjGm=wn9AbcyvcKiD71jEw0M_y=+UVsA@mail.gmail.com>
Subject: Re: [PATCH] of: device: fix repeated words in comments
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 9:04 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Mon, Sep 26, 2022 at 01:58:52PM -0500, Rob Herring wrote:
> > On Sun, Sep 18, 2022 at 05:49:15PM +0800, Jilin Yuan wrote:
> > > Delete the redundant word 'of'.
> >
> > Again? Sigh.
> >
> > Please read:
> >
> > https://lore.kernel.org/all/CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2zCz67w@mail.gmail.com/
> >
> > >
> > > Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> >
> > Are you sure you are the author?
> >
>
> Hi Rob,
>
> Some reviewers sent comments for similar patches from @cdjrlc.com
> people (including myself at [1]), with some of them requesting changes.
> However, there are never any responses to these reviews from @cdjrlc.com
> people, just like ZTE developers sending through cgel.zte ignored
> review comments [2] (try searching `f:"cdjrlc.com" AND s:"Re:"`, it returns
> nothing for now).

I can't decide whether to fix it correctly myself or leave it to see
how many times I can get the same patch. :)

Rob
