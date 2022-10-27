Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0E60F1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiJ0H4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiJ0H4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:56:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A9DBE65
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:56:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id n130so878304yba.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KeiSAxf55Qgt0sTgqqzoMI3sslh+XAwt6WemHVLUyTQ=;
        b=jQqE8d7UC08I2MQzXE34te2JuWP/x4Wh7JtL9xmvFOD1ixa5Q0/2bz13L0cENjjYIU
         fxQZAcOREYgXndWHCDNeOB9EZ9zRQg9GdDx3jgCyuuUqILFGe5M5IN8UWuKdkJcZD+Uo
         PMo+/lvU1VojB/X8TpGRqx7AFT55PAkNaUVUi0HXTsbILndzK4qly6q8eCq1wxiOnqOP
         Hdd6TcVSMyS2XyL723FQ96Y2AndzA9cPSl2+QMFV3GoPybP3lrUPbm6Y/OnUQz0HtiUy
         qrgLeN2gJsCjbUh6UwI3aZh1rjG2uUCTzmcHt25kdSWhijhVnOWP/bQqLY9khdVM2Gg0
         DUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeiSAxf55Qgt0sTgqqzoMI3sslh+XAwt6WemHVLUyTQ=;
        b=crp4HlBRxV8KfAnT5HgRSi9DgPoj3XiqoNq5uT+zMIiXNczEefDd0keXAKl7QqjLNW
         B0Xc9YimYbKUulEtdqFLrlgOloKlQbZuMKMRaP5sHsxmfVLo4Zl68y9GvZOIFwUQOgz5
         xVIV2ZpQP0V5hn7YQc2VbU9/Qmmp1QHfAi3byA5odBNdnY8mpytWhfLcWUH/r2Po4bdH
         RCt+E1UO0Grjq+w72Nqkg6e0LKNe3MTbVLrfv6lhECJVBia9KzTKsm4b27LY0brpz2uT
         KetUgV0imsl76hTUkVtgroDAqA7rypkUokC4aASYHAXEsprx40QNdv0BOHHi1sutQ8tp
         VMbQ==
X-Gm-Message-State: ACrzQf2toLlIvY6/03BEwoGzyKiQ214pOigPX6csXf2KiZrZqMtQHDfL
        tAUAbr1NBeeV+BY4VX30fcD6GC4JSdxk8XHdIqJghYmyEeopI41T
X-Google-Smtp-Source: AMsMyM4glR5aG/V2ywcFzYodsjYaJMGrcUWMlLZjGEdvZ/mcVDuw2aU10TGlnkfq9Z+WdEG9OxHgK3WEIyjB5M+xGsY=
X-Received: by 2002:a5b:542:0:b0:6ca:1d54:fec8 with SMTP id
 r2-20020a5b0542000000b006ca1d54fec8mr35103573ybp.45.1666857404857; Thu, 27
 Oct 2022 00:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com> <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
 <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com> <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
 <317b4a96-f28d-aab5-57cc-f0222b7e4901@intel.com>
In-Reply-To: <317b4a96-f28d-aab5-57cc-f0222b7e4901@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 27 Oct 2022 09:56:33 +0200
Message-ID: <CALPaoChNAaoJ7uzuxFFDn-f5nvUCXyJ4jkbETHXNdDpXNnh9pQ@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
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

Hi Reinette,

On Wed, Oct 26, 2022 at 11:12 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> The original concern is "the stores to t->closid and t->rmid could be
> reordered with the task_curr(t) and task_cpu(t) reads which follow". I can see
> that issue. Have you considered using the compiler barrier, barrier(), instead?
> From what I understand it will prevent the compiler from moving the memory accesses.
> This is what is currently done in __rdtgroup_move_task() and could be done here also?

A memory system (including those on x86) is allowed to reorder a store with a
later load, in addition to the compiler.

Also because the locations in question can be concurrently accessed by another
CPU, a compiler barrier would not be sufficient.

-Peter
