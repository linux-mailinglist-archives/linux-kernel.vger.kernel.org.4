Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477F6604059
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiJSJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiJSJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:48:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB90F9852
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:20:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-357208765adso161659527b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PrzM6VyPi82PaY92fbo9QUTAaPQLulnJ473n1V6J/xI=;
        b=LV8dRzW59fxCD/e2uDQI/3qQq7wcs6RnVxoUT8hIRFcCF4rHedHKNCK9qPbv+aEVyz
         ea/DOIIrjF5hCVwrhOIglaiX25R5gZu5DXFfjRQ6C5Nk1L+kKDmnajNSl1Qol8aH6w0s
         Qjr/c/B96Cyw/OB/4zYo7lOCnhiIbnrCl6HWeIslw4oys+Gdbx9TLIOlimgl1ilDUBgd
         cHIWemqFDtASkKNqSwxo0VcE6R/Wia8ZpM7Mn371Y+PkHMyslgMpAnjmKRAuVnexFb+g
         jXclGgx1OKsB6+pmpCcugZQhbQEjiuf9LCufOx4Wm9GAeJSZNHy/HOj0HtSIvgsjyHEl
         H1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrzM6VyPi82PaY92fbo9QUTAaPQLulnJ473n1V6J/xI=;
        b=nThiE0Q5pQcNorganwCQ8FaOjpyRf87x9XWWAc040b6wR+uDhqYtM2JPZzElcEnPjK
         dlwh/vX49I5Dj5NcRE/c7Xz9nwSjF8w1hVqHr1lCoJyLdgWFQuSWLxCidk4RjXczItc6
         WIDL3oYi1992PBp+rn2ogHSwXWP0oNoctJhRS4Rtgq4JHhzXyZDc5q0zhRWN5697QnwK
         13/SDDZK9CQDheGYhFHfqd1G05mFGJr3J6zysny1y2DpxIUmfgou/kLlV3a5alOsFQUM
         b0Yth6SRMyCxIZRr4rsRn2AeTGSDIi8B/GSWfpBrJh1hWNXRpQSVU6yUsqpVDCBqKlBX
         JV9A==
X-Gm-Message-State: ACrzQf1r7sltQPcNBIk0hExYUvufGvnKBlnY6tY9EldxJN6mL93c4zmj
        GnpjMghIvUQduJt1BS6VI2mPdXhzBWI98RAv/3iSLrrXdQaKoQ==
X-Google-Smtp-Source: AMsMyM4oghdEcTZ2acHMOKvr7imO0TA4Zy0rQDQ/F0PDUc221PhV+vAlSIzI4F4JG0E2YXeyYkoDNVuxZkze4Muz4yU=
X-Received: by 2002:a81:1012:0:b0:35e:2df:42ac with SMTP id
 18-20020a811012000000b0035e02df42acmr6057158ywq.457.1666170542391; Wed, 19
 Oct 2022 02:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com> <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
In-Reply-To: <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 19 Oct 2022 11:08:51 +0200
Message-ID: <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
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

Hi Reinette,

On Wed, Oct 12, 2022 at 7:23 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> What if resctrl adds support to rdtgroup_kf_syscall_ops for
> the .rename callback?
>
> It seems like doing so could enable users to do something like:
> mv /sys/fs/resctrl/groupA/mon_groups/containerA /sys/fs/resctrl/groupB/mon_groups/
>
> Such a user request would trigger the "containerA" monitor group
> to be moved to another control group. All tasks within it could be moved to
> the new control group (their CLOSIDs are changed) while their RMIDs
> remain intact.

I think this will be the best approach for us, since we need separate
counters for every job. Unless you were planning to implement this very
soon, I will prototype it for the container manager team to try out and
submit patches for review if it works for them.

> I just read James's response and I do not know how this could be made to
> work with the Arm monitoring when it arrives. Potentially there
> could be an architecture specific "move monitor group" call.

AFAICT all we could do in that situation is hope there are plenty of
CLOSIDs, since we wouldn't be able to create any additional monitoring
groups.

What's still unclear to me is exactly how an application would interpret
the reported CLOSID and RMID counts to decide whether it should create
lots of MON groups vs CTRL_MON groups, given that the RMID count would
mean something semantically different on MPAM. I would not want to see
the container manager asking itself "am I on an ARM system?" when
calculating how many containers' bandwidth usage it can count. (Maybe
James has an answer to this question.)

Thanks!
-Peter
