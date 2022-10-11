Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C905FB6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJKPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJKPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:22:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A411B2D2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:13:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so13044972pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH61kT+wk9qQeQtr18nkFVkMNvE3Of5ZE74j8i5uZRs=;
        b=Ki0hHaBDFFTECeeqlzDtdZe6tS6GMZY9Bc7S4GEXjc+wCZxXXIYfBdFIzSDaVSVOZP
         fEMqnDG0mnTQ3Cje3CjeBFwS7I89p5EIzaTk7pQ8q1VxuiI8LM39M39JtVB02rk6OMU8
         xGURux2nB/GPD0IZTAsB3XB8HNojtqGdhZMyS1PmjfPqtTTLnG1iSDNdiYWX2Ibj1JN4
         m3GP6lgA7JJbSpIPCA/pPQBa2rK/kWIgm8RyNjNZrrE3Fyf+x/HA7grU46ow4PJTqaIy
         Y6CNi9nF+Eaas25QNYhRnjgolTXLV/3EmvYHQHoOLMtRrXRoI7f802PN7eMEIs6sXQUZ
         JlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RH61kT+wk9qQeQtr18nkFVkMNvE3Of5ZE74j8i5uZRs=;
        b=Hr/o+vnLd3A3Rumr3stLTtLuSUuo9V7k+GbgGNLsHsJqbPHbvraenZcxHUDA4Abcse
         GMIdzVnfpErbDRcf8UpUMqbKLXUXPjE/Q/Qu9VMm+JfOC/9Y6FXU3xzg4AMwlkgarmqb
         5cg3mjMtY8ZunIs/lzZ6kmOp34L74ZBsyV8rok2kLgriYA89v4va890RChAkMhfbKyvm
         yWnUDv3w2agP1pzvw17ULBeATwoy3Q65RwqpDUz3F7QT077FuwUEwhDsfbdrQ7CiLZpq
         CPUQ4X1NhPSTCrr/ApY56bCEf0BghJAiR/E4A9togXufFvu4ZBtEwzafzOEY6289WrhY
         XGPw==
X-Gm-Message-State: ACrzQf0AQASxnWe+DpfDX5Mdq+n1GWt4I3MZwVEnI4zy8XrshTjBL3fH
        uN8D1xLMt6rVN/oy1vDn/wK8UCi7ARQ9odu9LBAVMGermC4=
X-Google-Smtp-Source: AMsMyM6iTtWLyusY/a5TirRFeV1JoXX8/sks6yxB6jKrPb/dHt/Lb1+3MkUlRnpHpeISKdaY441CpJqpPrUQnucOcZw=
X-Received: by 2002:a1f:26d8:0:b0:39e:e116:59b8 with SMTP id
 m207-20020a1f26d8000000b0039ee11659b8mr12168746vkm.36.1665500432252; Tue, 11
 Oct 2022 08:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <MW3PR12MB45531D396A2010666F3E238F955F9@MW3PR12MB4553.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB45531D396A2010666F3E238F955F9@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 11 Oct 2022 08:00:20 -0700
Message-ID: <CABPqkBS_=V4D-3wRvucEBZqEsT6VppYutg8ExQoLpKjbzKvZoA@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Peter Newman <peternewman@google.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 7, 2022 at 10:57 AM Moger, Babu <Babu.Moger@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Peter,
>
> > -----Original Message-----
> > From: Peter Newman <peternewman@google.com>
> > Sent: Friday, October 7, 2022 5:40 AM
> > To: Reinette Chatre <reinette.chatre@intel.com>; Fenghua Yu
> > <fenghua.yu@intel.com>
> > Cc: Stephane Eranian <eranian@google.com>; linux-kernel@vger.kernel.org=
;
> > Thomas Gleixner <tglx@linutronix.de>; James Morse
> > <james.morse@arm.com>; Moger, Babu <Babu.Moger@amd.com>
> > Subject: [RFD] resctrl: reassigning a running container's CTRL_MON grou=
p
> >
> > Hi Reinette, Fenghua,
> >
> > I'd like to talk about the tasks file interface in CTRL_MON and MON gro=
ups.
> >
> > For some background, we are using the memory-bandwidth monitoring and
> > allocation features of resctrl to maintain QoS on external memory bandw=
idth
> > for latency-sensitive containers to help enable batch containers to use=
 up
> > leftover CPU/memory resources on a machine.  We also monitor the extern=
al
> > memory bandwidth usage of all hosted containers to identify ones which =
are
> > misusing their latency-sensitive CoS assignment and downgrade them to t=
he
> > batch CoS.
> >
> > The trouble is, container manager developers working with the tasks int=
erface
> > have complained that it's not usable for them because it takes many (or=
 an
> > unbounded number of) passes to move all tasks from a container over, as=
 the
> > list is always changing.
> >
> > Our solution for them is to remove the need for moving tasks between
> > CTRL_MON groups. Because we are mainly using MB throttling to implement
> > QoS, we only need two classes of service. Therefore we've modified resc=
trl to
> > reuse existing CLOSIDs for CTRL_MON groups with identical configuration=
s,
> > allowing us to create a CTRL_MON group for every container. Instead of
> > moving the tasks over, we only need to update their CTRL_MON group's
> > schemata. Another benefit for us is that we do not need to also move al=
l of the
> > tasks over to a new monitoring group in the batch CTRL_MON group, and t=
he
> > usage counts remain intact.
> >
> > The CLOSID management rules would roughly be:
> >
> >  1. If an update would cause a CTRL_MON group's config to match that of
> >     an existing group, the CTRL_MON group's CLOSID should change to tha=
t
> >     of the existing group, where the definition of "match" is: all
> >     control values match in all domains for all resources, as well as
> >     the cpu masks matching.
> >
> >  2. If an update to a CTRL_MON group sharing a CLOSID with another grou=
p
> >     causes that group to no longer match any others, a new CLOSID must
> >     be allocated.
> >
> >  3. An update to a CTRL_MON group using a non-shared CLOSID which
> >     continues to not match any others follows the current resctrl
> >     behavior.
> >
> > Before I prepare any patches for review, I'm interested in any comments=
 or
> > suggestions on the use case and solution.
> >
> > Are there simpler strategies for reassigning a running container's task=
s to a
> > different CTRL_MON group that we should be considering first?
> >
> > Any concerns about the CLOSID-reusing behavior? The hope is existing us=
ers
> > who aren't creating identically-configured CTRL_MON groups would be
> > minimally impacted. Would it help if the proposed behavior were opt-in =
at
> > mount-time?
>
> I am still trying to understand. I would think when creating a new group,=
 the new CLOS id will be used. Basically, it will remain as default behavio=
r.  You probably don=E2=80=99t need to create two identical group during th=
e group creation.
> New behavior of changing the CLOS id will happen when the "match check" i=
s triggered. How is the match check is triggered? Is it triggered by user?

The matching check is triggered when the schemata is changed for any
resctrl group.

> Thanks
> Babu
>
>
