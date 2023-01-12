Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B045668430
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbjALUqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjALUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:46:01 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DB7BDFE;
        Thu, 12 Jan 2023 12:14:25 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 18so28431757edw.7;
        Thu, 12 Jan 2023 12:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENcQXNq3utNbMvThwA9waXitghPXyfLd3y7TavVSyBU=;
        b=7kc0BsZva0coJoxh8M3uCS8L2TM/gM+0jBmV2ULVnn+YR+qRULiPKEAQWP/gStbzgt
         x9FyA00DQRN76gBS4FcckYuQ8f3I01R/rV2rYy1zJI4y4xfsir/lKDWUI3epeknwIKJ5
         Gy1MQSwb5TJ9P8He5YdWGAWKSWpix5CqP4VpY25EuEWCIY7hiYKbPJVrAareyVr3KOSn
         LC5kAYeR6liG6kvsBq4a6U/jZOKRnEtN+thBHKHBP4Dp8GNdhj//s+lKkFZRFhd434cu
         D1vfRUNUjE6N5cqhns2gG4PWICtlrj+FlD3/lUsgW9jMTOfcMCpxGOT2ydoAep+mY2M+
         sghg==
X-Gm-Message-State: AFqh2kojqWTH+d7a3/RDQ2rhI8oFyWHvpmepwTZLZAP1W/P1uCX5TtAQ
        21EtnHr9oDmvjnIXlYlx2pZG0dDmGdQASYoJFiCjs43Fir4=
X-Google-Smtp-Source: AMrXdXu++LaiLKKNORVVOe3znN5KTmtUlYiNj2dteonp2U1gT1nkkMNUO3MErjhJQ3f38SoNLoU/huAvk/5AOXwX+IQ=
X-Received: by 2002:aa7:c853:0:b0:47e:4f0b:7ad9 with SMTP id
 g19-20020aa7c853000000b0047e4f0b7ad9mr5627141edt.239.1673554455025; Thu, 12
 Jan 2023 12:14:15 -0800 (PST)
MIME-Version: 1.0
References: <2687749.mvXUDI8C0e@kreacher>
In-Reply-To: <2687749.mvXUDI8C0e@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 21:14:03 +0100
Message-ID: <CAJZ5v0j_bvD=_XOtBdMjOHkBe+BP0Mvm+vQx+LzK97Or=OZeag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the ACPICA development list address
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Bob Moore <robert.moore@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 8:54 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The previous development list ACPICA address, devel@acpica.org, started

This should be "previous ACPICA development list address", sorry for
the typo (will fix when applying the patch).

> to bounce some time ago and it is not likely to be restored, so replace
> it with a new one, acpica-devel@lists.linuxfoundation.org.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-pm/MAINTAINERS
> ===================================================================
> --- linux-pm.orig/MAINTAINERS
> +++ linux-pm/MAINTAINERS
> @@ -383,7 +383,7 @@ ACPI COMPONENT ARCHITECTURE (ACPICA)
>  M:     Robert Moore <robert.moore@intel.com>
>  M:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>  L:     linux-acpi@vger.kernel.org
> -L:     devel@acpica.org
> +L:     acpica-devel@lists.linuxfoundation.org
>  S:     Supported
>  W:     https://acpica.org/
>  W:     https://github.com/acpica/acpica/
>
>
>
