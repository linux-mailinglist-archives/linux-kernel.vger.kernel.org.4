Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36889607728
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJUMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUMnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:43:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F1357F6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:42:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 126so3222916ybw.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H18fgacNDQLgrpVz2xT5w7SDdDDbUEcHj1IYxxrtq/s=;
        b=NZp3CanJ6NUzRaq6R3kgGsJHZZMPIL+BXN3fL8n5ldwI7gm0BhmSbJOWnEwUqwAEsp
         8DNff/mUS+/dhLSiRe9mm/rCitSHu3Zmi8GOG02WaD5w2fg2FN7Y4pNkhZ3EBmug/iSB
         q0+j2D7mhNSEyuN9RYAz/ZuMqUfxXiswXCc2vHtKYQ7rxHGj4OMG7beikG5npRD+jDm0
         ZzdDnT25sBi7B3buZkA9fDkx0aMyo31er2BQmfxMTLe7XdkGIJqyfnwSL97fFeZQqcRj
         Z/v42mbCV4Eo6hEBiMkK58iyrQHPuQgFVP9otIGDVYwcpEMDqrUFPyp40NYSPCeAy9K+
         16nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H18fgacNDQLgrpVz2xT5w7SDdDDbUEcHj1IYxxrtq/s=;
        b=s1ANoDUrW7PTxXZvnj69eDFiJb+vKxrm45Qvs43S4AB1k95tQ9X+HQq+JDNI+4d6VZ
         RcLHGG0EnBoB2kp/mK8KBzz3Z+0WpCxXtCWEZSAM9wX6gSfQI2XdwHz4qZFVv+bSEvmr
         oh37gyhV6SPGKA2Gh6Si7K9nNMqsBq0/dbXdX62e6u8hX+dMuUtMCBF1dRouWMtMJ2T9
         SNAqiWIaMXPJmY+PUjymNHBVPhrd2eCTWClwnlw0lUOqAPb4auj7t3vfqZrZRPNqT53I
         NFrB+sPRPCe/L0qUMrrGW0lxyMHCGujm4sPVkd1Ltn4psV4IyrWn0rxF7B8bdG/cgPee
         Nvpw==
X-Gm-Message-State: ACrzQf0Nrb0CA9uohFmAGH+5orVCpUt4jngQNNUzWhfuHVJjJ6pulwKI
        w7X5zu3wzqXf17fTTIz+gvO3mapReEBqJzKUYkOOuQ==
X-Google-Smtp-Source: AMsMyM4j0zvIhhQgbUc087N6XCBPmc7zOkEBbj/aCq0dZejSsCLUzts9QUOrV/x18trUAJWUjXt4hHlLjIwQTGrNTNc=
X-Received: by 2002:a25:4a06:0:b0:695:c6a0:c8e1 with SMTP id
 x6-20020a254a06000000b00695c6a0c8e1mr16534878yba.181.1666356175684; Fri, 21
 Oct 2022 05:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com> <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
In-Reply-To: <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 21 Oct 2022 14:42:44 +0200
Message-ID: <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
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

On Thu, Oct 20, 2022 at 12:39 PM Peter Newman <peternewman@google.com> wrote:
>
> On Wed, Oct 19, 2022 at 3:58 PM James Morse <james.morse@arm.com> wrote:
> > The devil is in the detail, I'm not sure how it serialises with a fork()ing process, I'd
> > hope to do better than relying on the kernel walking the list of processes a lot quicker
> > than user-space can.
>
> I wasn't planning to do it any more optimally than the rmdir
> implementation today when looking for all tasks impacted by a
> CLOSID/RMID deletion.

This is probably a separate topic, but I noticed this when looking at how rmdir
moves tasks to a new closid/rmid...

In rdt_move_group_tasks(), how do we know that a task switching in on another
CPU will observe the updated closid and rmid values soon enough?

Even on x86, without an smp_mb(), the stores to t->closid and t->rmid could be
reordered with the task_curr(t) and task_cpu(t) reads which follow. The original
description of this scenario seemed to assume that accesses below would happen
in program order:

    WRITE_ONCE(t->closid, to->closid);
    WRITE_ONCE(t->rmid, to->mon.rmid);

    /*
     * If the task is on a CPU, set the CPU in the mask.
     * The detection is inaccurate as tasks might move or
     * schedule before the smp function call takes place.
     * In such a case the function call is pointless, but
     * there is no other side effect.
     */
    if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
         cpumask_set_cpu(task_cpu(t), mask);

If the task concurrently switches in on another CPU, the code above may not
observed that it's running, and the CPU running the task may not have observed
the updated rmid and closid yet, so it could continue with the old rmid/closid
and not get interrupted.

-Peter
