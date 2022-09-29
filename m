Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC315EF524
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiI2MUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI2MU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:20:29 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19E8992B;
        Thu, 29 Sep 2022 05:20:27 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id f26so609855qto.11;
        Thu, 29 Sep 2022 05:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0JbOCdOKk6WwUbn/XvGSZm441jy6P94HZMbRF7zv7gk=;
        b=kxxPejVwKEc2XnhVNyVjyQWkS3qgHlW4IMDjsGSAtFp0BP2b3Js4xsJ0Qa1opR3dmB
         BAc4cAipXgsbVbNlfmVQEjtXV+E7UyzcVsqzAS8bmYQdghTvgk3lyP2bfBjdYiFlj4Fg
         c1gWheJ/NQQgnUrMhvOBMEFXZ59fHPDKxMiC+od6Ch7cACTcSRJ7h6gwK8sKSYqiPTy2
         FYo0n2mHXC/2TdWdR9SxizwI0y4jrVicvuBdLiVWYNPXcqX+NH1x7oVSWrWobWO8lg8r
         zFIA+DbHF5ZuPsCKwUMqDYe6mtRcWIVCB6+nM8ITihu8sFuBkHCcVwsNk51ih+JsUNVL
         f+jA==
X-Gm-Message-State: ACrzQf1MIXmTnrGX4KQlXM4nPIUURwmAg7xAGrH4F7PgktHZPOAIdSu0
        HvrOSe0dmbuQ6WzB3z0CdifVUOvGCrVRVA==
X-Google-Smtp-Source: AMsMyM5sEfkxWRi5K7J/t8SGo6qDH9ceaJd3Fz4VRWNa6dcdampFmAVTh/ZCYQbZNXGrmQz6azUGCg==
X-Received: by 2002:a05:622a:1307:b0:35c:aacf:20 with SMTP id v7-20020a05622a130700b0035caacf0020mr2001075qtk.444.1664454026515;
        Thu, 29 Sep 2022 05:20:26 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id c22-20020ac81116000000b0035d43eb67bcsm5114833qtj.91.2022.09.29.05.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:20:26 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3321c2a8d4cso12524357b3.5;
        Thu, 29 Sep 2022 05:20:25 -0700 (PDT)
X-Received: by 2002:a81:5a57:0:b0:353:6de6:3263 with SMTP id
 o84-20020a815a57000000b003536de63263mr2925782ywb.358.1664454025727; Thu, 29
 Sep 2022 05:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com> <20220926230438.GA3128861-robh@kernel.org>
 <cbe89899-7f56-c43a-f8c9-887825fbe4a6@amd.com> <CAMuHMdUuzrdf4rmD3n_-S9ujrfmY5Y6VOsNapiLRR5MG9bKAjw@mail.gmail.com>
 <5a037955-4832-e42a-eb58-719ed4672395@renesas.com> <20220928234137.71ACEC433D6@smtp.kernel.org>
 <a89b8124-78e2-f9a9-c3bf-1e30687127ca@amd.com>
In-Reply-To: <a89b8124-78e2-f9a9-c3bf-1e30687127ca@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Sep 2022 14:20:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrQJaBmrWoMp7EFNFhEpamp7qZ-eKqyChVNvr5=BPCUg@mail.gmail.com>
Message-ID: <CAMuHMdVrQJaBmrWoMp7EFNFhEpamp7qZ-eKqyChVNvr5=BPCUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
To:     Michal Simek <michal.simek@amd.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, geert+renesas@glider.be
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

Hi Michal,

On Thu, Sep 29, 2022 at 2:01 PM Michal Simek <michal.simek@amd.com> wrote:
> On 9/29/22 01:41, Stephen Boyd wrote:
> > Quoting Alex Helms (2022-09-28 16:16:04)
> >> On 9/27/2022 7:51 AM, Geert Uytterhoeven wrote:
> >>> On Tue, Sep 27, 2022 at 4:10 PM Michal Simek <michal.simek@amd.com> wrote:
> >>>> On 9/27/22 01:04, Rob Herring wrote:
> >>>>> On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
> >>>>>> Add dt bindings for the Renesas ProXO oscillator.
> >>>>>>
> >>>>>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> >>>
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> >>>
> >>>> Driver is also using clock-output-names which is not listed here.
> >>>
> >>> ... which is deprecated, and thus should not be used by the driver
> >>> at all.
> >>
> >> Can you point me to somewhere showing it is deprecated? It is in the
> >> current dt clock documentation.
> >
> > I wouldn't say it is deprecated. Instead, it isn't useful if you're able
> > to use struct clk_parent_data and auto-generated clk names.
>
> I am not closely doing clk subsystem but these chips are clock provider without
> any parent. If you mean calling function like this
> of_clk_get_parent_name(client->dev.of_node, 0) then it should return null.
> But maybe there is something else what you are referring to.
>
> I see that fixed clock driver is using node->name which is also problematic
> because node name for these devices on i2c will look like clock-controller@XX
> where XX could be the same when i2c muxes are used.

Indeed, drivers typically use the node name or the driver name instead,
but that may cause conflicts in case of multiple instances.
So you best append ".%u" obtained from e.g. <linux/idr.h>.

> And in connection to deprecation. I see only one file which is saying that it is
> deprecated.
> Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> and it was deprecated before yaml conversion already.

It was deprecated long before the introduction of json-schema (2015?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
