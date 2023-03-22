Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564186C4C04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCVNkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCVNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87494AFFC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E2CCB81CEC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0811EC4339B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679492434;
        bh=h6KnKtWUb50NFsSz08OGO0Ww0EhLMbbSVFFsTqIkSBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e3MzlkqMI4bQYjvleeSzCeZieNCQ+pnnAWsl6iN6v7phmkd+y9FjUy+EiSbZ1am2I
         BeSkfkqEn1OxE1ViYkBH8EKt9JLQlXra/J1gKpKyGyWxr1HueIgjBAEwcG4v6wNSqo
         4dfTWUCcpu9cKCAdV07p+xa1rA4HyriLg60TMBjY3lW3o/j1y66i0skgaVFSn5FFjr
         G95zfYAq+VLnanAR6yxC76HUGosdMGahjJkHxCn+n83yG8vlkUT978AzPNh8zwpeAx
         tuUTGxUn0FYvdcjUmysiD7HHDLHCmDWP82Ch4JnlSVWDUYfSvfFg4ZFBW16aPuUAPV
         99pgFxVuQh0RA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5416698e889so339061747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:40:33 -0700 (PDT)
X-Gm-Message-State: AAQBX9c12WIOQVsNDQgBptbPfz0FE6Dm5W96sIrBxRD9ZQguRqUBroGl
        W/4Rml1I5QiM2sgFwrFtg3126VfnTJrEAqs1VA==
X-Google-Smtp-Source: AKy350a5m4jSHyL+Y8fesOmyQwSmUGYFosaWR/jC/4K/uezLnhwjF/308aBXdZNaXPLHhS7f3xHO7aHJFcoK+ABhtZU=
X-Received: by 2002:a81:af48:0:b0:541:6aa7:f889 with SMTP id
 x8-20020a81af48000000b005416aa7f889mr3058232ywj.5.1679492432988; Wed, 22 Mar
 2023 06:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
 <20230321215337.GA1656483-robh@kernel.org> <20230322102607.5rac7lmy5w653jen@CAB-WSD-L081021>
In-Reply-To: <20230322102607.5rac7lmy5w653jen@CAB-WSD-L081021>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Mar 2023 08:40:21 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com>
Message-ID: <CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com>
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

On Wed, Mar 22, 2023 at 5:26=E2=80=AFAM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> Hello Rob, thank you for the comments. Please find my thoughts below.
>
> On Tue, Mar 21, 2023 at 04:53:37PM -0500, Rob Herring wrote:
> > On Mon, Mar 20, 2023 at 11:33:50PM +0300, Dmitry Rokosov wrote:
> > > All headers from 'include/dt-bindings/' must be verified by checkpatc=
h
> > > together with Documentation bindings, because all of them are part of
> > > the whole DT bindings system.
> > >
> > > The requirement is dual licensed and matching pattern:
> > >     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> >
> > This is not correct. The headers can and should be licensed like the dt=
s
> > files which are (unfortunately) all over the place and differ from the
> > bindings.
> >
> > Also, GPL-2.0-or-later is neither desired nor encouraged.
>
> Sorry, I'm little bit confused. Let's discuss correct way.
>
> We had such discussion in another review.
>
> https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.=
ru/
>
> Krzysztof has mentioned that Documentation yaml bindings schemas and
> include bindings headers should have the same license by default.

By default is the key. Logically, headers are part of the binding
definition. However, they are included by dts files, so IMO their
license should align with dts files. If you don't yet have any dts
files, then yes, "GPL-2.0-only OR BSD-2-Clause" is what you should
use.

> And checkpath must check not only Documentation schema (previous
> implementation), but 'include bindings' as well:
>
> From Krzysztof at https://lore.kernel.org/all/9d176288-cd7c-7107-e180-761=
e372a2b6e@linaro.org/:

Checkpatch has no way of knowing about the dts file part, so it can't
tell you what license.

Even as-is, checkpatch is wrong sometimes. If you convert a binding
(that defaulted to GPL-2.0-only) to schema, you can't just relicense
it dual licensed.

>
> ---
> >>>>> @@ -0,0 +1,20 @@
> >>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
> >>>>
> >>>> I found in changelog:
> >>>> "fix license issue, it's GPL-2.0+ only in the current version"
> >>>> and I do not understand.
> >>>>
> >>>> The license is wrong, so what did you fix?
> >>>>
> >>>
> >>> Sorry don't get you. Why is it wrong?
> >>
> >> Run checkpatch - it will tell you why wrong. The license is not correc=
t.
> >> This is part of binding and should be the same as binding.
> >>
> >
> > I always run checkpatch before sending the next patch series. Checkpatc=
h
> > doesn't highlight this problem:
> >
> > --------------
> > $ rg SPDX a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-P=
eriphera.patch
> > 32:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > 111:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > 188:+/* SPDX-License-Identifier: GPL-2.0+ */
> > 294:+/* SPDX-License-Identifier: GPL-2.0+ */
> >
> > $ ./scripts/checkpatch.pl --strict a1_clkc_v10/v10-0003-dt-bindings-clo=
ck-meson-add-A1-PLL-and-Periphera.patch
> > total: 0 errors, 0 warnings, 0 checks, 259 lines checked
>
> Hmm, my bad, that's something to fix/improve in checkpatch.
> ---
>
> Actually, I agree with Krzysztof that checkpatch should verify 'include
> bindings', but looks like there is misunderstanding which license pattern
> we have to use.
>
> Rob, could you please share your thoughts if possible? Which one pattern
> we have to base on? GPL-2.0-only without 'later' suffix? Or you totally
> disagree that checkpatch is responsible for 'include bindings'
> verification?

I think we could do this:

Schemas should be: GPL-2.0-only OR BSD-2-Clause
Headers should be: GPL-2.0-only OR .*

Perhaps the 2nd term can be constrained to "(MIT|BSD-[23]-Clause)",
but I haven't looked at what variations exist in the headers. It may
be too varied that we can only check for "OR". We don't want to
encourage folks to blindly relicense things because checkpatch says
so. If you are copying an existing header and modifying it, then you
keep the original license (unless you have rights to change it).

Rob
