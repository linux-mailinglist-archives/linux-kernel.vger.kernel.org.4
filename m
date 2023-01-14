Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4790566AB77
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjANNK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjANNKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:10:53 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09D65B7;
        Sat, 14 Jan 2023 05:10:51 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so13670383otp.9;
        Sat, 14 Jan 2023 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3MdNdF8Xsr/CFhUD2SEaMu/iBQ2k8zQdq8AYu1J6uI=;
        b=OLi2UW1aWjvyBrAY/TiZZY1hKnBfV/RxNxbeXS+GLpx1w6Beqn/fmA/Ze8RilYSM/R
         yL2+AXHufL/2dYE67umsxSk9jW7Q7Lebi3wt/Pv0wS8N8up/BGiV5HvGsGVvP2sVcuj8
         D7w6d2JXEsdLu3Qgqoxw0yR+F7PHneSA5M8WG3FpqJByh9gg3YLZAwRNrmI1G/hqVsFM
         efF3RnuzKKCdNreblBZprq8/7KP2JTwswqd1T5wl4ioxCEkxb2aNS4tssrpSR3hWXT0G
         Mfc7tmQEdXbRa2VWO8MFbxf1hIr2B37Ve7sa7th9aaT/0ZFU2QPfwH4/SIzCG/qkLRS4
         7q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3MdNdF8Xsr/CFhUD2SEaMu/iBQ2k8zQdq8AYu1J6uI=;
        b=YCLVN9XBUBn0Gy6tgrRrVR7ltjvYJ/NFlx+hp8O7qxpgIhvBnWlcmywK4C3O2NW1Kh
         eByN4qV2KXp60n729E0z82sslmvTzDIiJ4e1lvg0X0j+gQM+/qiBBvDQpD+coKYyIKxZ
         ITC2xSbibTOkg3ojFjONgR6VlmUvh+gf6CFJ1mSj5T/Wpz1arCqbS5hYxYfmmMn8u3s2
         nzMuds3cvYaAu+wwCtFMqdf+SIISPen64yWr63FoW72+ZSXGAd3qh591rRat6zkGKg/E
         PNDyXgYKL3FR4WBpMZEhJG93lX1YvUXcEptAriYBwUO5WDvseao8l5twnAJqhA2OJi7j
         l7/g==
X-Gm-Message-State: AFqh2kqFGYaBVCRKrleOUpi3flm5z1cT8Zg+2ZCCp1gFclMz8b1yNuM0
        tclFYFEiAHFqi7HERMVoH5cCru1fFB9fC4i4LyI=
X-Google-Smtp-Source: AMrXdXtp0vKi2W4302CMvaPhUPuAY6QwMhuCCRpuhABUJqkTKmdOIAxKBAPjHcz36zLcyFEm7Cy1c0ZYVY10oeVAQm8=
X-Received: by 2002:a9d:61ca:0:b0:670:6dc1:6c2c with SMTP id
 h10-20020a9d61ca000000b006706dc16c2cmr5073968otk.375.1673701850925; Sat, 14
 Jan 2023 05:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20230106215613.7159-1-apantykhin@gmail.com> <a6a2e8b1-7194-75f1-d59c-7c8bc059174a@intel.com>
In-Reply-To: <a6a2e8b1-7194-75f1-d59c-7c8bc059174a@intel.com>
From:   Alexander Pantyukhin <apantykhin@gmail.com>
Date:   Sat, 14 Jan 2023 17:10:39 +0400
Message-ID: <CAPi66w__aD7DqueUGA=yXfY-puW6nSKGSjEPA+n28U39j7r=ig@mail.gmail.com>
Subject: Re: [PATCH] tools:perf:scripts:python:intel-pt-events del unusedvar
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     peterz@infradead.org, akpm@linux-foundation.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>
> On 6/01/23 23:56, Alexander Pantyukhin wrote:
> > The event_attr is never used later, the var is ok be deleted.
> > Additional code simplification is to substitute string slice comparison
> > with "substring" function. This case no need to know the length specific
> > words.
> >
> > Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> > ---
> >  tools/perf/scripts/python/intel-pt-events.py | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> > index 08862a2582f4..28d08e2fb7cd 100644
> > --- a/tools/perf/scripts/python/intel-pt-events.py
> > +++ b/tools/perf/scripts/python/intel-pt-events.py
> > @@ -340,7 +340,6 @@ def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
> >       print(start_str, src_str)
> >
> >  def do_process_event(param_dict):
> > -     event_attr = param_dict["attr"]
>
> Should really be moved to the "Unused fields:" comment
> section a few lines below.

Fixed in the patch v2.

>
> >       sample     = param_dict["sample"]
> >       raw_buf    = param_dict["raw_buf"]
> >       comm       = param_dict["comm"]
> > @@ -359,13 +358,13 @@ def do_process_event(param_dict):
> >               print(glb_switch_str[cpu])
> >               del glb_switch_str[cpu]
> >
> > -     if name[0:12] == "instructions":
> > +     if name.startswith("instructions"):
> >               if glb_src:
> >                       print_srccode(comm, param_dict, sample, symbol, dso, True)
> >               else:
> >                       print_instructions_start(comm, sample)
> >                       print_common_ip(param_dict, sample, symbol, dso)
> > -     elif name[0:8] == "branches":
> > +     elif name.startswith("branches"):
> >               if glb_src:
> >                       print_srccode(comm, param_dict, sample, symbol, dso, False)
> >               else:
>
