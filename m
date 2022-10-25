Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E060D378
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiJYSUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJYSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:20:37 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C0C1FFB7;
        Tue, 25 Oct 2022 11:20:36 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id w29so1043118qtv.9;
        Tue, 25 Oct 2022 11:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKMeUtAah02HR7mhiTOn7+NntwlpmfPwqW3wxj21CT8=;
        b=lRoS50owdRQ5yRSWslpA31bO1RS64CDrgDIvk/z3WQKoh/swgU1mNyOwc1Hi61KDkq
         hp3HRIhaQ18vDwt3CgPwejQjQNX1gwIibY1Enp7z5OREMOgDLSLmmQD3JJABB+2JBbie
         sOaAq7+WHZi+Uvk9B/LtE/32tJtfCKgLE+ZJleR2JG29SrmrRV30Q+U+QSVBxJC4zGMI
         q9S/GuSPClVxdmHFmq7Dr+buS455Ja9ur2WvoEox9A/x098OE4CEWSCwxY2eVmdZhqP0
         WA6nOKS7Ijhk07/ke9ufZdKtOeAo7VPzT4KmN+ltiH0mVYnkWvRpLcHKsa1lH60y8RYS
         sUmg==
X-Gm-Message-State: ACrzQf2ZutHlk4kDD/iS9jQxSSLun6tUpdd3hjsIKaD9b0Grp/A8K/+Y
        QgChU2QGbqh99LZ2QJLUYUXguxpIFbAY2avDjgw=
X-Google-Smtp-Source: AMsMyM6rKfm4ZzLlokOacMbkCjlmmhehIKvoGTax7heJ1JyZAy3/dcaTveUJdbJqUmsgm+hrSWWkHr71iyDiEOj/AJo=
X-Received: by 2002:ac8:7d02:0:b0:39c:bbef:178a with SMTP id
 g2-20020ac87d02000000b0039cbbef178amr32905375qtb.357.1666722035750; Tue, 25
 Oct 2022 11:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com> <Y1em/YJwcvLV4J05@smile.fi.intel.com>
In-Reply-To: <Y1em/YJwcvLV4J05@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 20:20:24 +0200
Message-ID: <CAJZ5v0hKgtVSH51+XP+Yb6b9HZaMhmRgDjrkGSupuafg5MPKiw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Fix documentation for
 *_match_string() APIs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:06 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 06, 2022 at 03:38:07PM +0300, Andy Shevchenko wrote:
> > The returned value on success is an index of the matching string,
> > starting from 0. Reflect this in the documentation.
> >
> > Fixes: 3f5c8d318785 ("device property: Add fwnode_property_match_string()")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Is this gone through the cracks?

No, it is not.  I've just applied it for 6.1-rc3.

Thanks!
