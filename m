Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C95681C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjA3VTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjA3VTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:19:17 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593463526F;
        Mon, 30 Jan 2023 13:19:16 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id p10so9541736vsu.5;
        Mon, 30 Jan 2023 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8i8qmt471abNDlIaN1iaD7HI60G2RMUS6KOx2pzMhE=;
        b=Elsa+5UTRqjxhS5P+JqJxs+3LGvxVHldO4hUuw6VRah7gK+PpV0JaHbjdbOTix3PPp
         HE+IwCMwxWTexcQGnwrIK8sSBnWCCXBzcqJJJkuU1SbutMCHdVNRx/pm5nb75CKj38ys
         j3ncfHB5uqECQ1ogWtFQAarHRgpPCzrEtBJSWp2dW3+fH1Yuu9kIBFMMERcRwz/+fNQb
         eD/epoCByHIuZQ+xOdHcNdxFkNSdUaVNamO2NZESO3ngS25z1JRKpTmYxFpLF8RxW27I
         OVA1qrumWckSrXYkgxUOQE3yikBtN4RnwRfcxJ4rgajiW59qhMCugbUz2W0JboCjLBNM
         Kv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8i8qmt471abNDlIaN1iaD7HI60G2RMUS6KOx2pzMhE=;
        b=PnXPHJlApKgp4JBy8iRrltURRoAKvjk1yCDa3t132UNbzLJIQ5fBmi6FO76qi3riX7
         tMerC2qrFmYE9An9fphlpu7MXCOhOHrHpbG6fCZAPgQskCIrTNqOCJxKizH4f1C9ae11
         V9ZhTuOg8sgmuMpx1E5WyLzndt1EQu3JlRBMZFzJGute5Jia4gbShxoFUePot2VOw2qM
         de5fXaPeHXJ1qyM9CeX0VyqztX6J3DEzqxPfY4D/IXqPCgLGueV24aQk0SAQdPX6pL8q
         6D0URzEv8Zk7lysC4y/Fh/fUU/etDE/XhnX66FZqmJSXJ46k5OrFfZ6YyTcpFssqexGI
         UQUg==
X-Gm-Message-State: AO0yUKVM7dySusWCp8G2tbc8Bwas5otCHs6An7Xd7P/3SGPcESKTZt2K
        YEYPirgpFJxCYI8eydOSZ/pkYT5gwMbTwUdf5O7M/FZC
X-Google-Smtp-Source: AK7set+fGCz4Q5zuRM71sqnro0HaxX1F3fdvkHsBIWxqsUpydU6TzQcGGnKNSg6uHw1WdlZv/3r0gntvrkJ2houTgsA=
X-Received: by 2002:a05:6102:738:b0:3f7:588e:b7d7 with SMTP id
 u24-20020a056102073800b003f7588eb7d7mr951165vsg.59.1675113555284; Mon, 30 Jan
 2023 13:19:15 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR18MB28441B6B542B2A59CF39BF6DAFCE9@DM6PR18MB2844.namprd18.prod.outlook.com>
 <DM6PR18MB2844505042F7EDCF69CE08DBAFD39@DM6PR18MB2844.namprd18.prod.outlook.com>
 <63d8292f70918_ea22229465@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <63d8292f70918_ea22229465@dwillia2-xfh.jf.intel.com.notmuch>
From:   Shesha Sreenivasamurthy <sheshas@gmail.com>
Date:   Mon, 30 Jan 2023 13:19:04 -0800
Message-ID: <CABL7MgHU_at16WQ0fwDvJKnBPgcQ7Z7mLqEPex3uN9SY-owEoQ@mail.gmail.com>
Subject: Re: Hot ADD using CXL1.1 host
To:     linux-cxl@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The re-configuration does not reset the device. It does re-program the
PCIe DVSEC for CXL Device register (Section 8.1.3 CXL 2.0 spec Pg
258), register (DVSEC vendor ID 0x1E98, DCSEC ID 0x0).

=E2=80=9CSo you need to dynamically recreate the region, especially if your
step 10 above resets the device.=E2=80=9D

Do you mean the DAX region ? If so, I can if the system stays up.
After a few seconds the system crashes. Can the crash be because of a
mismatch between DVSEC information with what kernel was informed by
BIOS during boot (Some ACPI tables ?)


Thanks,
Shesha.


On Mon, Jan 30, 2023 at 12:51 PM Dan Williams <dan.j.williams@intel.com> wr=
ote:
>
> [ add linux-cxl@vger.kernel.org ]
>
> Hi Shesha, I missed this earlier because it does not appear in my
> "linux-cxl" filter. In general, mail to linux-kernel does not get great
> response from domain-specific experts, so I recommend going to the
> domain specific list like linux-cxl@ in this. Comments below:
>
> Shesha Bhushan Sreenivasamurthy wrote:
> > From: Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
> > Date: Thursday, January 26, 2023 at 6:05 PM
> > To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> > Subject: Hot ADD using CXL1.1 host
> > Hi All,
> >
> > In our setup, the host is a CXL1.1 running fedora 6.1 kernel. This is
> > connected to a Marvell CXL 2.0 Type-3 memory pooling device. The goal
> > for me is to dynamically change the memory configuration without
> > rebooting the host or the memory device.
> >
> > The approach that I am currently taking is to use dax. I configured
> > the memory device to export 8G and the host sees 8G. I am successful
> > to convert the memory from =E2=80=98devdax=E2=80=99 to =E2=80=98system-=
ram=E2=80=99 mode so that
> > general application can use it. At this time, I modify the memory on
> > our memory device to export 16G and host crashes in few mins. The
> > steps I followed are the following
> >
> >
> >   1.  Configure my memory device to export 8G
> >   2.  Boot host. BIOS populates SRAT table with size 8G.
> >   3.  daxctl list --regions --devices -u // Shows 8G
> >   4.  sudo daxctl reconfigure-device --mode=3Dsystem-ram dax0.0 -f
> >   5.  Use memory in my application
>
> Ok up to this point, no interaction with the CXL enabling. This is just
> the default kernel behavior with a BIOS that applies the EFI_MEMORY_SP
> attribute to an address range.
>
> >   6.  ---- RECONFIGURATION PART ----
> >   7.  sudo daxctl offline-memory dax0.0
> >   8.  sudo daxctl destroy-device  dax0.0 -f // All numa node memory map=
pings are gone
> >   9.  sudo sh -c "echo 1 > /sys/bus/pci/devices/0000\:38\:00.0/remove"
>
> Note that this only takes care of the software side, the CXL hardware /
> decoder side is not touched.
>
> >   10. Reconfigure memory device to be 16G
>
> Does this reset the device?
>
> >   11. sudo sh -c "echo 1 > /sys/bus/pci/rescan"
> >      *   CXL DEVSEC (Cap ID 0x23, DVSEC VendorID 0x1E98, DVSEC-ID: 0x0)=
 shows size to be 16G =F0=9F=98=8A
> >   12. daxctl list --regions --devices -u
> >      *   This still shows 8G =E2=98=B9
>
> Yes, because there is currently no hookup between the CXL subsystem and
> device-dax, but I am working on that:
>
> https://lore.kernel.org/linux-cxl/63d21ce66e5c_ea22229446@dwillia2-xfh.jf=
.intel.com.notmuch/
>
> >   13. System crashes
> >
> > There is a mismatch between what DXL is seeing and what PCI DVSEC is
> > saying. Looks like I am missing some step so that old 8G information
> > is removed from the system. Can someone advise ?
>
> So you need to dynamically recreate the region, especially if your step
> 10 above resets the device.
>
> > Now, I can try the following
> >
> >   1.  Power off memory device
> >   2.  Power on and boot my host
> >   3.  Power on memory device
> >   4.  Configure the memory device to have 8G
> >   5.  Follow the above 5-12 commands
> >
> > With this, the question I have is =E2=80=93 will the host recognize the=
 PCI
> > device as CXL device and run cxl.mem protocol or will it just see it
> > as PCIe device ? Note that the host is CXL1.1.
>
> Does your device support the HDM decoder capability? As it stands the
> driver expects to use HDM decoders for region creation rather than CXL
> DVSEC range registers.
>
> My expectation is that once the ram-region creation work is done you
> should be able to do something like:
>
> cxl disable-region $region
> cxl disable-memdev $memdev
> modprobe -r cxl_pci
> <reconfigure device>
> modprobe cxl_pci
> cxl create-region ...
>
> ...and be back up and running with a new region with the update size.
