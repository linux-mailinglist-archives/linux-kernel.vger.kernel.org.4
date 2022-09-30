Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA45F1136
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiI3Rz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiI3RzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:55:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BF79EEA;
        Fri, 30 Sep 2022 10:55:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so4606934plo.3;
        Fri, 30 Sep 2022 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oIAo9+qWUeQbXeHzAy+ugcYbG6Lm0wKQlqadtQ8eNSA=;
        b=L/Jm/QyNeAQsX6+TeyY0u4/7zeV88gIhYmLe2m73zwA0wA/SJwDkIfQXSSbCUMvZRM
         acULk+m2YNyYFhFx8tcXL6TehWZL/D3wdG2g4SSdVTCUIx4mfudsC1OuSGTXYaA9ksyL
         gXs5jQYipA18IFaU8v8eLJzatgtz6IqMQ2URxp04w4EapLyNuLhDJPCMsJcqUP79I8yk
         Jc8Rl3Dp1j4sSwMz5ayOWj6t02lnmMne66MkBzg5grVaslbsFA9U/+el0e5csEXQYfxN
         tRKuOTDQHGlsdNnUNuPVMrMXTZy6pqgEq0VWyDP5muDgaWbQkvBJQDzD8qkQqcKxTmY9
         BShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oIAo9+qWUeQbXeHzAy+ugcYbG6Lm0wKQlqadtQ8eNSA=;
        b=5KYdup0giLKXNBgzKDcIRHj0WhaPRzdptPf4bD2Qic2Jb5lwi6KOOpFQsriEWzS3ZN
         lDEB5FZ7bhP9VsJ0HmzTUJ7A+h80izp5/Bzf+OIU9/fOXnrqa7inUy7BVsmv2lOAq5AA
         t6MAO/7bbSoTgRte6MqIZ9V0DQKhFQEHtxk8chZV6AUO+p3e9uYl6BwKMuqN/pwA/Sse
         PAfdo9Gtx1swFNdHNeo1SeWpI+F0HFzMQ/uFO3wsKL3G2loXmtdHV8+9kK23o383qv7U
         OZBudGMdb0se8vCAkTQUmtfH5KoVPpmsP/jiFuJMC/Hsb7OnkdScz/NReszxV8H4DpCS
         8WNQ==
X-Gm-Message-State: ACrzQf0Q/lnVYR75x9H7532HcbfxnRIsW0UHSgbPa7cCh4cOhp8+t0Pf
        OeoJ6/g20h88J/GV2f1QqsQ=
X-Google-Smtp-Source: AMsMyM52dJzRPZQA4CrgFqXqnB8JDUSQFWJSxghPXouTP3w78MpcSmkjO5+lWVlBP2dTfjQfG+s+sA==
X-Received: by 2002:a17:90a:10d6:b0:20a:46a7:beb9 with SMTP id b22-20020a17090a10d600b0020a46a7beb9mr3505094pje.49.1664560520691;
        Fri, 30 Sep 2022 10:55:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d016:f5be:4ff2:43f])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79491000000b0053ebafa7c42sm2110574pfk.79.2022.09.30.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:55:19 -0700 (PDT)
Date:   Fri, 30 Sep 2022 10:55:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <YzcthIfnpi8E6XVk@google.com>
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
 <YzYowYJpRTImmg4m@google.com>
 <CAJZ5v0i+QYcMuqsK9y6qy9qzJdUp503Sidr1e4V_ROyumLKCsw@mail.gmail.com>
 <YzcqdTxLMF5028yz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcqdTxLMF5028yz@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 08:42:13PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 30, 2022 at 07:13:37PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Sep 30, 2022 at 1:22 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> 
> ...
> 
> > I think that patches [5-8/13] from this series are significant
> > framework changes, so it would make sense to route them via the ACPI
> > tree.
> > 
> > If this is fine with everybody, I will queue them up for merging into
> > 6.1 (probably in the second half of the upcoming merge window).
> 
> I believe it's fine from GPIO ACPI perspective (there shouldn't be conflict,
> but if you wish you always may take this PR [1] to your tree (it's already in
> GPIO tree pending v6.1), it may be considered as immutable tag.
> 
> [1]: https://lore.kernel.org/linux-gpio/Yym%2Fj+Y9MBOIhWtK@black.fi.intel.com/

Yeah, having an immutable branch hanging off 6.0-rcN would be awesome -
I could pull it and this would avoid any potential conflicts later.

Thanks.

-- 
Dmitry
