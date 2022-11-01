Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4688C614C14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiKANus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiKANum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:50:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90316556
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:50:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f5so15626277ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQAnjt+7XG8p++j0HFBqJ1i4IPg+WyhF6FRul3d1/9M=;
        b=hesLDdylycooTsz6aCItyOr7PtE299wGrzDAYVq5R34UZo3QscVnl8OQaus4HSG6AK
         Mdk1ppaD67TQP3cDlAYo9APgzs+RmxBeuxxRVjavusi51UKc1MYMzXMjUVHxKbCg5vI8
         VUExyH4qUIkhWDbZmocLqwRhLD+gdvCFrB9qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQAnjt+7XG8p++j0HFBqJ1i4IPg+WyhF6FRul3d1/9M=;
        b=wS24/ZpOaUb9/svPKpiZPFp07JMeBr/V32Nppd5hcWRlWcJ0N/bmRHGBSZ1SyeAs6G
         prda1BQ58IVbXlNaVdSixa9OTWBbAQ/4zJXv28u9YBwJGUkYoNYxaJZ5ozcO+/GWpPCR
         6w17B0HAYXdjIKMvOLejdJ8NDjf+dz3YDQX77fHaVz4rJcHN4MV8KvDpDQpT/DG3w2wP
         iGEMffiolIzC2qOXqiJ9HRMtGFiyj785KMYlDi/ipCTIflOvVRH2n7ltXWIOHcE/jYvX
         IZw7kZ9+M57RI1OX043KABkaIF4JZbZWyN5VkSZLjiOBj7pXJVIVjvgBW+IS1L/INTbs
         diKg==
X-Gm-Message-State: ACrzQf31+qjCmYEcxvwyOratFBbFYHyyTueChr4XM6+ypjrBw432CypL
        yQcNAfqcvI4GR8PZUGOrPzVSdzx/UKjbP51d
X-Google-Smtp-Source: AMsMyM40d3/bKH27DzcZxATgD3jKZGJSUDeSmsBIKKDRre92BqqXWmAbyYhNTU8mInJxeet5kvYHpA==
X-Received: by 2002:a17:907:6d8c:b0:7ad:b45c:dd24 with SMTP id sb12-20020a1709076d8c00b007adb45cdd24mr16161762ejc.616.1667310640214;
        Tue, 01 Nov 2022 06:50:40 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090686cf00b007305d408b3dsm4214843ejy.78.2022.11.01.06.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 06:50:39 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id y14so37168242ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 06:50:38 -0700 (PDT)
X-Received: by 2002:a17:907:75f1:b0:78a:f935:647d with SMTP id
 jz17-20020a17090775f100b0078af935647dmr18150379ejc.587.1667310637954; Tue, 01
 Nov 2022 06:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com> <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
 <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijSASfbfWQNarjGqj2UxQDOSdwM-qj5YA5A9ur=DNJf-g@mail.gmail.com> <cb5ab68e-5034-d937-e28e-e838e50172a8@amd.com>
In-Reply-To: <cb5ab68e-5034-d937-e28e-e838e50172a8@amd.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 1 Nov 2022 09:50:26 -0400
X-Gmail-Original-Message-ID: <CAM7w-FW2Yer3B+Z6giP8Jc8i5xEMueFKzY=R172drWaYtRHwQg@mail.gmail.com>
Message-ID: <CAM7w-FW2Yer3B+Z6giP8Jc8i5xEMueFKzY=R172drWaYtRHwQg@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 9:58 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> I actually thought that by putting the duration of time put in
> last_hw_deepest_state you'll be able to catch this by comparing the
> duration of the suspend to the duration of last_hw_deepest_state.

I'm not sure if this method would catch all or even most suspend
failures. That's why the EC monitoring of S0ix was devised. I will
circulate this internally, see what comes back.

> >
> > Is the light worth the candle?
>
> I wrote an RFC that I sent out for it with my ideas at least.
>

That is much appreciated ! Yet even for good ideas, it's often
necessary to weigh the benefits and downsides of the intervention.
Perhaps we can get some pros/cons feedback from other stakeholders ?

Sven
