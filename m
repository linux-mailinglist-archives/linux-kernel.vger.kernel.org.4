Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5F5B9420
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIOGIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIOGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:08:02 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07385FBA;
        Wed, 14 Sep 2022 23:08:00 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28F67k11009843;
        Thu, 15 Sep 2022 15:07:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28F67k11009843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663222067;
        bh=6PV3lcHHOxzv/duhBj26ubq4AwvvBnQo7b4k6YgkWkw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZmvHy3tfUylWoK4jmbrtmC0qLP9DHMDcpcNimJDgXObiy05ujQPfFU5UJtbppJLjr
         0vCTtZrmAiF4yvghOyBP1bCN15PDj3VyQl1Gs1vXf4FkL0Lg1scBH5YTYKLW0W+EQy
         ywXTOevmWjonPl3LUQyv804L+ea6nWQuSb6FOS2Qi0eSj8B4pXW7PadyTX9eoErJZU
         J/JW1Yu8atheMNYPc8dNiGzGlz8xOxpKNx0HwvbAcd+ljKJxoU1vnUpAErJSOFI0kW
         Dfmzpwi28f3q6ho9kGjgyZZn3Sf9zuEYD89ycfHece5hMz0wgziQT8KoOCLvdPW23R
         uvwJ/nZRfIK7Q==
X-Nifty-SrcIP: [209.85.160.47]
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-127dca21a7dso46015406fac.12;
        Wed, 14 Sep 2022 23:07:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo0Ww+0teShAy4RJafUpSSmqZsegmzc5dbrKL9RH4LD5zy/F9Lls
        yJSr0vHnFkvrMJmv+sHKRApfFtsyRkqAD/ofZKo=
X-Google-Smtp-Source: AA6agR5WmZPYNskXyaJDbPSbLnZqaSGxs5J9raWGX0OrWsvG171H9Sf4OXvGnEYaIZQpxqzdRMcPphnpRF51y0HITmE=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr4373555oab.287.1663222065381; Wed, 14
 Sep 2022 23:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220906193436.2135744-1-masahiroy@kernel.org> <CAKwvOdnhW7j0y_DH5W42VBsODH1BN01hSGiTXFF1KiW1w__twA@mail.gmail.com>
In-Reply-To: <CAKwvOdnhW7j0y_DH5W42VBsODH1BN01hSGiTXFF1KiW1w__twA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 15 Sep 2022 15:07:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8nc5xr1Cjs568VGoNshTSdFg31abn_fe-+ZeZsRN3yg@mail.gmail.com>
Message-ID: <CAK7LNAQ8nc5xr1Cjs568VGoNshTSdFg31abn_fe-+ZeZsRN3yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: use modpost-args-y to clean up modpost arguments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 2:26 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Sep 6, 2022 at 12:35 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Separate the modpost executable (scripts/mod/modpost) and the command
> > parameters for the next commit.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                 |  2 +-
> >  scripts/Makefile.modpost | 22 +++++++++++-----------
> >  2 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index aee4f0769d9d..e07236209606 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1908,7 +1908,7 @@ tags TAGS cscope gtags: FORCE
> >  # ---------------------------------------------------------------------------
> >
> >  PHONY += nsdeps
> > -nsdeps: export KBUILD_NSDEPS=1
> > +nsdeps: export KBUILD_NSDEPS=y
> >  nsdeps: modules
> >         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/nsdeps
> >
> > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > index ceb1d78140e7..87821a5fe16b 100644
> > --- a/scripts/Makefile.modpost
> > +++ b/scripts/Makefile.modpost
> > @@ -38,17 +38,17 @@ __modpost:
> >  include include/config/auto.conf
> >  include $(srctree)/scripts/Kbuild.include
> >
> > -MODPOST = scripts/mod/modpost                                                          \
> > -       $(if $(CONFIG_MODVERSIONS),-m)                                                  \
> > -       $(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)                                        \
> > -       $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)                                  \
> > -       $(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))                                     \
> > -       $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)       \
> > -       -o $@
> > +MODPOST = scripts/mod/modpost
> > +
> > +modpost-args-$(CONFIG_MODVERSIONS)                             += -m
> > +modpost-args-$(CONFIG_MODULE_SRCVERSION_ALL)                   += -a
> > +modpost-args-$(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)  += -N
> > +modpost-args-$(KBUILD_NSDEPS)                                  += -N -d $(MODULES_NSDEPS)
>
> Was it intentional that you included -N for KBUILD_NSDEPS?


Yes.
See $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS)
in the original code.


> That seems
> like a change in behavior.  Everything else LGTM but that.


No behavior change.


If both CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
and KBUILD_NSDEPS are defined, -N was previously passed
just once, but now twice.
This is a slight change, but behavior is still the same.





> > +modpost-args-y += $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)
>
> Ugh, your pattern kind of falls apart for the above ^.  Maybe this is
> the most concise way to express this, but boy I sure do sometimes wish
> for a programming language that had booleans and simple negation.
> Maybe I would regret that in a build system...
> --
> Thanks,
> ~Nick Desaulniers


I do not think CONFIG_SECTION_MISMATCH_WARN_ONLY will live long,
but a cleaner fix is to stop negating the option.

Anyway, I do not care about that.







diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 911606496341..c5a18920646d 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -44,7 +44,7 @@ include $(srctree)/scripts/Kbuild.include
 MODPOST = scripts/mod/modpost
                 \
        $(if $(CONFIG_MODVERSIONS),-m)
                 \
        $(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)
                 \
-       $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)
                 \
+       $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),-E)
                 \
        -o $@

 ifdef MODPOST_VMLINUX
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c3..be55dd541055 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -33,7 +33,7 @@ static bool external_module;
 static bool warn_unresolved;

 static int sec_mismatch_count;
-static bool sec_mismatch_warn_only = true;
+static bool sec_mismatch_warn_only;
 /* ignore missing files */
 static bool ignore_missing_files;
 /* If set to 1, only warn (instead of error) about missing ns imports */
@@ -2355,7 +2355,7 @@ int main(int argc, char **argv)
                        warn_unresolved = true;
                        break;
                case 'E':
-                       sec_mismatch_warn_only = false;
+                       sec_mismatch_warn_only = true;
                        break;
                case 'N':
                        allow_missing_ns_imports = true;



























-- 
Best Regards
Masahiro Yamada
