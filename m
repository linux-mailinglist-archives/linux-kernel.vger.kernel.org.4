Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2544272F724
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbjFNH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbjFNH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:59:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E4510E6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:59:12 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A36E3F18B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686729551;
        bh=rH99kLgOd0nw3NlgxGmEp/5xDqohv+MhP0ukWnkRMoc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=VhGWSM4iEQOKyAKdcMkZjQm1w9ifo0wKyfzww06uFbfeOmRrlTpgpp6sZiTu6wHJa
         VxTHrURNkj+o0GcbiRYNbF9r/tEpGHRFvmdh/zTr1mTm1BMvs1uocukn/2exuST8R8
         6Giysewj6SPz2rLSKD0+p5BBnAzb3cCMevmbwVBj9Zhg3bzZJiQft4KPzHfB1oXdO0
         +LnopOU6IxirETZ6N1cFdMDiQG8rDbLd1x2dHQAy5XjxIr13lr3Y92OeT3R1kwnf7H
         Hq1azfvV6TPjo4myrCB9N5P8UM1grfk5JW7HQnpUuS5v34CcGOPJgrTJxEY8dZP9yN
         w4HD8eRQvU3Cw==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-55a1045c2bbso409729eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686729549; x=1689321549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rH99kLgOd0nw3NlgxGmEp/5xDqohv+MhP0ukWnkRMoc=;
        b=VcxGomToDaSGSwQsQyVLJMruj4HHMz0inBTgp9ZeOxwr4N4HtZVj4C+oJCfQ56s9ie
         Q/E/bjU1jPclOr4RKWJC34QSfw5ym/ugU/O2YxSTk79+OzrvVsttzVlWlAWOCmSu1lOS
         9jHt8l9JnTDcigEIXPGzSCd9zcY3misqLZuRGlWDq4JK6M4SywiM0ENp+ewIh3S/Ulwl
         KV5khfhhFn8aJ4LpNfzGmC3JLYwtDliLd9kMW6dnlEbspzlyLnioWlQRiC9SQog7BRHR
         giPwS6alIRDJ/j0WXqBv9u7fS43ZBjJsQl11BniMC+/XhLBOQGceUTT6eGyI7Y/oIBrh
         yFgA==
X-Gm-Message-State: AC+VfDyrYfOzTxO4zvgGlN5ntgUr5RpoVgniO7pnG5EoKH70kqitVgJs
        Mv3rYsHHIDgdIvq2lz/t6uj9g0EqNjapVK9YECloeSVeJFkpKGFLSAOyNO2V/s30StInjQKZA4L
        N0f42Hz2YbPDjfhoa6+aDZtv0NIG3n5Xn5XLLOzlZLJH58118Ox7ZaA1jZYTqpO744Q==
X-Received: by 2002:a05:6808:23d4:b0:398:1151:a42d with SMTP id bq20-20020a05680823d400b003981151a42dmr12046545oib.24.1686729548851;
        Wed, 14 Jun 2023 00:59:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5R4nnffjm0l7juVJYTkx1zHnhw7GCtfI7fPojJw5AQK8hIv6+7u53q6hde9hskOJSsB+oqfPiHr7hOlYCaJu8=
X-Received: by 2002:a05:6808:23d4:b0:398:1151:a42d with SMTP id
 bq20-20020a05680823d400b003981151a42dmr12046532oib.24.1686729548684; Wed, 14
 Jun 2023 00:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230516033133.340936-1-kai.heng.feng@canonical.com>
 <IA1PR11MB61718EFB6DB1BF95CB1CEA5089799@IA1PR11MB6171.namprd11.prod.outlook.com>
 <SJ1PR11MB608384487F94EC485C91F47CFC799@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com>
In-Reply-To: <CAAd53p56=CpWpPEOD2YdCneJX-XxO93MHMQHbLRB7VCYweW7SQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 14 Jun 2023 15:58:56 +0800
Message-ID: <CAAd53p7rpY7uUE-zBQOy3XBmB_JO96qYxkSZr26nZ+qcdT=COA@mail.gmail.com>
Subject: Re: [PATCH] EDAC/Intel: Fix shift-out-of-bounds when DIMM/NVDIMM is absent
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "kao, acelan" <acelan.kao@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 3:49=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Wed, May 17, 2023 at 1:13=E2=80=AFAM Luck, Tony <tony.luck@intel.com> =
wrote:
> >
> > >> [   13.875282] Hardware name: HP HP Z4 G5 Workstation Desktop PC/896=
2,
> > > > BIOS U61 Ver. 01.01.15 04/19/2023
> >
> >
> > >> When a DIMM slot is empty, the read value of mtr can be 0xffffffff, =
therefore
> >
> > > Looked like a buggy BIOS/hw that didn't set the mtr register.
> > >
> > > 1. Did you print the mtr register whose value was 0xffffffff?
> > > 2. Can you take a dmesg log with kernel "CONFIG_EDAC_DEBUG=3Dy" enabl=
ed?
> > > 3. What was the CPU? Please take the output of "lscpu".
> > > 4. Did you verify your patch that the issue was fixed on your systems=
?
> >
> > I wonder if BIOS is "hiding" some devices from the OS? The 0xffffffff r=
eturn is
> > the standard PCI response for reading a non-existent register. But that=
 doesn't
> > quite make sense with having a "dimm present" bit in the MTR register. =
If
> > the register only exists if the DIMM is present, then there is no need =
for
> > a "dimm present" bit.
>
> I wonder if the "non-existent register" read is intended?
>
> >
> > Some "lspci" output may also be useful.
>
> lspci can be found in [1]:
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217453

A gentle ping...

>
> Kai-Heng
>
> >
> > -Tony
