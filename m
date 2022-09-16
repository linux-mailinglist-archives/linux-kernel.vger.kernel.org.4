Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23625BAFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiIPOzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:55:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8AF38442;
        Fri, 16 Sep 2022 07:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CC52B82790;
        Fri, 16 Sep 2022 14:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA23C433D7;
        Fri, 16 Sep 2022 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663340100;
        bh=1JtWgU4IMLSrJcnsoWnWTBB8fxGl/q/nzolLwfTS1Ts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QtS1Jr1pORezOCZlrPdwWzxKyIVs888jS/nx/tP43R4M12pxzZUX9dcXPxZp03hoU
         CJFnh2unllgPT2ToO48jciivVcTXvdlAx1eyVFFuDWFK4KlXEhF1binD4N9rKptcQj
         WuA+DEtqv9XGrYCWh2djw54O0wq9SdcbsXx/9h2Ez0BGrcsuX0jwJL13I9Ojo6X4CV
         gsY1GXynWbHATLkxuJqJhU5v5MrtbpNS0HNgE5WgeScakdtwKjKuS2paM1oQfjRpjD
         lVnjsX2ei3k7Nr1Pe289uve6726wFQ+xeckOmMCtERp/gTwWUPiz0blBRM/1OmPT/3
         61vzH42XysF8Q==
Received: by mail-ua1-f51.google.com with SMTP id z26so7988982uaq.0;
        Fri, 16 Sep 2022 07:54:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf1GD0ai0JjFn5hll83sTiibvcYpHwXqWCOiuK2qTP/2n6pgRcJ6
        t3cc20X2/LCA1lgX349SL3iRIpFNOb2qyKPF/A==
X-Google-Smtp-Source: AMsMyM7mMlTK86vtP1IW/NYRfDQ0eMTJDSBrYVjENW4L+hpK8Et6SqJT5Yz2WmXh+ChDbk+GcgGIZpUoEhgnvkfgJBk=
X-Received: by 2002:ab0:32d1:0:b0:3ab:7f86:2121 with SMTP id
 f17-20020ab032d1000000b003ab7f862121mr2129148uao.86.1663340098893; Fri, 16
 Sep 2022 07:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
 <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
 <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
 <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com>
 <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
 <CAA8EJprBAtdWAGG=a7BYc_Zwx9B5Dqsy4n3dhvP5cA40agR8ew@mail.gmail.com>
 <CAK7LNARpPvBH0i55nD0v+8KDeqy2eK996TRhwE-KNAF+8mG3xQ@mail.gmail.com>
 <CAA8EJppdS4st0G21Nk1SU9fbXCcEefHO=8E=upOPdjgRYhPBLA@mail.gmail.com>
 <CAK7LNARZUkkyjUZCp5cXs_ROz+KzJPPGkoFpTKFXJaixXGofkw@mail.gmail.com> <CAA8EJpoDgHeYs2JwBwGksh10_5ZEQvJ7ARLig=HfX4K2uuL2XQ@mail.gmail.com>
In-Reply-To: <CAA8EJpoDgHeYs2JwBwGksh10_5ZEQvJ7ARLig=HfX4K2uuL2XQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 16 Sep 2022 09:54:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=0G9nTwyCWy1TY5btvYO7CtGcZ4inok=u9mw4Da1b1Q@mail.gmail.com>
Message-ID: <CAL_JsqL=0G9nTwyCWy1TY5btvYO7CtGcZ4inok=u9mw4Da1b1Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 9:21 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 16 Sept 2022 at 04:10, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Thu, Sep 15, 2022 at 8:40 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, 15 Sept 2022 at 07:51, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Sun, Sep 11, 2022 at 2:36 AM Dmitry Baryshkov
> > > >
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > On Thu, 4 Aug 2022 at 18:27, Rob Herring <robh+dt@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jul 29, 2022 at 1:46 AM Dmitry Baryshkov
> > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > >
> > > > > > > On Fri, 29 Jul 2022 at 10:05, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
> > > > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> > > > > > > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > It is useful to be able to recheck dtbs files against a limited set of
> > > > > > > > > > > > DT schema files. This can be accomplished by using differnt
> > > > > > > > > > > > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > > > > > > > > > > > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > > > > > > > > > > > (and doesn't retrigger the build).
> > > > > > > > > > > >
> > > > > > > > > > > > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > > > > > > > > > > > and dt-validate into a single new command. Then if_changed_dep triggers
> > > > > > > > > > > > on DT_SCHEMA_FILES changes and reruns the build/check.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  scripts/Makefile.lib | 14 ++++++--------
> > > > > > > > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > > > > > > > > > index c88b98b5dc44..3df470289382 100644
> > > > > > > > > > > > --- a/scripts/Makefile.lib
> > > > > > > > > > > > +++ b/scripts/Makefile.lib
> > > > > > > > > > > > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > > > > > > > > > > >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > > > > > > > > > > >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > > > > > > > > > > >
> > > > > > > > > > > > -quiet_cmd_dtb_check =  CHECK   $@
> > > > > > > > > > > > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > > > > > > > > > > > +quiet_cmd_dtb =        DTC/CHECK   $@
> > > > > > > > > > >
> > > > > > > > > > > This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> > > > > > > > > > > always do just 'DTC'. I can fixup when applying.
> > > > > > > > > > >
> > > > > > > > > > > I'll give it a few days for other comments.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
> > > > > > > > > > You do not need to re-run dtc.
> > > > > > > > > >
> > > > > > > > > > I guess the strangeness comes from the fact that you are trying to do the
> > > > > > > > > >  two different things in a single rule.
> > > > > > > > >
> > > > > > > > > The issue is that with the current rules the dt-validate isn't
> > > > > > > > > re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.
> > > > > > > >
> > > > > > > > Correct.
> > > > > > > >
> > > > > > > > What I said is like this.
> > > > > > > >
> > > > > > > > # touch the timestamp file, %.dtb.checked
> > > > > > > > $(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE
> > > > > >
> > > > > > Not really a fan of the thousands of files that creates. Maybe if it
> > > > > > was turned into something useful like a list of schemas that apply to
> > > > > > the dtb. IOW, a dependency list. That would speed up re-running after
> > > > > > a schema change. Though if a schema change created new dependencies,
> > > > > > that wouldn't work.
> > > > > >
> > > > > > > >         $(call if_changed_rule,dtb_check)
> > > > > > > >
> > > > > > > > $(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
> > > > > > > >         $(call if_changed_rule,dtc)
> > > > > > > >
> > > > > > > > $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> > > > > > > >         $(call if_changed_dep,dtc)
> > > > > > > >
> > > > > > > >
> > > > > > > > With the dtc/check split, we can avoid unneeded regeneration of
> > > > > > > > %.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
> > > > > > > > changed.
> > > > > > > >
> > > > > > > >
> > > > > > > > One drawback is we track %.dtb.checked and and %.dtb separately,
> > > > > > > > so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
> > > > > > > > may come back.
> > > > > > >
> > > > > > > It's up to you and Rob, but I'd really prefer a simpler solution here.
> > > > > > > Regenerating dtbs sounds like a minor pain compared to hacking the
> > > > > > > top-level Makefile again. What I really like is that if one has
> > > > > > > CHECK_DTBS=y (for whatever reason), he can not generate dtb without
> > > > > > > validation.
> > > > > >
> > > > > > I lean towards just rebuilding the dtbs. That's pretty quick and
> > > > > > ensures we get dtc warnings with schema warnings. In the long run, I
> > > > > > would like to make the schema checks not optional to run. The
> > > > > > impediment to doing that is lots of warnings (but not not some
> > > > > > platforms), adding a tool dependency, and validation time.
> > > > >
> > > > > Rob, Masahiro, do we have any conclusion here? I can change my patch,
> > > > > but I'd like to understand in which way I should change it.
> > > > > Fixing/testing yaml changes is a bit painful w/o this change.
> > > > >
> > > > > --
> > > > > With best wishes
> > > > > Dmitry
> > > >
> > > >
> > > >
> > > >
> > > > I am fine with the patch as long as you fix DTC/CHECK to DTC.
> > >
> > > Ack, I completely forgot about this part. Please excuse me. I'll
> > > change it to DTC_CHK (as suggested before) to fit into 7 chars in v2.
> > >
> > > >
> > > > Another idea is to re-check the schema every time,
> > > > like this:
> > >
> > > I think this will add the external build dependency. We tried a
> > > similar approach several releases ago and had to revert the change.
> >
> >
> > If you are talking about
> > 75e895343d5a2fcbdf4cb3d31ab7492bd65925f0,
> > you are completely misunderstanding.
> >
> > Look at my code closely.
> > It is how the sparse checker works with C=2.
>
> Ah, I see. Then I'm fine with either your patch or mine v2 at your
> (and Rob's) preference.

I'd rather not recheck every time. The user can remove the dtbs if
they want to do that.

Rob
