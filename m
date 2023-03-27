Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74476C9BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjC0HOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjC0HON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:14:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67A4695
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:14:12 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p204so9176603ybc.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679901251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DADc3+3y25wA+EijOJMVd9N7kcsiCNVkrstmJZ8tqpI=;
        b=Rdl/AQ56SV9DvRObt3MwQLMuMrW0nQfSrGayJl00GO0evqEqVoHc04TiQf+WTri43u
         SITTwkJQK7P6gAqw8irtbYtn7eWUzj1UnmcPEtwuYkYKVEnbvBLcJljsPkqO9fNap2Dq
         zQkn6r9nZ/LvHGYC3s+L/qdn4B8dgZryaSda76cHUX+S9H9msqwpVgDM8qEHhetVln0L
         JVVBtfI/qXN4Kp3V1u6VCmhZJRz8lfX640bkrMLItSuDu5R5LuBP+FII6NdCJwfYmMmn
         WAX0PXdTwQ1z9Sr89qg4FzwPHQmj4eNWS3or1RghMLKNeXUMd/GHcELuOuYisF80LBPk
         1cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679901251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DADc3+3y25wA+EijOJMVd9N7kcsiCNVkrstmJZ8tqpI=;
        b=dSZJkw/KabxcVdg/syHikDdCqX7Q0JqlHwTUxaRuCa29jFU4VkL1LVE4NAP92MlylK
         fJi5wAeXCYMdpHgwFZqqvdRkRTgEu2ufh1MKxafMgSpG4pzb+Wb/4JxZCq1A2outgZCG
         d/ty4g8Ee2icOgJciSypcqsoxLRIwK/R8xrOafeLPIIwd46n6VzXJz44X3eQ94Yrmr8P
         kwAEuGc0eesl5UPBxK1/4EOeyu/9pxwJ+Nx32gQDXRbGnFrG1rjiaPEWJY+WBGvTBw40
         bI/YLwu+RJ4JPMx0qfgbZfL6UiXvO0dAD+Xi8swCVeMMx02RONmVghMsHym3H2AFOjFV
         msCg==
X-Gm-Message-State: AAQBX9f+Qk+8PQf8xa5DVQSb4YcNAEsVMMTSh3sfOFPvGaeXz3g9cVmb
        AzcsEqnIe47F++zE5PRZIMbUQvhq8SwkFKS0iFW283jsMZ+icO7W
X-Google-Smtp-Source: AKy350Zgax0q8sTztpH7KMeTMyIX1/Z3llPizGyqcwGyW+FPedrteczeEw3cA/BbZPguCWHqJDq6ek7FroXti6lH5ZY=
X-Received: by 2002:a05:6902:1024:b0:b77:3f5a:8a53 with SMTP id
 x4-20020a056902102400b00b773f5a8a53mr4624349ybt.12.1679901251455; Mon, 27 Mar
 2023 00:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230327112026.409883c2@canb.auug.org.au>
In-Reply-To: <20230327112026.409883c2@canb.auug.org.au>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Mon, 27 Mar 2023 09:14:00 +0200
Message-ID: <CACMJSevvO0B8O0K4HtdTdxsGYGVfyHOug=qSg00SwVU+vw8Xsw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the gpio-intel tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 02:20, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> The following commits are also in the gpio-brgl-fixes tree as a different
> commit (but the same patch):
>
>   782eea0c89f7 ("gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU")
>
> This is commit
>
>   a21031ccf31b ("gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xNU")
>
> in the gpio-brgl-fixes tree.
>
> --
> Cheers,
> Stephen Rothwell

I missed the fact Andy already picked it up. Now backed out of my tree.

Bart
