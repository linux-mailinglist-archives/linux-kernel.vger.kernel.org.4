Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483DC5EC580
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiI0OHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiI0OHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DF31B14CC;
        Tue, 27 Sep 2022 07:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48FB619A2;
        Tue, 27 Sep 2022 14:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B69C433D7;
        Tue, 27 Sep 2022 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664287648;
        bh=zzApm3YbxwwBjwPAWZr5XX6s78O6jQ2TeF6um5gEkMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tgt/Bk37cdmUoLab/DzCiZNmw556sPsOitMXLHG5Iwyqich9nRnqN8oQTw/9ipZ0/
         KHpy5p3I2qeLyA5Dv9S5V8sYmevqfmN13hWVJ79dYWv0r2cHCyamG2YNX0I1DESeNb
         jcMKvFeAOEt/eT7Zfjt/945TpNtOocVUdkmVP881v39ZETFYdoeIuVMFC2wl+kQMVX
         PL+untVUNajXQq3KVLG6Ha1fvFPjHfUzSoJShjyy1aQpHpZBcMOGYKmosipY/RS1VF
         75MDi6YcucHwxj7Y0CdH2dqpDOqna1D7D54my3uClW4ty0veSYx08B5JC7jj7yOWgA
         7q5Ls2fJtBTQA==
Received: by mail-vs1-f54.google.com with SMTP id j17so9780360vsp.5;
        Tue, 27 Sep 2022 07:07:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf3XPQoSO2oFg71mJikKPbcv2IHG45bPyxbA6HbKJ+FboBkX2a0C
        b7aDfQHuIyBzf7cIM4wFZy4BN64tH0Gn1HKnjA==
X-Google-Smtp-Source: AMsMyM56K5CtVi3wlYZFB+KAmT5nqbjlimeXatZo9vdyUvxaMV+oWayihLzTK1gcdSaLYEWPgZSCprNwI/iHId0uVDs=
X-Received: by 2002:a67:c18a:0:b0:398:4c72:cafb with SMTP id
 h10-20020a67c18a000000b003984c72cafbmr10416210vsj.53.1664287647289; Tue, 27
 Sep 2022 07:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220918094915.19567-1-yuanjilin@cdjrlc.com> <20220926185852.GA2581083-robh@kernel.org>
 <YzJaIolrTarQ4Qdn@debian.me> <CAL_JsqKb595eUCL6k6yjGm=wn9AbcyvcKiD71jEw0M_y=+UVsA@mail.gmail.com>
 <8821ae25-eb20-b673-6d57-fb2cc03d9726@gmail.com>
In-Reply-To: <8821ae25-eb20-b673-6d57-fb2cc03d9726@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Sep 2022 09:07:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJcs9N9m8ymQRWx3VV=7m2959FOrcuTpU6JDRuMwUeX9Q@mail.gmail.com>
Message-ID: <CAL_JsqJcs9N9m8ymQRWx3VV=7m2959FOrcuTpU6JDRuMwUeX9Q@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 7:47 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 9/27/22 19:29, Rob Herring wrote:
> >> Hi Rob,
> >>
> >> Some reviewers sent comments for similar patches from @cdjrlc.com
> >> people (including myself at [1]), with some of them requesting changes.
> >> However, there are never any responses to these reviews from @cdjrlc.com
> >> people, just like ZTE developers sending through cgel.zte ignored
> >> review comments [2] (try searching `f:"cdjrlc.com" AND s:"Re:"`, it returns
> >> nothing for now).
> >
> > I can't decide whether to fix it correctly myself or leave it to see
> > how many times I can get the same patch. :)
> >
>
> Hi Rob,
>
> I'm not talking about whether this patch should be picked up or not, but
> rather I'm pointing out the ignoring review behavior of @cdjrlc.com people.

Yes, I get that. Not responding seems to be a growing behavior not
just on these trivial type patches. (Though replying with 'ok' to
every review comment is equally annoying.) I suppose there could be
some filtering happening such that replies are never received.

Rob
