Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3A66B4FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjAPAmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAPAmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:42:18 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6896A4A
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 16:42:17 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id f5so4036793ual.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 16:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6baWnHaMeq//wWgiDgPtR7wttjvBbwrgF13EwkKD/cE=;
        b=fQ645zQjAeaiKdNcfuKaw5q60oC3763af0bKnIpQK9n0Vx7E11+DcrztbGRzukep0S
         6gn9f2ePl10gZ9WD3YtyNk5j9PZ8cm4v7znaVvfrc1pgU/VuuOre37Dh/k+MZ1rGQyhs
         m5VFC0p94hj68AHm7ID1eC1g8sPXhCQD4HA68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6baWnHaMeq//wWgiDgPtR7wttjvBbwrgF13EwkKD/cE=;
        b=R+T3gZopsptFAEl22IVtBZwniUGtIMmvmRh7+2ChMHMzmr/R34o/qXcLw1jRt/RX6v
         dvcJ8tX7cWqORy4o/5aSEGKV92PK3x/i4CIOh2ckzlNdFVq3pG6tdPlNvjNXw+CVazXV
         KF6bPYALhS1EuesWy1y26b1WYzCA7hGr3v0WMmKqUGWb4XPvh92mhvim4VjwuOMBt9S5
         F1TubTff4CoNo4hNSdqZO1HjLna2gpktcJcFCBAAYKyaNgwFBNRpEvlWVVEMzotTfgGW
         pzqHKKWVKY9gIfv1T7FAdrIfY+9tpWJA6CUxxBcDq01sfOyALolSQ3Cvzaw/4jJsqpPD
         VpQw==
X-Gm-Message-State: AFqh2kppppn9n3UmzGsR0HULeeVFsbgcEHSXAzL9A4953XJSOsuvOB2i
        5U8dOAqhUCz0c7B3dTplXN09qyqx0EKLtwX++x6wsg==
X-Google-Smtp-Source: AMrXdXtSGMQ8TmffqUbtzp62L6p2NM5X45zupfLjEjP0IhWRu0tTi2BUXLTEpKCnBUkxKouEjGEIu6c58810DbBvQ9c=
X-Received: by 2002:ab0:2b93:0:b0:60a:bb33:8267 with SMTP id
 q19-20020ab02b93000000b0060abb338267mr129165uar.47.1673829736705; Sun, 15 Jan
 2023 16:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20230114-doc-v1-1-efec2689e423@pefoley.com> <87edrxgk25.fsf@meer.lwn.net>
In-Reply-To: <87edrxgk25.fsf@meer.lwn.net>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Sun, 15 Jan 2023 16:42:05 -0800
Message-ID: <CAOFdcFNKJacBVtrV-hJyUu6hKBVFaKdpA84cZ6WGnZ=ZGnb4kQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Avoid duplicate Kconfig inclusion
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 8:25 AM Jonathan Corbet <corbet@lwn.net> wrote:
> The duplicate inclusion does seem worth fixing, but I wonder if you're
> deleting the right one?  Having the documentation Kconfig under lib
> seems a bit strange, somehow; Documentation/ is a top-level directory,
> after all.

I thought about that.
Looking at the history, the toplevel inclusion was added in
b1663d7e3a7961 (2019-06-04), and the lib/Kconfig.debug inclusion was
added in 75442fb0ccaacd (2020-10-30).
Given the actual entries in Documentation/Kconfig
(WARN_MISSING_DOCUMENTS and WARN_ABI_ERRORS), putting them under the
"Kernel hacking" menu makes sense to me.
We *could* add a new top-level menu to Documentation/Kconfig, but it
doesn't really seem like an improvement over having them live in
Kernel hacking.
