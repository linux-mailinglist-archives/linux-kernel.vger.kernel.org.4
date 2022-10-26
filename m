Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B47D60DE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiJZJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiJZJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:37:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA9BA917
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:37:00 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j7so18089753ybb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=706h6cqOs2l/kslM/B1QDVDbS14wTyqp/kH04Nk7mGo=;
        b=lcFpMlXR9QDRQnn1OcsqiZF1fCtrsX5FdlgD4yAkwK1hey81P/rPiPN6O3vW6cC8Js
         pqYgyU4uPdnR25kYhcm4XOn3qC2hzcUv6fEpK7SiWKlZGqyu9r71ued3BK1r+uVLDKyD
         D2QNTfeVVySYmI4ZNXgggcW+IfM0BfFq8rV+tzyRb/oUT0YqgeYEIWHMeXBHxKoB1dKG
         x4N5YO9YHhfnhToGdnynRgywOgArNsLvlXsyMsfduxpk/mVa1QAXJySmvrCeZohRZr67
         kbmM2pMzbwWhdjFmIlvu1gt5edpZpsviZ7QCOGsgJEZnusU/YD2Zsc+6Tt5u36lbT8LA
         JRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=706h6cqOs2l/kslM/B1QDVDbS14wTyqp/kH04Nk7mGo=;
        b=Rjrz1HhfGB+2KsqtJHBQsWwyOIhSYQoVN5AkrYyaqyy84bs5c6BiGa6SKdJcgX3Rjv
         s5MnJI8vccCkGPXPBXNWDE12tR2kg5T0gfPIF5rmGlM6xziti+ubGeYQYFSPDZnIa9xp
         lhay5QBqRvPPq3PFiZ9cK1zRrKvGX7MAHTFAxxi7W8ey2YdVip1seZtMN3zD5KUtg9x3
         9IM3oZz5MfA+bJUWO6Wukoxck0jtfkaGUeKWuBmXVwZq1oa5tBXPnC///vAyES/pWcqC
         YhWzJl5OmtU+tTPPN5OO9TMPcaQXrdLMxHrFRdufbDPD4ROOrfT1lM01wjPKemN1clfm
         nn8w==
X-Gm-Message-State: ACrzQf1Vr0/q6R+5bkuXCEJC0F6SPRiuRdgDoYoETFaenanjj3T5ZzO8
        DRe7n4XjwydR+DDJvbE1YOyH3ABUuNvqF7Q61otXjg==
X-Google-Smtp-Source: AMsMyM4zuIhWn8iUOnMyOHU9NCU+8cn/kqFCo2Uza6O/mZFLbz5czJttUk1/UxjThsCNEP+sHOL2LWiLjfq51M2fsLc=
X-Received: by 2002:a05:6902:10ca:b0:671:3616:9147 with SMTP id
 w10-20020a05690210ca00b0067136169147mr37253355ybu.105.1666777019885; Wed, 26
 Oct 2022 02:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com> <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
 <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com> <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
 <da89ea90-8453-f848-38d1-a14195faa95e@intel.com> <a4def722-aa98-6bf9-6e77-65a9fd9bd8ca@arm.com>
In-Reply-To: <a4def722-aa98-6bf9-6e77-65a9fd9bd8ca@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 26 Oct 2022 11:36:48 +0200
Message-ID: <CALPaoCgdk_Yaw_EQ1ca9-h5L+sHBEkm3TpT-o84TC4AxWDSsbg@mail.gmail.com>
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

On Tue, Oct 25, 2022 at 5:56 PM James Morse <james.morse@arm.com> wrote:
> This would work when systems are built to look like RDT, but MPAM has other control types
> where this would have interesting behaviours.
>
> 'CPOR' is equivalent to CBM as they are both a bitmap of portions. MPAM also has 'CMAX'
> where a fraction of the cache is specified. If you create two control groups with
> different PARTIDs but the same configuration, their two 50%s of the cache could become
> 100%. CPOR can be used like this, CMAX can't.

I thought we only allocated caches with CBMs and memory bandwidth with
percentages.
I don't see how CMAX could be used when implementing resctrl's CAT
resources. Percentage
configurations are only used for MBA in resctrl today.

> Even when the controls behave in the same way, a different PARTID with the same control
> values could be regulated differently, resulting in weirdness.

Can you provide further examples?

-Peter
