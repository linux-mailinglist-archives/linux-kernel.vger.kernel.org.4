Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA18A705C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEQBVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQBVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:21:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B750646B6;
        Tue, 16 May 2023 18:21:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae50da739dso1230065ad.1;
        Tue, 16 May 2023 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684286502; x=1686878502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc5kCvbNWz3KM2SNUBOoevcDuTxR/og4VBr5RaEEGus=;
        b=QjV4sMA0vpAF1Zbq8t+2lq2LPbm+asq9DFF85vgRjw54vytEpt3eMOnlOZ3/hYKfut
         fg37O2x85XtFIxq97+xB2BOJBHh4dc1CvKnJTbIVk4EEDr1W08nlgy6YLQZK0xCA0rjO
         KPh2aYjCktdn8uBh4d3zdGAuX9/H1BOwNX8jTh4hD78yOV0XRhUJ6fTx70buM0VnQeEJ
         wS92wzUnY7+GjMfeGtH7dhiMXPL1fuXoSJ4foNsQ54ccC8axf2ZOaeZOO5brr227n4kD
         yntIrpI1EDAggAsOsiU3av2I70H5XXVG6R/2MXM6pe5s8rtWz2n7OBsjU5qJj/wC1qTk
         bytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684286502; x=1686878502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc5kCvbNWz3KM2SNUBOoevcDuTxR/og4VBr5RaEEGus=;
        b=feJq7z/ylHGY1ZfRZNGQZPfa4vLzMRjqVrqVWSY7VxMlusd1WsGVd3BQz8AgaZNNh7
         lQSwr02mSfzfueXcXtYQ/4NDVptw6Wxf5wYViXOG6AYgy2M6QMP2muV97GgBj2P1ogD4
         crwpk2vAZxKZYyJ2QjEu757wNFIg9yi5/dVM8Y5LVstbGJlH2RABlxEjrxreUb7pCj0w
         EJ+EwB3r3B35VALo4prxWKfU9N3YNrVNwWFumc0nSKoDfyn+VVqH+T1My0lRwGcHIAQL
         W+Hb5bZACzlJ6Im2VYQw7d5JUWvgfOqRQVRsxxS9PMHBRDN1scC4qzk9V6ItlGB28d2a
         sQCA==
X-Gm-Message-State: AC+VfDwkTaKQA20ULhifxK7ubuxRrtGZnQA1KaDFTEEBSJqmGRlwXsdm
        msUgUMSPtuiZP7GZdXQ+zWY=
X-Google-Smtp-Source: ACHHUZ7xl6fh/WH6JnOATEgOGGGGp3TvP/rtjK58iuVtwTmuT+XxljRplIMLnEAwpHLQ7L1bZrCE0Q==
X-Received: by 2002:a17:902:ec85:b0:1ad:e746:ca50 with SMTP id x5-20020a170902ec8500b001ade746ca50mr22360069plg.2.1684286502180;
        Tue, 16 May 2023 18:21:42 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id ay8-20020a1709028b8800b001a9a3b3f931sm16181989plb.99.2023.05.16.18.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 18:21:41 -0700 (PDT)
Date:   Wed, 17 May 2023 09:21:36 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZGQsIEmrWlM0fK9v@sol>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
 <ZGQkEdZ6DoJbgiFh@sol>
 <457859be-257a-5528-d5dd-d59c4c9c0636@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457859be-257a-5528-d5dd-d59c4c9c0636@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 01:07:25AM +0000, Chris Packham wrote:
> 
> On 17/05/23 12:47, Kent Gibson wrote:
> > On Tue, May 16, 2023 at 11:50:42PM +0000, Chris Packham wrote:
> >> Hi Kent,
> >>
> >>
> > Given appropriate line names, that is already something you can do with
> > the libgpiod v2 tools.  Something like:
> >
> > `for x in gpiochip*; do gpioset -c x tx-dis=1; done`
> Would that deal with the fact the GPIO lines are port1-tx-dis, 
> port2-tx-dis, ... port96-tx-dis?

That is assuming the lines are all given the same name - "tx-dis".

If the line names are all distinct, and you can generate the list, then
you could provide that list to gpioset instead.
e.g.
`gpioset port1-tx-dis=1 port2-tx-dis=1 ....`

and it will work out which lines are on which chips.

Cheers,
Kent.

