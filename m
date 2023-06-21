Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41F738D00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFURYd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFURYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:24:32 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36295E2;
        Wed, 21 Jun 2023 10:24:31 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bb15165ba06so4907620276.2;
        Wed, 21 Jun 2023 10:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368270; x=1689960270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4okefCgqaBFfWVHjEtGss5H94GBXCxgg538PEPA+JVw=;
        b=EswNHvQZ4lZPop38prfc/hfZhcXG7bXP21n2M8fuRJioOzRhKupp83k0zGX/1RqdxO
         0nG03+HdWne64kP9bmSR8zN25x3Ow+05QGQNXRvzp6SEgJygvbHmxcJVwAxf1tznVWpK
         6ZyJuAEuNag5MdSztRC8k36vQPzFBPmwtuLRo0Gorijy18h7cpbj28R+N/x91LUkQ3xF
         UyZ6e08ozmmVHevVmRS4QPsOAeMQVKzLXE+kVefUBTOeFxG44P3b3hfFdsQ5z6DD6fbC
         trqTeFeHNe7Sss8GzMQNrYUiH9C8UCo68d/HxlLUIKDgtih7o0hiPRvaFPWdjpx+ilPK
         rJkg==
X-Gm-Message-State: AC+VfDyJNk4UjL8KxdrUSWK0IzKcUy8rttXhAC1E980a2uWF3fspvaFO
        E6w3UoAK0hHHkXOeVPtbRrMnp49ygfaM3m0lf4M=
X-Google-Smtp-Source: ACHHUZ7AAztT7wDg04CQ2nKnfAWMa1pnmSlip+Vrhoyf2jr1HYgNLDOjZbq4X91IiHV6bhFIlToNI63sxAm9XYfkFoM=
X-Received: by 2002:a25:583:0:b0:bc8:5eff:9767 with SMTP id
 125-20020a250583000000b00bc85eff9767mr6075869ybf.33.1687368270308; Wed, 21
 Jun 2023 10:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230614080937.54937-1-luojianhong@cdjrlc.com>
 <2c733a91717eae93119ba2226420fd8f@208suo.com> <CAM9d7chMMQcnV+hTwyEDbcQrO0ELtQTnhQ5bZptF6g_k+m0mAg@mail.gmail.com>
In-Reply-To: <CAM9d7chMMQcnV+hTwyEDbcQrO0ELtQTnhQ5bZptF6g_k+m0mAg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:24:19 -0700
Message-ID: <CAM9d7cjZQa531P8gn03QErYLx79yQ_9axtMTLdx9jEcRpLNoqQ@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Remove unneeded semicolon
To:     baomingtong001@208suo.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 3:50 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Wed, Jun 14, 2023 at 1:13 AM <baomingtong001@208suo.com> wrote:
> >
> > ./tools/perf/util/parse-events.c:1466:2-3: Unneeded semicolon
> >
> > Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> > ---
> >   tools/perf/util/parse-events.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-events.c
> > b/tools/perf/util/parse-events.c
> > index 629f7bd9fd59..42f84f61fabc 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1463,7 +1463,7 @@ static int __parse_events_add_numeric(struct
> > parse_events_state *parse_state,
> >       if (extended_type && (type == PERF_TYPE_HARDWARE || type ==
> > PERF_TYPE_HW_CACHE)) {
>
> The format is broken, please fix your mail client not fix wrap long lines.
> This time I fixed it manually, but you need to update your config.

Also there were other whitespace breakages, but applied to
perf-tools-next anyway, thanks!
