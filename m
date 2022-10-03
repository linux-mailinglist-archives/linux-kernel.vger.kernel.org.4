Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C515F28DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJCG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJCG7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:59:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5665AA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 23:59:46 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 825B13F337
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664780382;
        bh=UHiuVEKc94OUJVqIYBM7NGy3SMjIJiq4PorrDzTuUAM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QWwL9mF/BDTGeh3ElZLUaDY0e1YiRDSFnnqkIr0V0eV3kAzajh3Y4ODJFkjer2P3M
         aCNB4X9b5w4YC5EBCT2Lw/Yoc7RGXcmpsKs0/dtAKQO66T9nOK4dKQnVwcODpdkAhi
         CRQaVoF4wjCyKsFGA94hZT85vV0j+SJYQ6A+7C22ogM+B+Az/pJneUgdcCV2YgwF3B
         GI+BagCPYO4dKBNepY7VvtxIyEks2vt4xItlu2xbvmgNqvfryo2GpmzFfv+b0rU+wI
         QGoc0NGdU+IMcoPU3xW7tbcTlFiKzeS1W3r7XfK/eWC3BvfB/P7pgRMOHu+oNQS8RO
         rwsTMNT6Cqtkg==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-13193fb45b9so6525612fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 23:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UHiuVEKc94OUJVqIYBM7NGy3SMjIJiq4PorrDzTuUAM=;
        b=auLYY2kvfnHMxk0VdLE2GwBwItAeDq04188g44hpmjUcPypLf58EFfrDdbw37jqd78
         OpitalmL+kHcu5Rk/F5wYCi5rdfXs1n1Powj4Pyo41FYt4SuaVtPbVoWM70cJAIV4+JZ
         CIvY92Rj7j3wAeqpePMumxEULExN3OETAAPZPZr1uP/kbW1IGO7FaFcJw4k6DJD6Gqb7
         n8drJltzJNo5C/j6ATKPPDt+KqIOYbfAVP/gngoptpKyYC1H0rrFSDtVCeaPUBlMT4Vf
         ta7Aw0v6K3iF7GAMmZqtEo2N9pfhyysOqRiqhn7rKermnKL1rOdVSyV42+kqjMwHP/E+
         dLpg==
X-Gm-Message-State: ACrzQf13XZXX2CcdSyySuFLU3QZHtUaovbbFPG1En2L8PTzNa1HsxpN2
        iR/g4m8VMV5SvIUgG8Ner/AhHbKb9b/FyvU0OexkOh53yuX8bsDIIs+kXCDUiNhV1cmQU0SBmhY
        vVFDUjXcQn5GLJ3RE/4+hHwsRG533RzfGZKBc0nEwRIvgErKd21xUTUo9wg==
X-Received: by 2002:aca:180b:0:b0:352:8bda:c428 with SMTP id h11-20020aca180b000000b003528bdac428mr3470637oih.13.1664780381371;
        Sun, 02 Oct 2022 23:59:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4zdCtBQ3UdibMD6yNa4by2Yri2tdCrhDWrQ1u1+t1VIRLpocsG5334oeh4l0FV+NxHnTdijt2a8h5owzuT180=
X-Received: by 2002:aca:180b:0:b0:352:8bda:c428 with SMTP id
 h11-20020aca180b000000b003528bdac428mr3470629oih.13.1664780381066; Sun, 02
 Oct 2022 23:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220930091050.193096-1-chris.chiu@canonical.com> <20220930151817.GA1973184@bhelgaas>
In-Reply-To: <20220930151817.GA1973184@bhelgaas>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 3 Oct 2022 14:59:30 +0800
Message-ID: <CABTNMG0SbnYc1LkPnrNLB-MTVyEkutO0vwW+8GhuHaQOw__Zxw@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Make SUNIX serial card acceptable latency unlimited
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Sep 30, 2022 at 05:10:50PM +0800, Chris Chiu wrote:
> > SUNIX serial card advertise L1 acceptable L0S exit latency to be
> > < 2us, L1 < 32us, but the link capability shows they're unlimited.
> >
> > It fails the latency check and prohibits the ASPM L1 from being
> > enabled. The L1 acceptable latency quirk fixes the issue.
>
> Hi Chris, help me understand what's going on here.
>
> The "Endpoint L1 Acceptable Latency" field in Device Capabilities is
> described like this (PCIe r6.0, sec 7.5.3.3):
>
>   This field indicates the acceptable latency that an Endpoint can
>   withstand due to the transition from L1 state to the L0 state. It is
>   essentially an indirect measure of the Endpoint=E2=80=99s internal
>   buffering.
>
>   Power management software uses the reported L1 Acceptable Latency
>   number to compare against the L1 Exit Latencies reported (see below)
>   by all components comprising the data path from this Endpoint to the
>   Root Complex Root Port to determine whether ASPM L1 entry can be
>   used with no loss of performance.
>
> The "L1 Exit Latency" in Link Capabilities:
>
>   This field indicates the L1 Exit Latency for the given PCI Express
>   Link. The value reported indicates the length of time this Port
>   requires to complete transition from ASPM L1 to L0.
>
> Apparently the SUNIX device advertises in Dev Cap that it can tolerate
> a maximum of 32us of L1 Exit Latency for the entire path from the
> SUNIX device to the Root Port, and in Link Cap that the SUNIX device
> itself may take more than 64us to exit L1.
>
> If that's accurate, then we should not enable L1 for that device
> because using L1 may cause buffer overflows, e.g., dropped characters.
>
> Per 03038d84ace7 ("PCI/ASPM: Make Intel DG2 L1 acceptable latency
> unlimited"), the existing users of aspm_l1_acceptable_latency() are
> graphics devices where I assume there would be little data coming from
> the device and buffering would not be an issue.
>
> It doesn't seem plausible to me that a serial device, where there is a
> continuous stream of incoming data, could tolerate an *unlimited* exit
> latency.
>
> I could certainly believe that Link Cap advertises "> 64us" of L1 Exit
> Latency when it really should advertise "< 32us" or something.  But I
> don't know how we could be confident in the correct value without
> knowledge of the device design.
>
> Bjorn

Hi Bjorn,
    Thanks for the clear explanation. I understand your concern and
I'll try to reach the vendor for their comment about the device
design. But the value "unlimited" for L1 exit latency with specified
L1 acceptable latency on a self-claimed "ASPM L1" capable device
really looks weird to me, I'd rather assume the 32us limit in DevCap
is actually for LinkCap (L1 exit latency), and the acceptable latency
is actually unlimited.

    I'll try to ask SUNIX if they intentionally program the latency
this way and expect the device is unlikely to enter ASPM L1. Or they
just accidentally program it with the incorrect value. Will keep
updating here. Thanks

Chris

>
> > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > ---
> >  drivers/pci/quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4944798e75b5..e1663e43846e 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5955,4 +5955,5 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x5=
6b0, aspm_l1_acceptable_latency
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptab=
le_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptab=
le_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptab=
le_latency);
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999=
, aspm_l1_acceptable_latency);
> >  #endif
> > --
> > 2.25.1
> >
