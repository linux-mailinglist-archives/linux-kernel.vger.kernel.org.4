Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B35B47BC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIJRgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:36:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A446239
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:35:58 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id f131so7035783ybf.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gLVbshsHa2sc404y0Bd85BoPJIDMSkXF3ZFiG5HMn+4=;
        b=WlvDmqLKsIVj30dGxIVC9LhXEdbTCn+OGriYlT7pW7q942pY/vT3Vh1MBnPzh4VXUd
         5C7oARpyRLFbfR7nfG+FABVt4wFjprwC3Q1+r9VXPU3Qdt/GD5kOsJEHBQKFl38Sk7ZS
         UGPxUu+5dIlc/ObzcpgsUGh7sRLrpQmwcbmLjGpsplcfqJIvdxO8AiirFB5bmVxqgPd3
         qQMnIRb//ZehSiZPrFuhbFKnig3w43cXyt4PhrzODi7YDmNNCkepLGGgvMln8f2qU9/L
         8Qekk0lg/Od+vS4l7kX/CgiZrbF5/7RRIZNcRynWEyssNMvr2wizBMiaKI8p3zfqaxWA
         V5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gLVbshsHa2sc404y0Bd85BoPJIDMSkXF3ZFiG5HMn+4=;
        b=fogoRZYecx7YOCKmuf1YzRZTiaUVUruwB1Rx0l9wnVn5zuax8RLNv4EPrc3EIjGzKS
         t0RMUC9osyvkZfK/QGVMFeUzGzlSVSRwlAXPlnjpi7iTDjE3X3DPPRNBcABftrltL9uM
         QcwK/Dc8aTeZZHnIxncGwj/t5FuGck9THEUQNf/ijk6Uo1as6U4o0+gV6iA2OJ8OQJwR
         VS/KMeLQ75BNiaGOmS/ipKYiafrstYrZ4mQrZYylIMUzIoUazRiFGukPY7y0DxpgQc4b
         V3Wsjx8ZrR+xI/8AsAYRwFrTRT5fhcmZGeRgulKYKbErK4tX+ACayb83PL+eUiCl/EV6
         vl2g==
X-Gm-Message-State: ACgBeo3tZ76MPh4VR1yvpNsd8H3zyQ9FSYL5VOaxRrWLMzPafPgew1EX
        KgOkK/b1+PnNxyjZs6gtIJzntq7UsYdE+nGgCehwsw==
X-Google-Smtp-Source: AA6agR5AKI4RoJD/lniyBNi6dwnQ+x/GZD3aL6I194xxeHfqq8Es1K9B3NYX0w9ok2xr1U4BTU6tp2vsBDJY2p6J0L0=
X-Received: by 2002:a25:af13:0:b0:6ae:3166:1aee with SMTP id
 a19-20020a25af13000000b006ae31661aeemr11400657ybh.288.1662831357675; Sat, 10
 Sep 2022 10:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
 <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
 <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
 <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com> <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
In-Reply-To: <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 10 Sep 2022 20:35:46 +0300
Message-ID: <CAA8EJprBAtdWAGG=a7BYc_Zwx9B5Dqsy4n3dhvP5cA40agR8ew@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 at 18:27, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Jul 29, 2022 at 1:46 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Fri, 29 Jul 2022 at 10:05, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> > > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > > >
> > > > > > > It is useful to be able to recheck dtbs files against a limited set of
> > > > > > > DT schema files. This can be accomplished by using differnt
> > > > > > > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > > > > > > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > > > > > > (and doesn't retrigger the build).
> > > > > > >
> > > > > > > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > > > > > > and dt-validate into a single new command. Then if_changed_dep triggers
> > > > > > > on DT_SCHEMA_FILES changes and reruns the build/check.
> > > > > > >
> > > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > > ---
> > > > > > >  scripts/Makefile.lib | 14 ++++++--------
> > > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > > > > index c88b98b5dc44..3df470289382 100644
> > > > > > > --- a/scripts/Makefile.lib
> > > > > > > +++ b/scripts/Makefile.lib
> > > > > > > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > > > > > >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > > > > > >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > > > > > >
> > > > > > > -quiet_cmd_dtb_check =  CHECK   $@
> > > > > > > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > > > > > > +quiet_cmd_dtb =        DTC/CHECK   $@
> > > > > >
> > > > > > This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> > > > > > always do just 'DTC'. I can fixup when applying.
> > > > > >
> > > > > > I'll give it a few days for other comments.
> > > > >
> > > > >
> > > > >
> > > > > When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
> > > > > You do not need to re-run dtc.
> > > > >
> > > > > I guess the strangeness comes from the fact that you are trying to do the
> > > > >  two different things in a single rule.
> > > >
> > > > The issue is that with the current rules the dt-validate isn't
> > > > re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.
> > >
> > > Correct.
> > >
> > > What I said is like this.
> > >
> > > # touch the timestamp file, %.dtb.checked
> > > $(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE
>
> Not really a fan of the thousands of files that creates. Maybe if it
> was turned into something useful like a list of schemas that apply to
> the dtb. IOW, a dependency list. That would speed up re-running after
> a schema change. Though if a schema change created new dependencies,
> that wouldn't work.
>
> > >         $(call if_changed_rule,dtb_check)
> > >
> > > $(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
> > >         $(call if_changed_rule,dtc)
> > >
> > > $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> > >         $(call if_changed_dep,dtc)
> > >
> > >
> > > With the dtc/check split, we can avoid unneeded regeneration of
> > > %.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
> > > changed.
> > >
> > >
> > > One drawback is we track %.dtb.checked and and %.dtb separately,
> > > so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
> > > may come back.
> >
> > It's up to you and Rob, but I'd really prefer a simpler solution here.
> > Regenerating dtbs sounds like a minor pain compared to hacking the
> > top-level Makefile again. What I really like is that if one has
> > CHECK_DTBS=y (for whatever reason), he can not generate dtb without
> > validation.
>
> I lean towards just rebuilding the dtbs. That's pretty quick and
> ensures we get dtc warnings with schema warnings. In the long run, I
> would like to make the schema checks not optional to run. The
> impediment to doing that is lots of warnings (but not not some
> platforms), adding a tool dependency, and validation time.

Rob, Masahiro, do we have any conclusion here? I can change my patch,
but I'd like to understand in which way I should change it.
Fixing/testing yaml changes is a bit painful w/o this change.

-- 
With best wishes
Dmitry
