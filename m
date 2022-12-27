Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5A656F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 21:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiL0Uvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 15:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiL0UvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 15:51:06 -0500
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Dec 2022 12:39:27 PST
Received: from mr85p00im-zteg06021901.me.com (mr85p00im-zteg06021901.me.com [17.58.23.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA013DFC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 12:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1672173090; bh=bn8cbZ1+5gpfp47ylD0XGaLQcJuV5XgPGMnDvf0oOfc=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=HMQytf0C+PD8zA4CoYTgDmf1Mf0ZzOLE8VHOzCS80TmAJ2zA7D9gcTBvlGLLQpPix
         wZVz4pA8/EWoMFWutcn6xmbmpffQPyU3APfozAUxxkIo0aSARH+GO+bsJ5NfdyTk6g
         l1bB1yPHgTU/sbnNNi7/yD2IuF7qYCz13wz4Ux6vTmJi7t8TLxhQV+W9F6euHi59Es
         v2tRTrRV6DjBy6qlWOW1wKsSf6pA2LeF1OL4gmdGr232sZ1FNqnByWlXqVP87YjgDe
         SRCWicxsvwDmCKiGs0iLCKdVpUZdPwB4zViyi3vVVyW77UTj+zoHBNG6Dl5w2mM3gW
         FBUhY2P0vYBOA==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 59F2F74062F;
        Tue, 27 Dec 2022 20:31:29 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.23\))
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
From:   Alexander Altman <alexanderaltman@me.com>
In-Reply-To: <Y6r+UbfkXruwHU2v@zn.tnic>
Date:   Tue, 27 Dec 2022 12:31:17 -0800
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76353487-736A-4470-AD31-77F47F8C08F6@me.com>
References: <202212272003.rgQDX8DQ-lkp@intel.com> <Y6r4mXz5NS0+HVXo@zn.tnic>
 <Y6r+UbfkXruwHU2v@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.400.23)
X-Proofpoint-GUID: AR0abnXbYKiN-FukuifFkXTTBuwPFtj0
X-Proofpoint-ORIG-GUID: AR0abnXbYKiN-FukuifFkXTTBuwPFtj0
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1011
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212270170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 27, 2022, at 6:16 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> Resending because rust ML doesn't like big messages:
>=20
> From: rust-for-linux-owner@vger.kernel.org
> To: rust-for-linux-approval@vger.kernel.org, bp@alien8.de
> Subject: BOUNCE rust-for-linux@vger.kernel.org:     Message too long =
(>100000 chars)
>=20
> Rust folks, you can check out the whole thing here:
>=20
> https://lore.kernel.org/all/202212272003.rgQDX8DQ-lkp@intel.com/
>=20
> (and maybe raise the limit on that ML of yours :))
>=20
> Thx.
>=20
> On Tue, Dec 27, 2022 at 02:52:25PM +0100, Borislav Petkov wrote:
>> On Tue, Dec 27, 2022 at 08:36:11PM +0800, kernel test robot wrote:
>>> Hi Borislav,
>>>=20
>>> FYI, the error/warning was bisected to this commit, please ignore it =
if it's irrelevant.
>>>=20
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git =
tip-x86-alternatives
>>> head:   82db736201e76889825efe8899ad55976111691a
>>> commit: 82db736201e76889825efe8899ad55976111691a [1/1] =
x86/alternatives: Add alt_instr.flags
>>> config: x86_64-rhel-8.3-rust
>>> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project =
f28c006a5895fc0e329fe15fead81e37457cb1d1)
>>> reproduce (this is a W=3D1 build):
>>>        wget =
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross =
-O ~/bin/make.cross
>>>        chmod +x ~/bin/make.cross
>>>        # =
https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?id=3D82d=
b736201e76889825efe8899ad55976111691a
>>>        git remote add bp =
https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
>>>        git fetch --no-tags bp tip-x86-alternatives
>>>        git checkout 82db736201e76889825efe8899ad55976111691a
>>>        # save the config file
>>>        mkdir build_dir && cp config build_dir/.config
>>>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang =
make.cross W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
>>>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang =
make.cross W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 prepare
>>=20
>> These reproduction instructions look insufficient to me. The env =
needs a
>> rust compiler installed. Which I don't have:
>>=20
>> ./scripts/rust_is_available.sh -v
>> ***
>> *** Rust compiler '' could not be found.
>> ***
>>=20
>> Or does some of that make.cross magic install one? I don't see a =
"rustc"
>> mentioned there at all but I see
>>=20
>> CONFIG_RUSTC_VERSION_TEXT=3D"rustc 1.62.0 (a8314ef7d 2022-06-27)"
>>=20
>> in the .config so apparently that rustc thing has come from =
somewhere...
>>=20
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>=20
>>> All errors (new ones prefixed by >>):
>>>=20
>>>>> error[E0588]: packed type cannot transitively contain a =
`#[repr(align)]` type


This is indeed directly because of your change, although fixing it =
beyond my
skill.  Explanation:

You made the following change:
> - u16 cpuid; /* cpuid bit set for replacement */
> +
> + union {
> + struct {
> + u32 cpuid: 16; /* CPUID bit set for replacement */
> + u32 flags: 16; /* patching control flags */
> + };
> + u32 ft_flgs;
> + };

That caused Rust=E2=80=99s bindgen (bindings generator) to generate a =
type for the
altered field that indirectly included a representation of the
bitfields...which have a greater-than-natural alignment because of their
encoding (they=E2=80=99re represented as an array of 4 8-bit unsigned =
integers, but
aligned as if they=E2=80=99re a single 16-bit unsigned integer).  This =
interacts
badly with the top-level command to make the alt_instr struct packed, =
which
bindgen faithfully translates from C __packed to Rust #[repr(packed)].

One way to resolve this temporarily would be to add the following line =
above
the offending struct:
/// <div rustbindgen hide></div>
This will cause bindgen to ignore the struct entirely and not translate =
it.  If it=E2=80=99s
actually needed for Rust code, now or later, then we can=E2=80=99t do =
that and need
to actually replace it with something translatable, or else leave it =
hidden and
manually create its translation on the Rust side.  For the latter, just =
using a
u32 for the entire bitfield-containing union would be sufficient.

>>=20
>> -ENOPARSE this error.
>>=20
>> Lemme add rust and toolchain MLs to Cc and leave the rest for them =
with
>> the hope that they can translate this linenoise for me.
>=20
> Well, not leaving it because rust ML can't take such big emails.
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
>=20


Thanks,
     Laine Taffin Altman=20=
