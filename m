Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFC5FC162
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJLHqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJLHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:46:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2A5AD992
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:46:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so1286932pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sfz6fI+waSDU3ZtEut+m6PQbascjwAqpu4j66Ya8eHY=;
        b=FmTZI5fRZ25dAj+kKYYmqVZuzul44O1FOLNen8ghsx7njavhDh/6vtHcjvdFJaF2VA
         +MGmoQ7HRd3r81mpgA2F1Nv/Z4/0UHZPmCYMsKvfCzg3rGNUBxU9ECaxZObZQxctClNx
         LZkX/rA7xx4KUwtooZfcm970mwgROzcQI1MNmRd8S682lt0u6wRF5+dgUeA5d6i2Cv4+
         aOCXZsdCT8ihzkg2NnLLiqrxFZnuS1OH8IZFy/sZPKwv0KzQccpttE/ImHI5rLzPM5tj
         24EWSdxm4kXWsDLIfJ5i+i9JioSQl4kcr52OTpcZ2Ehn4x7MeEeM8S7bMIGW3sM+qwx2
         Ty4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfz6fI+waSDU3ZtEut+m6PQbascjwAqpu4j66Ya8eHY=;
        b=46NsS1sZXb1u8G7MUGagSLpA3vuMIFHElRgSBDwbNBGRu0kPhse417FOmFNtuU729T
         2n61uzEwXz/VxvzDDiQJRIh94YYFy+Tqaohmxbk7EkcBB9A3EcelVKkcCy07i9Pr7VWl
         6Ek1plLKfbyPk8vSkaQywR/Yvgt52gFka1FkHupUyaZQH8ue0EpELxBCPr/3zEiV6ft6
         Z+SIWx9cCYkn1hEnwUmqAZQfdvx4z/efbmlhF5Zh7pvImyKvV62v3m2Ry3tdAJM36iMN
         9LNfLjk73jK3elR6WAwuvO9TghcOfPVayq+YATLURydfri0S4DwDAsMB2m69aySMnQyA
         KD4A==
X-Gm-Message-State: ACrzQf23XYXfK0sFkBEK5uMjvP4LPT5Xbf+lwd5+Y6hnXQOgF1PFCCck
        fIJvz+GxTAJjbpvANsvUPf4=
X-Google-Smtp-Source: AMsMyM43m8K/vEP4UpOUIVvN0NJ04jMO9OIWrHAjsXMw/VUu8g24yIlB1jma8s9Hh014jqZ/+Y/0uw==
X-Received: by 2002:a17:90b:17ca:b0:20d:76bb:3f8c with SMTP id me10-20020a17090b17ca00b0020d76bb3f8cmr3589595pjb.28.1665560798955;
        Wed, 12 Oct 2022 00:46:38 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b0017e232b6724sm9870912pls.69.2022.10.12.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 00:46:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E523C103ED1; Wed, 12 Oct 2022 14:46:33 +0700 (WIB)
Date:   Wed, 12 Oct 2022 14:46:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Message-ID: <Y0Zw2eHEb1aZ9f4y@debian.me>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U62gqkxvp2W2LZUM"
Content-Disposition: inline
In-Reply-To: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U62gqkxvp2W2LZUM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 07:57:59PM +0200, Mirsad Goran Todorovac wrote:
> Hello all,
>=20
> This is my first kernel BUG report, so please bear with me for a while if
> I'm doing something wrong or otherwise awkward.
> I've noticed it in the 6.0.0-rc3 kernel and following patches to see if it
> will be fixed by other testers.
>=20
> I've read the bug report instructions, so I hope this will be useful.
>=20
> However, now we are at rc7, so keeping it for myself when the kernel is n=
ear
> production state might be an offence to good conscience.
>=20
> In particular, it is the problem with Firefox 104.x and 105.x, which has
> tabs crashing, and later it refuses to restart.
>=20
> Exactly the same config works with the other Linux kernels tried (5.15.x =
and
> 5.19.x) on the Ubuntu 22.04 system.
>=20
> Firefox is a snap. The bug persisted with apparmor ON and OFF.
>=20
> The kernel is compiled with KMEMLEAK and KASAN options, but otherwise it =
is
> the default config file for Ubuntu's rc3 release candidate.
>=20
> Here is the syslog of the startup.
>=20
> Please find dmesg output. It is rather similar to the dmesg output of
> production kernels.
>=20
> /var/log/syslog:
>=20
> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]: message repeated=
 11
> times: [ /snap/firefox/1883/usr/lib/firefox/firefox:
> /snap/firefox/1883/usr/lib/firefox/firefox: no version information availa=
ble
> (required by /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)]
> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]:
> /snap/firefox/1883/usr/lib/firefox/firefox:
> /lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]:
> /snap/firefox/1883/usr/lib/firefox/firefox:
> /lib/x86_64-linux-gnu/librt.so.1: version `' not found (required by
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
> Sep 27 18:43:20 IdeaPad-3 firefox_firefox.desktop[5811]:
> /snap/firefox/1883/usr/lib/firefox/firefox:
> /lib/x86_64-linux-gnu/libdl.so.2: version `' not found (required by
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
> Sep 27 18:43:27 IdeaPad-3 firefox_firefox.desktop[2686]: Missing chrome or
> resource URL: resource://gre/modules/UpdateListener.sys.mjs
> Sep 27 18:43:31 IdeaPad-3 firefox_firefox.desktop[2921]:
> /snap/firefox/1883/usr/lib/firefox/firefox: symbol lookup error:
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so: undefined symbol: ,
> version
> Sep 27 18:43:33 IdeaPad-3 systemd[1791]:
> snap.firefox.firefox.8b8574d2-116e-411a-9bba-c145e8cc0aa2.scope: Consumed
> 10min 18.279s CPU time.
> Sep 27 18:44:49 IdeaPad-3 snapd[818]: storehelpers.go:748: cannot refresh:
> snap has no updates available: "bare", "canonical-livepatch", "core",
> "core18", "core20", "firefox", "gnome-3-34-1804", "gnome-3-38-2004",
> "gtk-common-themes", "slack", "snap-store", "snapd", "zoom-client"
> Sep 27 19:04:59 IdeaPad-3 systemd[1791]: Started
> snap.firefox.firefox.d0067088-10d8-459d-a40d-fed0c95b1481.scope.
> Sep 27 19:05:04 IdeaPad-3 systemd[1791]:
> snap.firefox.firefox.d0067088-10d8-459d-a40d-fed0c95b1481.scope: Consumed
> 4.239s CPU time.
> Sep 27 19:05:41 IdeaPad-3 systemd[1791]: Started
> snap.firefox.firefox.c93d07ee-bee6-492d-aa89-2e27db5d5ae7.scope.
> Sep 27 19:05:42 IdeaPad-3 systemd[1791]:
> snap.firefox.firefox.c93d07ee-bee6-492d-aa89-2e27db5d5ae7.scope: Consumed
> 1.256s CPU time.
> Sep 27 19:06:39 IdeaPad-3 systemd[1791]: Started
> snap.firefox.firefox.b4550475-1ff8-41ee-9a39-305174eeaa44.scope.
> Sep 27 19:06:41 IdeaPad-3 systemd[1791]:
> snap.firefox.firefox.b4550475-1ff8-41ee-9a39-305174eeaa44.scope: Consumed
> 1.231s CPU time.
> Sep 27 19:06:55 IdeaPad-3 systemd[1791]: Started
> snap.firefox.firefox.c42cb676-a7a7-49e6-8685-610bd9c1de81.scope.
>=20
> $ sudo dmesg -l err
> [=C2=A0=C2=A0=C2=A0 1.638759] ACPI BIOS Error (bug): Could not resolve sy=
mbol [\_SB.PCI0],
> AE_NOT_FOUND (20220331/dswload2-162)
> [=C2=A0=C2=A0=C2=A0 1.638854] ACPI Error: AE_NOT_FOUND, During name looku=
p/catalog
> (20220331/psobject-220)
> [=C2=A0=C2=A0=C2=A0 2.175611] ACPI BIOS Error (bug): Could not resolve sy=
mbol
> [\_SB.PC00.DGPV], AE_NOT_FOUND (20220331/psargs-330)
> [=C2=A0=C2=A0=C2=A0 2.175731] ACPI Error: Aborting method \_SB.PC00.PEG0.=
PCRP._ON due to
> previous error (AE_NOT_FOUND) (20220331/psparse-529)
> [=C2=A0=C2=A0=C2=A0 5.519037] integrity: Problem loading X.509 certificat=
e -65
> [=C2=A0=C2=A0 10.010679] mtd device must be supplied (device name is empt=
y)
> [=C2=A0=C2=A0 12.220863] i801_smbus 0000:00:1f.4: Transaction timeout
> [=C2=A0=C2=A0 12.222934] i801_smbus 0000:00:1f.4: Failed terminating the =
transaction
> [=C2=A0=C2=A0 12.223023] i801_smbus 0000:00:1f.4: SMBus is busy, can't us=
e it!
> [=C2=A0=C2=A0 13.092867] rcu: INFO: rcu_preempt detected expedited stalls=
 on
> CPUs/tasks: { 3-.... } 6 jiffies s: 61 root: 0x8/.
> [=C2=A0=C2=A0 13.092878] rcu: blocking rcu_node structures (internal RCU =
debug):
> [=C2=A0=C2=A0 13.991053] mtd device must be supplied (device name is empt=
y)
> [=C2=A0=C2=A0 15.315968] Bluetooth: hci0: Malformed MSFT vendor event: 0x=
02
> [=C2=A0=C2=A0 18.018388] ACPI BIOS Error (bug): Could not resolve symbol =
[\_TZ.ETMD],
> AE_NOT_FOUND (20220331/psargs-330)
> [=C2=A0=C2=A0 18.018857] ACPI Error: Aborting method \_SB.IETM._OSC due t=
o previous
> error (AE_NOT_FOUND) (20220331/psparse-529)
>=20
> Please find attached the config file for the kernel build. Source is rc7
> "master" clean after rc7 rlse.
>=20
> Here is the demonstration of bug with apparmor ON and OFF:
>=20
> $ sudo systemctl stop apparmor
> $ firefox &
> [1] 7825
> $ date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: symbol lookup error: date: undefined symbol: , version GLIBC_2.2.5
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: symbol lookup error: chmod: undefined symbol: , version
> xdg-user-dirs-update: error while loading shared libraries:
> xdg-user-dirs-update: unsupported version 0 of Verneed record
> rm: rm: no version information available (required by rm)
> rm: rm: no version information available (required by rm)
> rm: rm: no version information available (required by rm)
> rm: rm: no version information available (required by rm)
> rm: rm: no version information available (required by rm)
> rm: symbol lookup error: rm: undefined symbol: , version GLIBC_2.2.5
> XPCOMGlueLoad error for file
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so:
> /lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
> Couldn't load XPCOM.
>=20
> [1]+=C2=A0 Exit 255=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firefox
> $
> $ sudo systemctl start apparmor
> $ firefox &
> [1] 7996
> $ date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: date: no version information available (required by date)
> date: symbol lookup error: date: undefined symbol: , version GLIBC_2.2.5
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: chmod: no version information available (required by chmod)
> chmod: symbol lookup error: chmod: undefined symbol: , version
> xdg-user-dirs-update: error while loading shared libraries:
> xdg-user-dirs-update: unsupported version 0 of Verneed record
> XPCOMGlueLoad error for file
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so:
> /lib/x86_64-linux-gnu/libpthread.so.0: version `' not found (required by
> /snap/firefox/1883/usr/lib/firefox/libmozsandbox.so)
> Couldn't load XPCOM.
>=20
> All other apps work OK AFAICS, however I suspected a kernel bug since it
> only shows only in RC kernels
> (even the Ubuntu's own 6.0.0-rc3 mainline build).
>=20
> Hope this helps someone. I could provide more info at request.
>=20
> Kind regards,
>=20
> Mirsad
>=20

Hi Mirsad,

The bug doesn't appear on 6.0 mainline release. However, in my case,
Firefox is downloaded and installed from official Mozilla binary [1].

Also, many developers here want to see bisection result. In order to
shorten kernel build time (and thus time needed for bisection),
you can strip out unneeded modules in your kernel configuration with
"make localmodconfig". Ensure that all devices on your computer is
plugged in before running that. And as other people pointed, base
your localmodconfig from last working kernel.

In any case, please reproduce with Firefox from [1].

Thanks.

[1]: https://www.mozilla.org/en-US/firefox/

--=20
An old man doll... just what I always wanted! - Clara

--U62gqkxvp2W2LZUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0Zw1AAKCRD2uYlJVVFO
o1BnAP9WKzrij0HFFdp3n3t1wiFW6854tI+Yd9sq10w77K73kgD/RCg4iWykmu4+
5y2Kgs6iwoH2k4rw6+bhdbBJ7FBlXAY=
=D8xB
-----END PGP SIGNATURE-----

--U62gqkxvp2W2LZUM--
