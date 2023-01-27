Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721AE67EA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjA0QDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjA0QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB46875BB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:30 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id i28so2550465qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K6anF/hme5CxdN/v2AxIOwVlqBuJbrYgKdBlK4gdSTc=;
        b=rfn4ZOVzxnWfwhSIE8fkDMAxjolzF6kjdNho2Tt2KbjgrwOdvpYDCJg4XE0UF1ww/a
         DWLoEkC3WvlpmCpGmzy3JCRm3y/ekNQ+VJw9Qg7YbBn+BgaNixIipxSUP2aDLyvAxgxF
         UPK5ciVbW056HreDoSQSF+UlIbC9KGmzM7XwOsEcakZrPTNLVPUt5OPuiasL5WCFprKe
         YIOdWzPY2MmanVRj6NrjOTbou6mKwojzy1wHVjNqyA/zS4Q39L/ppG+JRF63KRUra/KH
         n9N1B4wF13I2sHApXGUIF5wHHVZzE/u49bCFteRMP50r6EZenFdZADc/bJztTjD9/z2R
         ZlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6anF/hme5CxdN/v2AxIOwVlqBuJbrYgKdBlK4gdSTc=;
        b=3AblN9Tap3vU8f2Q5IP0qeq3W2WE7PizMs3xrnz76JoZ58iUsZxbTy3dqGParcYoIx
         1G1gcAkiRJRcK3F4XhDnBXe3OL4dU6kkWqjc6q2DHaeO6ZFZjwBWkYW7ggKE8kJ5qoSl
         Z2t5WSTKhqGn/veyT4j/ybCg7cpjCop2vEt4L8II7Ff3l7OvsL/Bnqf6151qeRfm8q6e
         LsWdg7AYFPaEvmmt6Z26tyq1PQm2hVWJmHbuk96vGbYgeElxGO9kafa0SLOhsDdHojQ7
         Lq9yVB+PvRXPAl+Pj9pUMjLs0mHGBJWGANS9sJrIqEENjzC0g8ydZRqt2kPbIcKQYtkw
         JIzQ==
X-Gm-Message-State: AFqh2kquSMNVWzFrAzLlznLwD/iT+Ylcb0IjMl6Mo5/enx7dmTvBoE0V
        JYJMiOA0nuR1aiQ27hV2EQrCGlmWIArX1Y/NC0tRPg==
X-Google-Smtp-Source: AMrXdXtQsGdbJsrbBeF3q8V17XDVqU2isO6dhJveWB03TYXftJcVZ2ElfilNcMywMtoyOtMxp8PqMFzRNq5S/xKnSpc=
X-Received: by 2002:a05:620a:9cf:b0:706:8a3f:f17a with SMTP id
 y15-20020a05620a09cf00b007068a3ff17amr1913224qky.52.1674835346359; Fri, 27
 Jan 2023 08:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20230126184157.27626-1-tony.luck@intel.com> <20230126184157.27626-4-tony.luck@intel.com>
 <IA1PR11MB6097400A3056553FCC8E193C9BCC9@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6097400A3056553FCC8E193C9BCC9@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 27 Jan 2023 17:02:15 +0100
Message-ID: <CALPaoCiFotg80LJZ3d+QeO=bNUh85AuP2VgmLaWXX7JaAMYfLQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to rdt_resources_all[]
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
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

Hi Tony,

On Fri, Jan 27, 2023 at 6:25 AM Yu, Fenghua <fenghua.yu@intel.com> wrote:
>
> On 1/26/23 10:41, Tony Luck wrote:
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 6914232acf84..19be6fe42ef3 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -100,6 +100,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
> >                       .fflags                 = RFTYPE_RES_MB,
> >               },
> >       },
> > +     [RDT_RESOURCE_NODE] =
> > +     {
> > +             .r_resctrl = {
> > +                     .rid                    = RDT_RESOURCE_NODE,
> > +                     .name                   = "L3",
> "L3" was named as RDT_RESOURCE_L3 already. The duplicate name here may
> cause duplicate file names in info dir. Maybe rename it as "L3_NODE"?

I'm trying to get some feedback from our own users on whether changing
the directory names would bother them. At least from my own testing, I
did learn to appreciate the interface change a bit more: I needed an
SNC and non-SNC case to correctly predict which mon_data subdirectory
the data would appear in.

I was able to confirm that this change allows bandwidth to be counted
on RMID/CPU combos where it didn't work before on an SNC2
configuration.

If I'm understanding this correctly, it might be helpful to highlight
that the extra resource is needed to allow a different number of L3
domains in L3 monitoring vs allocation.

Thanks!
-Peter

Tested-By: Peter Newman <peternewman@google.com>
Reviewed-By: Peter Newman <peternewman@google.com>
