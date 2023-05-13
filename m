Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97A70187D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjEMRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjEMRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:35:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA42D7F;
        Sat, 13 May 2023 10:35:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f423ac6e2dso52476775e9.2;
        Sat, 13 May 2023 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683999352; x=1686591352;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BLOUqfjXCsAtbM5DsveuSFhUHFLrfF63jU+miLmBZbs=;
        b=YLyJj8pQxWkWmiJ0hLax7XJSu6Mv5QHDpPxIrCrWFKaS0wbKNONaH4NY1I+bfr+DxH
         weiK7Ejfsoew+UMMEUHIdhynU1iQe8a1j2e6dEcoKWGTHXNC4aK05yZkVoRezOFZg56c
         VJYol0JmUFRKQ2UsEYKwh6xaunYsCcm71NHevRIuslJ9aC1aTMbEU9dRBRH4/Apu18TX
         22gbUR18w42P8sE/BLZhEAFD2YK5zSv2hbG23QEfv3h47J/54B0ERl1iojEZgYS7QgGc
         5zmZ3SgGK4IGVUR3KTfLCdZUa+cBZH9Gbohw8zmF7TMrOKjkFsKFr54HPP1rUZCzz3Ug
         aM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999352; x=1686591352;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLOUqfjXCsAtbM5DsveuSFhUHFLrfF63jU+miLmBZbs=;
        b=XTmRIAOZTmEigNugj/SSJwBhhXvAi4B6tAVkgaL3P8GzYQQbAjIDOO5HtMK54ulrNn
         wHZpqYsNY9orsx+SZ8iuiBylZWtQLOBKXVjNhUdBK3ONQT4hYVrAI7yTFau384QT6kg7
         Ly4npBj4qOnGhmePsjs8SC+wANJA34u9OQGQ0DxrcZzYTmAhH6caS8xBf+vjpvzv1b2R
         P8JsrKjY/n9Jrc20Le5/g/cycPXCBXk3eg2149bpwkCB0ULpKIYwdib1zlJH310QHZ75
         tKMjavfTBnoB0P0gRGknEfOt5cDUVG1pf7FCHTt2dX8Rtkm9w4YjtHaYUmLmsrHKF0Ja
         zZXg==
X-Gm-Message-State: AC+VfDzXTKOzoAuNSS0cqDzD9DNg5Mm6btc2wvzfwgmUBWH04lSetYrH
        8FEfJ9OaB6WkAfmvixG4Yng=
X-Google-Smtp-Source: ACHHUZ6SZW4y6haBJKsEhfa2Gl/pz2bfQldaiVnrwvRp/HOhQrhB6j0Zr8pJ2dBbnR46f4fVrU8I9A==
X-Received: by 2002:a7b:c318:0:b0:3f0:a08e:811b with SMTP id k24-20020a7bc318000000b003f0a08e811bmr20276287wmj.13.1683999351927;
        Sat, 13 May 2023 10:35:51 -0700 (PDT)
Received: from [192.168.8.84] (213-225-15-168.nat.highway.a1.net. [213.225.15.168])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b003f1978bbcd6sm21092199wms.3.2023.05.13.10.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 10:35:51 -0700 (PDT)
Message-ID: <0688b1a52258ad1bee88facf4cbe72f46430108c.camel@gmail.com>
Subject: Re: [REGRESSION] wifi: brcmfmac: add firmware vendor info in driver
 info
From:   Nimrod MacIomhair <nimrod4garoa@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        regressions@lists.linux.dev,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Date:   Sat, 13 May 2023 19:35:49 +0200
In-Reply-To: <3c195b2430668788f993df7872b21e52f4450ef0.camel@gmail.com>
References: <4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com>
         <c7aa9034-59f8-11aa-7170-86c0db012dda@redhat.com>
         <87bkiso0aw.fsf@kernel.org>
         <3c195b2430668788f993df7872b21e52f4450ef0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2023-05-10 at 14:53 +0200, Felix wrote:
> On Wed, 2023-05-10 at 15:09 +0300, Kalle Valo wrote:
> > Hans de Goede <hdegoede@redhat.com> writes:
> >=20
> > > On 5/10/23 10:25, Felix wrote:
> > > > Changes made by the mentioned commit lead to Oops when waking up af=
ter
> > > > suspend to RAM.
> > > >=20
> > > > When waking up a Dell XPS 13 9350 with BCM4350 wifi card after susp=
end
> > > > to RAM,=C2=A0the kernel hangs with a NULL pointer dereference and O=
ops. The
> > > > issues was introduced by commit
> > > > da6d9c8ecd00e20218461007948f2b0a8e7fa242 and only happens when the
> > > > brcmfmac module is loaded. This issue is the reason we could not
> > > > upgrade to newer kernels than the 6.1 series on the affected machin=
e.
> > > >=20
> > > >=20
> > > > Details:
> > > >=20
> > > > On a Dell XPS 13 9350 laptop with Broadcom BCM4350 wifi card (accor=
ding
> > > > to lspci), every kernel starting with 6.2 hangs when waking up afte=
r
> > > > suspend to RAM. The issue persisted as of May 2nd (last tested comm=
it
> > > > was 348551ddaf311c76b01cdcbaf61b6fef06a49144). Passing the debug an=
d
> > > > no_console_suspend parameters to the kernel show that a NULL pointe=
r
> > > > dereference and an Oops happen at wakeup. Please find the kernel
> > > > messages readable on the screen at this point attached
> > > > (kernel_log_after_suspend.txt).
> > > >=20
> > > > A bisection was successful and produced the first bad commit
> > > > [da6d9c8ecd00e20218461007948f2b0a8e7fa242]=C2=A0wifi: brcmfmac: add=
 firmware
> > > > vendor info in driver info
> > > > I've attached the bisection log as well (bisect.txt).
> > > >=20
> > > > Suspend to RAM works on this machine on newer kernels once the brcm=
fmac
> > > > module is unloaded.
> > > >=20
> > > > Distribution: Arch Linux
> > > > Architecture: x86_64
> > > > Device: Dell XPS 13 9350 with BCM4350 wifi card
> > > > Kernel config used at compilation (created using the Arch Linux def=
ault
> > > > config and make olddefconfig):
> > > > https://gist.githubusercontent.com/maclomhair/e33fa7eece8f8c77e5a88=
c4eede2f523/raw/429dfb022498c026225865dbb3ab2f75d5030a54/config
> > > > Dmesg output after boot:
> > > > https://gist.githubusercontent.com/maclomhair/47c75fa759d93800e7fb5=
e937fabef3e/raw/10750996a1ea9dcb3fa14d9b94e11fedd3abf280/dmesg
> > > >=20
> > > > #regzbot introduced da6d9c8ecd00e20218461007948f2b0a8e7fa242
> > >=20
> > > Thank you for reporting this and thank you for bisecting it too!
> > >=20
> > > As a result of your excellent bug report I've been able to write
> > > a fix for this. I'm confident enough in the fix that I've submitted
> > > it upstream right away.
> > >=20
> > > But it would still be good if you can test the fix and let us know
> > > if it fixes this issue for you. You should have received a copy
> > > of the patch when I submitted it upstream.
>=20
> I have now tested the patch you sent and it indeed fixes the issue for
> me! Thank you for your quick response!

I have now also tested the second version of the patch, and it also
fixes the issue for me!

>=20
>=20
> >=20
> > For the archives here's the patch:
> >=20
> > https://patchwork.kernel.org/project/linux-wireless/patch/2023051010005=
0.27099-1-hdegoede@redhat.com/
> >=20
>=20

