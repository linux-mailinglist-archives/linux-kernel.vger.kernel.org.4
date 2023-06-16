Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9101733147
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbjFPMdr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbjFPMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:33:45 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C030DF;
        Fri, 16 Jun 2023 05:33:43 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-97ea801b0d0so16277166b.1;
        Fri, 16 Jun 2023 05:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918822; x=1689510822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTRWCve4aiZlLjjembeAxWUlGki5BZgszXsoy6USiS4=;
        b=WFl7x1M3zrcw6Uu7bUB5KigaF82A5+/AW5FSLYhlG8BQDxVJMcJ6j6cWn3k3JJCl+q
         Pf2gLz4p0gXPcZo5M8xcjSjLBl3zuvxqiycW8A8WTT9KwSzHDfDK/GvJyNPPF74muKZR
         kfxUyzkqPCa/askbnVgWSvfg/T0RcLxLG7bk0+VwWf94bT+19pkE66RNp7/vcGbfKT3I
         1uqe5X7ujc+DhObNxdXtVnxPgZyNotO8WYtEOX9sY7RbtRisj4gMIl2wT41B7feP9yYc
         4ZmqOGmefSM9oxzcQdrg+LXiTk360jLk71PevS27NRCLlbPjAjOkBZz3Id4nQBxTuQbh
         ZNeQ==
X-Gm-Message-State: AC+VfDwNMIEaChPfH1fdtd7GVFlkf0PDXTrmnCluqOMSI8N4/BqN6AyJ
        EoNIlJG07wsKHzlxcLU8hG4mbZaK+NW/lX04dLN/h0U4
X-Google-Smtp-Source: ACHHUZ79y6h/AB3JoK5Bq0mgG7Jfw9riBgIfzW94PqUGvj00CUEL8w+BC2GU4nNixQLXM+tLTaPg9Vl1Y+prHIWexZs=
X-Received: by 2002:a17:906:7a53:b0:976:7c67:4bf8 with SMTP id
 i19-20020a1709067a5300b009767c674bf8mr1480785ejo.5.1686918822099; Fri, 16 Jun
 2023 05:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230612113615.205353-1-wyes.karny@amd.com> <20230612113615.205353-2-wyes.karny@amd.com>
 <ZIwKNI6OvhZles5F@amd.com>
In-Reply-To: <ZIwKNI6OvhZles5F@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 14:33:30 +0200
Message-ID: <CAJZ5v0j0AqosqH6wx2ToGOM-zGdowJiZtxG2kZrSd9QcJyXdtw@mail.gmail.com>
Subject: Re: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name hyphenated
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 9:08 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Mon, Jun 12, 2023 at 07:36:10PM +0800, Karny, Wyes wrote:
> > amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> > mode driver consistent with that rename "amd_pstate_epp" to
> > "amd-pstate-epp".
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
>
> Acked-by: Huang Rui <ray.huang@amd.com>
>
> And yes, we should seprate it from cpupower as Rafael mentioned. cpupower
> tool may go to another repo.

Not only that.

It is generally better to send individual fixes that don't depend on
anything else as separate patches, because this allows them to be
picked up and fast-tracked at multiple levels (mainline, stable,
distro kernels etc.).
