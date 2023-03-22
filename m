Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFF66C4DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCVOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCVOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:36:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E70B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD3FBB81CF3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90697C4339C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679495812;
        bh=4PtAlV0x6TV4oDMDVLLN8Bty/SGvzqWo6EIQ9zFORa4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsJbvdPLTB07Hg0NBOV6upPbFsPrwlFIA80dBzu5PDKnDoj36cDW3ugN7PL+wxGb3
         zgGaBQKCCEeZXJPD0o1r7Kz+ZVrpFZYWn7ryf9VVbpCM4dqbBfvGaUoMrconOBWsbw
         MupiZeQH10b9jQFe8PpH7t3hnYIgAfsMYKB0Fub64cNwd3DZ6IT7ij68pH7J859zAW
         RH+KMK+DQfklOSouCgqXbr2YkkYplZn0xxoivtPflqcchVBPoryqk4nZljf6h8e6TL
         QDb4ZzXhSAXtEyEwaPLIsxECeT+oAJpakXnzs4PZr8zXV0vv1eOEoISTbB91kf2wJO
         XIpLeLRSQ8s1Q==
Received: by mail-yb1-f181.google.com with SMTP id e71so21295040ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:36:52 -0700 (PDT)
X-Gm-Message-State: AAQBX9eZ2gSsTbyJB1+l/kqYNEB5tbpunqPFoRteOaFecPtUvtlqHIgn
        DSfjlodWlu8LsVWTgzGph6WLBqJPGQUtQyH33Q==
X-Google-Smtp-Source: AKy350aWnQ2P3jpoeLgqzexPjNVchvN1x7nw6kp4bXREpb2oUEW3doYAG76NmskkHSan8r77fctFk65AGvnqcl74VRU=
X-Received: by 2002:a05:6902:70f:b0:b6a:2590:6c63 with SMTP id
 k15-20020a056902070f00b00b6a25906c63mr2098482ybt.2.1679495811430; Wed, 22 Mar
 2023 07:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
 <20230321215337.GA1656483-robh@kernel.org> <20230322102607.5rac7lmy5w653jen@CAB-WSD-L081021>
 <CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com> <20230322141444.abwirejgfbeer7lr@CAB-WSD-L081021>
In-Reply-To: <20230322141444.abwirejgfbeer7lr@CAB-WSD-L081021>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Mar 2023 09:36:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJa-McFEorLr6ZWNqaEtjG8Oi2rNJ3hGwb2Xk3jvqMZgQ@mail.gmail.com>
Message-ID: <CAL_JsqJa-McFEorLr6ZWNqaEtjG8Oi2rNJ3hGwb2Xk3jvqMZgQ@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add missing bindings license check
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     krzysztof.kozlowski@linaro.org, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 9:15=E2=80=AFAM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> On Wed, Mar 22, 2023 at 08:40:21AM -0500, Rob Herring wrote:
> > On Wed, Mar 22, 2023 at 5:26=E2=80=AFAM Dmitry Rokosov <ddrokosov@sberd=
evices.ru> wrote:
> > >
> > > Hello Rob, thank you for the comments. Please find my thoughts below.
> > >
> > > On Tue, Mar 21, 2023 at 04:53:37PM -0500, Rob Herring wrote:
> > > > On Mon, Mar 20, 2023 at 11:33:50PM +0300, Dmitry Rokosov wrote:
> > > > > All headers from 'include/dt-bindings/' must be verified by check=
patch
> > > > > together with Documentation bindings, because all of them are par=
t of
> > > > > the whole DT bindings system.
> > > > >
> > > > > The requirement is dual licensed and matching pattern:
> > > > >     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> > > >
> > > > This is not correct. The headers can and should be licensed like th=
e dts
> > > > files which are (unfortunately) all over the place and differ from =
the
> > > > bindings.
> > > >
> > > > Also, GPL-2.0-or-later is neither desired nor encouraged.
> > >
> > > Sorry, I'm little bit confused. Let's discuss correct way.
> > >
> > > We had such discussion in another review.
> > >
> > > https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevi=
ces.ru/
> > >
> > > Krzysztof has mentioned that Documentation yaml bindings schemas and
> > > include bindings headers should have the same license by default.
> >
> > By default is the key. Logically, headers are part of the binding
> > definition. However, they are included by dts files, so IMO their
> > license should align with dts files. If you don't yet have any dts
> > files, then yes, "GPL-2.0-only OR BSD-2-Clause" is what you should
> > use.
> >
> > > And checkpath must check not only Documentation schema (previous
> > > implementation), but 'include bindings' as well:
> > >
> > > From Krzysztof at https://lore.kernel.org/all/9d176288-cd7c-7107-e180=
-761e372a2b6e@linaro.org/:
> >
> > Checkpatch has no way of knowing about the dts file part, so it can't
> > tell you what license.
> >
> > Even as-is, checkpatch is wrong sometimes. If you convert a binding
> > (that defaulted to GPL-2.0-only) to schema, you can't just relicense
> > it dual licensed.
> >
> > >
> > > ---
> > > >>>>> @@ -0,0 +1,20 @@
> > > >>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
> > > >>>>
> > > >>>> I found in changelog:
> > > >>>> "fix license issue, it's GPL-2.0+ only in the current version"
> > > >>>> and I do not understand.
> > > >>>>
> > > >>>> The license is wrong, so what did you fix?
> > > >>>>
> > > >>>
> > > >>> Sorry don't get you. Why is it wrong?
> > > >>
> > > >> Run checkpatch - it will tell you why wrong. The license is not co=
rrect.
> > > >> This is part of binding and should be the same as binding.
> > > >>
> > > >
> > > > I always run checkpatch before sending the next patch series. Check=
patch
> > > > doesn't highlight this problem:
> > > >
> > > > --------------
> > > > $ rg SPDX a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-a=
nd-Periphera.patch
> > > > 32:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > 111:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > 188:+/* SPDX-License-Identifier: GPL-2.0+ */
> > > > 294:+/* SPDX-License-Identifier: GPL-2.0+ */
> > > >
> > > > $ ./scripts/checkpatch.pl --strict a1_clkc_v10/v10-0003-dt-bindings=
-clock-meson-add-A1-PLL-and-Periphera.patch
> > > > total: 0 errors, 0 warnings, 0 checks, 259 lines checked
> > >
> > > Hmm, my bad, that's something to fix/improve in checkpatch.
> > > ---
> > >
> > > Actually, I agree with Krzysztof that checkpatch should verify 'inclu=
de
> > > bindings', but looks like there is misunderstanding which license pat=
tern
> > > we have to use.
> > >
> > > Rob, could you please share your thoughts if possible? Which one patt=
ern
> > > we have to base on? GPL-2.0-only without 'later' suffix? Or you total=
ly
> > > disagree that checkpatch is responsible for 'include bindings'
> > > verification?
> >
> > I think we could do this:
> >
> > Schemas should be: GPL-2.0-only OR BSD-2-Clause
> > Headers should be: GPL-2.0-only OR .*
> >
> > Perhaps the 2nd term can be constrained to "(MIT|BSD-[23]-Clause)",
> > but I haven't looked at what variations exist in the headers. It may
> > be too varied that we can only check for "OR". We don't want to
> > encourage folks to blindly relicense things because checkpatch says
> > so. If you are copying an existing header and modifying it, then you
> > keep the original license (unless you have rights to change it).
>
> Yes, if we are thinking in the such terms, when bindings are part of
> device tree source, it's one option to make the same license for both of
> them. But usually developer creates bindings definition in the first.

No, most often they are copied from something else. Any tool can't
know what the source (and its license) is and actively telling users
to do something different is bad.

I imagine writing the schema is the last thing because upstream
requires it and downstream doesn't.

> After that, developer or other contributor creates device tree nodes.
> Also different device tree sources (for differnt boards as an example)
> can have different licenses.

I'm sure there are combinations of dts files and headers with
incompatible licenses. A tool to check that would be nice. Just need
to generate a list of all input files perhaps with the preprocessor
dependency generation and then get the licenses for all the files.

> Maybe it's better option to make license dependency between dts and
> bindings when bindings have a first priority and dts should have the
> same license or dual license, because bindings are the primary from the
> git history point of view.

dts files are too far gone to define any rule in checkpatch. Binding
files are not because there's really only 2 variations since all the
existing bindings are just kernel default license (GPL-2.0-only).

> OR
>
> Make default value of bindings as suggested in the patchset (maybe
> without +/or-later) and show notice log from the checkpatch, like:
>
> '''
> DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
> For special cases ask 'devicetree@vger.kernel.org' directly

For special cases, ask your lawyer...

> '''
>
> And handle all exceptions during LKML review, as Krzysztof suggested
> before.
>
> What do you think about above approaches?

I laid out what the options are already.

>
> Krzysztof, please share your opinion as well.
>
> For sure, current checkpatch behaviour is wrong, it doesn't help to
> understand all mentioned interlacements.

checkpatch is suggestions or possible issues in many cases. It's not
absolute nor completely accurate to begin with.

Rob
