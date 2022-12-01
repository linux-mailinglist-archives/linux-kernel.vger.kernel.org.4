Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6982C63F757
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiLASP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiLASPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:15:38 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D92FC39
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:15:37 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id g65so2386297vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5O79/4dfGMvQHa5X3uTB0Wr7dyVvtYnPErb8zE0PW4=;
        b=0QRtYe0OZR2bih7SfGC+1aiErKGHk1LpvBAB2PO1DmSiaWmmFHLw6PCpshZGQnElDI
         TZCRKw1cLuYYwcYCwJmQORY1mn3XOctHINTTsnikgr1dBXjpjR6DNIpfERJWd2WYHFkx
         0/V2L6ChDyYwxCbIN0bRibcjAWQT12Z6bne3s1VjyF5AZXN+CjMa7fj9Jevmbyi3QiFy
         Knc0THZqFg8zyAyZnxSDQSCXQf5Jv2gvkniRZd6hMDQfBwNZYEHMLjAcM5DN/XJ034fw
         RhYuuvmRxOiRCYGigEbyQax7SIirGl/ZDIqRquisGWsYBdyQxascKEYcurLv2IX0R7oZ
         qBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5O79/4dfGMvQHa5X3uTB0Wr7dyVvtYnPErb8zE0PW4=;
        b=zRivqRl6X+B9/PnIBTn4uqytFoRqNnylKy0DgH15+7LcG6S0PKUhi1bdp3vFbXOrbW
         T9oVMjCrknwICRMRHxiqvBT4o0n0x5q9Sbm8HFspPiTo+SHxB18V1GupanTkvZgt0LHW
         VyZ5L8uSbr/TQcBevuST1YFmEat31d+26ozSPPGlGLXhP/8fVtu996iYAzlfZCDy+F1Z
         sATa+8q0S4SxjMlgavHZ6C8qaIwtJL3EH9RJtxoxo2edLCBzXa8m/nDSzWp0qNw5QiU6
         rPNV2A60XmW72QwxGNakw8m/xZxqedzT6N8h2XtGr9iCR12ABJCLtzReoQL/yMY7gZx5
         8Rcg==
X-Gm-Message-State: ANoB5pk372R+bScxAp3yblMfzZ+Vb/ElF+RzuA8yT+Fiii1RfYlNna0u
        azJ4RGLqe/MaOXW/fQm0LiIggoovHFmH3T6LbInNgA==
X-Google-Smtp-Source: AA0mqf7bo78lraZUUUB7N0VesoapToaxgVbuwa2Gu0JpPQAvqfAEl8zW5qXdBZx0YVONq4cpATryi06eFu8n6sNHqYs=
X-Received: by 2002:a67:1c85:0:b0:3b0:92e2:37b0 with SMTP id
 c127-20020a671c85000000b003b092e237b0mr14573916vsc.9.1669918536345; Thu, 01
 Dec 2022 10:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20221201125928.3031325-1-brgl@bgdev.pl> <CAMRc=MfGi52s+LcTrBnBPDV91SbC4vf1prrLUpzQ_KZQQZGBuQ@mail.gmail.com>
 <Y4izMVZBhXGj1jbj@smile.fi.intel.com> <CAMRc=MedXBgh+JnTL0qUOrhKJ+w0vcVZTk-k2TKJzdbk_TNtVQ@mail.gmail.com>
 <Y4jK/RPDsyf/wcqM@smile.fi.intel.com>
In-Reply-To: <Y4jK/RPDsyf/wcqM@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 1 Dec 2022 19:15:22 +0100
Message-ID: <CAMRc=MfNSLDx0L1jC6HY8VEGTVfuQCGRHF2XQS_3txKDXiVjEQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 4:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Dec 01, 2022 at 03:13:55PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Dec 1, 2022 at 2:59 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Dec 01, 2022 at 02:00:06PM +0100, Bartosz Golaszewski wrote:
> > > > On Thu, Dec 1, 2022 at 1:59 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > ...
> > >
> > > > I know Kent and Linus left their review tags already, I will add them
> > > > when applying.
> > >
> > > I guess it's good enough, go ahead with it.
> >
> > Can you leave your Reviewed-by here too?
>
> Hmm... Your both patches already have it.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I was thinking about the mailing list's history but whatever. Applying it now.

Bart
