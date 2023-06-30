Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8293743A95
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjF3LOP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjF3LN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:13:57 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1AC3A89;
        Fri, 30 Jun 2023 04:13:53 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5183075a5ecso323977a12.0;
        Fri, 30 Jun 2023 04:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688123632; x=1690715632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NqWzpNqz4GejaakdrG2FU3sXjzVzmUMDqfldvIeJWs=;
        b=SOaPohP63fPAHcw4NkdknlJKI3HRSVKX3AhqZQVAs2IZK/09vJS4soCwAfg6BQixuC
         2BGOgu2GcMwlf+Xt2wx3tHL6tj8UL8nl9PI5f/x+WXPz+NCudQ+rH/zQjJdhsMUjuUDp
         EMXOqc1qeMubB4MhQPi6B7MMpwz8Ud5vW4dzSym/Nlcb4W2g40EPcCebl6R0Y9SGOPxj
         FAMRAl72dG91NXkGYH8EO5m85g1bkMrMjcquURH6iE1A6hj2TfcyrwVQJI6raTwopThG
         trbk5DTv2IVN6d4CNKlSGNvuUrdUjHgloh3O/eCwgX3WJC9PdxCyghx4xjVi28OzeSzR
         AmQA==
X-Gm-Message-State: ABy/qLZhyZcS/Cv1pnGXwd/CwQDpaiLdD/205QnLT/3KujRBhFwUIjXN
        fjIEaT+xkS6v9y/dckGUPb/baJ991ly9nKTRa05EsoPP
X-Google-Smtp-Source: APBJJlFBMk4yfxaXHTVpdexNeeOE3q6Y64T1g1p+6G/uFx0CIFgz8gGoMQlz52ijPBzf51zuvCktC2iXmxNInWXqh30=
X-Received: by 2002:a05:6402:8d0:b0:516:463d:8a10 with SMTP id
 d16-20020a05640208d000b00516463d8a10mr1339755edz.3.1688123632251; Fri, 30 Jun
 2023 04:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-9-michal.wilczynski@intel.com> <CAJZ5v0hPY=nermvRKiyqGg4R+jLW13B-MUr0exEuEnw33VUj7g@mail.gmail.com>
 <699b327d-acea-c51d-874a-85133b74a73c@intel.com> <CAJZ5v0jpcas1TLGVR5Cic-bz4YkkAVypShj0sfEKUmy+930vVA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jpcas1TLGVR5Cic-bz4YkkAVypShj0sfEKUmy+930vVA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 13:13:41 +0200
Message-ID: <CAJZ5v0hUiZy+yxd9mZoLM99194N0u42+UCms8Fm8s4YpkM1yFg@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] acpi/nfit: Improve terminator line in acpi_nfit_ids
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
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

On Fri, Jun 30, 2023 at 1:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jun 30, 2023 at 11:52 AM Wilczynski, Michal
> <michal.wilczynski@intel.com> wrote:
> >
> >
> >
> > On 6/29/2023 6:14 PM, Rafael J. Wysocki wrote:
> > > On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> > > <michal.wilczynski@intel.com> wrote:
> > >> Currently terminator line contains redunant characters.
> > > Well, they are terminating the list properly AFAICS, so they aren't
> > > redundant and the size of it before and after the change is actually
> > > the same, isn't it?
> >
> > This syntax is correct of course, but we have an internal guidelines specifically
> > saying that terminator line should NOT contain a comma at the end. Justification:
> >
> > "Terminator line is established for the data structure arrays which may have unknown,
> > to the caller, sizes. The purpose of it is to stop iteration over an array and avoid
> > out-of-boundary access. Nevertheless, we may apply a bit more stricter rule to avoid
> > potential, but unlike, event of adding the entry after terminator, already at compile time.
> > This will be achieved by not putting comma at the end of terminator line"
>
> This certainly applies to any new code.
>
> The existing code, however, is what it is and the question is how much
> of an improvement the given change makes.
>
> So yes, it may not follow the current rules for new code, but then it
> may not be worth changing to follow these rules anyway.

This is a bit like housing in a city.

Usually, there are strict requirements that must be followed while
constructing a new building, but existing buildings are not
reconstructed to follow them in the majority of cases.  It may not
even be a good idea to do that.
