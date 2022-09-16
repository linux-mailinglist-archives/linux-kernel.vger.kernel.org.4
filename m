Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51EC5BA3C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIPBLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIPBK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:10:57 -0400
X-Greylist: delayed 73136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 18:10:51 PDT
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC9501AC;
        Thu, 15 Sep 2022 18:10:51 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28G1AUmm017285;
        Fri, 16 Sep 2022 10:10:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28G1AUmm017285
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663290630;
        bh=3KdVhX/ek+RoM1zR1D7PkB6f0EicE4mePH412t8y/g8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NWx10Z0NwYJiRy+sISz+EQL1F8M9lbaWTCEQonoJyj2GdlcZ5cjVgPzSmFRkpib43
         EduhmA/qZHU5P0pz0BUF4i2pfGw/mw7s4v3El1YhbG29Li5EO0TVYz7zKBPSBYPFOv
         Ysd/drLvJMQYFV9L4qTddo0DefFix43ROCb94L/RwL7uhlOUUFpP/GGqFvHNcEO6Qm
         RUgV52/Yhm4+1SwRh1msDSzjl3okyhbGei7PePuSPqylfVGK0M4lLTl1xJAxO4dME0
         jCZgnvCsitkS7SXoQqrwyGhyNkyNmbdc1ls7xx+hhdHzLnqFkcvEPPTGMln+3t01O2
         5ZxZrc3wbZ/Wg==
X-Nifty-SrcIP: [209.85.167.181]
Received: by mail-oi1-f181.google.com with SMTP id m81so2711437oia.1;
        Thu, 15 Sep 2022 18:10:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf3W7oVBv8Ef05W4I6v+Di6tKWGB3gnjWT3NO5jB+xRFzLpuikkW
        2JS73zd7d8thi/lAekXJGR9t/RCKqeMFnupXhOE=
X-Google-Smtp-Source: AMsMyM5lHMEqblldfjyoSZX78K8K5cYMBjCgLS8+JcbL3D0tvPqTgPw4byoUsUQkl/TH80N/4HdRUGYFeUM4IWwv7Ag=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr1266968oie.287.1663290629299; Thu, 15
 Sep 2022 18:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
 <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
 <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
 <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com>
 <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
 <CAA8EJprBAtdWAGG=a7BYc_Zwx9B5Dqsy4n3dhvP5cA40agR8ew@mail.gmail.com>
 <CAK7LNARpPvBH0i55nD0v+8KDeqy2eK996TRhwE-KNAF+8mG3xQ@mail.gmail.com> <CAA8EJppdS4st0G21Nk1SU9fbXCcEefHO=8E=upOPdjgRYhPBLA@mail.gmail.com>
In-Reply-To: <CAA8EJppdS4st0G21Nk1SU9fbXCcEefHO=8E=upOPdjgRYhPBLA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 16 Sep 2022 10:09:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZUkkyjUZCp5cXs_ROz+KzJPPGkoFpTKFXJaixXGofkw@mail.gmail.com>
Message-ID: <CAK7LNARZUkkyjUZCp5cXs_ROz+KzJPPGkoFpTKFXJaixXGofkw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 8:40 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 15 Sept 2022 at 07:51, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sun, Sep 11, 2022 at 2:36 AM Dmitry Baryshkov
> >
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, 4 Aug 2022 at 18:27, Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 29, 2022 at 1:46 AM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > On Fri, 29 Jul 2022 at 10:05, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
> > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > >
> > > > > > > On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> > > > > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > It is useful to be able to recheck dtbs files against a limited set of
> > > > > > > > > > DT schema files. This can be accomplished by using differnt
> > > > > > > > > > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > > > > > > > > > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > > > > > > > > > (and doesn't retrigger the build).
> > > > > > > > > >
> > > > > > > > > > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > > > > > > > > > and dt-validate into a single new command. Then if_changed_dep triggers
> > > > > > > > > > on DT_SCHEMA_FILES changes and reruns the build/check.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > >  scripts/Makefile.lib | 14 ++++++--------
> > > > > > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > > > > > > > index c88b98b5dc44..3df470289382 100644
> > > > > > > > > > --- a/scripts/Makefile.lib
> > > > > > > > > > +++ b/scripts/Makefile.lib
> > > > > > > > > > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > > > > > > > > >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > > > > > > > > >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > > > > > > > > >
> > > > > > > > > > -quiet_cmd_dtb_check =  CHECK   $@
> > > > > > > > > > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > > > > > > > > > +quiet_cmd_dtb =        DTC/CHECK   $@
> > > > > > > > >
> > > > > > > > > This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> > > > > > > > > always do just 'DTC'. I can fixup when applying.
> > > > > > > > >
> > > > > > > > > I'll give it a few days for other comments.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
> > > > > > > > You do not need to re-run dtc.
> > > > > > > >
> > > > > > > > I guess the strangeness comes from the fact that you are trying to do the
> > > > > > > >  two different things in a single rule.
> > > > > > >
> > > > > > > The issue is that with the current rules the dt-validate isn't
> > > > > > > re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.
> > > > > >
> > > > > > Correct.
> > > > > >
> > > > > > What I said is like this.
> > > > > >
> > > > > > # touch the timestamp file, %.dtb.checked
> > > > > > $(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE
> > > >
> > > > Not really a fan of the thousands of files that creates. Maybe if it
> > > > was turned into something useful like a list of schemas that apply to
> > > > the dtb. IOW, a dependency list. That would speed up re-running after
> > > > a schema change. Though if a schema change created new dependencies,
> > > > that wouldn't work.
> > > >
> > > > > >         $(call if_changed_rule,dtb_check)
> > > > > >
> > > > > > $(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
> > > > > >         $(call if_changed_rule,dtc)
> > > > > >
> > > > > > $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> > > > > >         $(call if_changed_dep,dtc)
> > > > > >
> > > > > >
> > > > > > With the dtc/check split, we can avoid unneeded regeneration of
> > > > > > %.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
> > > > > > changed.
> > > > > >
> > > > > >
> > > > > > One drawback is we track %.dtb.checked and and %.dtb separately,
> > > > > > so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
> > > > > > may come back.
> > > > >
> > > > > It's up to you and Rob, but I'd really prefer a simpler solution here.
> > > > > Regenerating dtbs sounds like a minor pain compared to hacking the
> > > > > top-level Makefile again. What I really like is that if one has
> > > > > CHECK_DTBS=y (for whatever reason), he can not generate dtb without
> > > > > validation.
> > > >
> > > > I lean towards just rebuilding the dtbs. That's pretty quick and
> > > > ensures we get dtc warnings with schema warnings. In the long run, I
> > > > would like to make the schema checks not optional to run. The
> > > > impediment to doing that is lots of warnings (but not not some
> > > > platforms), adding a tool dependency, and validation time.
> > >
> > > Rob, Masahiro, do we have any conclusion here? I can change my patch,
> > > but I'd like to understand in which way I should change it.
> > > Fixing/testing yaml changes is a bit painful w/o this change.
> > >
> > > --
> > > With best wishes
> > > Dmitry
> >
> >
> >
> >
> > I am fine with the patch as long as you fix DTC/CHECK to DTC.
>
> Ack, I completely forgot about this part. Please excuse me. I'll
> change it to DTC_CHK (as suggested before) to fit into 7 chars in v2.
>
> >
> > Another idea is to re-check the schema every time,
> > like this:
>
> I think this will add the external build dependency. We tried a
> similar approach several releases ago and had to revert the change.


If you are talking about
75e895343d5a2fcbdf4cb3d31ab7492bd65925f0,
you are completely misunderstanding.

Look at my code closely.
It is how the sparse checker works with C=2.





> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 3fb6a99e78c4..9fc9f39fb12e 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -375,13 +375,9 @@ quiet_cmd_dtb_check =      CHECK   $@
> >        cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u
> > $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA
> > ) $@ || true
> >  endif
> >
> > -define rule_dtc
> > -       $(call cmd_and_fixdep,dtc)
> > -       $(call cmd,dtb_check)
> > -endef
> > -
> >  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
> > -       $(call if_changed_rule,dtc)
> > +       $(call if_changed_dep,dtc)
> > +       $(call cmd,dtb_check)
> >
> >  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> >         $(call if_changed_dep,dtc)
> >
> >
>
> --
> With best wishes
> Dmitry

--
Best Regards
Masahiro Yamada
