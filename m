Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7529E69ED58
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjBVDOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBVDOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:14:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CA33C30
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:14:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso7324307pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAyS6CEssyL2O/MQCLxRPme0Kdvtsn1ed2T3vpNQ+gU=;
        b=Eaidv/Lm+TFJ7SA6oPwzO/I72/6tfubWrfh4vDeIy6lh65hOXt5Wv3XYF2om11k15c
         dQW8o4gdS+LSpaqxPdehdmBFaRcj21zuJyRLRbC86IIx+yskh/5oeuMHrVR6lq+89lef
         cKvfSsSbtodx6w4JPpdW+ZJCtJ05dxopY0pzC+WETFgnuexKaNVeaANlijHHrkA8rZPp
         QpoS/2m4lS6yi0FBY1rc/wJ531dkEnCR1HNRF3fc7ggSOD3ZwtehLz/f5rhwsQEeVUJt
         R6FBKJEyv0A7w4/fbbSL/FN1xknxKXgNi41QFikEcbXHYX/hFtSEozxgrSZKAgZHa39Z
         aVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAyS6CEssyL2O/MQCLxRPme0Kdvtsn1ed2T3vpNQ+gU=;
        b=aFixf5LGlHvskSTmvTJh5EfVgBOcx/znu15Iy2DHnYpuQl9AUqwVH6i4I/bMx2Y6pX
         NVZQ8vxU83aMso68Tq/8JVUmRezXqTYtKxZzY7e8u+BkVGdCl789OCx2XQ8cZLdk5ny/
         tLUv9gnSPW04dBIECETnj2egTH1VMyU2j60PIVp5e0QSeW8HbIBWgSV5vP51layuWny1
         Z1XRDZAuzSijDRnWymCshm6I0WAacdl/XbmtotxNdjZDGWxaYWpYtX60nHebuW8pUZ8B
         dJPPka0WST33ANSjtaE5RQTKlT5cwH9szXXoh5quzCgvN3wjWK/PI5N5NfY/igeTr1cb
         9UDQ==
X-Gm-Message-State: AO0yUKWgG6ryofaQ3FVU0wSe6V6zv+DTOBdKNQWXYsljv+9QbIiAS/LJ
        SREkAwGl4ZSkKRWM5Auc2zuUIVLbdTSSRLtoGmqqyw==
X-Google-Smtp-Source: AK7set8t979gnqwj+sVUGVPrKyJM8PhOgL2X7XUZIC33hVlIdI94hkRRMzq6VIYYiJFm0dlW7MCewUh2h78USFa11fE=
X-Received: by 2002:a17:903:449:b0:199:4830:5cc9 with SMTP id
 iw9-20020a170903044900b0019948305cc9mr856207plb.10.1677035655978; Tue, 21 Feb
 2023 19:14:15 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230218083300eucas1p28c7c584877b8914a3b88904690be82f6@eucas1p2.samsung.com>
 <20230218083252.2044423-1-saravanak@google.com> <e3814c81-c74d-7087-e87d-12dcb49e6444@samsung.com>
 <CAGETcx-UcVnDw-FJAPeA1mLpPno4OE3AAv4WsfP852zOdKqPCw@mail.gmail.com> <Y/VLREM7n+wstHbn@sirena.org.uk>
In-Reply-To: <Y/VLREM7n+wstHbn@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 21 Feb 2023 19:13:39 -0800
Message-ID: <CAGETcx_hp_P09diJWgP7=4QiKJi91oVXie3iddpkTOdO4uuZjg@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 2:52 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 21, 2023 at 02:36:52PM -0800, Saravana Kannan wrote:
>
> > Thanks for testing it Marek! I don't want people to spend more time
> > testing this before I hear Mark/Liam's thoughts. So, let's hold off
> > for now.
>
> My main thought right now is that I'm not going to think about it
> too hard if it doesn't work correctly...

:( I'm not asking for a thorough code review. Just if you are okay
with the idea/approach of pushing the ordering logic to driver core to
avoid reimplementing what's already available and avoiding some races
in the regulator code (stuff like, checking if some other thread
resolved a supply while you were working on it). The patch at least
works on my device and works for most regulators in Marek's devices.
So, it's not a complete broken mess :)

On a separate note, I have some questions about setting machine
constraints during regulator_register(). Why do we even try to set
machine constraints before a regulator's supply is resolved? None of
the consumers can make any requests anyway. So what else is going to
need those constraints? Wouldn't the regulator just be in whatever
state the bootloader left it at?

The current logic is something like:

1. Try to resolve supply if it's always on or a boot on regulator.
2. Set machine constraints -- this might fail for multiple reasons.
One of them being unresolved supply.
3. If it failed due to unresolved supply, but it wasn't resolved in step 1.
3. a. Try to resolve supply,
3. b. If 3.a. didn't fail, try to set machine constraints.
3. c. If 3.b failed, fail registration.

Why isn't this just:
1. Try to resolve supply (for all regulators).
2. If we are able to resolve supply set machine constraints.
3. If we weren't able to resolve supply, set machine constraints when
we resolve supply in the future?

Or if you need to set machine constraints without waiting for supply,
then why not at least:

1. Try to resolve supply (for all regulators).
2. Set machine constraints.
3. When we resolve supply in the future, do whatever remaining bits
that you need to do.

Thanks,
Saravana
