Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1205F5790
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJEPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJEPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:30:39 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7043112D07;
        Wed,  5 Oct 2022 08:30:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n83so17977651oif.11;
        Wed, 05 Oct 2022 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=X2C9NpjkzSIFyjSc8krQm4ahQQhwd6xH158mB569dTc=;
        b=aOiJu2zMzQds9XXZCJxWaOkP8JWwxUdyM6lxXECzdHlBqL53gRQjf0b3to37Rcoeek
         3b7u7jAKg76wuUJcbOt58rW+auewfBnoEnrtpsxHmDUSon9lPiKWkfBKlgfdEvMW/1YW
         fSioqNp5yOxBbhgiiBB3C0j1qO3zWH+51SdNabd7oJotJgT7cQGByCD1Po3reTTSdrIn
         6sTVdRySbdZINNVERtFhKfApCl624I2jUE4Svyvv8/0CPjI7F5lc6byhDet7Zgrhgtel
         E3E7gOcTUFeKDj8J3OymIqzzEwnshBQSynse457cE48sIV3SZRUIPYR1Dwg7dhZYitg3
         KzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=X2C9NpjkzSIFyjSc8krQm4ahQQhwd6xH158mB569dTc=;
        b=GoIhyCe8E9tm1SYOhh2wZXqMG8LN9h31fmK51AmapSLuzNfemQDgyI10QtrCfjK9bm
         lZhyefxEosjq/04CAtx3QWZ8MUV9qDWb6Gs4BHylN4liJf4G9AQoCz4VlFHMi7MZc8bA
         hpYzz+G+KCRETQoYNgjs2CBYb8kDEpy48kDcXSizjxw4VpHUEjzKydKklYmLP6JfHIZQ
         7hHdvQMiAs4Jo3e0XfBhtOd+5AvZNOnwUBBPUHVbmQ1ERN/isVt5KdbHkgyctPRJ+8EI
         ZMgaS7W1UVGWso36tkKeAQHuxjzL+/Oe0hrAK8ZYDRsJ503E6V/tLeIrejscItZiRFNM
         yPpw==
X-Gm-Message-State: ACrzQf3xH0vuuVgJbSVD5jA9N+w/nZPQWlqA9Nw8bscZMKemJgcyk1BY
        6nUPZB7MXoZp65AAVAmULcgHhVI9hFJy9LqkImw=
X-Google-Smtp-Source: AMsMyM5VwGJODOGxycweKrN1XoHFTMm4jpXK6PlMseeSAOkpc6Vzki8bBhh9s/IYeyDjekkcAGGFPc/JA22W0Fkx9HY=
X-Received: by 2002:aca:1b0f:0:b0:353:f306:198b with SMTP id
 b15-20020aca1b0f000000b00353f306198bmr182796oib.96.1664983837838; Wed, 05 Oct
 2022 08:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220930105434.111407-1-broonie@kernel.org> <20221004132047.435d42db@canb.auug.org.au>
 <CAMwc25oshRcJBoCT70B+b42bh5sPqgyoHuBx6K6ZLrwBMHnJzw@mail.gmail.com>
 <20221004140558.64f59f2c@canb.auug.org.au> <YzwbW4YQwQPsRPYw@sirena.org.uk>
In-Reply-To: <YzwbW4YQwQPsRPYw@sirena.org.uk>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 5 Oct 2022 11:30:26 -0400
Message-ID: <CADnq5_PbPQPui1tOdUMB+OYbz6UBMKCgtwvE95oA+SfcN0RzNg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To:     Mark Brown <broonie@kernel.org>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Mahfooz, Hamza
@Aurabindo Pillai can you get this fixed up?

Thanks,

Alex

On Tue, Oct 4, 2022 at 7:39 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Oct 04, 2022 at 02:05:58PM +1100, Stephen Rothwell wrote:
> > On Tue, 4 Oct 2022 12:24:37 +1000 David Airlie <airlied@redhat.com> wrote:
> > > On Tue, Oct 4, 2022 at 12:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > > I'm not seeing it here, what gcc is this with?
>
> > I am using an x86_64 cross compiler hosted on ppc64le - gcc v11.2.0 (on
> > Debian).
>
> I was seeing this with an x86_64 cross compiler hosted on arm64 -
> Ubuntu 11.2.0-17ubuntu1 from the looks of it.
