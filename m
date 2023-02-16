Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0306469939D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBPLuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:49:58 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B9C3;
        Thu, 16 Feb 2023 03:49:57 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v17so1757614qto.3;
        Thu, 16 Feb 2023 03:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vRXh53rDIPfkOghYvjcnBS1VR8mTE7eIS5ytjBUNN+Q=;
        b=o5C/1GlDs7Nx4gq1hcPr8Z58lI3DeImupM7x2ccCT0kE/4zfs0dnziyjvwjtJpp/VU
         CmiukAFax7sDeM7HzhbmzWT2Mmqv91KCgFwmBaGsTuOfpFYQFzPHMRm1PZNCmTd9+1Er
         hJjISfwOkeQBpNEuJ76zsEI56lp4dJNnMh3vGpqYbRYUJKRE37Fn//2XXwoG7h4d50oL
         jdW5HB11PTnoS5SUNb7cAZ60bdxlePR7QRQYK+dtCci3S4Tw1OY4i4MjAuTQSEISvNHA
         cfzhrni+6qJBYWjV3vdhTOAp1vbhoixVVMnhou/FuM9qipT5fHBHgr3a+1sAF2iB1imd
         cGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRXh53rDIPfkOghYvjcnBS1VR8mTE7eIS5ytjBUNN+Q=;
        b=pRUaUNwj2WXIVEeJ3dZJm56jSVbSrkNvAO6pGCK7DZ27TEkOKF3mLzSGYJH5zcfVg6
         8/LfIeeJGCR2QoMtkZ4u7FcdLQkkJOmBTLtUXBfOzYdzzkhd0nM5ysFrnz7kHXpLNH7g
         KnTZCaB/yKQNBceoEzUcBdICsr++yeLy61GMHWpn0+P5/ec0nGP4g3ucl2sGt6zRKPyh
         jNwBnRiXolEqkBx7hBc55Hs5lF3bFtz9LUSONFfggg6yiR3ssb5bgqBFoEAAWfYWKVjM
         tVhLGbMRlOH1opQbIql0ytykgtFJ77Aa4mru7iY9ce+NDHLTktKdIruH4pri6EC6NA9H
         OCig==
X-Gm-Message-State: AO0yUKX9N5cLIlkyMPBmri4uWUkDQ1ijV8xj+6R9ZkiKAY1gU3gB1KK+
        KJY0PQFZE07dYC2QdKuLfxTZK6tkZOg55Ao6L+U=
X-Google-Smtp-Source: AK7set+I31Cl3AIUfxzv+fEgeIfaPFm8Q3LG+x4PwzMo8O9raTMc6wGum1zrT7P6yQgByG5JenYn+VT4YdblVaHHGyk=
X-Received: by 2002:ac8:5fd1:0:b0:3b6:82ef:2d6 with SMTP id
 k17-20020ac85fd1000000b003b682ef02d6mr639948qta.24.1676548197007; Thu, 16 Feb
 2023 03:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20230216041224.4731-1-orlandoch.dev@gmail.com>
 <20230216041224.4731-3-orlandoch.dev@gmail.com> <20230216181050.52a31247@redecorated-mbp>
In-Reply-To: <20230216181050.52a31247@redecorated-mbp>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Feb 2023 13:49:21 +0200
Message-ID: <CAHp75VeX0j8ZX+j0i7qPe97NcyFLvhmETFCbRVYiVCFQWk8Akg@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
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

On Thu, Feb 16, 2023 at 10:15 AM Orlando Chamberlain
<orlandoch.dev@gmail.com> wrote:
> On Thu, 16 Feb 2023 15:12:28 +1100
> Orlando Chamberlain <orlandoch.dev@gmail.com> wrote:

...

> >  drivers/hid/apple-magic-backlight.c | 125
>
> A general question to the hid/input folks:
>
> Is it alright that this doesn't start with "hid-"? All the other
> drivers start with that so I'm not sure if its an issue.

What makes apple so special?

> If it is, then
> I can rename it to "hid-apple-magic-backlight".

If there is a good justification of not doing that, put it into the
commit message.

-- 
With Best Regards,
Andy Shevchenko
