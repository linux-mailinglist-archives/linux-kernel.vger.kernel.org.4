Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9208D715605
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjE3HBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjE3HB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:01:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232EC124;
        Tue, 30 May 2023 00:01:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso4581583b3a.1;
        Tue, 30 May 2023 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685430068; x=1688022068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fk99nHTowkAbXunn+arnORjVFJFBQPCdSbV/HP1twd0=;
        b=ONNDvfwRP9COQv0o/Xm0STUTeB8ZxKECg32/iQcrxW+4vYJ6h98g2LE8w7hd2axQKq
         sSdkhhDBHXcZRoHtOacusN7cpolE/k55a6WOa5fhDilLT05+NKZnh5S3B94VOqi6Tvjj
         EMXn2kTp0qOASPj2DeG1NgN1ftBYQMMN9qPrqtY1w1ZGm/w0D63H/ENgtZgWtBiN5fsi
         pO7SJrbQfRADrrm3JhWKrLUn0w3HF6piPFQQ7hT9j5fSDvh8twhWI6KkrG8AIqyIrvpa
         hH4/mxd0eLbrLBG6/wcIY797YSZwCiBuo5o/SRgbGnISSYR7+mXN88tOJPG+C3urg2s4
         553w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685430068; x=1688022068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk99nHTowkAbXunn+arnORjVFJFBQPCdSbV/HP1twd0=;
        b=QyUPBqdnAEJ6yIIKluSbgd+q8wpYsAxMdBqgDxJyitACpjWyGrS5XS/hCxkhVZbq3P
         pfzIFfiakCuQMUWhqF9VJWSbnBFFeKnVERChGNyr4k8DQu8CMhMtU1hwT40o2pfHKtK7
         /RwGxT/B63qiBV72U8EA3uruSXWsYVcRLpFjDq4NkFIk9G74SlVx8SOWxKBvbaLCX8/U
         5fcL5i3HgExYfAHBMu2UZVbwqCY8qLA4GoDFD6shN1r217Mh0wMk0bMTDskRi99EoT42
         XCwka6Qr9ZTdjE6pcuGLmVZFmou8ox1f3DXTx2bh3ghLLTC72wNKhCE7wLvArouZoG0z
         U47A==
X-Gm-Message-State: AC+VfDxHfdgDeiuVgPfamzd81nPHHRsOyi0XHUzxQe1tHw7QOEU9WQmp
        eN+9G1vE5sPA8OarRf9dLPI=
X-Google-Smtp-Source: ACHHUZ78bcPmocoq1OEtrrjwh0/JfGXNP4tvnfRBHgXXv27f40VFC7XLVpRFg19GYkG6nCGkuIt3gQ==
X-Received: by 2002:a17:903:2641:b0:1ae:43a8:2759 with SMTP id je1-20020a170903264100b001ae43a82759mr1293172plb.58.1685430068352;
        Tue, 30 May 2023 00:01:08 -0700 (PDT)
Received: from localhost ([2405:6581:d4e0:1600:c494:2aca:bc01:6f7b])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b001a6a53c3b04sm5658487plk.306.2023.05.30.00.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:01:07 -0700 (PDT)
Date:   Tue, 30 May 2023 16:01:04 +0900
From:   Nick Hastings <nicholaschastings@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1036530@bugs.debian.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Message-ID: <ZHWfMBeAONerAJmd@xps>
References: <ZHCYRmD7YeIWoy2W@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps>
 <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com>
 <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
 <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps>
 <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Mario Limonciello <mario.limonciello@amd.com> [230530 13:00]:
> On 5/29/23 18:01, Nick Hastings wrote:
> > Hi,
> > 
> > * Nick Hastings <nicholaschastings@gmail.com> [230529 12:51]:
> > > * Mario Limonciello <mario.limonciello@amd.com> [230529 10:14]:
> > > > On 5/28/23 19:56, Nick Hastings wrote:
> > > > > Hi,
> > > > > 
> > > > > * Mario Limonciello <mario.limonciello@amd.com> [230528 21:44]:
> > > > > > On 5/28/23 01:49, Salvatore Bonaccorso wrote:
> > > > > > > Hi Mario
> > > > > > > 
> > > > > > > Nick Hastings reported in Debian in https://bugs.debian.org/1036530
> > > > > > > lockups from his system after updating from a 6.0 based version to
> > > > > > > 6.1.y. >
> > > > > > > #regzbot ^introduced 24867516f06d
> > > > > > > 
> > > > > > > he bisected the issue and tracked it down to:
> > > > > > > 
> > > > > > > On Sun, May 28, 2023 at 10:14:51AM +0900, Nick Hastings wrote:
> > > > > > > > Control: tags -1 - moreinfo
> > > > > > > > 
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > I repeated the git bisect, and the bad commit seems to be:
> > > > > > > > 
> > > > > > > > (git)-[v6.1-rc1~206^2~4^5~3|bisect] % git bisect bad
> > > > > > > > 24867516f06dabedef3be7eea0ef0846b91538bc is the first bad commit
> > > > > > > > commit 24867516f06dabedef3be7eea0ef0846b91538bc
> > > > > > > > Author: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > Date:   Tue Aug 23 13:51:31 2022 -0500
> > > > > > > > 
> > > > > > > >        ACPI: OSI: Remove Linux-Dell-Video _OSI string
> > > > > > > >        This string was introduced because drivers for NVIDIA hardware
> > > > > > > >        had bugs supporting RTD3 in the past.
> > > > > > > >        Before proprietary NVIDIA driver started to support RTD3, Ubuntu had
> > > > > > > >        had a mechanism for switching PRIME on and off, though it had required
> > > > > > > >        to logout/login to make the library switch happen.
> > > > > > > >        When the PRIME had been off, the mechanism had unloaded the NVIDIA
> > > > > > > >        driver and put the device into D3cold, but the GPU had never come back
> > > > > > > >        to D0 again which is why ODMs used the _OSI to expose an old _DSM
> > > > > > > >        method to switch the power on/off.
> > > > > > > >        That has been fixed by commit 5775b843a619 ("PCI: Restore config space
> > > > > > > >        on runtime resume despite being unbound"). so vendors shouldn't be
> > > > > > > >        using this string to modify ASL any more.
> > > > > > > >        Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > > > >        Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > >        Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > > 
> > > > > > > >     drivers/acpi/osi.c | 9 ---------
> > > > > > > >     1 file changed, 9 deletions(-)
> > > > > > > > 
> > > > > > > > This machine is a Dell with an nvidia chip so it looks like this really
> > > > > > > > could be the commit that that is causing the problems. The description
> > > > > > > > of the commit also seems (to my untrained eye) to be consistent with the
> > > > > > > > error reported on the console when the lockup occurs:
> > > > > > > > 
> > > > > > > > [   58.729863] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> > > > > > > > [   58.729904] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> > > > > > > > [   60.083261] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
> > > > > > > > 
> > > > > > > > Hopefully this is enough information for experts to resolve this.
> > > > > > > 
> > > > > > > Does this ring some bell for you? Do you need any further information
> > > > > > > from Nick?
> > > > > > > 
> > > > > > > Regards,
> > > > > > > Salvatore
> > > > > > 
> > > > > 
> > > > > > Have Nick try using "pcie_port_pm=off" and see if it helps the issue.
> > > > > 
> > > > > I booted into a 6.1 kernel with this option. It has been running without
> > > > > problems for 1.5 hours. Usually I would expect the lockup to have
> > > > > occurred by now.
> > > 
> > > I let this run for 3 hours without issue.
> > > 
> > > > > > Does this happen in the latest 6.4 RC as well?
> > > > > 
> > > > > I have compiled that kernel and will boot into it after running this one
> > > > > with the pcie_port_pm=off for another hour or so.
> > > 
> > > I'm now running 6.4.0-rc4 without seeing the problem after 1 hour.
> > 
> > I did eventually see a lockup of this kernel. On the console I saw:
> > 
> > [  151.035036] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
> > 
> > I did not see the other two lines that were present in earlier lock ups >
> > > I did however see two unrelated problems that I include here for
> > > completeness:
> > > 1. iwlwifi module did not automatically load
> > > 2. Xwayland used huge amount of CPU even though was not running any X
> > > programs. Recompiling my wayland compositor without XWayland support
> > > "fixed" this.
> > > 
> > > > > > I think we need to see a full dmesg and acpidump to better
> > > > > > characterize it.
> > > > > 
> > > > > Please find attached. Let me know if there is anything else I can provide.
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Nick.
> > > > 
> > > > I don't see nouveau loading, are you explicitly preventing it from
> > > > loading?
> > > 
> > > Yes nouveau is blacklisted.
> > > 
> > > > Can I see the journal from a boot when it reproduced?
> > > 
> > > Hmm not sure which n for "journalctl -b n" maps to which kernel (is that
> > > what you are requesting?). The commit hash doesn't not seem to be
> > > listed. I may have to boot into a bad kernel again.
> > 
> > Please find attached the output from a "journalctl --system -bN" for a
> > kernel that has this issue.
> > 
> > Regards,
> > 
> > Nick.
> 
> In this log I see nouveau loaded, but I also don't see the failure
> occurring.

I never saw anything in the logs from a lockup either. I had assumed it
was no longer able to write to disk. The failure did occur on that
occasion.

> As you're actually loading nouveau, can you please try nouveau.runpm=0 on
> the kernel command line?

I'm not intentionally loading it. This machine also has intel graphics
which is what I prefer. Checking my
/etc/modprobe.d/blacklist-nvidia-nouveau.conf
I see:

blacklist nvidia
blacklist nvidia-drm
blacklist nvidia-modeset
blacklist nvidia-uvm
blacklist ipmi_msghandler
blacklist ipmi_devintf

So I thought I had blacklisted it but it seems I did not. Since I do not
want to use it maybe it is better to check if the lock up occurs with
nouveau blacklisted. I will try that now.

> If that helps the issue; I strongly suggest you cross reference the latest
> kernel to see if this bug still exists.

I did. See above.

Regards,

Nick.

