Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09265C52A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjACRhh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Jan 2023 12:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjACRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:37:33 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D5BF5BE;
        Tue,  3 Jan 2023 09:37:32 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id j16so25084990qtv.4;
        Tue, 03 Jan 2023 09:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snuAeqrKkcnHwzA0AdwomJTJESrNdqyAgQMbGE4/gOc=;
        b=MLUjX1CWSzh4vyozDvmrLM4VP+jeJo2+HeRWzjfV0QJ3kwCvgXnjhWaDsSao599+0K
         pD0f8JOssP20mC+PFP19X4iZHMm8FpbOhMLCLpmxUT2U/3VFAmSndNziAeo3Lt/aMpqD
         xSVdqYMEvIj8YDR5qi1C9si/XlhCmhl3iidKZJM9W+w2dkWT67i6L7PbCdO7hJWOKr/0
         E+ltpopd7GtecCTGVCMo9gwO3bHYDG88+qMzszcbAUC7n009n02CodjKEAzqSpUeFPeZ
         wvsrDQAHmLrSobNrn7W7Xf0xEfjUXAHgY05ASUQk8Mj/vIj7ZEvJzJzBTE/yftxcC3b3
         MCFw==
X-Gm-Message-State: AFqh2kp5Mu3u/70jJ+O7rPWH6l3+WL4nMVUe5un77Z+rSvuWdqo240rZ
        XCmrtZtGdhK1cittyEOOlBlO4jdBWhemBQ==
X-Google-Smtp-Source: AMrXdXtF/8CnV4F3JJN74R9WYXmBw6ZL3IcfMW+KDzrZMKi8hcUNzEoLXE0D+29P4fsCUtH0t5Ra1g==
X-Received: by 2002:a05:622a:1f14:b0:3a5:43af:d7ac with SMTP id ca20-20020a05622a1f1400b003a543afd7acmr67432419qtb.67.1672767451412;
        Tue, 03 Jan 2023 09:37:31 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id g8-20020ac81248000000b003a69de747c9sm18952564qtj.19.2023.01.03.09.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 09:37:30 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-482363a1232so291457427b3.3;
        Tue, 03 Jan 2023 09:37:30 -0800 (PST)
X-Received: by 2002:a81:ae0e:0:b0:388:941:23a8 with SMTP id
 m14-20020a81ae0e000000b00388094123a8mr5281814ywh.152.1672767450539; Tue, 03
 Jan 2023 09:37:30 -0800 (PST)
MIME-Version: 1.0
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info> <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
In-Reply-To: <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
From:   Dave Chiluk <chiluk@ubuntu.com>
Date:   Tue, 3 Jan 2023 11:37:19 -0600
X-Gmail-Original-Message-ID: <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com>
Message-ID: <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
Cc:     "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 5:33 AM Coelho, Luciano <luciano.coelho@intel.com> wrote:
>
> On Thu, 2022-12-01 at 11:14 +0100, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker.
> >
> > Luca, I noticed a regression report in bugzilla where I'd like your
> > advice on. To quote https://bugzilla.kernel.org/show_bug.cgi?id=216753
>
> Hi Thorsten wearing-the-regression-hat, 🙂
>
> I'm not the maintainer of iwlwifi anymore, so I'm adding the new
> maintainer here, Gregory Greenman.
>
> Gregory, can you take a look?
>

@Gregory Greenman as I'm sure this got buried over the holidays, can
you take a look at this and advise?  This is definitely a regression,
but I don't think a lot of people are noticing it or don't yet have
6ghz access points.  I can write up a patch removing the offending
commit (698b166ed), or I can add an iwlwifi option to ignore the 6e
ACPI bit.  Which would you prefer?

Dell has been of little help which I pretty much expected.

@Luciano, as you were the author of the original change, and I'm not
familiar enough with ACPI, is the below code reading the enable bits
from the BIOS ACPI table or is this somehow coming out of the network
card through some UEFI extensions?  I'm trying to figure out which of
Dell or Intel need to update their firmware?  I think some Lenovo's
have similar problems, so I suspect it's a BIOS ACPI table problem.

 ret = iwl_acpi_get_dsm_u32(mvm->fwrt.dev, 0,
                                   DSM_FUNC_ENABLE_6E,
                                   &iwl_guid, &value);

Thanks,
Dave.
