Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB548600C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJQKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJQKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:15:26 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C521A38697
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:15:25 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-354c7abf786so103272827b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/KHDot+HL1PAnlsK/AO7u3+UGCBHwNGnrH5L/AzTmQ=;
        b=P1nxaguM5LhN9oYBPtJBnma39fj4KaIJu73EUVmohbpKmx5SLfDeElwZ7sKERc/Y47
         otIAokYks6WhmFYfMJ5Vrq5+QBDrFwEwDdRGjb8l//1eAmZlo547kXdpbL3TsxACalN5
         ziPqfMDEYsWR51q08CD8W1yukqIhzRbDIiW+AoG38vpHXvpo7+bQZ0BfmIZNwy2WgwjV
         DBzViZE9mrAqg1vth17r6STUDCjPqF4bmsZFaC5o4OmsZrYsLEsqzNWFltHInSe/Yk+x
         I+Q4yAeC4GRWt5t4sJLyTZnYfXQ6ErL7KQ3nu0A6fYp5N/VEfQ9YGbMg5DVbiCQtC4tA
         RBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/KHDot+HL1PAnlsK/AO7u3+UGCBHwNGnrH5L/AzTmQ=;
        b=U+1hnT+0JL2lyAXbi4XSQix8GBsKymkLroks0gZW+6zM9aDfM+MtZgKppA6nNtoN4H
         VctO3ccAjmheyrJ7HZb5cAvedIawvtMUwaoIIR+gOppfIZWjwmmfek5QRgrGNte7w2hP
         mC1BU6yi0Ixs3vOUpoCvekbIjvS2aWsTqoFedf2sfgfx/MCayIipgrULnLxKBnMUZITw
         gGyCp7YQf23mKeOuXoEu96bFIEOtVExATBLbRTKaKuHaCrutmvt9jepAqtPWLY5KFWO9
         coq9pRLtolKoHCpZhI3AuKlh9KO4OFOPquGNwwtKHRZwVzxfDbNU75UQ5OLIluYpVhfv
         vy8A==
X-Gm-Message-State: ACrzQf3Z25M9j8uISjQgyo7ADFmY5a4itsuIamLmju7yBqkMA5nLXLhf
        FUOaXgv2LIhu6GV+MPUPiUKlDYrLMc35Qwko3J+L2w==
X-Google-Smtp-Source: AMsMyM41fpDS5tjvrCIH3afsq49Fa5gP/eN8Jt2Rq/TudUhaZJBl4Ls+JrqgjC3CNl+hiXlcgwxwU9ZJ3JFdRT3kvIE=
X-Received: by 2002:a81:9151:0:b0:35f:bd8f:4cb0 with SMTP id
 i78-20020a819151000000b0035fbd8f4cb0mr8430969ywg.399.1666001724898; Mon, 17
 Oct 2022 03:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com> <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
In-Reply-To: <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 17 Oct 2022 12:15:14 +0200
Message-ID: <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi James,

On Wed, Oct 12, 2022 at 6:55 PM James Morse <james.morse@arm.com> wrote:
> You originally asked:
> | Any concerns about the CLOSID-reusing behavior?
>
> I don't think this will work well with MPAM ... I expect it will mess up the bandwidth
> counters.
>
> MPAM's equivalent to RMID is PMG. While on x86 CLOSID and RMID are independent numbers,
> this isn't true for PARTID (MPAM's version of CLOSID) and PMG. The PMG bits effectively
> extended the PARTID with bits that aren't used to look up the configuration.
>
> x86's monitors match only on RMID, and there are 'enough' RMID... MPAMs monitors are more
> complicated. I've seen details of a system that only has 1 bit of PMG space.
>
> While MPAM's bandwidth monitors can match just the PMG, there aren't expected to be enough
> unique PMG for every control/monitor group to have a unique value. Instead, MPAM's
> monitors are expected to be used with both the PARTID and PMG.
>
> ('bandwidth monitors' is relevant here, MPAM's 'cache storage utilisation' monitors can't
> match on just PMG at all - they have to be told the PARTID too)
>
>
> If you're re-using CLOSID like this, I think you'll end up with noisy measurements on MPAM
> systems as the caches hold PARTID/PMG values from before the re-use pattern changed, and
> the monitors have to match on both.

Yes, that sounds like it would be an issue.

Following your refactoring changes, hopefully the MPAM driver could
offer alternative methods for managing PARTIDs and PMGs depending on the
available hardware resources.

If there are a lot more PARTIDs than PMGs, then it would fit well with a
user who never creates child MON groups. In case the number of MON
groups gets ahead of the number of CTRL_MON groups and you've run out of
PMGs, perhaps you would just try to allocate another PARTID and program
the same partitioning configuration before giving up. Of course, there
wouldn't be much point in reusing PARTIDs in such a configuration
either.

If we used the child MON groups as the primary vehicle for moving a
container's tasks between a small number of CTRL_MON groups like in
Reinette's proposal, then it seems like it would be a better use of
hardware to have many PMGs and few PARTIDs. In that case, the monitors
would only match on PMGs. Provided that there are sufficient monitor
instances, there would never be any need to reprogram a monitor's
PMG.

> I have half-finished patches that add a 'resctrl' cgroup controller that can be used to
> group tasks and assign them to control or monitor groups. (the creation and configuration
> of control and monitor groups stays in resctrl - it effectively makes the tasks file
> read-only). I think this might help, as a group of processes can be moved between two
> control/monitor groups with one syscall. New processes that are created inherit from the
> cgroup setting instead of their parent task.
>
> If want to take a look, its here:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.0&id=4e5987d8ecbc8647dee0aebfb73c3890843ef5dd

> I've not worked the cgroup thread stuff out yet ... it doesn't appear to hook thread
> creation, only fork().

This looks very promising for our use case, as it would be very easy to
use for a container manager. I'm glad you're looking into this.

Thanks!
-Peter
