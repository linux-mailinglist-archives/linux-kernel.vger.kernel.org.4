Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C45F580C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJEQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJEQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A647CB40
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FE79B81E73
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508C9C433D7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664986245;
        bh=2kAcxYh/aDNzXrxp4mtWajIo28uI6uHs4/Lk0YeAACs=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=oATKaZ93ZEoYuSpBeoQ4oPNBMYIVBiss066ImimQvT2C3chmDp1w8+KMhcesaONbF
         nsFGIxkTqHzGT3EsZTtwMg8DUnch7YUdgoOPYK/qj/+1qsj7IZg5JupsHJiXxJA5GK
         D+gyKwwFd5qKjVYoavo4bZz/IKHyTBXBNUfTQDvY0b9Om8JwFFf25OJmERaBk1jMXF
         gD5oacXpyogd0H8hyHKyMpbrpkA2QuQT1zSKW8jIocKLkImLkkpgedN7QwJ+yLsfOy
         KhpIWhssaQ/NCeiuQVpolxTvuUW9p8oGpSQ3+Vo982Mxm15wboxXO6h3da+i7wc2fW
         xmcAB1q5qDDHg==
Received: by mail-wr1-f41.google.com with SMTP id b4so19720778wrs.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:10:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf3vA9ekNtqaSUfub1aA3jHBQHi+qF+rMQAOBoAw7IHiMqzSIL94
        ZD1c01/nuciam0F+/+XORn/h0sYkE8bwN0HZjcM=
X-Google-Smtp-Source: AMsMyM7uvd/Y7yJn8mca9vBdHt6k+1Qqil9T1D/MPy/es5QUUYqMnoFlEATJ/1BSFU9T8qfAdzLVLvWKR+5I+O6j2I8=
X-Received: by 2002:a5d:59af:0:b0:22e:32be:60f1 with SMTP id
 p15-20020a5d59af000000b0022e32be60f1mr310576wrr.81.1664986243596; Wed, 05 Oct
 2022 09:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220902184543.1234835-1-pgwipeout@gmail.com> <YxTDBpkllQjf0nIW@matsya>
In-Reply-To: <YxTDBpkllQjf0nIW@matsya>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 6 Oct 2022 00:10:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v664UnNC_UP-yFFLD9gCLnc989VAvUw1BghrctxdmLfVDA@mail.gmail.com>
Message-ID: <CAGb2v664UnNC_UP-yFFLD9gCLnc989VAvUw1BghrctxdmLfVDA@mail.gmail.com>
Subject: Re: [PATCH v4] phy: rockchip-inno-usb2: Return zero after otg sync
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Samuel Holland <samuel@sholland.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 11:24 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 02-09-22, 14:45, Peter Geis wrote:
> > The otg sync state patch reuses the ret variable, but fails to set it to
> > zero after use. This leads to a situation when the otg port is in
> > peripheral mode where the otg phy aborts halfway through setup.  It also
> > fails to account for a failure to register the extcon notifier. Fix this
> > by using our own variable and skipping otg sync in case of failure.
>
> Applied, thanks

This should have been applied for v6.0-rc, not -next.
We now have a v6.0 release that doesn't boot properly on RK3399.

ChenYu
