Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB62C74BCC4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGHIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHIJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F71FC6;
        Sat,  8 Jul 2023 01:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A3260202;
        Sat,  8 Jul 2023 08:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5A8C433C8;
        Sat,  8 Jul 2023 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688803779;
        bh=hMxDvTSCmpzzyFQNw140/iCDQpgewmXQyl9v5IUyvvk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=YXllSzrD6dh7bm3E7O+yNPQgCySArB5BoefZ0+HaBR+r+LW3Xn/GoxfzCbdGKvUYH
         KWK8h+NdoSX7r6M9RQXeVw7rpl6LPmhDX2V3J1zVyTkpcmhxvkkf12matpiponyZ+M
         QWGyrXIFPTV5uvgCVNLHC2FRlixL/PPN1ycrYmmdyrEsrHGlGEFk05tvkBhRxglsOG
         Bc6MuV4fwCyxMwCtskQWwAfD2bReMSyUl++5AlpVP9f86EOlKrEixjCPtro4Be4aXx
         7kyJ9ZGizQtWNJvf/AjalMnxNql+Gkk/e2yuJ17dqGI9aeIo9t+AnusGY7L0eVzKIE
         tC8cMmdat9qKA==
Date:   Sat, 08 Jul 2023 09:09:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>
CC:     sunilvl@ventanamicro.com, ardb@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, rminnich@gmail.com,
        mark.rutland@arm.com, lpieralisi@kernel.org, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, weidong.wd@bytedance.com
Subject: =?US-ASCII?Q?Re=3A_=5BExternal=5D_Re=3A_=5BPATCH_v3_4/4=5D_dt-bin?= =?US-ASCII?Q?dings=3A_firmware=3A_Document_ffitbl_binding?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEEQ3wkgxagOPYrg3g8apLHHDOcAR3hFKpHA3ZQDm9PKvO1xUg@mail.gmail.com>
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <20230705114251.661-5-cuiyunhui@bytedance.com> <20230707-brigade-myth-86ee252b2e4a@spud> <CAN3iYbP_dQOOJKLjAf+pVeYUZRBqwZBG7eq6=pR0upsjT2GpOA@mail.gmail.com> <CAEEQ3wkgxagOPYrg3g8apLHHDOcAR3hFKpHA3ZQDm9PKvO1xUg@mail.gmail.com>
Message-ID: <FEAC0857-A90B-42EC-A426-09AF3C9F463D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 July 2023 04:04:05 IST, "=E8=BF=90=E8=BE=89=E5=B4=94" <cuiyunhui@byte=
dance=2Ecom> wrote:
>Hi Conor,
>
>On Sat, Jul 8, 2023 at 12:53=E2=80=AFAM =E8=91=9B=E5=A3=AB=E5=BB=BA <gesh=
ijian@bytedance=2Ecom> wrote:
>>
>>
>>
>>
>> On Sat, Jul 8, 2023 at 12:16=E2=80=AFAM Conor Dooley <conor@kernel=2Eor=
g> wrote:
>>>
>>> Hey,
>>>
>>> On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
>>> > Add the description for ffitbl subnode=2E
>>> >
>>> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance=2Ecom>
>>> > ---
>>> >  =2E=2E=2E/devicetree/bindings/firmware/ffitbl=2Etxt   | 27 ++++++++=
+++++++++++
>>> >  MAINTAINERS                                   |  1 +
>>> >  2 files changed, 28 insertions(+)
>>> >  create mode 100644 Documentation/devicetree/bindings/firmware/ffitb=
l=2Etxt
>>> >
>>> > diff --git a/Documentation/devicetree/bindings/firmware/ffitbl=2Etxt=
 b/Documentation/devicetree/bindings/firmware/ffitbl=2Etxt
>>> > new file mode 100644
>>> > index 000000000000=2E=2Ec42368626199
>>> > --- /dev/null
>>> > +++ b/Documentation/devicetree/bindings/firmware/ffitbl=2Etxt
>>> > @@ -0,0 +1,27 @@
>>> > +FFI(FDT FIRMWARE INTERFACE) driver
>>> > +
>>> > +Required properties:
>>> > + - entry             : acpi or smbios root pointer, u64
>>> > + - reg                       : acpi or smbios version, u32
>>> > +
>>> > +Some bootloaders, such as Coreboot do not support EFI,
>>> > +only devicetree and some arches do not have a reserved
>>> > +address segment=2E Add "ffitbl" subnode to obtain ACPI RSDP
>>> > +and SMBIOS entry=2E
>>>
>>> Since the conversation on this stuff all seems to be going absolutely
>>> nowhere, the ACPI portion of this is intended for use on RISC-V in
>>> violation of the RISC-V ACPI specs=2E It also goes against the
>>> requirements of the platform spec=2E Quoting from [1]:
>>>
>>> | > Just so we're all on the same page, I just now asked Mark Himelste=
in
>>> | > of RISC-V International if there is anything in RISC-V standards t=
hat
>>> | > requires UEFI, and the answer is a solid "no=2E"
>>> |
>>> | Huh? Firstly, running off to invoke RVI is not productive - they don=
't
>>> | maintain the various operating system kernels etc=2E
>>> | Secondly, that does not seem to be true=2E The platform spec mandate=
s UEFI
>>> | for the OS-A server platform, alongside ACPI:
>>> | https://github=2Ecom/riscv/riscv-platform-specs/blob/main/riscv-plat=
form-spec=2Eadoc#32-boot-process
>>> | and the OS-A embedded platform needs to comply with EBBR & use DT:
>>> | https://github=2Ecom/riscv/riscv-platform-specs/blob/main/riscv-plat=
form-spec=2Eadoc#32-boot-process
>>> |
>>> | EBBR does say that systems must not provide both ACPI and DT to the =
OS
>>> | loader, but I am far from an expert on these kind of things & am not
>>> | sure where something like this where the DT "contains" ACPI would st=
and=2E
>>> |
>>> | The RISC-V ACPI spec also says "UEFI firmware is mandatory to suppor=
t
>>> | ACPI":
>>> | https://github=2Ecom/riscv-non-isa/riscv-acpi/blob/master/riscv-acpi=
-guidance=2Eadoc
>>
>>  UEFI firmware is mandatory to support ACPI and coreboot is an option t=
o support ACPI as well=2E i think it works well for both, I don't think UEF=
I and ACPI need to be binding together, each UEFI and ACPI also works well =
with other solutions=2E
>
>Thanks for shijian(Nill)'s suggestions=2E
>
>Hi Conor,
>Thank you very much for your valuable comments on this set of patch
>codes, which are very helpful=2E
>
>Judging from the current specifications, maybe yes, you can NACK, but
>it's better not to rush to conclusions=2E

Naks are not permanent, I can remove it in the future if the specs change=
=2E

>The so-called specifications represent the ideas of FFI opponents=2E

"So-called"? They _are_ the specs=2E

>What we have to do is to discuss with them and get an effective
>consensus, so as to achieve the purpose of updating the specification=2E

Yes, but that needs to be done on tech-brs, not lkml=2E

Thanks,
Conor=2E

>
>>>
>>>
>>>
>>> NAKed-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>>>
>>> Cheers,
>>> Conor=2E
>>>
>>> [1] - https://lore=2Ekernel=2Eorg/linux-riscv/20230707-attach-conjuror=
-306d967347ce@wendy/
>
>Thanks,
>Yunhui
