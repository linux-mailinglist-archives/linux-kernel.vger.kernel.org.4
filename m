Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666EB6DC5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDJKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDJKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:16:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601DB19A9;
        Mon, 10 Apr 2023 03:16:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s2so785050wra.7;
        Mon, 10 Apr 2023 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681121794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y87tZFoC/KdScQr6abhaMOpEnoPUy3mE3ceR7Hpef7c=;
        b=XGe4Iz0EmXtSua5NiypvfHiGB/IVZKzquVds3lD+x0SgFvYbDsmasHmrv70MVqcoKo
         IjvemB+CjzKMliRNv1qjJphwpwtiyYRA+tfZ+xvGfv6Sd8nXQi92aYKhjBYRv+ztwpNE
         SxVHk6TUCUwMgKKcDzMiFwpyNNlvxy+SNL8Fcs2Nophf/lum+oh2PQBBC2pvHajUHHbV
         MC1W79WVFmKASAn7BLbBP7ZDskLnbuf6sTmuORI67WBeaZ7YCaghvi4pL+IQJoRYnn3l
         DW6GIYP5v9lPQJvpQWYgbl0+z22j21B6aCwFRrRvpqZYaVV9ctZNDwjocyP8IH/C63RV
         u9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681121794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y87tZFoC/KdScQr6abhaMOpEnoPUy3mE3ceR7Hpef7c=;
        b=qP4UuFpHBBuaXfg5w4Tm49Ud727l6Fet/upQrnmD7DjQb8m1MKXkcOXpBbpz50koEl
         xUc9l6abW2g7T9Yz27CLaXbz8paCqiWHfUi+aLnh/HujpV8rV75poZEa/yb4VNXRT7Ob
         wz2BrvtMMNeZFvgPdVLLnq6kpdwlleQf1GdvJk5+1mO6yY9nEB2WtE4kErDgXCQ8FcLD
         X+ZnJN+G3gGWyVwSjEQdbr/EAVmH80X4jSOPdCKdE0ZhZcCS/qE0W3c6zAqQuPMw5VIm
         NmGt991qYzMKKpQOGOV4Pko2El0xjE0xKmgnc9J386sX5p/lgj0ksq5Sd6pDAvnI/Gpc
         r/BA==
X-Gm-Message-State: AAQBX9en/64BdYI6qfDRo5hCVtaNz0h1NfTcWPOLuBeT7V4WpG7fMaCz
        4se0ulSRLKOTzsCCOb7a/2RqgpBnm4X5F0irXho=
X-Google-Smtp-Source: AKy350biPu21FdDFHs9CmRz24gJ63Y/R+xvNeM/1dfBNjgthiKxQ2qdP4cgvG66pNRoCbkQhwwCgu0IOnqKS+NFTs9g=
X-Received: by 2002:a5d:6391:0:b0:2e6:e4df:a7bd with SMTP id
 p17-20020a5d6391000000b002e6e4dfa7bdmr1348525wru.7.1681121793754; Mon, 10 Apr
 2023 03:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680610554.git.mazziesaccount@gmail.com> <20230408104938.74a36f7a@jic23-huawei>
In-Reply-To: <20230408104938.74a36f7a@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 10 Apr 2023 13:16:22 +0300
Message-ID: <CANhJrGPBdJwaoDFy=Rp38k_uSsZrzzMSSKxswwbur67YGG0ZrQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/3] Improve kernel docs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagath Jog J <jagathjog1996@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

la 8. huhtik. 2023 klo 12.34 Jonathan Cameron (jic23@kernel.org) kirjoitti:
>
> On Tue, 4 Apr 2023 15:24:15 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> > IIO has very nice facilities for efficiently providing data from a
> > device to user (and probably also vice-versa - but I've not used that
> > direction). Getting started with IIO may not be so simple though - some
> > of the concepts like triggers and buffers are quite unique.
> >
> > This series tries to make it easier for a newcomer to write his/her first
> > IIO driver by adding some documentation to used enums. Series does not
> > provide extensive documentation but just documents those few entries I
> > have become familiar with - but it still aims to be a starting point for
> > others to add missing bits and pieces.
> >
> > This series is marked as v2 because the patch 1 was previously sent as a
> > stan-alone RFC to collect the missing channel units. RFC can be seen
> > here:
> > https://lore.kernel.org/all/10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com/
> >
> > Patches 2 and 3 were added as a result of discussion followed by the
> > RFC.
>
> Something odd happened on this resend. Patch 1 didn't make it to me
> or patchwork.  I'll reply to previous posting instead.
>

It seems checkpatch.pl + some of the patches were only picking the
huawei.com address. Maybe that is the reason?

This really was a resend with no changes other than rebasing it -
hence reviewing the v2 was absolutely fine. Thanks for the review!
I'll check the suggestions and send v3 later this week.

Yours,
  -- Matti
