Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A210F6E4769
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDQMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjDQMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:18:59 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F15BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:18:57 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D5563F22C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681732223;
        bh=6GYDRTm5i091Nsg8Us5E8SdBSSCh6NzIhoebfwUefD0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IgahMDmI2v/POHGj/X7gKk2fgviknFjsr8RSLsNooxNNiteND1O8zFY4wH/E1/jUB
         CX0sSrAtgeH0+ik6GB0OOh7fVyXajxjNxuz5+FcUn4J/sD9Sym7q1MVzEli7Kj8JuA
         6LupZE4KoJPcYufC+T9d6rgnkbycOEHytZn3mbS/Kh4TThmWAkGeZmuHxVBlwMtcpU
         OBipkC6SlRTmHquxE99vR8myA5yVdlYeP0ZUnuE08o/TwCV3mtj0eNNaDpQrKQK1bS
         0sXRoREMQyLyp4QGcAnj7xvdP/lJBuIwyiVX/dc5CsWJaV8NxQolyNdqv1yXX8LM/8
         QC3zBal444PKQ==
Received: by mail-pj1-f70.google.com with SMTP id n14-20020a17090aab8e00b002470e26aa0cso3269272pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732221; x=1684324221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GYDRTm5i091Nsg8Us5E8SdBSSCh6NzIhoebfwUefD0=;
        b=cxflpyog8MwSVAlrxaG1HwG1W0/Lf43QGhbcinyUuXfswbz2xhhOSp3SwJBtGI4azY
         DkqYrtKxLYo3PMtlpgwG1+8PEIqZH6l5YRQAusOffnHqODbaCmmn1uhkVNXZg8qXwU+b
         eKdpuJKR5hFe50cZMLTO9ZaZzjMs5LnSIHU2V7h1T03jpkGMaUaUa/OK0SXoW8z9GuTT
         lsuKAiiWIqWPO4UenfN8uiAgpzPAWdTFsMTmN5NT3tncqxTPdo9kOAds8OB4+anHROJw
         1qk0gAxA1avcH6HvL21BRH5vnzL24r+EZHtkS44C3U1DnpAm9U+aoYXiLK/KWvHK18iR
         xPUQ==
X-Gm-Message-State: AAQBX9cpzk90pWWfclBcm8KItKQS2Q+Xs81RTRCx0y/BzOYffC9rflAr
        GeGN4U3bvOnLGNGRk4aMQ8HeJAfmBP4G24C5DunFU+8gjzgVwccd7to+UZwqw4J0Lo/FxkxRtnw
        YUQOdMF4ceXBZyGX3fWRfmlHlNvXLSuml3CNv8/pvSwGTz2MTpS6tq1k0mw==
X-Received: by 2002:a17:90a:b00e:b0:247:2437:d5c4 with SMTP id x14-20020a17090ab00e00b002472437d5c4mr13489421pjq.13.1681732221391;
        Mon, 17 Apr 2023 04:50:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bMHUJJluXpbTYJTU5g2d4iXGCmYsFbXGYmNAIPXStId8I4XBXBOXkL9aEbLgiYT/vEGd3M3KO/cmCBEgLV28M=
X-Received: by 2002:a17:90a:b00e:b0:247:2437:d5c4 with SMTP id
 x14-20020a17090ab00e00b002472437d5c4mr13489409pjq.13.1681732221055; Mon, 17
 Apr 2023 04:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220727013255.269815-2-kai.heng.feng@canonical.com> <20220928214557.GA1840266@bhelgaas>
In-Reply-To: <20220928214557.GA1840266@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Apr 2023 19:50:09 +0800
Message-ID: <CAAd53p7LFXSmBfLoz3i1C16x1oSJf99pVPuxTbj+tvxuKcNmPA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI/AER: Disable AER service on suspend when IRQ is
 shared with PME
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, koba.ko@canonical.com,
        "Oliver O'Halloran" <oohall@gmail.com>,
        mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 5:46=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Jul 27, 2022 at 09:32:51AM +0800, Kai-Heng Feng wrote:
> > PCIe service that shares IRQ with PME may cause spurious wakeup on
> > system suspend.
> >
> > PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> > that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> > (D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
> > much here to disable AER during system suspend.
> >
> > This is very similar to previous attempts to suspend AER and DPC [1],
> > but with a different reason.
> >
> > [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.=
feng@canonical.com/
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/aer.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 7952e5efd6cf3..60cc373754af2 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1372,6 +1372,26 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +
> > +     if (dev->shared_pme_irq)
> > +             aer_disable_rootport(rpc);
>
> aer_disable_rootport() seems like it might be overkill.  IIUC, what
> we want to do here is disable AER interrupts, which should only
> require clearing ROOT_PORT_INTR_ON_MESG_MASK in PCI_ERR_ROOT_COMMAND.
>
> In addition to clearing ROOT_PORT_INTR_ON_MESG_MASK,
> aer_disable_rootport() traverses the whole hierarchy, clearing
> PCI_EXP_AER_FLAGS (CERE | NFERE | FERE | URRE) in PCI_EXP_DEVCTL.
> I don't think these DEVCTL bits control interrupt generation, so I
> don't know why we need to touch them.
>
> aer_disable_rootport() also clears PCI_ERR_ROOT_STATUS, which I think
> we should not do during suspend either.  We might want to clear it
> on resume (which we already do in pci_restore_state()), but I think
> generally we should preserve error information as long as it doesn't
> cause trouble.
>
> Your thoughts please :)

Sorry for the belated response.

Clearing ROOT_PORT_INTR_ON_MESG_MASK along to disable interrupt can
solve the issue too.
And I agree that the AER information should be preserved too.

Kai-Heng

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +
> > +     if (dev->shared_pme_irq)
> > +             aer_enable_rootport(rpc);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1441,8 +1461,9 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .name           =3D "aer",
> >       .port_type      =3D PCIE_ANY_PORT,
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> > -
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
> > --
> > 2.36.1
> >
