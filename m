Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA994656FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiL0VKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiL0VJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:09:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3B26D;
        Tue, 27 Dec 2022 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672175221; bh=OL5WJhJ3/ioUTccUP2H6ZJHZm++nEKN5MiFWcaZshkI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DP1X3adLdzt3xnBG3I0B9VUWlDhKza6IbdAs40Qoe/bPk3oB4A+eZOBtyvYpW0ppF
         VKlADVUoLV255aRFH2P6g7Os4xXiKumbLF5yWAhXH6h0IpeuxIs0hsiyIgapKEfIpk
         Mr/7enpe72LseWOrkj3IG7rGXXGLRNgmbtEqCPJkM9667QYESkhYbLC7f5ugS883do
         w5wlWUPT0LlOyCXAMnTBZpSRkOHCHDZ1DFEyfp5HZMeH2SRqU0V4HT06AA+sPwMImI
         dtu9zVhJ2Tdnj3Jz0dCy05W1a4kFLd8W59zYAEX7cFq0kIs1/d40QIyrRkpbRiKEEg
         Kn45IwDeNEXlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.190.3]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1oX6Re0szP-00oYBV; Tue, 27
 Dec 2022 22:07:01 +0100
Message-ID: <aaf6a109-ac1b-c22a-88b7-0414b3265857@gmx.de>
Date:   Tue, 27 Dec 2022 22:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fbdev: make offb driver tristate
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        llvm@lists.linux.dev
References: <20221126000401.25302-1-rdunlap@infradead.org>
 <46e8cf0d-ab47-59b1-6c87-53d2d63a5bf6@suse.de>
 <f8c6eb94-10ee-07a8-ea48-d4fae60fc9ae@gmx.de>
 <Y6s96iuc3NRN5tS4@dev-arch.thelio-3990X>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Y6s96iuc3NRN5tS4@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pmufG/yBB7w10j8I7juqQ1B39xUxP8hRiEiNAVefeU+Zrc6CndG
 P8D13De0yweY4iSpmMFzYgs6fOK5FY/JajFhHgVW2MhBJFSnDzKgrXKxbm67ZiGG77ZOXyu
 FLsoDQkkcIufDRIPC8QEKCG9C/E/xdgEsK+r6KUlD4LVKleVqgJN1rYSFrY3/kFHkS0k90G
 3aibwRR9tFFMx1kg3m9XA==
UI-OutboundReport: notjunk:1;M01:P0:4m/m/TKe8EY=;8px+0lBpXJqhmDlMMqcatGE6fyR
 kwdAiq3U2LOYRCxMiNVKvGCCqgYC7ouanOJGEqPMwm2bYQgcwkpZQa8H5cF9bZQj34BAIsZsA
 1XaKbiPO6NpfRjtEEMZtMJxLLjyQml/if2W/d9BlP9bs9nHhn/x81lApHGsN8lRiie2Hw5s65
 CkGmlTfGpZqQFfR3vl7BrvMn8H4VBnh9fqZQP/Qax0iIoCeVG57nvtJwaUGFKx1Te4GHsigtp
 qyYqRalAbUye9HFVHulSa43FI7QDfWFz2FHzyrboHoSvQ4m2xPUpU6QY+Ux9j2ZRBr78JqaDN
 cLZz6NQUsojzhZ7gPHpjMdyART5prM6RQozcOlq0WB/yyNqsD7UqbWQWFAsV3oVafcDG8X6gf
 xAYOzoEoYGRMmpt3htPz1nJYi+fKuvOOWmc2eG6edLfPAH3KtnnZQtpvfgWt7cVkLqbtWWoPC
 CB8xkIdRQglorW4K8x1cCNApA3rr6y26eFaZKXjO87lEhOg5QOnz5XTSn3XgZ2d9FmFaYsFMc
 3NVsCgZ2gE0BFa1lem1NlLGvpU/bgrnCIZppeqOe+xhZ5+fw5t+KVVhVXmg1x1PDaY/o1cJJ5
 p5YQfhICbF/Eh1NNjPo7XKtVU4NqOxXWhh+SyAiNabpDIxUEx3phW6Iw5RwSvqeOijsriYAT6
 KBZLy4gdPEg9p0Yq9h6tzRUSB183VmBIaM4L1toY6RF1VO2tS5fCRb9GQUp25gmkTRG8CSVbx
 ejQSOttkcoVUXEb64ETtnJNUVv6KF5bHR96YTiNAqjSryZd5VJLZJ4Hfagb4S6XgT69FXReDu
 pmU6YXRpUtZQNzcqZ3A9mqEJPS8H35jtEqXcPR54RKvB+gPOlKqmyw4DEMc5O+Ew+og53U+LL
 MpDMGXwo0jV2Nu1DrSFMLj6Hw9g9KHRXCGYL6LdvIrIT1jl2QayH61cYho1wZiYKrCMhf+e4c
 gkwanbkBWZCZ56wz9awOPy+2nJk=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/22 19:48, Nathan Chancellor wrote:
> On Sat, Dec 10, 2022 at 05:35:06PM +0100, Helge Deller wrote:
>> On 11/26/22 14:40, Thomas Zimmermann wrote:
>>> Am 26.11.22 um 01:04 schrieb Randy Dunlap:
>>>> Make the offb (Open Firmware frame buffer) driver tristate,
>>>> i.e., so that it can be built as a loadable module.
>>>>
>>>> However, it still depends on the setting of DRM_OFDRM
>>>> so that both of these drivers cannot be builtin at the same time
>>>> nor can one be builtin and the other one a loadable module.
>>>>
>>>> Build-tested successfully with all combination of DRM_OFDRM and FB_OF=
.
>>>>
>>>> This fixes a build issue that Michal reported when FB_OF=3Dy and
>>>> DRM_OFDRM=3Dm:
>>>>
>>>> powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x58): u=
ndefined reference to `cfb_fillrect'
>>>> powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x60): u=
ndefined reference to `cfb_copyarea'
>>>> powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x68): u=
ndefined reference to `cfb_imageblit'
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Cc: Michal Such=C3=A1nek <msuchanek@suse.de>
>>>> Cc: linuxppc-dev@lists.ozlabs.org
>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>>> Cc: Helge Deller <deller@gmx.de>
>>>> Cc: linux-fbdev@vger.kernel.org
>>>> Cc: dri-devel@lists.freedesktop.org
>>>
>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>> applied.
>
> Is this going to make it to Linus soon? We are now seeing this error in
> our CI, which has the configuration describe in this commit.
>
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/=
3785609002/jobs/6437398666#step:5:149
>
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integrati=
on2/builds/2JUMSmjAoSJoKfl6PPjfU66JGit/build.log


It didn't applied cleanly earlier.
I've now added it to the fbdev for-next branch, and if no problems
show up in the next few days I'll push it before next weekend.
https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/log=
/?h=3Dfor-next

Helge


> Cheers,
> Nathan
>
>>>> ---
>>>>  =C2=A0 drivers/video/fbdev/Kconfig |=C2=A0=C2=A0=C2=A0 4 ++--
>>>>  =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff -- a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>>>> --- a/drivers/video/fbdev/Kconfig
>>>> +++ b/drivers/video/fbdev/Kconfig
>>>> @@ -456,8 +456,8 @@ config FB_ATARI
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chipset found in Ataris.
>>>>  =C2=A0 config FB_OF
>>>> -=C2=A0=C2=A0=C2=A0 bool "Open Firmware frame buffer device support"
>>>> -=C2=A0=C2=A0=C2=A0 depends on (FB =3D y) && PPC && (!PPC_PSERIES || =
PCI)
>>>> +=C2=A0=C2=A0=C2=A0 tristate "Open Firmware frame buffer device suppo=
rt"
>>>> +=C2=A0=C2=A0=C2=A0 depends on FB && PPC && (!PPC_PSERIES || PCI)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on !DRM_OFDRM
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select APERTURE_HELPERS
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select FB_CFB_FILLRECT
>>>
>>
>>

