Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21DF642965
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiLEN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiLEN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:28:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AD7DF48
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:28:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y16so18595361wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6J+5H0KWEWYqjfx5EbQcfYsdjvKQnnhpjVdr0SMdxo=;
        b=KajtrDYkbGXekCAhlvBExpgniFq8X1oDyJALi1+eg+V7l2f/ImbF6FdsgoBk3rqrlW
         I5hqw4k2BmO6BBlttVXW/TDdiCK90mBsqe6AxSn3/kiyGOFYLKPPz5WMIRWo9W17uBt5
         Gjv+AUM0J8GhAONtLiyMwfQsZVniEShDX7PzSR5klCzqiskjBf0bV5kUplydwMhit5Kl
         8LTbJYOf64NAXABAhxHl5yHv2KoKu5outTvAs/LRCiN7tqNeQ2J0ij/shUlutXV/dImR
         O6RG/U7CASUyoE1c600wvJneN74tNMM/l7CLtICFQRPkqe/SG0rfge9o21v16H07HhRd
         gc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6J+5H0KWEWYqjfx5EbQcfYsdjvKQnnhpjVdr0SMdxo=;
        b=agjBjI/bxUK2Wo4DGIiXNBcL63vuj/XtBKIxic/uab/C+G5ayMHgVvwo9oozbxmJAa
         YLYA+ioCDlr7avBbLFiZ+AFOCtTfcDl2dZosHon3qNH+m0wSb2BGu+3FKlluSOZdGiYn
         vkkSuKJIEe6ZD7KEACv3vuhMvNN+R/GMwKdU5bEmanvkKCCdBfFrA9PebnKzp26gdADq
         Mpg7GwwQjdRqG0XMeC8pmJmP9SvxxGQ4aV7cK6QvtHB06A03WNNUyJqbnGb0WlzOxhNN
         Ni/FAuRFUSfsTqXIP06fCbZyT3SFUDEn05qn3HaAdSX2Au5ay5xmaWALzFIPLbBUMr4T
         GPaA==
X-Gm-Message-State: ANoB5pnZaosRgT66uXib7YeLfP+ilIzdiWND8rSSvmRyB4glbDUuiwUo
        z9kcpiv008oGmemQq8/XPs/k7w==
X-Google-Smtp-Source: AA0mqf5oN5IoGcH2Dda7EcklO+hxEGRSsULwk9da/QmVIVa2SIRbH1iJO1nCE6ZTZl0bT6vFV+fNxA==
X-Received: by 2002:adf:b610:0:b0:231:9b9f:652b with SMTP id f16-20020adfb610000000b002319b9f652bmr42911196wre.421.1670246933335;
        Mon, 05 Dec 2022 05:28:53 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h130-20020a1c2188000000b003b4fdbb6319sm21294013wmh.21.2022.12.05.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:28:52 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Eirin Nya <nyanpasu256@gmail.com>, phoenix <phoenix@emc.com.tw>
Cc:     'Dmitry Torokhov' <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "'Josh.Chen'" <josh.chen@emc.com.tw>
Subject: Re: [PATCH V2 3/3] Input: elantech - Fix incorrectly halved
 touchpad range on ELAN v3 touchpads
In-Reply-To: <20221202234206.6527835a.nyanpasu256@gmail.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-4-nyanpasu256@gmail.com> <Y4T2nygbxkhAQRvM@google.com>
 <Y4T21vl0mJocdpdV@google.com> <003201d904ae$05d38870$117a9950$@emc.com.tw>
 <20221202234206.6527835a.nyanpasu256@gmail.com>
Date:   Mon, 05 Dec 2022 14:28:51 +0100
Message-ID: <877cz6rncc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eirin,

On Fri, Dec 02, 2022 at 23:42, Eirin Nya <nyanpasu256@gmail.com> wrote:

>> If the setting is indeed double resolution, can we simply multiply 
>> x_max and y_max by 2 instead of re-querying it?
>
> Perhaps in some laptops, x_max or y_max is odd when resolution is
> doubled, and rounded up or down in half-resolution mode, so multiplying
> the half-resolution size by 2 results in a slightly incorrect full
> size. I don't know if that's the case in other touchpads, but my
> laptop's touchpad has even size in full-resolution (doubled) mode,
> meaning it doesn't round its size in half-resolution mode (so
> multiplying both values by 2 would work on my machine).
>
> On Wed, 30 Nov 2022 19:22:25 +0800
> "phoenix" <phoenix@emc.com.tw> wrote:
>
>> Consulted with FW team, we suggest re-querying x/y resolution after
>> setting absolute mode.
>
> My current patch re-queries x/y resolution after setting absolute mode.
> If this is the process that Elan's FW team recommends, should the patch
> be kept as-is?

Yes, I think you can keep it the way it is. Dmitry will either pick it
up or suggest additional changes.

