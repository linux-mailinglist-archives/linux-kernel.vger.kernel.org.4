Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905A36B986E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCNO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCNO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:59:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1561A49C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:59:36 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8CD91445BB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678805974;
        bh=nF+ggmBWwds1ZYP2z1dvsdxQUR9vO8d2eE2ZJ19uHDk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=CtR3VRxPb6pTtLPP+je5fSDlYNnnHLwdLXaU96a86oMoj5Z3UMC6zyOSXu8x+Mreg
         WDSuqxvP+TC5Q3FUdsxTGRhmyCA11VSIGkRPyRk2hpUH3wawKzuGn37WhQt8OR/HEr
         M1YN7ISynn4rPs78B//Jtx2LiAlZmjLYuxtF8zedTm8GqhOaPOVoMfEEz3za8kELMY
         p6DWjGuyOBPMlNsvFJPy456MK3b0aG2N22VwqAM41JPFSheFwuFKNpJvBtB4+ht4bX
         j1alHZLch3WDD4F/LNXwfXC84sOsin2RWoFJZBQn3Xd841BjHuXG80iDPNkMczLv7T
         k5tF8lkZdiEgg==
Received: by mail-ed1-f69.google.com with SMTP id p36-20020a056402502400b004bb926a3d54so22208604eda.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678805974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nF+ggmBWwds1ZYP2z1dvsdxQUR9vO8d2eE2ZJ19uHDk=;
        b=g05EB/hGRVWoPiSXnM9d1Bqo5s6DnNpkDR83QWDhCj5waWOKGYeuWTqlgmucaTB4cR
         L4AJ1VZjKkhQv1tET7KabkR8rH4hCtSn8vO2MVu4DWZ0riFQs2cYu++FbDs6L+U5KYeW
         HVNdoa/PrelGTHuBeXPW+5orgpFT3KFZdA2lMx4SM2fyBeCoiy9ALN0RwRkoPp8UFb6J
         ikpQNWwq9BUEkQICO+lQxLTIUX5o+CxkNC7CgXhf2kv0upBdvbDHg2xZ33S/qq9Jzfg0
         TTDwG+VbIrPigrnbfN+X+ULKzgufrH6i2dyi5kgc89+tBRf1sIJ9xqyACje25TmvTykj
         +4Sg==
X-Gm-Message-State: AO0yUKW8YsR/mskhQEGOyuTYoZy0+DElhVhSXgTkDxPr/NzzUfNWpa6w
        b5yFQkFd5iYzqqBbog9b3ZpIV0XF70ukdBL3LJIQhhrYFBsM8uZmHqA/FgYrDU7tSpUKtco+119
        NLaa4a03qVWnL5fVWNhq+7ZYNUuO2gTyr53010stECg==
X-Received: by 2002:a17:906:b0cb:b0:8b1:2d0e:281 with SMTP id bk11-20020a170906b0cb00b008b12d0e0281mr2788815ejb.18.1678805973750;
        Tue, 14 Mar 2023 07:59:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set/XTw24LCqFGNaFcrwMcuz5Qf9nJ1bmKJZIJY68sG3doUud9PbveOC4IeN89bxtmEsy9saBSQ==
X-Received: by 2002:a17:906:b0cb:b0:8b1:2d0e:281 with SMTP id bk11-20020a170906b0cb00b008b12d0e0281mr2788791ejb.18.1678805973363;
        Tue, 14 Mar 2023 07:59:33 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b008e53874f8d8sm1235863ejj.180.2023.03.14.07.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:59:33 -0700 (PDT)
Date:   Tue, 14 Mar 2023 15:59:32 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
Message-ID: <ZBCL1G+8z8c6zLI0@righiandr-XPS-13-7390>
References: <20230111161155.1349375-1-gary@garyguo.net>
 <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
 <20230313214853.GY19419@kitsune.suse.cz>
 <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
 <20230313220234.GZ19419@kitsune.suse.cz>
 <ZA+fGpAdnvB5VwKW@righiandr-XPS-13-7390>
 <ZBCG3ykG1q4GEcIf@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBCG3ykG1q4GEcIf@righiandr-XPS-13-7390>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 03:38:24PM +0100, Andrea Righi wrote:
> On Mon, Mar 13, 2023 at 11:09:31PM +0100, Andrea Righi wrote:
> > On Mon, Mar 13, 2023 at 11:02:34PM +0100, Michal Suchánek wrote:
> > > On Mon, Mar 13, 2023 at 10:53:34PM +0100, Andrea Righi wrote:
> > > > On Mon, Mar 13, 2023 at 10:48:53PM +0100, Michal Suchánek wrote:
> > > > > Hello,
> > > > > 
> > > > > On Mon, Mar 13, 2023 at 09:32:16PM +0100, Andrea Righi wrote:
> > > > > > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
> > > > > > > Currently modversion uses a fixed size array of size (64 - sizeof(long))
> > > > > > > to store symbol names, thus placing a hard limit on length of symbols.
> > > > > > > Rust symbols (which encodes crate and module names) can be quite a bit
> > > > > > > longer. The length limit in kallsyms is increased to 512 for this reason.
> > > > > > > 
> > > > > > > It's a waste of space to simply expand the fixed array size to 512 in
> > > > > > > modversion info entries. I therefore make it variably sized, with offset
> > > > > > > to the next entry indicated by the initial "next" field.
> > > > > > > 
> > > > > > > In addition to supporting longer-than-56/60 byte symbols, this patch also
> > > > > > > reduce the size for short symbols by getting rid of excessive 0 paddings.
> > > > > > > There are still some zero paddings to ensure "next" and "crc" fields are
> > > > > > > properly aligned.
> > > > > > > 
> > > > > > > This patch does have a tiny drawback that it makes ".mod.c" files generated
> > > > > > > a bit less easy to read, as code like
> > > > > > > 
> > > > > > > 	"\x08\x00\x00\x00\x78\x56\x34\x12"
> > > > > > > 	"symbol\0\0"
> > > > > > > 
> > > > > > > is generated as opposed to
> > > > > > > 
> > > > > > > 	{ 0x12345678, "symbol" },
> > > > > > > 
> > > > > > > because the structure is now variable-length. But hopefully nobody reads
> > > > > > > the generated file :)
> > > > > > > 
> > > > > > > Link: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")
> > > > > > > Link: https://github.com/Rust-for-Linux/linux/pull/379
> > > > > > > 
> > > > > > > Signed-off-by: Gary Guo <gary@garyguo.net>
> > > > > > 
> > > > > > Is there any newer version of this patch?
> > > > > > 
> > > > > > I'm doing some tests with it, but I'm getting boot failures on ppc64
> > > > > > with this applied (at boot kernel is spitting out lots of oops'es and
> > > > > > unfortunately it's really hard to copy paste or just read them from the
> > > > > > console).
> > > > > 
> > > > > Are you using the ELF ABI v1 or v2?
> > > > > 
> > > > > v1 may have some additional issues when it comes to these symbol tables.
> > > > > 
> > > > > Thanks
> > > > > 
> > > > > Michal
> > > > 
> > > > I have CONFIG_PPC64_ELF_ABI_V2=y in my .config, so I guess I'm using v2.
> > > > 
> > > > BTW, the issue seems to be in dedotify_versions(), as a silly test I
> > > > tried to comment out this function completely to be a no-op and now my
> > > > system boots fine (but I guess I'm probably breaking something else).
> > > 
> > > Probably not. You should not have the extra leading dot on ABI v2. So if
> > > dedotify does something that means something generates and then expects
> > > back symbols with a leading dot, and this workaround for ABI v1 breaks
> > > that. Or maybe it is called when it shouldn't.
> > 
> > Hm.. I'll add some debugging to this function to see what happens exactly.
> 
> Alright I've done more tests across different architectures. My problem
> with ppc64 is that this architecture is evaluating sechdrs[i].sh_size
> using get_stubs_size(), that apparently can add some extra padding, so
> doing (vers + vers->next < end) isn't a reliable check to determine the
> end of the variable array, because sometimes "end" can be greater than
> the last "vers + vers->next" entry.
> 
> In general I think it'd be more reliable to add a dummy NULL entry at
> the end of the modversion array.
> 
> Moreover, I think we also need to enforce struct modversion_info to be
> __packed, just to make sure that no extra padding is added (otherwise it
> may break our logic to determine the offset of the next entry).
> 
> > @@ -2062,16 +2066,25 @@ static void add_versions(struct buffer *b, struct module *mod)
> >  				s->name, mod->name);
> >  			continue;
> >  		}
> > -		if (strlen(s->name) >= MODULE_NAME_LEN) {
> > -			error("too long symbol \"%s\" [%s.ko]\n",
> > -			      s->name, mod->name);
> > -			break;
> > -		}
> > -		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
> > -			   s->crc, s->name);
> > +		name_len = strlen(s->name);
> > +		name_len_padded = (name_len + 1 + 3) & ~3;
> > +
> > +		/* Offset to next entry */
> > +		tmp = TO_NATIVE(8 + name_len_padded);
> 
> ^ Here's another issue that I found, you can't use TO_NATIVE() in this
> way, some compilers are complaining (like on s390x this doesn't build).
> 
> So we need to do something like:
> 
> 	/* Offset to next entry */
> 	tmp = 8 + name_len_padded
> 	tmp = TO_NATIVE(tmp);
> 
> I'll do some additional tests with these changes and send an updated
> patch (for those that are interested).
> 
> -Andrea

In practice, this is what I'm testing at the moment:

---
 arch/powerpc/kernel/module_64.c |  5 +++--
 include/linux/module.h          |  8 +++++---
 kernel/module/version.c         | 22 ++++++++++-----------
 scripts/export_report.pl        |  9 +++++----
 scripts/mod/modpost.c           | 35 +++++++++++++++++++++++----------
 5 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index ff045644f13f..ea6c830ed1e7 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -234,12 +234,13 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 static void dedotify_versions(struct modversion_info *vers,
 			      unsigned long size)
 {
-	struct modversion_info *end;
+	struct modversion_info *end = (void *)vers + size;
 
-	for (end = (void *)vers + size; vers < end; vers++)
+	for (; vers < end && vers->next; vers = (void *)vers + vers->next) {
 		if (vers->name[0] == '.') {
 			memmove(vers->name, vers->name+1, strlen(vers->name));
 		}
+	}
 }
 
 /*
diff --git a/include/linux/module.h b/include/linux/module.h
index 8c5909c0076c..4744901bdf63 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -34,9 +34,11 @@
 #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
 
 struct modversion_info {
-	unsigned long crc;
-	char name[MODULE_NAME_LEN];
-};
+	/* Offset of the next modversion entry in relation to this one. */
+	u32 next;
+	u32 crc;
+	char name[0];
+} __packed;
 
 struct module;
 struct exception_table_entry;
diff --git a/kernel/module/version.c b/kernel/module/version.c
index 53f43ac5a73e..5528f98c42dc 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -17,32 +17,30 @@ int check_version(const struct load_info *info,
 {
 	Elf_Shdr *sechdrs = info->sechdrs;
 	unsigned int versindex = info->index.vers;
-	unsigned int i, num_versions;
-	struct modversion_info *versions;
+	struct modversion_info *versions, *end;
+	u32 crcval;
 
 	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
 	if (!crc)
 		return 1;
+	crcval = *crc;
 
 	/* No versions at all?  modprobe --force does this. */
 	if (versindex == 0)
 		return try_to_force_load(mod, symname) == 0;
 
 	versions = (void *)sechdrs[versindex].sh_addr;
-	num_versions = sechdrs[versindex].sh_size
-		/ sizeof(struct modversion_info);
+	end = (void *)versions + sechdrs[versindex].sh_size;
 
-	for (i = 0; i < num_versions; i++) {
-		u32 crcval;
-
-		if (strcmp(versions[i].name, symname) != 0)
+	for (; versions < end && versions->next;
+	       versions = (void *)versions + versions->next) {
+		if (strcmp(versions->name, symname) != 0)
 			continue;
 
-		crcval = *crc;
-		if (versions[i].crc == crcval)
+		if (versions->crc == crcval)
 			return 1;
-		pr_debug("Found checksum %X vs module %lX\n",
-			 crcval, versions[i].crc);
+		pr_debug("Found checksum %X vs module %X\n",
+			 crcval, versions->crc);
 		goto bad_version;
 	}
 
diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index feb3d5542a62..1117646f3141 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -116,18 +116,19 @@ foreach my $thismod (@allcfiles) {
 	while ( <$module> ) {
 		chomp;
 		if ($state == 0) {
-			$state = 1 if ($_ =~ /static const struct modversion_info/);
+			$state = 1 if ($_ =~ /static const char ____versions/);
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
+			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
 			next;
 		}
 		if ($state == 2) {
-			if ( $_ !~ /0x[0-9a-f]+,/ ) {
+			if ( $_ !~ /\\0"/ ) {
+				last if ($_ =~ /;/);
 				next;
 			}
-			my $sym = (split /([,"])/,)[4];
+			my $sym = (split /(["\\])/,)[2];
 			my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
 			$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
 			push(@{$MODULE{$thismod}} , $sym);
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index efff8078e395..55335ae98f4f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2046,13 +2046,17 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 static void add_versions(struct buffer *b, struct module *mod)
 {
 	struct symbol *s;
+	unsigned int name_len;
+	unsigned int name_len_padded;
+	unsigned int tmp;
+	unsigned char *tmp_view = (unsigned char *)&tmp;
 
 	if (!modversions)
 		return;
 
 	buf_printf(b, "\n");
-	buf_printf(b, "static const struct modversion_info ____versions[]\n");
-	buf_printf(b, "__used __section(\"__versions\") = {\n");
+	buf_printf(b, "static const char ____versions[]\n");
+	buf_printf(b, "__used __section(\"__versions\") =\n");
 
 	list_for_each_entry(s, &mod->unresolved_symbols, list) {
 		if (!s->module)
@@ -2062,16 +2066,27 @@ static void add_versions(struct buffer *b, struct module *mod)
 				s->name, mod->name);
 			continue;
 		}
-		if (strlen(s->name) >= MODULE_NAME_LEN) {
-			error("too long symbol \"%s\" [%s.ko]\n",
-			      s->name, mod->name);
-			break;
-		}
-		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
-			   s->crc, s->name);
+		name_len = strlen(s->name);
+		name_len_padded = (name_len + 1 + 3) & ~3;
+
+		/* Offset to next entry */
+		tmp = 8 + name_len_padded;
+		tmp = TO_NATIVE(tmp);
+		buf_printf(b, "\t\"\\x%02x\\x%02x\\x%02x\\x%02x",
+			   tmp_view[0], tmp_view[1], tmp_view[2], tmp_view[3]);
+
+		tmp = TO_NATIVE(s->crc);
+		buf_printf(b, "\\x%02x\\x%02x\\x%02x\\x%02x\"\n",
+			   tmp_view[0], tmp_view[1], tmp_view[2], tmp_view[3]);
+
+		buf_printf(b, "\t\"%s", s->name);
+		for (; name_len < name_len_padded; name_len++)
+			buf_printf(b, "\\0");
+		buf_printf(b, "\"\n");
 	}
 
-	buf_printf(b, "};\n");
+	/* Always end with a dummy NULL entry */
+	buf_printf(b, "\t\"\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\";\n");
 }
 
 static void add_depends(struct buffer *b, struct module *mod)
-- 
2.39.2

