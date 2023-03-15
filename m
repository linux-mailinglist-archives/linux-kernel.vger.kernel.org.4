Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1F6BA3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCOAPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCOAPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:15:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF51279A7;
        Tue, 14 Mar 2023 17:15:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so76469wmb.5;
        Tue, 14 Mar 2023 17:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678839305;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3awC0gMPAiPXnlm6wKZJyVsjNQ276k/08Eimwgsa2PY=;
        b=qvmwb0/PxDkWj/0STg/wCTEyGg8MPkbhQVsg70PSBLJukww9j8oQCmHhUNMk6OXtjj
         mksE1fmju6ez2ur6MvSDX+1u4Qg8DLq9xRsNEf8pe4UjfOsVumNrY3kAGzz4ZTqAhRm+
         IQLAuvp4R2VgBIagDb6WaTjFiHpQTl+9R5aO46IxdzzomgiOooAoKIShp5o54e5cjqpv
         szMrLSZgQ4EdAagUmNvqNn2bD7ODX6+TEyEbxRRojuxWSzYLSvg+GxXgIdfYm2kxwgVT
         m6K+j6JxckWHZlonHB95o3vpCgFMoBaxVQTSmeEHMSSjljqLjejB+Fnc7sDDVxBMxQcR
         P/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678839305;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3awC0gMPAiPXnlm6wKZJyVsjNQ276k/08Eimwgsa2PY=;
        b=WVSIY0YVNEeDJ/G3ebZ1TAKnDaR6bU0AtrB5T7bMi3a5v3YaQUobrUUJGHooy2p6/6
         MQgBW8NAJMeMSHI35hDP4V6pMfHtuobXEgf1DcGTXKOZdJzoj+ybrzIg9qO07jzRoc1i
         uq9/7aaBb1ltlc/CG4cQrWg6l6w77k730SOXm84Kpoty0vX8DluU4qaVLeCvUun0uE1n
         qNHq6F3zP0lapMDPWRB37kHtp3VV82OnCN57GWXrFFfImXG8jnQedkBSqCFzQsjH1Lyj
         GRvXV7xg+WQJkaPR8N4FibBUJp2HF5jSJ21uKj/LUZxWtTHmlpbc5Z2NpNGPcfdYuGXH
         Hk7g==
X-Gm-Message-State: AO0yUKV5BiyZ8z7rDRGFotsRw7IqsEt1n6LiRKat7E51QkAaYjNGYLjv
        kWdv+yrZcbTLXS0zO4mO0w4=
X-Google-Smtp-Source: AK7set9z+WtrIevyfgj0uiVN2/U69pNjGkpvV5AmeeklAczYUZcRXbCkH10sq6c4Hml5XTZPzgMDVg==
X-Received: by 2002:a05:600c:3b9d:b0:3ed:29db:cb80 with SMTP id n29-20020a05600c3b9d00b003ed29dbcb80mr6153512wms.18.1678839305389;
        Tue, 14 Mar 2023 17:15:05 -0700 (PDT)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003e20cf0408esm72131wmj.40.2023.03.14.17.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 17:15:04 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Mar 2023 01:15:03 +0100
Message-Id: <CR6IV4NTEN8Z.1V1RNR667SWJ7@vincent-arch>
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Andrea Righi" <andrea.righi@canonical.com>,
        =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     "Gary Guo" <gary@garyguo.net>, "Kees Cook" <keescook@chromium.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        <linux-kbuild@vger.kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@google.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <rust-for-linux@vger.kernel.org>,
        "Guo Zhengkui" <guozhengkui@vivo.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-modules@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230111161155.1349375-1-gary@garyguo.net>
 <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
 <20230313214853.GY19419@kitsune.suse.cz>
 <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
 <20230313220234.GZ19419@kitsune.suse.cz>
 <ZA+fGpAdnvB5VwKW@righiandr-XPS-13-7390>
 <ZBCG3ykG1q4GEcIf@righiandr-XPS-13-7390>
 <ZBCL1G+8z8c6zLI0@righiandr-XPS-13-7390>
In-Reply-To: <ZBCL1G+8z8c6zLI0@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In practice, this is what I'm testing at the moment:
>
> ---
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module=
_64.c
> index ff045644f13f..ea6c830ed1e7 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -234,12 +234,13 @@ static unsigned long get_stubs_size(const Elf64_Ehd=
r *hdr,
>  static void dedotify_versions(struct modversion_info *vers,
>  			      unsigned long size)
>  {
> -	struct modversion_info *end;
> +	struct modversion_info *end =3D (void *)vers + size;
> =20
> -	for (end =3D (void *)vers + size; vers < end; vers++)
> +	for (; vers < end && vers->next; vers =3D (void *)vers + vers->next) {
>  		if (vers->name[0] =3D=3D '.') {
>  			memmove(vers->name, vers->name+1, strlen(vers->name));
>  		}
> +	}
>  }
> =20
>  /*
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8c5909c0076c..4744901bdf63 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -34,9 +34,11 @@
>  #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
> =20
>  struct modversion_info {
> -	unsigned long crc;
> -	char name[MODULE_NAME_LEN];
> -};
> +	/* Offset of the next modversion entry in relation to this one. */
> +	u32 next;
> +	u32 crc;
> +	char name[0];
> +} __packed;
> =20
>  struct module;
>  struct exception_table_entry;
> diff --git a/kernel/module/version.c b/kernel/module/version.c
> index 53f43ac5a73e..5528f98c42dc 100644
> --- a/kernel/module/version.c
> +++ b/kernel/module/version.c
> @@ -17,32 +17,30 @@ int check_version(const struct load_info *info,
>  {
>  	Elf_Shdr *sechdrs =3D info->sechdrs;
>  	unsigned int versindex =3D info->index.vers;
> -	unsigned int i, num_versions;
> -	struct modversion_info *versions;
> +	struct modversion_info *versions, *end;
> +	u32 crcval;
> =20
>  	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
>  	if (!crc)
>  		return 1;
> +	crcval =3D *crc;
> =20
>  	/* No versions at all?  modprobe --force does this. */
>  	if (versindex =3D=3D 0)
>  		return try_to_force_load(mod, symname) =3D=3D 0;
> =20
>  	versions =3D (void *)sechdrs[versindex].sh_addr;
> -	num_versions =3D sechdrs[versindex].sh_size
> -		/ sizeof(struct modversion_info);
> +	end =3D (void *)versions + sechdrs[versindex].sh_size;
> =20
> -	for (i =3D 0; i < num_versions; i++) {
> -		u32 crcval;
> -
> -		if (strcmp(versions[i].name, symname) !=3D 0)
> +	for (; versions < end && versions->next;
> +	       versions =3D (void *)versions + versions->next) {
> +		if (strcmp(versions->name, symname) !=3D 0)
>  			continue;
> =20
> -		crcval =3D *crc;
> -		if (versions[i].crc =3D=3D crcval)
> +		if (versions->crc =3D=3D crcval)
>  			return 1;
> -		pr_debug("Found checksum %X vs module %lX\n",
> -			 crcval, versions[i].crc);
> +		pr_debug("Found checksum %X vs module %X\n",
> +			 crcval, versions->crc);
>  		goto bad_version;
>  	}
> =20
> diff --git a/scripts/export_report.pl b/scripts/export_report.pl
> index feb3d5542a62..1117646f3141 100755
> --- a/scripts/export_report.pl
> +++ b/scripts/export_report.pl
> @@ -116,18 +116,19 @@ foreach my $thismod (@allcfiles) {
>  	while ( <$module> ) {
>  		chomp;
>  		if ($state =3D=3D 0) {
> -			$state =3D 1 if ($_ =3D~ /static const struct modversion_info/);
> +			$state =3D 1 if ($_ =3D~ /static const char ____versions/);
>  			next;
>  		}
>  		if ($state =3D=3D 1) {
> -			$state =3D 2 if ($_ =3D~ /__attribute__\(\(section\("__versions"\)\)\=
)/);
> +			$state =3D 2 if ($_ =3D~ /__used __section\("__versions"\)/);
>  			next;
>  		}
>  		if ($state =3D=3D 2) {
> -			if ( $_ !~ /0x[0-9a-f]+,/ ) {
> +			if ( $_ !~ /\\0"/ ) {
> +				last if ($_ =3D~ /;/);
>  				next;
>  			}
> -			my $sym =3D (split /([,"])/,)[4];
> +			my $sym =3D (split /(["\\])/,)[2];
>  			my ($module, $value, $symbol, $gpl) =3D @{$SYMBOL{$sym}};
>  			$SYMBOL{ $sym } =3D  [ $module, $value+1, $symbol, $gpl];
>  			push(@{$MODULE{$thismod}} , $sym);
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index efff8078e395..55335ae98f4f 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2046,13 +2046,17 @@ static void add_exported_symbols(struct buffer *b=
uf, struct module *mod)
>  static void add_versions(struct buffer *b, struct module *mod)
>  {
>  	struct symbol *s;
> +	unsigned int name_len;
> +	unsigned int name_len_padded;
> +	unsigned int tmp;
> +	unsigned char *tmp_view =3D (unsigned char *)&tmp;
> =20
>  	if (!modversions)
>  		return;
> =20
>  	buf_printf(b, "\n");
> -	buf_printf(b, "static const struct modversion_info ____versions[]\n");
> -	buf_printf(b, "__used __section(\"__versions\") =3D {\n");
> +	buf_printf(b, "static const char ____versions[]\n");
> +	buf_printf(b, "__used __section(\"__versions\") =3D\n");
> =20
>  	list_for_each_entry(s, &mod->unresolved_symbols, list) {
>  		if (!s->module)
> @@ -2062,16 +2066,27 @@ static void add_versions(struct buffer *b, struct=
 module *mod)
>  				s->name, mod->name);
>  			continue;
>  		}
> -		if (strlen(s->name) >=3D MODULE_NAME_LEN) {
> -			error("too long symbol \"%s\" [%s.ko]\n",
> -			      s->name, mod->name);
> -			break;
> -		}
> -		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
> -			   s->crc, s->name);
> +		name_len =3D strlen(s->name);
> +		name_len_padded =3D (name_len + 1 + 3) & ~3;
> +
> +		/* Offset to next entry */
> +		tmp =3D 8 + name_len_padded;
> +		tmp =3D TO_NATIVE(tmp);
> +		buf_printf(b, "\t\"\\x%02x\\x%02x\\x%02x\\x%02x",
> +			   tmp_view[0], tmp_view[1], tmp_view[2], tmp_view[3]);
> +
> +		tmp =3D TO_NATIVE(s->crc);
> +		buf_printf(b, "\\x%02x\\x%02x\\x%02x\\x%02x\"\n",
> +			   tmp_view[0], tmp_view[1], tmp_view[2], tmp_view[3]);
> +
> +		buf_printf(b, "\t\"%s", s->name);
> +		for (; name_len < name_len_padded; name_len++)
> +			buf_printf(b, "\\0");
> +		buf_printf(b, "\"\n");
>  	}
> =20
> -	buf_printf(b, "};\n");
> +	/* Always end with a dummy NULL entry */
> +	buf_printf(b, "\t\"\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\";\n");
>  }
> =20
>  static void add_depends(struct buffer *b, struct module *mod)
This looks promissing, do you had a small reproducer to this just to
make the code a little bit clearn to the reader?

Ciao,=20

Vincent.
