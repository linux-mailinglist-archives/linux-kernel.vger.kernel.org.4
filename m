Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C147694B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBMPfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjBMPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:35:19 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D0193EB;
        Mon, 13 Feb 2023 07:35:09 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id lu11so32877486ejb.3;
        Mon, 13 Feb 2023 07:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JhJdlDL6fmbS5q19tX3fu+mCrdjV4k/N8ZhnKBWWqo=;
        b=uryIt///vhzsubPV6oEXofZhYuq53F6QF3KamMZoT+w9Lt+3jO3qw2vC1vr0Kt+e+3
         SnlzDfhWqn10JcCH/5haVzHLHu2SM/Oas1kM93XSZMkibJxmVXYRB5Lg3xNPjDwCMvos
         wbLhGRfrmILcdl2QCVx1MZiCiv5eSnOyLjK7FXLLJ9aPrpcGzlfjkstVY8mLHwyWomlG
         2lnLitItY3pqmQ7iJbw9H5j0be7B+oj1sdstXJ0betVFtPtJlYAOnB3QsCoeQBlmUCAp
         a/r/WEUgFbDb0cVGV/IqP3Sk3m4bw4u26zZlitcvUXbX5bwhg759E05xRniVNUTV+tGn
         hg6g==
X-Gm-Message-State: AO0yUKUc+0H5nmsxlP1RsfonFqcWJIodLyt6Pbwrcclyv+9lSQnkl6Vx
        V5hEr6kFTWV5wjMSWE9HNUk7TWqmkV8dCUc4h1b3Mwes
X-Google-Smtp-Source: AK7set/tr7RnF5ql64ehY94/sYYKISWF6RLnIz0lIwA5Qx9zhJKZhozIHSQ9NiF+2QIYAD0HOdAMZEQ3lo83wQneLHw=
X-Received: by 2002:a17:906:d9d0:b0:8af:2abd:63ec with SMTP id
 qk16-20020a170906d9d000b008af2abd63ecmr4953094ejb.5.1676302508452; Mon, 13
 Feb 2023 07:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20230213100800.28333-1-bagasdotme@gmail.com> <f6fc39d2060c964d32b6610956b66e8d3151d926.camel@linux.intel.com>
In-Reply-To: <f6fc39d2060c964d32b6610956b66e8d3151d926.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 16:34:57 +0100
Message-ID: <CAJZ5v0jhz-x+YU7h=kPM3ECGT6cqkSmbkHVOCavY4cOLaJhugA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Documentation fixes for thermal/bleeding-edge
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:18 AM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2023-02-13 at 17:07 +0700, Bagas Sanjaya wrote:
> > Here are documentation fixes for thermal/bleeding-edge tree. The
> > first two patches are fixes to recently reported kernel test robot
> > reports whereas the third patch is cosmetical (formatting).
> >
> I am fine picking up this patchset over mine, as this series has  one
> additional fix.
>
>         [thermal-bleeding-edge][PATCH] thermal: intel: powerclamp: Fix
> warnings

So applied, thanks!
