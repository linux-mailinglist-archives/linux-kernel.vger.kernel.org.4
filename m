Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D95B9A10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIOLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiIOLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:43:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9BA9C2D5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:51 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 130so27203396ybz.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=URml8S1JcYbav8DX1XKzE1rKQKPDorOXuNAY5GP/bfM=;
        b=X2RZp3uIbTAG42nWBtDhiSzuoKCRNm45A6Fg2dKa3ojCdS0sZROU2lCOemxw9l7XEc
         3LChpuOPpo2ath6I/V8ePL+HKZEGLPuwN4Phbcy9WIrXJV+hJ+nr6a2YMm2EtAfZ/DBx
         qxutRNHYz4I4CYkMfyNvMAa5RhlcH2De+nGf3t7SlVb6JUnwcHV5uuBFFoZhL7nrX/O/
         ddOIassWcyo1uGLY4Q7uHlsSFMGuh5M5hMt/8MHsEKDvD4/pSwD2ZMsLByD1hk/ZujAp
         60nooXVG4n0GvBfkMVjoiTdbliNKbHspYW3k6lIzltDoUxphVYaWhsLhVFgiifKxyhOC
         BMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=URml8S1JcYbav8DX1XKzE1rKQKPDorOXuNAY5GP/bfM=;
        b=KNAFBZCuxvZz/zRh6vgi/gThG5V6BBcA8XrdgASAe8QMMHex5cCDZYmyVYtJ44H3KI
         zKeYB1RpHigQHRYtObJdiHtTNujLIC0DXcbyz7GWl7mmRF/nXaHoB7i52ryo1z1Nh/W1
         PPKtBVOjcy4qjHiVIB78JGodO69USLJSywNiWCS6DDv1grXShtMUTHLFG/8RMzgSbzEj
         zfRZmCcbX/NNCaamxRASVefjAZebvMlo8VzgzwL3MZ/szrGKaDGANjxM5aQktZRya7UC
         H/7fIqEed7LzYxbt9Td59PZOPfw0oKxCUchznjEbrEultmIVPB63qb8EBDuZgEdcOFis
         0VeA==
X-Gm-Message-State: ACgBeo134SKwLl9rEG+UMGC4pEWJ1sU7dXeyKG09FH20CVYPOnVpd2gs
        2JPxQPgbvYMn0xd+l8sZScTpm7Yl/ortsM1Yw5PWmA==
X-Google-Smtp-Source: AA6agR5Jd02d/4alqF4774h4T0Cr4tBfvBtGJJX9UroxPxusj3OchhNnWWbDJYW+riVAMJDHELFf2+qUdFLLKnnj1FY=
X-Received: by 2002:a05:6902:1029:b0:6af:2c99:4630 with SMTP id
 x9-20020a056902102900b006af2c994630mr17122921ybt.516.1663242043608; Thu, 15
 Sep 2022 04:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
 <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
 <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
 <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com>
 <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
 <CAA8EJprBAtdWAGG=a7BYc_Zwx9B5Dqsy4n3dhvP5cA40agR8ew@mail.gmail.com> <CAK7LNARpPvBH0i55nD0v+8KDeqy2eK996TRhwE-KNAF+8mG3xQ@mail.gmail.com>
In-Reply-To: <CAK7LNARpPvBH0i55nD0v+8KDeqy2eK996TRhwE-KNAF+8mG3xQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 15 Sep 2022 14:40:32 +0300
Message-ID: <CAA8EJppdS4st0G21Nk1SU9fbXCcEefHO=8E=upOPdjgRYhPBLA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sept 2022 at 07:51, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sun, Sep 11, 2022 at 2:36 AM Dmitry Baryshkov
>
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, 4 Aug 2022 at 18:27, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Fri, Jul 29, 2022 at 1:46 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Fri, 29 Jul 2022 at 10:05, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
> > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > >
> > > > > > On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> > > > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > It is useful to be able to recheck dtbs files against a limited set of
> > > > > > > > > DT schema files. This can be accomplished by using differnt
> > > > > > > > > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > > > > > > > > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > > > > > > > > (and doesn't retrigger the build).
> > > > > > > > >
> > > > > > > > > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > > > > > > > > and dt-validate into a single new command. Then if_changed_dep triggers
> > > > > > > > > on DT_SCHEMA_FILES changes and reruns the build/check.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > > > ---
> > > > > > > > >  scripts/Makefile.lib | 14 ++++++--------
> > > > > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > > > > > > index c88b98b5dc44..3df470289382 100644
> > > > > > > > > --- a/scripts/Makefile.lib
> > > > > > > > > +++ b/scripts/Makefile.lib
> > > > > > > > > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > > > > > > > >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > > > > > > > >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > > > > > > > >
> > > > > > > > > -quiet_cmd_dtb_check =  CHECK   $@
> > > > > > > > > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > > > > > > > > +quiet_cmd_dtb =        DTC/CHECK   $@
> > > > > > > >
> > > > > > > > This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> > > > > > > > always do just 'DTC'. I can fixup when applying.
> > > > > > > >
> > > > > > > > I'll give it a few days for other comments.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
> > > > > > > You do not need to re-run dtc.
> > > > > > >
> > > > > > > I guess the strangeness comes from the fact that you are trying to do the
> > > > > > >  two different things in a single rule.
> > > > > >
> > > > > > The issue is that with the current rules the dt-validate isn't
> > > > > > re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.
> > > > >
> > > > > Correct.
> > > > >
> > > > > What I said is like this.
> > > > >
> > > > > # touch the timestamp file, %.dtb.checked
> > > > > $(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE
> > >
> > > Not really a fan of the thousands of files that creates. Maybe if it
> > > was turned into something useful like a list of schemas that apply to
> > > the dtb. IOW, a dependency list. That would speed up re-running after
> > > a schema change. Though if a schema change created new dependencies,
> > > that wouldn't work.
> > >
> > > > >         $(call if_changed_rule,dtb_check)
> > > > >
> > > > > $(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
> > > > >         $(call if_changed_rule,dtc)
> > > > >
> > > > > $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> > > > >         $(call if_changed_dep,dtc)
> > > > >
> > > > >
> > > > > With the dtc/check split, we can avoid unneeded regeneration of
> > > > > %.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
> > > > > changed.
> > > > >
> > > > >
> > > > > One drawback is we track %.dtb.checked and and %.dtb separately,
> > > > > so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
> > > > > may come back.
> > > >
> > > > It's up to you and Rob, but I'd really prefer a simpler solution here.
> > > > Regenerating dtbs sounds like a minor pain compared to hacking the
> > > > top-level Makefile again. What I really like is that if one has
> > > > CHECK_DTBS=y (for whatever reason), he can not generate dtb without
> > > > validation.
> > >
> > > I lean towards just rebuilding the dtbs. That's pretty quick and
> > > ensures we get dtc warnings with schema warnings. In the long run, I
> > > would like to make the schema checks not optional to run. The
> > > impediment to doing that is lots of warnings (but not not some
> > > platforms), adding a tool dependency, and validation time.
> >
> > Rob, Masahiro, do we have any conclusion here? I can change my patch,
> > but I'd like to understand in which way I should change it.
> > Fixing/testing yaml changes is a bit painful w/o this change.
> >
> > --
> > With best wishes
> > Dmitry
>
>
>
>
> I am fine with the patch as long as you fix DTC/CHECK to DTC.

Ack, I completely forgot about this part. Please excuse me. I'll
change it to DTC_CHK (as suggested before) to fit into 7 chars in v2.

>
> Another idea is to re-check the schema every time,
> like this:

I think this will add the external build dependency. We tried a
similar approach several releases ago and had to revert the change.

> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 3fb6a99e78c4..9fc9f39fb12e 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -375,13 +375,9 @@ quiet_cmd_dtb_check =      CHECK   $@
>        cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u
> $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA
> ) $@ || true
>  endif
>
> -define rule_dtc
> -       $(call cmd_and_fixdep,dtc)
> -       $(call cmd,dtb_check)
> -endef
> -
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
> -       $(call if_changed_rule,dtc)
> +       $(call if_changed_dep,dtc)
> +       $(call cmd,dtb_check)
>
>  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>         $(call if_changed_dep,dtc)
>
>

-- 
With best wishes
Dmitry
