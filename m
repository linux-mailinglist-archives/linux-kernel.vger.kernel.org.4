Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929EE6C4EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCVO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjCVO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:57:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B267026
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:56:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6C0B35FD41;
        Wed, 22 Mar 2023 17:56:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679496987;
        bh=DK/BS0PsLzFCeIVeQ8zj/D8t80CWwlRCK2o6um1SyM4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=iQayR9g0DZQvUGrujRR09g+wQTLXw3Gl6oPfar1odxK8gZ5Ihf9nKnfuUYAQgEIZQ
         0pJIP0ewmWD6Fu2iO4AU90HI96RxoxfxbrVZucgOO/zR9UutEsKbix+42AhAVuNXy9
         pAlBtR4W7iBOup5KaMNFhOeZ2xB2cKsfibxqbl04Dq2ydM5MAWnwS3t+l7yxaC0NlO
         rmOSz3ANu64CTKdoIMBnXDeoFZonAlDSA/n0NoprGv6Y0xlQR2zp5Yk11K4on5YXTA
         ihcZHCpxIpPl4kVDmtNiNfYXYQBUHbCAEnyhPpBrXQPBR6isBrcnYWWh+ukxXq87Wx
         +qlCEmlIezN9g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Mar 2023 17:56:26 +0300 (MSK)
Date:   Wed, 22 Mar 2023 17:56:20 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Rob Herring <robh@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <apw@canonical.com>,
        <joe@perches.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <kernel@sberdevices.ru>,
        <linux-kernel@vger.kernel.org>, <rockosov@gmail.com>
Subject: Re: [PATCH v3] checkpatch: add missing bindings license check
Message-ID: <20230322145620.ksia76spsi7f6wxc@CAB-WSD-L081021>
References: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
 <20230321215337.GA1656483-robh@kernel.org>
 <20230322102607.5rac7lmy5w653jen@CAB-WSD-L081021>
 <CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com>
 <20230322141444.abwirejgfbeer7lr@CAB-WSD-L081021>
 <CAL_JsqJa-McFEorLr6ZWNqaEtjG8Oi2rNJ3hGwb2Xk3jvqMZgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJa-McFEorLr6ZWNqaEtjG8Oi2rNJ3hGwb2Xk3jvqMZgQ@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/22 10:34:00 #20990985
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:36:40AM -0500, Rob Herring wrote:
> On Wed, Mar 22, 2023 at 9:15 AM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >
> > On Wed, Mar 22, 2023 at 08:40:21AM -0500, Rob Herring wrote:
> > > On Wed, Mar 22, 2023 at 5:26 AM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> > > >
> > > > Hello Rob, thank you for the comments. Please find my thoughts below.
> > > >
> > > > On Tue, Mar 21, 2023 at 04:53:37PM -0500, Rob Herring wrote:
> > > > > On Mon, Mar 20, 2023 at 11:33:50PM +0300, Dmitry Rokosov wrote:
> > > > > > All headers from 'include/dt-bindings/' must be verified by checkpatch
> > > > > > together with Documentation bindings, because all of them are part of
> > > > > > the whole DT bindings system.
> > > > > >
> > > > > > The requirement is dual licensed and matching pattern:
> > > > > >     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> > > > >
> > > > > This is not correct. The headers can and should be licensed like the dts
> > > > > files which are (unfortunately) all over the place and differ from the
> > > > > bindings.
> > > > >
> > > > > Also, GPL-2.0-or-later is neither desired nor encouraged.
> > > >
> > > > Sorry, I'm little bit confused. Let's discuss correct way.
> > > >
> > > > We had such discussion in another review.
> > > >
> > > > https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> > > >
> > > > Krzysztof has mentioned that Documentation yaml bindings schemas and
> > > > include bindings headers should have the same license by default.
> > >
> > > By default is the key. Logically, headers are part of the binding
> > > definition. However, they are included by dts files, so IMO their
> > > license should align with dts files. If you don't yet have any dts
> > > files, then yes, "GPL-2.0-only OR BSD-2-Clause" is what you should
> > > use.
> > >
> > > > And checkpath must check not only Documentation schema (previous
> > > > implementation), but 'include bindings' as well:
> > > >
> > > > From Krzysztof at https://lore.kernel.org/all/9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org/:
> > >
> > > Checkpatch has no way of knowing about the dts file part, so it can't
> > > tell you what license.
> > >
> > > Even as-is, checkpatch is wrong sometimes. If you convert a binding
> > > (that defaulted to GPL-2.0-only) to schema, you can't just relicense
> > > it dual licensed.
> > >
> > > >
> > > > ---
> > > > >>>>> @@ -0,0 +1,20 @@
> > > > >>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
> > > > >>>>
> > > > >>>> I found in changelog:
> > > > >>>> "fix license issue, it's GPL-2.0+ only in the current version"
> > > > >>>> and I do not understand.
> > > > >>>>
> > > > >>>> The license is wrong, so what did you fix?
> > > > >>>>
> > > > >>>
> > > > >>> Sorry don't get you. Why is it wrong?
> > > > >>
> > > > >> Run checkpatch - it will tell you why wrong. The license is not correct.
> > > > >> This is part of binding and should be the same as binding.
> > > > >>
> > > > >
> > > > > I always run checkpatch before sending the next patch series. Checkpatch
> > > > > doesn't highlight this problem:
> > > > >
> > > > > --------------
> > > > > $ rg SPDX a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
> > > > > 32:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > 111:+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > 188:+/* SPDX-License-Identifier: GPL-2.0+ */
> > > > > 294:+/* SPDX-License-Identifier: GPL-2.0+ */
> > > > >
> > > > > $ ./scripts/checkpatch.pl --strict a1_clkc_v10/v10-0003-dt-bindings-clock-meson-add-A1-PLL-and-Periphera.patch
> > > > > total: 0 errors, 0 warnings, 0 checks, 259 lines checked
> > > >
> > > > Hmm, my bad, that's something to fix/improve in checkpatch.
> > > > ---
> > > >
> > > > Actually, I agree with Krzysztof that checkpatch should verify 'include
> > > > bindings', but looks like there is misunderstanding which license pattern
> > > > we have to use.
> > > >
> > > > Rob, could you please share your thoughts if possible? Which one pattern
> > > > we have to base on? GPL-2.0-only without 'later' suffix? Or you totally
> > > > disagree that checkpatch is responsible for 'include bindings'
> > > > verification?
> > >
> > > I think we could do this:
> > >
> > > Schemas should be: GPL-2.0-only OR BSD-2-Clause
> > > Headers should be: GPL-2.0-only OR .*
> > >
> > > Perhaps the 2nd term can be constrained to "(MIT|BSD-[23]-Clause)",
> > > but I haven't looked at what variations exist in the headers. It may
> > > be too varied that we can only check for "OR". We don't want to
> > > encourage folks to blindly relicense things because checkpatch says
> > > so. If you are copying an existing header and modifying it, then you
> > > keep the original license (unless you have rights to change it).
> >
> > Yes, if we are thinking in the such terms, when bindings are part of
> > device tree source, it's one option to make the same license for both of
> > them. But usually developer creates bindings definition in the first.
> 
> No, most often they are copied from something else. Any tool can't
> know what the source (and its license) is and actively telling users
> to do something different is bad.
> 
> I imagine writing the schema is the last thing because upstream
> requires it and downstream doesn't.
> 

Maybe checkpatch strict rules would allow developers to double confirm
licenses in the copied files...

> > After that, developer or other contributor creates device tree nodes.
> > Also different device tree sources (for differnt boards as an example)
> > can have different licenses.
> 
> I'm sure there are combinations of dts files and headers with
> incompatible licenses. A tool to check that would be nice. Just need
> to generate a list of all input files perhaps with the preprocessor
> dependency generation and then get the licenses for all the files.
> 

Are you talking about some make rule like 'dt_bindings_check' or part of
'dtb_check'?

> > Maybe it's better option to make license dependency between dts and
> > bindings when bindings have a first priority and dts should have the
> > same license or dual license, because bindings are the primary from the
> > git history point of view.
> 
> dts files are too far gone to define any rule in checkpatch. Binding
> files are not because there's really only 2 variations since all the
> existing bindings are just kernel default license (GPL-2.0-only).
> 
> > OR
> >
> > Make default value of bindings as suggested in the patchset (maybe
> > without +/or-later) and show notice log from the checkpatch, like:
> >
> > '''
> > DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)
> > For special cases ask 'devicetree@vger.kernel.org' directly
> 
> For special cases, ask your lawyer...
> 
> > '''
> >
> > And handle all exceptions during LKML review, as Krzysztof suggested
> > before.
> >
> > What do you think about above approaches?
> 
> I laid out what the options are already.
> 

I don't get your position, sorry. By adding GPL-2.0 OR .* pattern rule
we are just checking GPL licensed of bindings, it's not enough.

Different licenses in the *new* yaml schemas and *new* bindings are bad
idea, aren't?

If we introduce strict rules (read as 'suggestion') to checkpatch, the
world will be better. Because new bindings will be aligned with schemas
by license. The dual license, incompatible licenses with dts files are
already existed, it doens't solve this problem. But as a next step we
can expand dtb_check make rule and analyse dts license issues in
preprocessor execution time.

> >
> > Krzysztof, please share your opinion as well.
> >
> > For sure, current checkpatch behaviour is wrong, it doesn't help to
> > understand all mentioned interlacements.
> 
> checkpatch is suggestions or possible issues in many cases. It's not
> absolute nor completely accurate to begin with.
> 
> Rob

-- 
Thank you,
Dmitry
