Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC76FDE22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjEJMxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjEJMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:53:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A449E5;
        Wed, 10 May 2023 05:53:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f450815d02so6699945e9.0;
        Wed, 10 May 2023 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683723216; x=1686315216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEnydj+sztBx3mYVi8wHkJZbcQn+3Lp8nVVqu2XXxM0=;
        b=XA78EC4Q1d77CejcfRDQ3mTDVvNzoGVtb4ZRJOW+pKdLF9ocgxC8Vf4MkaRUj5c0Nq
         kVBURW4tI/OVHd95/CBR+PcnsQ/Qow4TdKI3NaXeTZcOXw9Y1pHlmxJ1AoWvzQTU8JeW
         bIgYZI/WsmFMU0pOkVrxPPhUKcjGATq0Wa5qY+TB7PMgbooMWbB8M0DeV3YFMoPbLIKk
         KJotyGMrDbCJ4AAqYbU0MjwpGMkxyFRycgrI+56cB950w95EE6Mmn64l6wIT0N2MjcQp
         CVW6vgmoyAgsqe2ZyJHn3IDXctG2wUdAIIEGq/lKSCRjXcC24AsIA16bBQuaOjTOMIVj
         llrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683723216; x=1686315216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEnydj+sztBx3mYVi8wHkJZbcQn+3Lp8nVVqu2XXxM0=;
        b=kwZsTaUeabcX0GsbCCsPZRKTIZwsa/sMP9aEab45hrq1nWvbxVgru3p16d6L0yNvn1
         nXrL7t2QnT2dTZEqepqlTqea3aiBSNTeCNIr5Pv4La88aXaPYhbYXVP97lzAXF80tO79
         dGKaFzKK99xByJzKjY0gVyD+AkNq/rqnNZhgqLP0O3LqaFVpHBq9nFfgUob6yl1+krnB
         ZAwNG7O21K81/epbGfycF+L7sxWZjcHb+RtaUl/P8LLr9rWctoFolTYKcTRNyqqyl2lB
         z4LZw7CVGMB3GwESIMq5TgsBOVo+IuxUw+sJDhjaqEbY+X+9aE9UrT3bKQ/0OWKz6Bo/
         EPog==
X-Gm-Message-State: AC+VfDzwmbldFqeFFNd5zw4TARl7bCcO28WzVgUvkm/NGO2FpOsfI2DA
        Z1kjLNs2HJ2c2tZCUvC985k=
X-Google-Smtp-Source: ACHHUZ7SgPVN45FISMZYl+La7pgsUhn+Zx/xyuhl+cPxR7tuL1FVJGGnkUx8442M7dRTNSqSjr3tYA==
X-Received: by 2002:a7b:ca45:0:b0:3f4:22da:c3f1 with SMTP id m5-20020a7bca45000000b003f422dac3f1mr7747167wml.17.1683723216362;
        Wed, 10 May 2023 05:53:36 -0700 (PDT)
Received: from [192.168.8.84] (213-225-15-168.nat.highway.a1.net. [213.225.15.168])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000050600b003079c402762sm7888259wrf.19.2023.05.10.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 05:53:36 -0700 (PDT)
Message-ID: <3c195b2430668788f993df7872b21e52f4450ef0.camel@gmail.com>
Subject: Re: [REGRESSION] wifi: brcmfmac: add firmware vendor info in driver
 info
From:   Felix <nimrod4garoa@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        regressions@lists.linux.dev,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Date:   Wed, 10 May 2023 14:53:34 +0200
In-Reply-To: <87bkiso0aw.fsf@kernel.org>
References: <4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com>
         <c7aa9034-59f8-11aa-7170-86c0db012dda@redhat.com>
         <87bkiso0aw.fsf@kernel.org>
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

On Wed, 2023-05-10 at 15:09 +0300, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>=20
> > On 5/10/23 10:25, Felix wrote:
> > > Changes made by the mentioned commit lead to Oops when waking up afte=
r
> > > suspend to RAM.
> > >=20
> > > When waking up a Dell XPS 13 9350 with BCM4350 wifi card after suspen=
d
> > > to RAM,=C2=A0the kernel hangs with a NULL pointer dereference and Oop=
s. The
> > > issues was introduced by commit
> > > da6d9c8ecd00e20218461007948f2b0a8e7fa242 and only happens when the
> > > brcmfmac module is loaded. This issue is the reason we could not
> > > upgrade to newer kernels than the 6.1 series on the affected machine.
> > >=20
> > >=20
> > > Details:
> > >=20
> > > On a Dell XPS 13 9350 laptop with Broadcom BCM4350 wifi card (accordi=
ng
> > > to lspci), every kernel starting with 6.2 hangs when waking up after
> > > suspend to RAM. The issue persisted as of May 2nd (last tested commit
> > > was 348551ddaf311c76b01cdcbaf61b6fef06a49144). Passing the debug and
> > > no_console_suspend parameters to the kernel show that a NULL pointer
> > > dereference and an Oops happen at wakeup. Please find the kernel
> > > messages readable on the screen at this point attached
> > > (kernel_log_after_suspend.txt).
> > >=20
> > > A bisection was successful and produced the first bad commit
> > > [da6d9c8ecd00e20218461007948f2b0a8e7fa242]=C2=A0wifi: brcmfmac: add f=
irmware
> > > vendor info in driver info
> > > I've attached the bisection log as well (bisect.txt).
> > >=20
> > > Suspend to RAM works on this machine on newer kernels once the brcmfm=
ac
> > > module is unloaded.
> > >=20
> > > Distribution: Arch Linux
> > > Architecture: x86_64
> > > Device: Dell XPS 13 9350 with BCM4350 wifi card
> > > Kernel config used at compilation (created using the Arch Linux defau=
lt
> > > config and make olddefconfig):
> > > https://gist.githubusercontent.com/maclomhair/e33fa7eece8f8c77e5a88c4=
eede2f523/raw/429dfb022498c026225865dbb3ab2f75d5030a54/config
> > > Dmesg output after boot:
> > > https://gist.githubusercontent.com/maclomhair/47c75fa759d93800e7fb5e9=
37fabef3e/raw/10750996a1ea9dcb3fa14d9b94e11fedd3abf280/dmesg
> > >=20
> > > #regzbot introduced da6d9c8ecd00e20218461007948f2b0a8e7fa242
> >=20
> > Thank you for reporting this and thank you for bisecting it too!
> >=20
> > As a result of your excellent bug report I've been able to write
> > a fix for this. I'm confident enough in the fix that I've submitted
> > it upstream right away.
> >=20
> > But it would still be good if you can test the fix and let us know
> > if it fixes this issue for you. You should have received a copy
> > of the patch when I submitted it upstream.

I have now tested the patch you sent and it indeed fixes the issue for
me! Thank you for your quick response!


>=20
> For the archives here's the patch:
>=20
> https://patchwork.kernel.org/project/linux-wireless/patch/20230510100050.=
27099-1-hdegoede@redhat.com/
>=20

