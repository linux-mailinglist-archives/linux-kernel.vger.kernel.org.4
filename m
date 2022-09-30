Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853705F03F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 06:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiI3E4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 00:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiI3Ezz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 00:55:55 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D0D127C9F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 21:55:21 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 254D03F1C5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664513075;
        bh=ux33z7H02aeUKz+r07uUOZtr3NLmpYkTJn7m+ajiqak=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QDLwRbLkoAhn9dPVgk24XjJQN7TeqsQ3urioQBeJkRfz4e7EutXdBuE42w35Jgxkf
         yyBF3wjPDiyI1WaeCpOQCSeWymRy0dAZvWHwPCHgexfHrQPlyVgvXgikB5Vhyz0RYM
         JKxOxqsW5Peq1RFxmeZmnlpcYidOkeEEMUWGzcDnPblBFYGi1LFzczh99JJkHx17vJ
         Ci+zlEQvlAmMB0q+qnwMq3Tp+Xi3sPaLn0w6isaKk3CA/2rztjKneT90Wtn5vdUg1V
         DZ08N32x+EMtHCFLXwcJ/ufPlsEfGRvdIfgrtvOlbONXYEGBKK+OzuS5JfBSNDl1Ra
         TU0w2PcmsIgOg==
Received: by mail-pl1-f200.google.com with SMTP id h11-20020a170902f54b00b001780f0f7ea7so2421794plf.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 21:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ux33z7H02aeUKz+r07uUOZtr3NLmpYkTJn7m+ajiqak=;
        b=rI7LJS1NyjtpWbLkhePRYoJZ9HXOMaJirlSJyhB6y+/rdWUcjeBRBVqYXPI7ivDMBv
         7Sw0ftjLVDA8S70yu16gUoEyglFGKmJ/nh/rt0tCRn/r0dp13Qe4hJvGnZRLhLKD0Ng4
         W2FZa8GjKtjAEqa4pGJuSOhnpnO0DFjHEvDOeLUjMkaHsK2Wy/pKgpbNNlZ628MKEaIS
         wGcZ8DmQEwxcKqKGsFTI8/knoV3YHV+25UFwar1iInCDlt8fDFw6zVADcnWPpf4l/Vnb
         2qeQ7Xejf9JXIVTkRmvPrySc2/4XFI3A1VWMZ9WtqkzfzjE6OtuiJhHGNCprCnIrXH+5
         HUHg==
X-Gm-Message-State: ACrzQf0Ly15g/zr4MpPR7PzCgDWny23uplH3try29Rt0JZptvQJKshHl
        0gaRJHBZ6UGL1ntk4+5VTNzhMq3fSj62bwQ+NmPEAP0vUyPqfIEHE+EZSPZ4bEDZPQWfzzRDRBS
        NFTST5oxyarnQaC1azV4CXxEv2sdYlRUGxI//m6l7xNDUlzll8Ep7c1oVFg==
X-Received: by 2002:a65:498b:0:b0:412:8e4:2842 with SMTP id r11-20020a65498b000000b0041208e42842mr5994922pgs.71.1664513073461;
        Thu, 29 Sep 2022 21:44:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7o+zURSqlabmjLr1RsgQuhoRn0j1PHFVEdM97/h6usvgfHP0rrcUpv5yIS+xoCLI8bzmxVyC7qwjdvS34EuNM=
X-Received: by 2002:a65:498b:0:b0:412:8e4:2842 with SMTP id
 r11-20020a65498b000000b0041208e42842mr5994912pgs.71.1664513073191; Thu, 29
 Sep 2022 21:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220830093207.951704-1-koba.ko@canonical.com>
 <20220929165710.biw4yry4xuxv7jbh@cantor> <YzXRbBvv+2MGE6Eq@matsya> <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
In-Reply-To: <4394cae0b5830533ed5464817da2c52119e30cea.camel@redhat.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Fri, 30 Sep 2022 12:44:22 +0800
Message-ID: <CAJB-X+XYq6JRewKkPu0OSnEhJAsW5qFcs2ym2c+wErxWgoXGDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: Fix client_count is countered one more incorrectly.
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 1:26 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> On Thu, 2022-09-29 at 22:40 +0530, Vinod Koul wrote:
> > On 29-09-22, 09:57, Jerry Snitselaar wrote:
> > > On Tue, Aug 30, 2022 at 05:32:07PM +0800, Koba Ko wrote:
> >
> > >
> > > Hi Vinod,
> > >
> > > Any thoughts on this patch? We recently came across this issue as
> > > well.
> >
> > I have only patch 3, where is the rest of the series... ?
> >
>
> I never found anything else when I looked at this earlier.
> The one thing I can think of is perhaps Koba was seeing multiple
> issues at time when he found this, like:
>
> https://lore.kernel.org/linux-crypto/20220901144712.1192698-1-koba.ko@canonical.com/
>
> That was also being seen by an engineer here that was looking
> at client_count code.
>
> Koba, was this meant to be part of a series, or by itself?
>

Jerry, you're right, it's a part of the series.

>
> Regards,
> Jerry
>
