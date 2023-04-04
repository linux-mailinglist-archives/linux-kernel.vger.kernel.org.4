Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492BA6D6B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbjDDSOe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjDDSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:14:31 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193B10C9;
        Tue,  4 Apr 2023 11:14:30 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id i5so134364672eda.0;
        Tue, 04 Apr 2023 11:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhKMzHmNqvB6X1qkKZYprOrOWk/8T8qP6X22oxtMlpQ=;
        b=djW0A5RTjq7OkOs8EMSTpAAAktgljy9Z19NArq+EoWOHXxMonJyr+G+R6dmpN5XPj6
         Pn4+I2WGHP1rIK/XcFMO8NqpC1cLGmGiNZVkUaxJa1KLB4Tkczd3rcWl4x27oRVC9MJ2
         MKitPKrb7dVRpjUo60MLgLqAQzTMt4vxqyyGLehYIgIS8vpTfn453Ca5rUc0kJMs0Qi7
         LLcmzvJ+PuxsIEGOopPF2VmqeD9fh/H/6WoKo2AXxkdqKHXV43ipmxcZurhc2guWuUhf
         jbmukyKqNnnjs2fuSySKjQTOD9n6c31/j24xHowMoBHaZFl/eWEMJgr4rIr8Csbw5NXe
         dWUQ==
X-Gm-Message-State: AAQBX9fEYI7MW8/2gzWXhYaGUl8kAkjn1cKCxXas68SUicWhV+GjuyI1
        NlJUOvrKpAZH6aBWWO1NbE5Kn09rJIDHXgbVBCEMg0ZS
X-Google-Smtp-Source: AKy350bRKPGjnc4ZAePM02pNmRNlV1Tb6qYnMPU/dgZOryDhR3nTJEsiN6vDr/wAE19ki2QC/KBpCKpwrMTAcbQNfeU=
X-Received: by 2002:a17:907:8c18:b0:93e:c1ab:ae67 with SMTP id
 ta24-20020a1709078c1800b0093ec1abae67mr249016ejc.2.1680632068845; Tue, 04 Apr
 2023 11:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-4-daniel.lezcano@linaro.org> <ca4e9523-0d12-c29f-6de1-365d1713ec84@linaro.org>
 <CAJZ5v0iYk7mC0K7Tsv7Dh9N=dQW151YhVcphvLm7T2vEY10tMA@mail.gmail.com>
 <b0e158d4-5522-821f-d3e5-abc6f77509cb@linaro.org> <CAJZ5v0g7Smzd5sOJ9K1sSF73C9sRC-GmDvAEV629+bYOa7F47Q@mail.gmail.com>
 <f68a0713-3388-aa3e-38d6-04b8a4bb9d16@linaro.org>
In-Reply-To: <f68a0713-3388-aa3e-38d6-04b8a4bb9d16@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Apr 2023 20:14:17 +0200
Message-ID: <CAJZ5v0gcNEtYJmOkkCKq23AsdDRxyLKY6seetnRwtLxyLPWmkg@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] thermal/drivers/intel_menlow: Remove add_one_attribute
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
        amitk@kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
        "open list:INTEL MENLOW THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 8:13 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 17/03/2023 19:18, Rafael J. Wysocki wrote:
> > On Mon, Mar 13, 2023 at 1:35 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 13/03/2023 13:26, Rafael J. Wysocki wrote:
> >>> On Mon, Mar 13, 2023 at 11:55 AM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> is this code removal acceptable ?
> >>>
> >>> I'll let you know later this week.
> >>
> >> Great, thank you
> >
> > So it would be acceptable if it had no users, but that's somewhat hard
> > to establish.
> >
> > As I wrote in a reply to the RFC version of this, I'd rather make
> > these attributes depend on a Kconfig option or a module parameter
> > before removing them completely.
>
> Do you mean we set the default to false and see if there are complaints?
> If not after awhile, we remove the code ?

Yes.  That's the idea at least.
