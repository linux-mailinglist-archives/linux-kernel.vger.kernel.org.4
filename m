Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E02614EA1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiKAPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKAPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:53:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3492A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:53:24 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g127so9259111ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OoqeNhyztxMh+aSsch8I+eD3VAvwBaYIfKxYJbYWvvc=;
        b=D5z8nU4FBPzjFefdFpz9+6gqBMRN+wgc7hfG8ROciZ89FHqpoW5Rjv6794zfagt9V4
         NW9CdQa+hVVQoXPyRZPvw9hl0txCBCNSteyppqHHuxRhPFRYV84zZCQgXPde23wJKTiI
         /cOVmddaJUCJcX5cR5S5oZL/ZlaEOQYmaFlvoO5D+8GaZlxajYE4LGMmFwb2ocFq5Eh5
         mzLWOtQ4sMO1xACOdzM7Z8AGSkNsQxvp5srDjMIJVFLF+LqFiD5zfEQCDqeIC7qsoFzX
         JXiHrGGUjtpVMMoeXB4gK+uzzVxC1U0zI78LiJpWCpyCg0mPcaYWouVyCGylrwwfvk+7
         SbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoqeNhyztxMh+aSsch8I+eD3VAvwBaYIfKxYJbYWvvc=;
        b=YOV0ptmky1cKjfU7Juyrw6+F355xZiKcm3OUURALQTr8PbYFyMtgeW4YFutY+0uXsR
         aBRLeVO4vAz4xphFmfduHFa+WqOkhHrvGkeFsKi11ex4oVKZFdeE7M09pU1cxITZ4pOA
         fZ+6cDH+SJ/3M1MrAKQ4H4M/4jK48It0X+WqL1T8+y+fqtvfPR4mBXpBZeIZi9v/I9GB
         NM0LxULhyjIZjhefidsCxUkJGmMDihfUNOrAQ97qp7vHQMgoRHLl2vk7ul0UyHbfK2tk
         3RblUC0AlxL+xLF/AytSs732qJEKmuxKAnQk2wBHWJGkuMNjQKaxhPpmzJLmNJVeynrY
         5LHw==
X-Gm-Message-State: ACrzQf3uCwPkON2sT+f/OC2Ip72b4Sm0M6k1JMBmTjs0XIgYYmEHNaGt
        6mYm6VLJSYFbz/8ScuTekRwK00rbtS6Bz0CR87p+nQ==
X-Google-Smtp-Source: AMsMyM4ZFczLE3qSUoRMUHLhkKihEjBCXVb0KD21pHAYskWZsp/tmZakL3aeLNhu/bURKXIk1yFlAMo7lVuBEuy5FFs=
X-Received: by 2002:a5b:443:0:b0:6bc:e3d1:8990 with SMTP id
 s3-20020a5b0443000000b006bce3d18990mr19926712ybp.191.1667318004077; Tue, 01
 Nov 2022 08:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com> <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
 <CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com>
 <715e4123-fdb3-a71e-4069-91d16a56a308@arm.com> <CALPaoCjUk31HvhaqWKfkLNLyZJzbDLJOnEqTsqn882CToLCGcw@mail.gmail.com>
 <317b4a96-f28d-aab5-57cc-f0222b7e4901@intel.com> <CALPaoChNAaoJ7uzuxFFDn-f5nvUCXyJ4jkbETHXNdDpXNnh9pQ@mail.gmail.com>
 <08c0e91a-a17a-5dad-0638-800a4db5034f@intel.com> <CALPaoCj8bVo3Z1r9_Ag=6KvGuR2wzQesArwZKEDvudGPYbbwaA@mail.gmail.com>
In-Reply-To: <CALPaoCj8bVo3Z1r9_Ag=6KvGuR2wzQesArwZKEDvudGPYbbwaA@mail.gmail.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 1 Nov 2022 16:53:12 +0100
Message-ID: <CALPaoCikWKz8VLf5QdeYm5k58tePTpb3nTKMGJ+qeGmevjvMpg@mail.gmail.com>
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

On Tue, Nov 1, 2022 at 4:23 PM Peter Newman <peternewman@google.com> wrote:
> Yes it looks like the task's rq_lock would provide the necessary
> ordering. It's not feasible to ensure the IPI arrives before the target
> task migrates away, but the task would need to obtain the same lock in
> order to migrate off of its current CPU, so that alone would ensure the
> next migration would observe the updates.
>
> The difficulty is this lock is private to sched/, so I'd have to propose
> some API.

Actually it looks like I can just use task_call_func() to lock down the
task while we do our updates and decide if or where to send IPIs. That
seems easy enough.

-Peter
