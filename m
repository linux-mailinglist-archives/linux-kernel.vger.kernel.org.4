Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8B715D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjE3LXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjE3LW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:22:59 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493AFD9;
        Tue, 30 May 2023 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EIqbr3ImWSf/0upwjLftoyo2ik4nrN7ZVxzp8AE4Lws=; b=S5hrlOkuY9bcl8i37p7KIhzcvy
        RgbGCGFuq1fhNMWlzgWeAV1OlGAdLcOf5V5kdtGWvFXxpRsf3s2bjuGiJbuOiEYQS5jW5rOj+fVRZ
        4TMnsXkxapqoc1zHd3/hbptFJ0uBz0A2kygPZT6sWimts93IBRBmD3nSKLfroXRRMvwGfvNb6GYp5
        D/ojL14qar2bXOkrjrqpadgZAXQUj99rLoyH6Cr3D3dnFNTpALfkPELfc9/lokjm+Vz+63PcjAyyR
        yIUSe+8+O3ad+AXTuXkDDE9RYQQx+Sbx0S13eSVIznlihEHAu5WG3BoEsYam+OJfmO6shNC93vu3v
        Xqq6PO7A==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <carnil@debian.org>)
        id 1q3xR3-00Eoj8-Rh; Tue, 30 May 2023 11:22:42 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
        id 90673BE2DE0; Tue, 30 May 2023 13:22:40 +0200 (CEST)
Date:   Tue, 30 May 2023 13:22:40 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Nick Hastings <nicholaschastings@gmail.com>,
        1036530@bugs.debian.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Bug#1036530: Regression from "ACPI: OSI: Remove Linux-Dell-Video
 _OSI string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of
 system)
Message-ID: <ZHXcgPC+7u04RuGD@eldamar.lan>
References: <ZHKrC4/G6ZyvRReI@xps>
 <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com>
 <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
 <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps>
 <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHWfMBeAONerAJmd@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHWfMBeAONerAJmd@xps>
X-Debian-User: carnil
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Thanks to you both for triaging the issue!

On Tue, May 30, 2023 at 04:01:04PM +0900, Nick Hastings wrote:
> Hi,
> 
> * Mario Limonciello <mario.limonciello@amd.com> [230530 13:00]:
> > On 5/29/23 18:01, Nick Hastings wrote:
> > > Hi,
> > > 
> > > * Nick Hastings <nicholaschastings@gmail.com> [230529 12:51]:
> > > > * Mario Limonciello <mario.limonciello@amd.com> [230529 10:14]:
> > > > > On 5/28/23 19:56, Nick Hastings wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > * Mario Limonciello <mario.limonciello@amd.com> [230528 21:44]:
> > > > > > > On 5/28/23 01:49, Salvatore Bonaccorso wrote:
> > > > > > > > Hi Mario
> > > > > > > > 
> > > > > > > > Nick Hastings reported in Debian in https://bugs.debian.org/1036530
> > > > > > > > lockups from his system after updating from a 6.0 based version to
> > > > > > > > 6.1.y. >
> > > > > > > > #regzbot ^introduced 24867516f06d
> > > > > > > > 
> > > > > > > > he bisected the issue and tracked it down to:
> > > > > > > > 
> > > > > > > > On Sun, May 28, 2023 at 10:14:51AM +0900, Nick Hastings wrote:
> > > > > > > > > Control: tags -1 - moreinfo
> > > > > > > > > 
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > I repeated the git bisect, and the bad commit seems to be:
> > > > > > > > > 
> > > > > > > > > (git)-[v6.1-rc1~206^2~4^5~3|bisect] % git bisect bad
> > > > > > > > > 24867516f06dabedef3be7eea0ef0846b91538bc is the first bad commit
> > > > > > > > > commit 24867516f06dabedef3be7eea0ef0846b91538bc
> > > > > > > > > Author: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > Date:   Tue Aug 23 13:51:31 2022 -0500
> > > > > > > > > 
> > > > > > > > >        ACPI: OSI: Remove Linux-Dell-Video _OSI string
> > > > > > > > >        This string was introduced because drivers for NVIDIA hardware
> > > > > > > > >        had bugs supporting RTD3 in the past.
> > > > > > > > >        Before proprietary NVIDIA driver started to support RTD3, Ubuntu had
> > > > > > > > >        had a mechanism for switching PRIME on and off, though it had required
> > > > > > > > >        to logout/login to make the library switch happen.
> > > > > > > > >        When the PRIME had been off, the mechanism had unloaded the NVIDIA
> > > > > > > > >        driver and put the device into D3cold, but the GPU had never come back
> > > > > > > > >        to D0 again which is why ODMs used the _OSI to expose an old _DSM
> > > > > > > > >        method to switch the power on/off.
> > > > > > > > >        That has been fixed by commit 5775b843a619 ("PCI: Restore config space
> > > > > > > > >        on runtime resume despite being unbound"). so vendors shouldn't be
> > > > > > > > >        using this string to modify ASL any more.
> > > > > > > > >        Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > > > > > >        Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > >        Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > > > 
> > > > > > > > >     drivers/acpi/osi.c | 9 ---------
> > > > > > > > >     1 file changed, 9 deletions(-)
> > > > > > > > > 
> > > > > > > > > This machine is a Dell with an nvidia chip so it looks like this really
> > > > > > > > > could be the commit that that is causing the problems. The description
> > > > > > > > > of the commit also seems (to my untrained eye) to be consistent with the
> > > > > > > > > error reported on the console when the lockup occurs:
> > > > > > > > > 
> > > > > > > > > [   58.729863] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> > > > > > > > > [   58.729904] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
> > > > > > > > > [   60.083261] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
> > > > > > > > > 
> > > > > > > > > Hopefully this is enough information for experts to resolve this.
> > > > > > > > 
> > > > > > > > Does this ring some bell for you? Do you need any further information
> > > > > > > > from Nick?
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > > Salvatore
> > > > > > > 
> > > > > > 
> > > > > > > Have Nick try using "pcie_port_pm=off" and see if it helps the issue.
> > > > > > 
> > > > > > I booted into a 6.1 kernel with this option. It has been running without
> > > > > > problems for 1.5 hours. Usually I would expect the lockup to have
> > > > > > occurred by now.
> > > > 
> > > > I let this run for 3 hours without issue.
> > > > 
> > > > > > > Does this happen in the latest 6.4 RC as well?
> > > > > > 
> > > > > > I have compiled that kernel and will boot into it after running this one
> > > > > > with the pcie_port_pm=off for another hour or so.
> > > > 
> > > > I'm now running 6.4.0-rc4 without seeing the problem after 1 hour.
> > > 
> > > I did eventually see a lockup of this kernel. On the console I saw:
> > > 
> > > [  151.035036] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
> > > 
> > > I did not see the other two lines that were present in earlier lock ups >
> > > > I did however see two unrelated problems that I include here for
> > > > completeness:
> > > > 1. iwlwifi module did not automatically load
> > > > 2. Xwayland used huge amount of CPU even though was not running any X
> > > > programs. Recompiling my wayland compositor without XWayland support
> > > > "fixed" this.
> > > > 
> > > > > > > I think we need to see a full dmesg and acpidump to better
> > > > > > > characterize it.
> > > > > > 
> > > > > > Please find attached. Let me know if there is anything else I can provide.
> > > > > > 
> > > > > > Regards,
> > > > > > 
> > > > > > Nick.
> > > > > 
> > > > > I don't see nouveau loading, are you explicitly preventing it from
> > > > > loading?
> > > > 
> > > > Yes nouveau is blacklisted.
> > > > 
> > > > > Can I see the journal from a boot when it reproduced?
> > > > 
> > > > Hmm not sure which n for "journalctl -b n" maps to which kernel (is that
> > > > what you are requesting?). The commit hash doesn't not seem to be
> > > > listed. I may have to boot into a bad kernel again.
> > > 
> > > Please find attached the output from a "journalctl --system -bN" for a
> > > kernel that has this issue.
> > > 
> > > Regards,
> > > 
> > > Nick.
> > 
> > In this log I see nouveau loaded, but I also don't see the failure
> > occurring.
> 
> I never saw anything in the logs from a lockup either. I had assumed it
> was no longer able to write to disk. The failure did occur on that
> occasion.

Can you try if you would get more out of it using netconsole?

https://www.kernel.org/doc/html/latest/networking/netconsole.html

Regards,
Salvatore
