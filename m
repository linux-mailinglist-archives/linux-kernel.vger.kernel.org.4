Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA7662C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjAIRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjAIRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:12:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17E26D3;
        Mon,  9 Jan 2023 09:10:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D70F761226;
        Mon,  9 Jan 2023 17:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE6DC433F1;
        Mon,  9 Jan 2023 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673284255;
        bh=oTRkQyMF2DjGCawOHegpUvhRGt2ypHnFvhlRYLqVs0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtNz0MLzegDV1DqfOGWuVF2pDOw09yDd7OKJHG6QPsoLSeAwWokuWWIqo2KDraxDr
         dgl+9bcjqqT5aifqPVOSKY6dDhlGqnigRmne7OThzQbydANXELK/cOdp9bJHe8RE4k
         J8z03Hn1/tRPH8iqXmKyFwGgpv/HoaGlZ/ySf+JSdfbDmx+lMlr7VLoe+SROLNVrLj
         1UkXdepbasIAP74XviavJ9EPoH5ikIybGqlQO/w8NutRptVEkNq2uiGUq5q9ynymLZ
         lasiB0cZwsBxaaB8LoTYcUUUi58DjTDa09tjvdduuvyKcNJQm8xfj/5amD2YhWLc7V
         S2WBDTwafnp7w==
Date:   Mon, 9 Jan 2023 10:10:52 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: rust: remove -v option of
 scripts/rust_is_available.sh
Message-ID: <Y7xKnFsDd5Vlqt4I@dev-arch.thelio-3990X>
References: <20230109061436.3146442-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109061436.3146442-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 03:14:36PM +0900, Masahiro Yamada wrote:
> The -v option is passed when this script is invoked from Makefile,
> but not when invoked from Kconfig.
> 
> As you can see in scripts/Kconfig.include, the 'success' macro suppresses
> stdout and stderr anyway, so this script does not need to be quiet.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> Changes in v2:
>   - Fix description (scripts -> script)
>   - Remove stale comment
> 
>  Makefile                     |  4 +-
>  scripts/rust_is_available.sh | 96 +++++++++++++++---------------------
>  2 files changed, 42 insertions(+), 58 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index c1f59f54ae90..59d827b85888 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1288,7 +1288,7 @@ prepare0: archprepare
>  # All the preparing..
>  prepare: prepare0
>  ifdef CONFIG_RUST
> -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh -v
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
>  	$(Q)$(MAKE) $(build)=rust
>  endif
>  
> @@ -1813,7 +1813,7 @@ $(DOC_TARGETS):
>  # "Is Rust available?" target
>  PHONY += rustavailable
>  rustavailable:
> -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh -v && echo "Rust is available!"
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh && echo "Rust is available!"
>  
>  # Documentation target
>  #
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index aebbf1913970..f43a010eaf30 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -2,8 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Tests whether a suitable Rust toolchain is available.
> -#
> -# Pass `-v` for human output and more checks (as warnings).
>  
>  set -e
>  
> @@ -23,21 +21,17 @@ get_canonical_version()
>  
>  # Check that the Rust compiler exists.
>  if ! command -v "$RUSTC" >/dev/null; then
> -	if [ "$1" = -v ]; then
> -		echo >&2 "***"
> -		echo >&2 "*** Rust compiler '$RUSTC' could not be found."
> -		echo >&2 "***"
> -	fi
> +	echo >&2 "***"
> +	echo >&2 "*** Rust compiler '$RUSTC' could not be found."
> +	echo >&2 "***"
>  	exit 1
>  fi
>  
>  # Check that the Rust bindings generator exists.
>  if ! command -v "$BINDGEN" >/dev/null; then
> -	if [ "$1" = -v ]; then
> -		echo >&2 "***"
> -		echo >&2 "*** Rust bindings generator '$BINDGEN' could not be found."
> -		echo >&2 "***"
> -	fi
> +	echo >&2 "***"
> +	echo >&2 "*** Rust bindings generator '$BINDGEN' could not be found."
> +	echo >&2 "***"
>  	exit 1
>  fi
>  
> @@ -53,16 +47,14 @@ rust_compiler_min_version=$($min_tool_version rustc)
>  rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
>  rust_compiler_min_cversion=$(get_canonical_version $rust_compiler_min_version)
>  if [ "$rust_compiler_cversion" -lt "$rust_compiler_min_cversion" ]; then
> -	if [ "$1" = -v ]; then
> -		echo >&2 "***"
> -		echo >&2 "*** Rust compiler '$RUSTC' is too old."
> -		echo >&2 "***   Your version:    $rust_compiler_version"
> -		echo >&2 "***   Minimum version: $rust_compiler_min_version"
> -		echo >&2 "***"
> -	fi
> +	echo >&2 "***"
> +	echo >&2 "*** Rust compiler '$RUSTC' is too old."
> +	echo >&2 "***   Your version:    $rust_compiler_version"
> +	echo >&2 "***   Minimum version: $rust_compiler_min_version"
> +	echo >&2 "***"
>  	exit 1
>  fi
> -if [ "$1" = -v ] && [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
> +if [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
>  	echo >&2 "***"
>  	echo >&2 "*** Rust compiler '$RUSTC' is too new. This may or may not work."
>  	echo >&2 "***   Your version:     $rust_compiler_version"
> @@ -82,16 +74,14 @@ rust_bindings_generator_min_version=$($min_tool_version bindgen)
>  rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
>  rust_bindings_generator_min_cversion=$(get_canonical_version $rust_bindings_generator_min_version)
>  if [ "$rust_bindings_generator_cversion" -lt "$rust_bindings_generator_min_cversion" ]; then
> -	if [ "$1" = -v ]; then
> -		echo >&2 "***"
> -		echo >&2 "*** Rust bindings generator '$BINDGEN' is too old."
> -		echo >&2 "***   Your version:    $rust_bindings_generator_version"
> -		echo >&2 "***   Minimum version: $rust_bindings_generator_min_version"
> -		echo >&2 "***"
> -	fi
> +	echo >&2 "***"
> +	echo >&2 "*** Rust bindings generator '$BINDGEN' is too old."
> +	echo >&2 "***   Your version:    $rust_bindings_generator_version"
> +	echo >&2 "***   Minimum version: $rust_bindings_generator_min_version"
> +	echo >&2 "***"
>  	exit 1
>  fi
> -if [ "$1" = -v ] && [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cversion" ]; then
> +if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cversion" ]; then
>  	echo >&2 "***"
>  	echo >&2 "*** Rust bindings generator '$BINDGEN' is too new. This may or may not work."
>  	echo >&2 "***   Your version:     $rust_bindings_generator_version"
> @@ -110,13 +100,11 @@ bindgen_libclang_min_version=$($min_tool_version llvm)
>  bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
>  bindgen_libclang_min_cversion=$(get_canonical_version $bindgen_libclang_min_version)
>  if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
> -	if [ "$1" = -v ]; then
> -		echo >&2 "***"
> -		echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN') is too old."
> -		echo >&2 "***   Your version:    $bindgen_libclang_version"
> -		echo >&2 "***   Minimum version: $bindgen_libclang_min_version"
> -		echo >&2 "***"
> -	fi
> +	echo >&2 "***"
> +	echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN') is too old."
> +	echo >&2 "***   Your version:    $bindgen_libclang_version"
> +	echo >&2 "***   Minimum version: $bindgen_libclang_min_version"
> +	echo >&2 "***"
>  	exit 1
>  fi
>  
> @@ -125,21 +113,19 @@ fi
>  #
>  # In the future, we might be able to perform a full version check, see
>  # https://github.com/rust-lang/rust-bindgen/issues/2138.
> -if [ "$1" = -v ]; then
> -	cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
> -	if [ "$cc_name" = Clang ]; then
> -		clang_version=$( \
> -			LC_ALL=C "$CC" --version 2>/dev/null \
> -				| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
> -		)
> -		if [ "$clang_version" != "$bindgen_libclang_version" ]; then
> -			echo >&2 "***"
> -			echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN')"
> -			echo >&2 "*** version does not match Clang's. This may be a problem."
> -			echo >&2 "***   libclang version: $bindgen_libclang_version"
> -			echo >&2 "***   Clang version:    $clang_version"
> -			echo >&2 "***"
> -		fi
> +cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
> +if [ "$cc_name" = Clang ]; then
> +	clang_version=$( \
> +		LC_ALL=C "$CC" --version 2>/dev/null \
> +			| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
> +	)
> +	if [ "$clang_version" != "$bindgen_libclang_version" ]; then
> +		echo >&2 "***"
> +		echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN')"
> +		echo >&2 "*** version does not match Clang's. This may be a problem."
> +		echo >&2 "***   libclang version: $bindgen_libclang_version"
> +		echo >&2 "***   Clang version:    $clang_version"
> +		echo >&2 "***"
>  	fi
>  fi
>  
> @@ -150,11 +136,9 @@ rustc_sysroot=$("$RUSTC" $KRUSTFLAGS --print sysroot)
>  rustc_src=${RUST_LIB_SRC:-"$rustc_sysroot/lib/rustlib/src/rust/library"}
>  rustc_src_core="$rustc_src/core/src/lib.rs"
>  if [ ! -e "$rustc_src_core" ]; then
> -	if [ "$1" = -v ]; then
> -		echo >&2 "***"
> -		echo >&2 "*** Source code for the 'core' standard library could not be found"
> -		echo >&2 "*** at '$rustc_src_core'."
> -		echo >&2 "***"
> -	fi
> +	echo >&2 "***"
> +	echo >&2 "*** Source code for the 'core' standard library could not be found"
> +	echo >&2 "*** at '$rustc_src_core'."
> +	echo >&2 "***"
>  	exit 1
>  fi
> -- 
> 2.34.1
> 
