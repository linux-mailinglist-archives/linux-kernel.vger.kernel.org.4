Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76662480B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKJROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:14:53 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FC11463
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:14:51 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k22so2765306pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6y6a9CCnRYcK46H9tBNyu9YqooXjHYmPole/YmAa0g=;
        b=d213MsYkK2b4xOJ++g+Vc2Dmf98bR79dIvZY1iGpZwGGR2D/JMeTzCBQAki0Ma/7sP
         qOZ4jHYEWAw1LP/GZsSYvejLpS87SylFjOIKS15bc7iO8ThVqw131oz8Sig6vKiVqN7B
         vETConGN+zJPn4AaA3/P2h2nloNCJh4hwyrht1Qo8nT8BZAF8EJTkco7n4SJt0o/MwRa
         WdTXr1hRz39oT92QPsXjmDo+r65QYRghYLjsLKxjZUFB8DV+lKf/eAycP93BoSs1KUmO
         7lMlAhuu8evK2LbvjhQ3Xnn1ddmzjto9g6uJdWIrk2G4lBOaeb+iCbu4p46LO58vFUxR
         Nkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6y6a9CCnRYcK46H9tBNyu9YqooXjHYmPole/YmAa0g=;
        b=jtiy0FmjoqypMHpE+MOvrNIro85xXbYSlLSDY/oZWrqb3IQYATZ13L4neqlSyyVkEd
         U3oeSfBVvnkwfN3W+6Sotdqhae+mFnUW3f0SIffcLvpG9alGB1G33y960piGdhYYovJ5
         7VjYrv4vSL+snorOCwM8CxKVcYWFTzwmTPjnr4tMN3USdLZ7qv6vC5E7DgoTD7do4xWB
         4KLPm72CE4wGzcxgUsnIZv/dloPSKW3z9PGNnJjVIplP1Ao8oaLNoFZFoaFpNszAXx1C
         Fi1zKwsBimNw5uWY2m6nEA93joXgFa3QgPgh4ksWYAMeB2XL9voqyCvQsOiW5bRhBhhr
         2dnQ==
X-Gm-Message-State: ACrzQf2UDb5voXMtaikxKvY7eTYukxeSms4ZQo8zEsc18pJcbBFUojSE
        xePETj6vmZQJzCFOkHrkc4A/Fxaw3eQ=
X-Google-Smtp-Source: AMsMyM4rhkHvhurqjUrWSl+ZglLlGtHIn8Qc+yLmoEU0uKhK3iz4BZkWrVykWku1c/qyzEaV9xYkcw==
X-Received: by 2002:a05:6a02:119:b0:463:cdc8:a3ff with SMTP id bg25-20020a056a02011900b00463cdc8a3ffmr2891803pgb.498.1668100491025;
        Thu, 10 Nov 2022 09:14:51 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b00183c67844aesm11598853plr.22.2022.11.10.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:14:50 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:14:47 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: remove devm_device_remove_groups()
Message-ID: <Y20xh1OpLGegZBRc@google.com>
References: <20221109140711.105222-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gv6L9Q+Nu3U0JAWqJk4MPt7kGVGiOAKuX5FcF=znyfTA@mail.gmail.com>
 <Y2wXYxrr/qed/j//@google.com>
 <Y2zFtWcytaIRWNqu@kroah.com>
 <CAJZ5v0jpm92CDHsH33aWNn97w5tpf-gust7ghkwdpmNbQf0ZDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jpm92CDHsH33aWNn97w5tpf-gust7ghkwdpmNbQf0ZDg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 02:07:51PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 10, 2022 at 10:34 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 09, 2022 at 01:10:59PM -0800, Dmitry Torokhov wrote:
> > > On Wed, Nov 09, 2022 at 03:11:47PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Nov 9, 2022 at 3:07 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > There is no in-kernel user of this function, so it is not needed anymore
> > > > > and can be removed.
> > > > >
> > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > For both patches in the series:
> > > >
> > > > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> > >
> > > I find it really weird to have an asymmetric core API...
> >
> > I'm working on fixing up that asymmetric-ness.  We have only one user of
> > devm_device_add_groups() and only a handful of devm_device_add_group()
> > left in the tree.
> >
> > But it turns out that no one ever called these functions anyway, so they
> > aren't needed even if we did keep the "add" functions.  So they should
> > be dropped no matter what.
> 
> Totally agreed.

OK, fair enough.

Thanks.

-- 
Dmitry
