Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E94F7253EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjFGGOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjFGGOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:14:03 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD8C1BCE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:13:46 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 140D33F0F8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686118424;
        bh=z2S8w94wmO6gro0MOA3TrsuV0coxncdiS+T7jLmq+Vg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=HZCXsNewWWWExbEKznaJ2w6AUilDsEmzOcsiyH93Hg7h9O1+zNQxRp9VcbKku3y2H
         0xDhzLhTDWEW/mpSvqcRlK27k+vRTOLwSaccNGKitkXS5z15Ex0WQqlNUgJzJfeRNq
         oTrjdmt+9aB6UrlI+ksAQJDXn2SdrodgOLe748VGpd1kKSfSJwglHSBtUjeiAh8gkr
         CfzFttrMylgM09YJXCzmwV7sX+Z3eGQBqulFvlSPxcjgpBJqaCy6CdnYeJZVr5tZ4I
         Bdt9ovQSYJaTEddQM6updNwJt6O5yX4Tvur/Ven9qhF51vZuOqWOhpjJjlh70xwh0a
         tDrzDlr6xmtCQ==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-565a33c35b1so105680147b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686118423; x=1688710423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2S8w94wmO6gro0MOA3TrsuV0coxncdiS+T7jLmq+Vg=;
        b=Rbl4qi0qe6ewKyWzwRKv10af9cGUBNazy2hvVKHuc4iZsAWsllrUAB6BJyMm/DrfBk
         d4q+oxwjazOzuKHETTo98ye65wQas5TuFvrN6uAgi0iFyuoarxWfKyDde3MsEnfUx7QG
         siAxS0hDteiIZ+TXAvcHSD4XcsTslvH6gslsZwY8RyBR9y4qHZHRH8A+7OdbTo3efZiO
         ozXdUsX9x4LNH1k0KrfG6pAITe6MI8gvtNQg2sEpHmNMakWnqZV1yUYlJtMyUhrhOy9z
         e6QTpa67O7vnioe6AwHCMD4sGUlxTkjDKqGChh/WpOP09ujTQqzwpMD5uabr3IHTsSUW
         CNpw==
X-Gm-Message-State: AC+VfDxRNHRxU6/6qokEIZ66/JjXBq2T+yWu2uSimOjAp3b6GTYNKQzS
        XDyKs2LWRb7JoX5DLxwvNBo7cDVfB1g02fXPnuhoH1nCsITaxiiIly0wnl+aPbD7/4dVkDwr53V
        T9JAfAYHJalSxd4oOLXjUcrD0uu1xv7Zf/82sOQ0Ob3bA5ODzgaAgeMHiLg==
X-Received: by 2002:a81:a511:0:b0:565:9105:d043 with SMTP id u17-20020a81a511000000b005659105d043mr6024557ywg.9.1686118423000;
        Tue, 06 Jun 2023 23:13:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rqvSoUhUn313mKwOLENsS5/zsi+enZgGIKlhgSKjCfVKJNE7d+wcq6fSsidRJ7F0ZeuQPx9J9eS9I3TEuY1U=
X-Received: by 2002:a81:a511:0:b0:565:9105:d043 with SMTP id
 u17-20020a81a511000000b005659105d043mr6024548ywg.9.1686118422733; Tue, 06 Jun
 2023 23:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230607034331.576623-1-acelan.kao@canonical.com>
 <20230607042032.GA28835@srcf.ucam.org> <CAFv23QmDNUFcPwvSQt5aUxtmHasfr8wrF72ObvcO-X19gfn=LA@mail.gmail.com>
 <20230607052724.GA29834@srcf.ucam.org>
In-Reply-To: <20230607052724.GA29834@srcf.ucam.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Wed, 7 Jun 2023 14:13:31 +0800
Message-ID: <CAFv23QkEdGnEz1q7vbyFCa9S9Dqh-zec72nRGyZ3wAz-8wpbvA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <mjg59@srcf.ucam.org> =E6=96=BC 2023=E5=B9=B46=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=881:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Jun 07, 2023 at 01:19:40PM +0800, AceLan Kao wrote:
> > Gfx drivers(i915/amdgpu/nvidia) depend on the drm driver, so delaying
> > the loading of dell_laptop after drm can ease the issue the most.
> > Right, it's still possible to encounter the issue, unfortunately, we
> > do not have a better solution for it at the moment.
>
> We could unregister inappropriate backlight drivers when a more
> appropriate one is loaded, or the policy decision around which driver to
> use could be made in userland?
It's hard to decide which backlight driver is redundant, and it's kind of u=
gly
to unregister the backlight driver which is registered by other driver and =
maybe
problematic.

I'm not familiar with userland, but I think we should handle this
issue within the
kernel and aim to register only one functional backlight driver.
