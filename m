Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117EF6756C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjATOQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjATOQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:16:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F63C45AD;
        Fri, 20 Jan 2023 06:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B1761F89;
        Fri, 20 Jan 2023 14:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42DC4339B;
        Fri, 20 Jan 2023 14:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674224098;
        bh=aT2QPER7G2pwEx35hjTz57D8G6XAX5GS99A1E1Dg2S8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oL2kaGiej98eDcuFimNLJv7iMH18XiO7sU5ZCFrEA1veGqeivzDikSXwBTSAv0RGm
         kxmsG8dcjR0OpJFq2auGq1KKz3nviMzjz/1/RhPKhBBoSP89YpfisCU7eir1aXzI3g
         DTLymK0oM4CxHaguYbFCWVYfqqWvuvoTCdljpS4LvzrJ2osKq9MQMwxyqZEVZXgO7u
         SUepPd5uzwbWTum0dYQ2BrlZqDW3RdMOWQ1IJ+4QeKoC+c5eatmTL6eefujbDFGRGH
         PeepFQ37keOBpiPj1wIjbtkVLniAdzW5Q1O+Ohqqf/JutYIf8ec7jW7eqHbgTsWKTQ
         hyV6qzMxP41AA==
Received: by mail-vs1-f54.google.com with SMTP id v127so5747515vsb.12;
        Fri, 20 Jan 2023 06:14:58 -0800 (PST)
X-Gm-Message-State: AFqh2kqKPxI2UX7J0llusPqm0FlUn3cruPO6VD84BIMJN5uHBecwR6mg
        Kn7MtFHVygcc8Av4N2YUwALqP0J5VRpdJdpUxg==
X-Google-Smtp-Source: AMrXdXsaHRx5tp7WwiGOksFRrbK1bg0v79HdqYyxlzRdi34zCccIWHHQIi/6gKtztP49xm7apRWR2lH7W3Q03vCB7aU=
X-Received: by 2002:a05:6102:5490:b0:3b5:1fe4:f1c2 with SMTP id
 bk16-20020a056102549000b003b51fe4f1c2mr2054571vsb.0.1674224097356; Fri, 20
 Jan 2023 06:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
 <20230119175135.GA2085792-robh@kernel.org> <Y8mt6ZCMf4YZvDYA@google.com>
In-Reply-To: <Y8mt6ZCMf4YZvDYA@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Jan 2023 08:14:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQd4W5-8ej48hAebvyA6neH=2hTtzVU5HhFpQ2yKsQFw@mail.gmail.com>
Message-ID: <CAL_JsqJQd4W5-8ej48hAebvyA6neH=2hTtzVU5HhFpQ2yKsQFw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
To:     Lee Jones <lee@kernel.org>
Cc:     Jesse Taube <mr.bossman075@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee.jones@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 2:54 PM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 19 Jan 2023, Rob Herring wrote:
>
> > On Fri, Dec 02, 2022 at 06:32:26AM -0500, Jesse Taube wrote:
> > > Some devices may want to use this driver without having a specific
> > > compatible string. Add a generic compatible string to allow this.
> >
> > What devices need this?
> >
> > Is that no specific compatible string at all or just in the kernel?
> > Because the former definitely goes against DT requirements. The latter
> > enables the former without a schema.
> >
> > >
> > > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > > ---
> > >  drivers/mfd/simple-mfd-i2c.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > > index f4c8fc3ee463..0bda0dd9276e 100644
> > > --- a/drivers/mfd/simple-mfd-i2c.c
> > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
> > >  };
> > >
> > >  static const struct of_device_id simple_mfd_i2c_of_match[] = {
> > > +   { .compatible = "simple-mfd-i2c-generic" },
> >
> > Simple and generic? There is no such device. Anywhere.
> >
> > This is also not documented which is how I found it (make
> > dt_compatible_check). But this should be reverted or dropped rather than
> > documented IMO.
>
> I thought it would be better than having a huge list here.

What indication is there that the list would be huge? We have 2 out of
137 MFD bindings. Usually if the MFD is simple, we'd make it a single
node. It just needs to be clear what the conditions are for using it.

> Devices should *also* be allocated a specific compatible string.
>
> $ git grep simple-mfd -- arch

Why can't simple-mfd be used here?

Rob
