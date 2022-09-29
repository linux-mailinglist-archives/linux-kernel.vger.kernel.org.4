Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448F5EF8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiI2Pdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbiI2Pc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:32:26 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD313BCDF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:31:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z18so916263qvn.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aDk5WhTWYMUS/Nso1zDY1vnbhdE3LxgEUkl0R9z8ikc=;
        b=fPZW2E15BveHnk+U+E2xsZfNruZ86H0qoVWMvgoDRp8LH8O++N2Te7BG0k08r2OaLy
         ftLEnS9PkDbmVxKsLnBgATVeGuFmaz+yhvNZHPRO/Lg/TsUROe30efvPXffm93CuJcoE
         Afylt8OU1K6UECrE+L02k9cPxn5B/QVCsR1E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aDk5WhTWYMUS/Nso1zDY1vnbhdE3LxgEUkl0R9z8ikc=;
        b=RzhydVoAB6DX6k5y6l9wFijnr3MCtWaxPZBheR4X8cgoU1WiqyI3CxdEPja1WIkK1t
         ph8lWwwar2yNT86Q42W9zZsptUC/7joFfd0s2L2xa2VDtyViDkrgM4At4pFu4c++gEXy
         yUXDNNlZXvNPH3BiIb7Ku8Yrmr5pny8av9CBx7Ukolx+fo/u44h77CEBNqlTGrat6R/0
         z+HmRfMAz5vCR1GoNx6HiCtw1umXWA0l/tVDTbt0ayrMG8y3gy3YUjC7+MYpw5RImb7T
         F1w0rtHkvgzFyl/Ine22xRnH3SorG1+hwAbL4oVko3jAKPsCWJ19Dz9zrv0GHvrDIv/x
         eGvg==
X-Gm-Message-State: ACrzQf3lr3foSbHPtMZgNoka/IlcJOmelAMFlrwsSzvKlz7J9X9uCaOH
        e8+hMVTq8DFcgi1pYFvBxPRD5A==
X-Google-Smtp-Source: AMsMyM7i7zIg+oSnI+5G7rUm05ea+Hzm8A3YgGg00fNvZsrGxIXxfIvcax1QpG3R8agfqkdKbfJFAQ==
X-Received: by 2002:a05:6214:29e7:b0:4af:487d:c049 with SMTP id jv7-20020a05621429e700b004af487dc049mr3121459qvb.96.1664465497726;
        Thu, 29 Sep 2022 08:31:37 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id az11-20020a05620a170b00b006b615cd8c13sm6104418qkb.106.2022.09.29.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 08:31:37 -0700 (PDT)
Date:   Thu, 29 Sep 2022 11:31:35 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20220929153135.vu43n5kgdj4a3at6@meerkat.local>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:22:10PM +0000, Artem S. Tashkinov wrote:
> * Delete all the components.
> * Leave a catch-all one.
> * Let bug reports rot because no one will ever see them. Almost just
> like now. Don't remind me of mailing lists.

This is my proposal, except also:

1. post all new bugs and comments to a public-inbox feed that people can query
   via lore.kernel.org and tooling like lei.

> Sarcasm and pain aside, Linus Torvalds himself _via Bugzilla_ has helped
> me resolve critical issues on several occasions while my messages to
> LKML were simply _ignored_. Think about that.

In fact, he probably did this by replying to emails, not via the web
interface.

> Mailing lists will not work for such a huge project. Period. In the
> early 90s they worked, but we are 25 years later with millions more
> users. With a ton more of a ton more complicated hardware.

We've recognized this a while ago, which is why our efforts have been targeted
at query-based message feeds. Hence, tools like lore.kernel.org and lei. It's
a work in progress, for sure, but it doesn't require any "everyone must switch
workflows today" kind of coordination, and avoids introducing single points of
failure by making it easy to replicate everything to mirrored systems.

-K
