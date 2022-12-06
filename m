Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112D5644587
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiLFOWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiLFOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:22:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC6E2DA99;
        Tue,  6 Dec 2022 06:22:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h33so13470590pgm.9;
        Tue, 06 Dec 2022 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMgzu0iWUBeUpifu7obIKbBGzuPvL5tzOlwVM/8tox8=;
        b=LpeeHMU/bHmIhuzoGWYsKr6J/bLPxqDRH4GiPefb0tD5w+v7qgo+o5y4iNQyNtGy37
         ovG7W/9AHi89srBPOgZVIOzNwUn3XTyMZPVyd7Xru9+GORGR6ki0adBCZWYhvG6ABulk
         Biwyf4RcdXrDy9RD7NNWoetwji4TbuIkiYrjDOfpO2m11mL5tSux7Y+kSvubV/5Y2Z/Z
         i3nccdr3B8j4VR2PEgiFhQtxlyc4V0VMjiOHvlfKQtzgOVzEPXlQQbGJZlQbBDwfXCmY
         j5+tmPfkm5ccPIQLeP+pJwQjlkBdVEBsDmDLcstjE7w6Sam0eqU2VMqFTmOMnvIKJni6
         l6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMgzu0iWUBeUpifu7obIKbBGzuPvL5tzOlwVM/8tox8=;
        b=C5e0sxrOopgNtptgnZOAhuhKW1UhdEEYoQcEygyHzRrxkW97svWlEArbpe/E0Ncijt
         Ag0vJLbvnpbZIBQPrTZoy1nPhYzyd4/dN1SuhKh/Cf0/Llyhrkfw9rNNbBowTr43ZfbO
         zdoxrN4Qk0bnxMCQhpMwXbURL5hELZHFvud0FEHe5A6CFw5SSdgfafpP/WxeGVdbtTRb
         aSbMd3Suc6hKgDeWnrzI2lqtZBa/bhBunlspmIZ32M4AXIuanja7GEILKq026U43A0hd
         QnKZSIYTnvou1rg2m4FpdQME5ZeSCvpkUu/0d1DJz77wfZJSINTGiPGlYzk3ILkpz7kQ
         NLaw==
X-Gm-Message-State: ANoB5pk8fBVDLXmmbLqYCnUAHYvcvCrzM2MwPbYpUt9MrvOaxHvDjkfK
        hBCZVagJx4BIyG1EOcfpVSi8bTwCFic=
X-Google-Smtp-Source: AA0mqf6GznOkZFV23X91yVCivgJuatvXjycEJIU7Sk4QqAJRFAjz8eHl4uOjMir/BO21WoAuk0ipXQ==
X-Received: by 2002:aa7:8a02:0:b0:573:846c:b88 with SMTP id m2-20020aa78a02000000b00573846c0b88mr234494pfa.23.1670336550405;
        Tue, 06 Dec 2022 06:22:30 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a24-20020aa795b8000000b00575d06e53edsm10695896pfk.149.2022.12.06.06.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 06:22:29 -0800 (PST)
Message-ID: <3e5f2b84-a351-2e6d-f620-421876908aba@gmail.com>
Date:   Tue, 6 Dec 2022 23:22:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org,
        ojeda@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
 <dd0a67d6-0ba3-66e2-851c-7498b0bc99d1@amd.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <dd0a67d6-0ba3-66e2-851c-7498b0bc99d1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 10:36:11 -0600, Carlos Bilbao wrote:
> On 12/4/22 19:06, Akira Yokosawa wrote:
>=20
>> Hi,
>>
>> On Thu, 1 Dec 2022 14:48:14 -0600, Carlos Bilbao wrote:
>>> Include HTML output generated with rustdoc into the Linux kernel
>>> documentation on Rust. Change target `make htmldocs` to combine RST S=
phinx
>>> and the generation of Rust documentation, when support is available.
>>>
>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>> ---
>>>
>>> Changes since V1:
>>> =C2=A0 - Work on top of v6.1-rc1.
>> Thank you for the rebase.
>>
>>> =C2=A0 - Don't use rustdoc.rst, instead add link to Documentation/rus=
t/index.rst.
>>> =C2=A0 - In Documentation/Makefile, replace @make rustdoc for $(Q)$(M=
AKE) rustdoc.
>>> =C2=A0 - Don't do LLVM=3D1 for all rustdoc generation within `make ht=
mldocs`.
>>> =C2=A0 - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.=

>>>
>>> ---
>>> =C2=A0 Documentation/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++++
>>> =C2=A0 Documentation/rust/index.rst |=C2=A0 3 +++
>>> =C2=A0 rust/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++++++------
>>> =C2=A0 3 files changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>>> index 64d44c1ecad3..f537cf558af6 100644
>>> --- a/Documentation/Makefile
>>> +++ b/Documentation/Makefile
>>> @@ -92,6 +92,10 @@ quiet_cmd_sphinx =3D SPHINX=C2=A0 $@ --> file://$(=
abspath $(BUILDDIR)/$3/$4)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 =C2=A0 htmldocs:
>>> +# If Rust support is available, add rustdoc generated contents
>>> +ifdef CONFIG_RUST
>>> +=C2=A0=C2=A0=C2=A0 $(Q)$(MAKE) rustdoc
>>> +endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @$(srctree)/scripts/sphinx-pre-install=
 --version-check
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @+$(foreach var,$(SPHINXDIRS),$(call l=
oop_cmd,sphinx,html,$(var),,$(var)))
>> So, this means "make htmldocs" will require kernel .config if CONFIG_R=
UST=3Dy.
>> I'm not sure this new requirement is acceptable for kernel documentati=
on
>> testers who just want to build kernel documentation.
>=20
>=20
> This is already kind of the case for Rust-related business.
>=20
>=20
>>
>> You are doing three things in this patch.
>>
>> =C2=A0 1) Change the destination of rustdoc to under Documentation/out=
put/
>> =C2=A0 2) Add a cross reference to the generated rustdoc in
>> =C2=A0=C2=A0=C2=A0=C2=A0 Documentation/rust/index.rst.
>> =C2=A0 3) Integrate rustdoc generation into htmldocs.
>>
>> I'm OK with 1) and 2).
>> Can you separate 3) into another patch and respin?
>=20
>=20
> Glad we can agree on 1) and 2). Why moving 3)? This is a small patch wi=
th
> one overall purpose (Integrate rustdoc into website).

Yes, I agree that 3) is a small change. I understand what you want to
do. But there are a couple of options for _how_ to do it.
My current position is that Documentation/Makefile is _not_ the right
place for the change, as mentioned in my reply to Miguel.

>=20
>=20
>>
>> By the way, is rustdoc's requirement of .config only for CONFIG_RUST?
>> In other words, are contents of rustdoc affected by other config setti=
ngs?
>>
>> If not, I think rustdoc can be generated regardless of config settings=
 as
>> far as necessary tools (rustc, bindgen, etc.) are available.
>=20
>=20
> Yes, but someone with the tools may not want to use them. Keep in mind =
that
> generating rustdoc takes a few extra seconds.

As mentioned in another reply, I'm convinced of the dependency on .config=
=2E

>=20
>=20
>>
>>> =C2=A0 diff --git a/Documentation/rust/index.rst b/Documentation/rust=
/index.rst
>>> index 4ae8c66b94fa..4005326c3ba9 100644
>>> --- a/Documentation/rust/index.rst
>>> +++ b/Documentation/rust/index.rst
>>> @@ -6,6 +6,9 @@ Rust
>>> =C2=A0 Documentation related to Rust within the kernel. To start usin=
g Rust
>>> =C2=A0 in the kernel, please read the quick-start.rst guide.
>>> =C2=A0 +If this documentation includes rustdoc-generated HTML, the en=
try point can
>>> +be found `here. <rustdoc/kernel/index.html>`_
>> This cross reference will only make sense in htmldocs build.
>> Perhaps, you can use the "only::" directive [1] as follows:
>>
>> .. only:: html
>=20
>=20
> This I can gladly do on a V3. I will wait for an answer on issues above=
=2E

OK.

So if you split this into a two-patch series, 1/2 for 1) and 2), and 2/2
for 3) (or an updated one), I'm glad to give my RB tag to 1/2 for Miguel
to be able take it for v6.2 (timing is tight!). 2/2 will need at least
a couple of respins, I guess.

        Thanks, Akira
>=20
>=20
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 If this documentation includes rustdoc-genera=
ted HTML, the entry point can
>> =C2=A0=C2=A0=C2=A0=C2=A0 be found `here. <rustdoc/kernel/index.html>`_=

>>
>> [1]: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fwww.sphinx-doc.org%2Fen%2Fmaster%2Fusage%2Frestructuredtext%2Fdirectiv=
es.html%23directive-only&amp;data=3D05%7C01%7Ccarlos.bilbao%40amd.com%7C1=
63763a795284a542e4f08dad65cf4c6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C=
0%7C638057991984040258%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DDU8n=
mQp7gCCGNMUR6urtHHCz5nXAtomeV17%2BzB%2F4L38%3D&amp;reserved=3D0
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thanks, Akira
>>
>>> +
>>> =C2=A0 .. toctree::
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :maxdepth: 1
>>> =C2=A0 diff --git a/rust/Makefile b/rust/Makefile
>>> index 7700d3853404..080c07048065 100644
>>> --- a/rust/Makefile
>>> +++ b/rust/Makefile
>>> @@ -1,5 +1,8 @@
>>> =C2=A0 # SPDX-License-Identifier: GPL-2.0
>>> =C2=A0 +# Where to place rustdoc generated documentation
>>> +RUSTDOC_OUTPUT =3D $(objtree)/Documentation/output/rust/rustdoc
>>> +
>>> =C2=A0 always-$(CONFIG_RUST) +=3D target.json
>>> =C2=A0 no-clean-files +=3D target.json
>>> =C2=A0 @@ -58,7 +61,7 @@ quiet_cmd_rustdoc =3D RUSTDOC $(if $(rustdoc=
_host),H, ) $<
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJTREE=3D$(abspath $(objtree)) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(RUSTDOC) $(if $(rustdoc_host),$(rust=
_common_flags),$(rust_flags)) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(rustc_target=
_flags) -L$(objtree)/$(obj) \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --output $(objtree)/$(obj=
)/doc \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --output $(RUSTDOC_OUTPUT=
) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --crate-name $=
(subst rustdoc-,,$@) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @$(objtree)/in=
clude/generated/rustc_cfg $<
>>> =C2=A0 @@ -75,15 +78,15 @@ quiet_cmd_rustdoc =3D RUSTDOC $(if $(rustd=
oc_host),H, ) $<
>>> =C2=A0 # and then retouch the generated files.
>>> =C2=A0 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins=
 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rustdoc-alloc rustdoc-kernel
>>> -=C2=A0=C2=A0=C2=A0 $(Q)cp $(srctree)/Documentation/images/logo.svg $=
(objtree)/$(obj)/doc
>>> -=C2=A0=C2=A0=C2=A0 $(Q)cp $(srctree)/Documentation/images/COPYING-lo=
go $(objtree)/$(obj)/doc
>>> -=C2=A0=C2=A0=C2=A0 $(Q)find $(objtree)/$(obj)/doc -name '*.html' -ty=
pe f -print0 | xargs -0 sed -Ei \
>>> +=C2=A0=C2=A0=C2=A0 $(Q)cp $(srctree)/Documentation/images/logo.svg $=
(RUSTDOC_OUTPUT)
>>> +=C2=A0=C2=A0=C2=A0 $(Q)cp $(srctree)/Documentation/images/COPYING-lo=
go $(RUSTDOC_OUTPUT)
>>> +=C2=A0=C2=A0=C2=A0 $(Q)find $(RUSTDOC_OUTPUT) -name '*.html' -type f=
 -print0 | xargs -0 sed -Ei \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's:rust-log=
o\.svg:logo.svg:g' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's:rust-log=
o\.png:logo.svg:g' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's:favicon\=
=2Esvg:logo.svg:g' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's:<link re=
l=3D"alternate icon" type=3D"image/png" href=3D"[./]*favicon-(16x16|32x32=
)\.png">::g'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(Q)echo '.logo-container > img { obje=
ct-fit: contain; }' \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >> $(objtree)/$(obj)/doc/=
rustdoc.css
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >> $(RUSTDOC_OUTPUT)/rust=
doc.css
>>> =C2=A0 =C2=A0 rustdoc-macros: private rustdoc_host =3D yes
>>> =C2=A0 rustdoc-macros: private rustc_target_flags =3D --crate-type pr=
oc-macro \
>>> @@ -141,7 +144,7 @@ quiet_cmd_rustdoc_test =3D RUSTDOC T $<
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @$(objtree)/in=
clude/generated/rustc_cfg \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(rustc_target=
_flags) $(rustdoc_test_target_flags) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --sysroot $(ob=
jtree)/$(obj)/test/sysroot $(rustdoc_test_quiet) \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -L$(objtree)/$(obj)/test =
--output $(objtree)/$(obj)/doc \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -L$(objtree)/$(obj)/test =
--output $(RUSTDOC_OUTPUT) \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --crate-name $=
(subst rusttest-,,$@) $<
>>> =C2=A0 =C2=A0 # We cannot use `-Zpanic-abort-tests` because some test=
s are dynamic,
>>>
>>> base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
>=20
>=20
> Thanks,
> Carlos
