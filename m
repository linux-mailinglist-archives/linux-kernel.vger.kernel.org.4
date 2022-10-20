Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86E605A23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJTIsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJTIsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:48:33 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FC1645D5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:48:32 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-357208765adso191471627b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=io5S3x3Fc7X0hqOEIUuJV2NHp+mjTu9Aj0Tpi5WlMBI=;
        b=eLL5jKrKA7W75AEN8cfBnnlHBRPQnpHoHKA8/aYos8co3mR6/q1BHhuYidkrIgqHaF
         6Pf1gwHvH//abNYZNzyBnsePVwqFcqWFebZ7Y3LJBefGJbbBeWgYnn31RtrOXdBQvj+i
         Bxut88feCjefby8zGDVj5YsvLXVafjbwnPld3bzLIPah+jU113riNzr0J81D86EC/1Mv
         nKi+l13VfnJx9O+falNGhqeLIsTd0Eri/uFzRehXPooQXDe89RCnX1jvAHV7E6U1L8wL
         kEHuWLLTq30eHfHxo7sbsrbuaCIheRdySCaZCprqXCgfJ3yjsfvWQLY+HB7UGNglzZg7
         CANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=io5S3x3Fc7X0hqOEIUuJV2NHp+mjTu9Aj0Tpi5WlMBI=;
        b=n8UuJ046RMfYkxeNQyINWq47+sqNeArEr9rWdkp7wXHPpFrtXWhSj1/e6GaMRLAFk/
         wZ4ZM3DmjxUQoKPM6ljYlhEZcVpmvksNNOO1MLLT1X7utg0NidcdZgM3q7F9kt1Tb4Rp
         E/m+AYk1KnZIOcLqIzcvSt7xAty2FQRJgcfbQXLsw+Im44XOtkiPTlGD7GLVuCqewy2L
         z6yuytVPeUo48R2DJo2vrpcTid6WfEkTfcPXo7VVRT5TsFpinLCOosV7sLAeDhHMrSq+
         /36cEwszqVoppQYg3ANWJkfIhAzJbrQ5hYy2tAkv+Uxn/lko42Ozm9HGP4eW8JRGmwXe
         6V0Q==
X-Gm-Message-State: ACrzQf2uGVWwPjkmPd01ToAza3pa86QGcajlemiGznToBPvbU8SAH5B9
        YjmbFiuW9UZ3yBHAWn0HxWM0M9sO2jODr+9sZCi3Zw==
X-Google-Smtp-Source: AMsMyM5yegQsJSt9D3OEblndOMocmwcyi++5XBMzLFrKpOd9+SNO1u8nQYAMemqAzVJpXgwR0jZwZlWskWkjoWk/0JU=
X-Received: by 2002:a81:7d42:0:b0:35c:12db:ac4c with SMTP id
 y63-20020a817d42000000b0035c12dbac4cmr10242599ywc.313.1666255711814; Thu, 20
 Oct 2022 01:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com> <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
 <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com>
In-Reply-To: <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 20 Oct 2022 10:48:20 +0200
Message-ID: <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
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

On Thu, Oct 20, 2022 at 1:54 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> It is still not clear to me how palatable this will be on Arm systems.
> This solution also involves changing the CLOSID/PARTID like your original
> proposal and James highlighted that it would "mess up the bandwidth counters"
> because of the way PARTID.PMG is used for monitoring. Perhaps even a new
> PMG would need to be assigned during such a monitor group move. One requirement
> for this RFD was to keep usage counts intact and from what I understand
> this will not be possible on Arm systems.  There could be software mechanisms
> to help reduce the noise during the transition. For example, some new limbo
> mechanism that avoids re-assigning the old PARTID.PMG, while perhaps still
> using the old PARTID.PMG to read usage counts for a while? Or would the
> guidance just be that the counters will have some noise after the move?

I'm going to have to follow up on the details of this in James's thread.
It sounded like we probably won't be able to create enough mon_groups
under a single control group for the rename feature to even be useful.
Rather, we expect the PARTID counts to be so much larger than the PMG
counts that creating more mon_groups to reduce the number of control
groups wouldn't make sense.

At least in our use case, we're literally creating "classes of service"
to prioritize memory traffic, so we want a small number of control
groups to represent the small number of priority levels, but enough
RMIDs to count every job's traffic independently. For MPAM to support
this MBM/MBA use case in exactly this fashion, we'd have to develop the
monitors-not-matching-on-PARTID use case better in the MPAM
architecture. But before putting much effort into that, I'd want to know
if there's any payoff beyond being able to use resctrl the same way on
both implementations.

-Peter
