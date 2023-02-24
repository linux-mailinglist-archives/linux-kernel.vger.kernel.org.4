Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CB6A16B7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 07:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBXGpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 01:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 01:45:22 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34F14224
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:45:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bw19so2226596wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4p2N3znozSpEZbXtte2eMWOETBMxmUkJjVlowyV2+bc=;
        b=N39tkFtx+s7CpXrGQlLyWXyoblArhh6VID9Ru50wl2J62Q++6oqJH6CDo1T3SFLs5/
         c7bA4i771vDpqJxlNPbOz1BvJROOZ5UxxrsZAEdsOsmEpF6CVY4Ri9C4HFCqQGV89zRO
         wJcp+gaKNkegs5/U6cNrOgakrYo+SLW/XZ5Dw13rRmtOx7lxZ3Laa/PQdaSZzFmmQlN1
         dr9xOJ716vNQ4W2La6SOrcgF3G0rWGoWIEQt65AfitBU3ZI8RKHpa0sAm4M9ou4qzVkA
         gLM1J3XQJtTayQLfzA1PRNI5hkU3MMfR4iqTWhOla8GhVP7Rj8Ktl9BLhNwHUqBbW9NX
         1ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4p2N3znozSpEZbXtte2eMWOETBMxmUkJjVlowyV2+bc=;
        b=y04//O2xIYb4slMVp9ylJWZyjVlfBxUPZkiJJmmg8aYzNP/RhDijsF8MWnrm3j4/4j
         4DeJbBUu6PiW1Y7oHC2yqoTDyOcgSZVjNCRX5pVxbJvV/2mI4EG7GJoCg53UOrv0FHLz
         8tvwXdDw0Bgjy0Aubg+OrwHhl2KaGLPwdnVbzg2PkwjZ1gkaVb37nrsrj+n1LmvzfFBR
         JXIg6J/grnmH6b+Uo6iVgQFxAYw3H+SBuEMo7aAmSpdprkwhkCM2SHbWKUcgddBmZEwh
         /BU59swLvXys6WKO1AHW0FQphm7r1lPujwSM31bylltesMbkP7+xLTBcnj++vm3UryP4
         VM3Q==
X-Gm-Message-State: AO0yUKXXYfMQpWbTi/PXeLuhAPHaa7Y9uhJHDNcOvOFMMlTxh7dZQgGs
        W2fzDa4fSiNnN8yRvn284aDnYqV45V/HcbiDg8Kk3g==
X-Google-Smtp-Source: AK7set/oLnSaCRuVllUODj6q0Pghmzon19a0040df5q10BofQNdQRjI3Ze3ELHznn1gn9/2Ovf05XHFR5R4O+US0skc=
X-Received: by 2002:a5d:544a:0:b0:2c5:3fcb:682b with SMTP id
 w10-20020a5d544a000000b002c53fcb682bmr946077wrv.2.1677221119373; Thu, 23 Feb
 2023 22:45:19 -0800 (PST)
MIME-Version: 1.0
References: <ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com>
 <CAMn1gO7Ve4-d6vP4jvASQsTZ2maHsMF6gKHL3RXSuD9N3tAOfQ@mail.gmail.com>
 <CANpmjNNvGL--j-20UxqX_WjeXGiAcjfDAQpfds+Orajz0ZeBsg@mail.gmail.com>
 <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com> <20230215143306.2d563215@rorschach.local.home>
In-Reply-To: <20230215143306.2d563215@rorschach.local.home>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 23 Feb 2023 22:45:07 -0800
Message-ID: <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
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

On Wed, Feb 15, 2023 at 11:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Feb 2023 09:57:40 +0100
> Marco Elver <elver@google.com> wrote:
>
> > Yes, you are right, and it's something I've wondered how to do better
> > as well. Let's try to consult tracing maintainers on what the right
> > approach is.
>
> I have to go and revisit the config options for CONFIG_FTRACE and
> CONFIG_TRACING, as they were added when this all started (back in
> 2008), and the naming was rather all misnomers back then.
>
> "ftrace" is really for just the function tracing, but CONFIG_FTRACE
> really should just be for the function tracing infrastructure, and
> perhaps not even include trace events :-/ But at the time it was
> created, it was for all the "tracers" (this was added before trace
> events).

It would be great to see this cleaned up. I found this aspect of how
tracing works rather confusing.

So do you think it makes sense for the KASAN tests to "select TRACING"
for now if the code depends on the trace event infrastructure?

Peter
