Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3522E644217
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiLFL1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiLFL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:26:40 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A020BD4;
        Tue,  6 Dec 2022 03:26:32 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id l15so13467193qtv.4;
        Tue, 06 Dec 2022 03:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dCrxb6SjU7+iy5Xbh0SeqdRn/Rhezi+lNHMuTEUibQ=;
        b=lcWeXk3X5AcnTGWqWgBC1rYLSDv4GQr/WLe5TpEaz4/iol06ODBfatagPR1ScKpYj3
         DljJXqhN5WqraV0xOMexlbxtbtGaeypLfBu76ln2tOwxWSOvEapnzJp0CgaiKp2OOIe/
         MFjIkG35TXT3qwdVXdt/8kA6UJJ65IUJYEP3YFDA1vhNMnvsPSQ2DjQEENMBlAOxHfKv
         wuCi1WvzHkjfzli0OA0rZ9Ia9rN58m113d2xA2XxQB7RZf2ZYMpCwbX8IiiOMGqqP7S9
         jaI/CkesHgNViTfJzXpvQdX+lcFVwwc8hhqMpb958rfBXO/q1KGfieoa5PvYRFtqT/hI
         4m7w==
X-Gm-Message-State: ANoB5pnY4gZbtwCu2LoqvxKAaqluvUP45+hVJTelfzSCfTExU2qS4sWU
        PG/mlMD9BMu8plzPC5aF0Tt48EFnkCkZ9U84ofA=
X-Google-Smtp-Source: AA0mqf5E2TWLF+azulQ+MNLQ3mwqL4nIvU/EQqPYQGsYHagKqnSncfnPIrCyyNAzHuTGX8qrGsoxuHwTvrnuw6r5/us=
X-Received: by 2002:ac8:1482:0:b0:3a5:1e6f:7e05 with SMTP id
 l2-20020ac81482000000b003a51e6f7e05mr62302238qtj.357.1670325991705; Tue, 06
 Dec 2022 03:26:31 -0800 (PST)
MIME-Version: 1.0
References: <MAZPR01MB57230DDF21FC26147D0B0CAF8F169@MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MAZPR01MB57230DDF21FC26147D0B0CAF8F169@MAZPR01MB5723.INDPRD01.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Dec 2022 12:26:19 +0100
Message-ID: <CAJZ5v0hp0eyp=ybOBOzFk=COSKmE0RDbCi9tsFtmHuSrZhxWRA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Remove CVS version control contents
To:     Conghui Wang <conghui.wang@hotmail.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 6:59 AM Conghui Wang <conghui.wang@hotmail.com> wrote:
>
> Since linux moved to git, CVS contents are no longer used.
>
> Signed-off-by: Conghui Wang <conghui.wang@hotmail.com>
> ---
>  Documentation/cpu-freq/index.rst | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
> index aba7831ab1cb..546c9161d906 100644
> --- a/Documentation/cpu-freq/index.rst
> +++ b/Documentation/cpu-freq/index.rst
> @@ -20,18 +20,15 @@ Author: Dominik Brodowski  <linux@brodo.de>
>
>  Mailing List
>  ------------
> -There is a CPU frequency changing CVS commit and general list where
> -you can report bugs, problems or submit patches. To post a message,
> -send an email to linux-pm@vger.kernel.org.
> +There is a CPU frequency general list where you can report bugs,
> +problems or submit patches. To post a message, send an email to
> +linux-pm@vger.kernel.org.
>
>  Links
>  -----
>  the FTP archives:
>  * ftp://ftp.linux.org.uk/pub/linux/cpufreq/
>
> -how to access the CVS repository:
> -* http://cvs.arm.linux.org.uk/
> -
>  the CPUFreq Mailing list:
>  * http://vger.kernel.org/vger-lists.html#linux-pm
>
> --

Applied as 6.2 material under edited subject and with some changelog
edits and white space fixes in the patch.

Thanks!
