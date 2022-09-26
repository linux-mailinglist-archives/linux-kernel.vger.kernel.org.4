Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C705EA87B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiIZOeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiIZOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:33:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB125E7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:49:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so12278912pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=SyCdAz3/ecUtDFfQmC1TuMy7jcuE/dDqGILRTJaH9kM=;
        b=OT/5lOeQ4YTZyfXlumqodv+v5oQvD8xxX4AUIYiSC2ReE1YVrHF0E8aI0MGhWfQoSJ
         uS+pc0fuPq6MdGBKK7WSqG+zO7KzjNdjAwVr3GHR4/HsQvYlQZ45eMnB4nTigK6d5HGS
         HmrdIID4CRJ7DJJn1/osW6mVWHOQJKtA3/euumGUZaJEWC7WzlweV7OfBDJFeBODgx0L
         P1HjgxWsCi/bLYKQGWWV1ZTJVGZnM9CjMwGIzO47oZT4kV8RM1QZ8Btb8Dm8lOotqfst
         yzQt/12StddSnVJGrcUbzcEYUnphUOkoV2cHmsnN9P75iMiFjvHsdwVulfap5gYaJTDY
         le2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SyCdAz3/ecUtDFfQmC1TuMy7jcuE/dDqGILRTJaH9kM=;
        b=vatJn3dTnhRC5GdQYpAW3KgLoenzCEwwPQjHFOB5Rnj4zykH8yJ1DCg+OdA/etA9IY
         ZS8SH/Lptsjvq45gppbLq/QE433x+EgNtg897MDcP5jAgppWIEYtQunN+/5Hs/UvKCKQ
         +VCxHg25z+ukyZ9K6tP2+/I8+ce4+BuTpyUPx9JGgls0v4QDR0CmFhbSlPKPz5zEjO6b
         v8+OAZCFX50oEnZ652NgROFplq9n6PD53p3TaEqeEq3XGKUkyLlM0+/LP2pJI+fDCN74
         aSM5SpcsrxTmeOavK9i8I/p9xNsvFv+MXJOwnX8D+Zelt/0NFFRMKI/RzeRh7YKXrRbo
         JbHA==
X-Gm-Message-State: ACrzQf1ZA87CMGyAklNvmveBLpsaJJng4EbDZs22pt7ogHG03Zh17d4O
        WR+nhVz8c6BPAQ9yJH88bEs7w1Px5xGuk9MtR0F2ZQ==
X-Google-Smtp-Source: AMsMyM5JCNqXfStgzSPDXC63FbpnxdfzEnUw+dVWS4OWRUC30Gpe5fUaA2MbUAlBgRmskYPYEwTySWBi+D4Y2P/yaRI=
X-Received: by 2002:a17:90a:fd8c:b0:200:8cf9:63f4 with SMTP id
 cx12-20020a17090afd8c00b002008cf963f4mr24332702pjb.201.1664196564264; Mon, 26
 Sep 2022 05:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220916131854.687371-1-jsd@semihalf.com> <20220916131854.687371-2-jsd@semihalf.com>
 <eafc7bb5-a406-132b-4b7d-167917cdab05@amd.com> <CAOtMz3Pgh+cERiXVetDZJrQa9C0kUUbZ9dRRhdghgm5Or8kwhg@mail.gmail.com>
 <YytwNvSyhq380YNT@zn.tnic> <60a52348-7d50-1056-a596-e154f87c99d2@amd.com>
 <Yyt5LSxSz+6QeWF1@zn.tnic> <YywvmueFj/ibyZdf@smile.fi.intel.com>
 <YywwEvkZK1R9mJfE@smile.fi.intel.com> <c0c8bdce-26a0-ad3f-749b-7585d947608b@redhat.com>
 <YyxrdpUyc+kp48kX@zn.tnic> <33d5cc27-474b-fdec-a6b0-84ac16f7d386@redhat.com>
In-Reply-To: <33d5cc27-474b-fdec-a6b0-84ac16f7d386@redhat.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 26 Sep 2022 14:49:12 +0200
Message-ID: <CAOtMz3M=BTZUTRMHWGULwMDWmGdOzHKo=UcZeg3sP8_ndVYk2g@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] i2c: designware: Switch from using MMIO access
 to SMN access
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, wsa@kernel.org,
        rrangel@chromium.org, upstream@semihalf.com,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

czw., 22 wrz 2022 o 16:29 Hans de Goede <hdegoede@redhat.com> napisa=C5=82(=
a):
>
> Hi,
>
> On 9/22/22 16:04, Borislav Petkov wrote:
> > On Thu, Sep 22, 2022 at 03:48:07PM +0200, Hans de Goede wrote:
> >> Right, thank you for Cc-ing me. At least on X86 there are several plat=
forms
> >> (and 100-s of device models) which use a PMIC connected to the i2c-des=
ignware
> >> controller and this PMIC gets poked directly from ACPI _S0 and _S3
> >> (power on/off) methods. So the I2C bus driver needs to *bind* to the c=
ontroller
> >> as soon as we find its description in ACPI, otherwise we get a whole b=
unch
> >> of failed ACPI OpRegion access errors as well as various actual really=
 issues.
> >
> > Thanks for explaining - I couldn't find the reason why it has to be a
> > subsys_initcall.
> >
> >> So please keep this as a subsys initcall.
> >
> > Which means, init_amd_nbs() would have to be sorted to run before
> > dw_i2c_init_driver()...
>
> Yes if possible. One solution might be to make it a arch_initcall_sync()
> which AFAIK runs after regular arch_initcall()-s but before subsys_initca=
ll()-s.

What do you think about this?

Best Regards,
Jan
