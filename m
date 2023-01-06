Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8165FE16
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjAFJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjAFJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:36:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30458CD18;
        Fri,  6 Jan 2023 01:28:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id az7so742143wrb.5;
        Fri, 06 Jan 2023 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF+G5asw3DoV5tASGaVh4EvguMJNhCFhpdQC68+023Y=;
        b=XM4Qf4iRjjxPBGacWTyTDOFT2kNDaYpVffQQFxL2scN4Bf4Ssng4LMa58HBF0Iou+A
         GUIZJvVNJJlk/4UEHkOBqsbX4UknOA8FjUehttLOvpTmuf16IbgBRNkQlPT3D6X0z7Fl
         uzGTsjd8XTEAVsafXIvPmpYzqcBopxZhwf92jtBEkJbUSPfdBahnxQws2rS7fcjmcKMl
         lVhlPQWyx2AlKoHfc+PadyJEeC4n4x8rBj5XDvV0pMAc4D/0Uq+z7xZ1tEgkmQQ4AOKu
         p3sUM3zrXDt+7vqqd7YOgWb+8rSBfATrDdUdR/ujz/f9D4A7xCmI1dZfPbqQQ//ZNwsD
         vaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rF+G5asw3DoV5tASGaVh4EvguMJNhCFhpdQC68+023Y=;
        b=ixx8urqMnDAfAd+Qb+BnOi3B1OaPnE9dmJVriGLJLkUyifFaIEBuJc2GBEBNPlq08Y
         7+sHN4sFAHn6pyiYM/M52RgckGRR0Ya3mlzLGp3ipJyN8SGJscRzPYhF0ynqwZ7MceTR
         ZxF3QedkGLiGdkFtap7Et70VSDHYoYgOG0n8M7LZu22eBHJxfH6OgRm4wvAKyT9w3o5v
         vO2bTqnosfd2pdGfbIgnLy3LW9Q/dLltdCPEhQMhxmhpBkurR+Br9PqUMm4PKYBuBUZY
         78CrKBj70SuQXVxS90L/R4DgQanSaLEt8fW5GWugvPNzL87PxqxKYZu8dUdyfBRjtRxz
         RgOQ==
X-Gm-Message-State: AFqh2koomrXDd+IJZrzOLAZNHC4cfB4dsSXssj4uQIR8gGpEUlVoIBzl
        Y8lahjgEK0WD/5f8T/TBVL8=
X-Google-Smtp-Source: AMrXdXuzlefAg6IUnUhQtdPsdVg1KlLam/tUTNrs801ZkcpkanATPiMDXUG0G8wmoRgIba017k6z3g==
X-Received: by 2002:a5d:564e:0:b0:27d:59a5:28bc with SMTP id j14-20020a5d564e000000b0027d59a528bcmr25814037wrw.35.1672997284118;
        Fri, 06 Jan 2023 01:28:04 -0800 (PST)
Received: from localhost ([217.138.219.182])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm682834wrj.2.2023.01.06.01.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 01:28:03 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 06 Jan 2023 10:28:00 +0100
Message-Id: <CPL01GLA72E1.N4D1Z43Y3NY@vincent>
Subject: Re: [PATCH 3/6] kbuild: remove sed commands after rustc rules
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        <linux-kbuild@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>, "Tom Rix" <trix@redhat.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <llvm@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20221231064203.1623793-1-masahiroy@kernel.org>
 <20221231064203.1623793-4-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-4-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

> rustc may put comments in dep-info, so sed is used to drop them before
> passing it to fixdep.
>
> Now that fixdep can remove comments, Makefiles do not need to run sed.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  rust/Makefile          |  6 ++----
>  scripts/Makefile.build | 18 ++++--------------
>  scripts/Makefile.host  |  3 +--
>  3 files changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 0e2a32f4b3e9..c8941fec6955 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -333,8 +333,7 @@ quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET=
) P $@
>  	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
>  		--emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --extern proc_macro =
\
>  		--crate-type proc-macro \
> -		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<; \
> -	sed -i '/^\#/d' $(depfile)
> +		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> =20
>  # Procedural macros can only be used with the `rustc` that compiled it.
>  # Therefore, to get `libmacros.so` automatically recompiled when the com=
piler
> @@ -349,8 +348,7 @@ quiet_cmd_rustc_library =3D $(if $(skip_clippy),RUSTC=
,$(RUSTC_OR_CLIPPY_QUIET)) L
>  		$(filter-out $(skip_flags),$(rust_flags) $(rustc_target_flags)) \
>  		--emit=3Ddep-info=3D$(depfile) --emit=3Dobj=3D$@ --emit=3Dmetadata=3D$=
(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
>  		--crate-type rlib -L$(objtree)/$(obj) \
> -		--crate-name $(patsubst %.o,%,$(notdir $@)) $<; \
> -	sed -i '/^\#/d' $(depfile) \
> +		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
>  	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
> =20
>  rust-analyzer:
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 40de20246e50..76323201232a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -289,9 +289,6 @@ rust_common_cmd =3D \
>  	--crate-name $(basename $(notdir $@)) \
>  	--emit=3Ddep-info=3D$(depfile)
> =20
> -rust_handle_depfile =3D \
> -	sed -i '/^\#/d' $(depfile)
> -
>  # `--emit=3Dobj`, `--emit=3Dasm` and `--emit=3Dllvm-ir` imply a single c=
odegen unit
>  # will be used. We explicitly request `-Ccodegen-units=3D1` in any case,=
 and
>  # the compiler shows a warning if it is not 1. However, if we ever stop
> @@ -301,9 +298,7 @@ rust_handle_depfile =3D \
>  # would not match each other.
> =20
>  quiet_cmd_rustc_o_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
> -      cmd_rustc_o_rs =3D \
> -	$(rust_common_cmd) --emit=3Dobj=3D$@ $<; \
> -	$(rust_handle_depfile)
> +      cmd_rustc_o_rs =3D $(rust_common_cmd) --emit=3Dobj=3D$@ $<
> =20
>  $(obj)/%.o: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_o_rs)
> @@ -311,24 +306,19 @@ $(obj)/%.o: $(src)/%.rs FORCE
>  quiet_cmd_rustc_rsi_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>        cmd_rustc_rsi_rs =3D \
>  	$(rust_common_cmd) -Zunpretty=3Dexpanded $< >$@; \
> -	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@; \
> -	$(rust_handle_depfile)
> +	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
> =20
>  $(obj)/%.rsi: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_rsi_rs)
> =20
>  quiet_cmd_rustc_s_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
> -      cmd_rustc_s_rs =3D \
> -	$(rust_common_cmd) --emit=3Dasm=3D$@ $<; \
> -	$(rust_handle_depfile)
> +      cmd_rustc_s_rs =3D $(rust_common_cmd) --emit=3Dasm=3D$@ $<
> =20
>  $(obj)/%.s: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_s_rs)
> =20
>  quiet_cmd_rustc_ll_rs =3D $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
> -      cmd_rustc_ll_rs =3D \
> -	$(rust_common_cmd) --emit=3Dllvm-ir=3D$@ $<; \
> -	$(rust_handle_depfile)
> +      cmd_rustc_ll_rs =3D $(rust_common_cmd) --emit=3Dllvm-ir=3D$@ $<
> =20
>  $(obj)/%.ll: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_ll_rs)
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 4434cdbf7b8e..bc782655d09e 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -148,8 +148,7 @@ $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
>  # host-rust -> Executable
>  quiet_cmd_host-rust	=3D HOSTRUSTC $@
>        cmd_host-rust	=3D \
> -	$(HOSTRUSTC) $(hostrust_flags) --emit=3Dlink=3D$@ $<; \
> -	sed -i '/^\#/d' $(depfile)
> +	$(HOSTRUSTC) $(hostrust_flags) --emit=3Dlink=3D$@ $<
>  $(host-rust): $(obj)/%: $(src)/%.rs FORCE
>  	$(call if_changed_dep,host-rust)
> =20
> --=20
> 2.34.1

