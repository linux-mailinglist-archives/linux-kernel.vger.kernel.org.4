Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560F56B8485
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCMWJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCMWJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:09:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1F222ED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:09:33 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2179D442D7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678745372;
        bh=EBMHeYCeRHGu2+rLkZfqPcI8agcZPwmUe8po8kQpky8=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=hQyuWLo/Zpp4zyc9Tx6w+ufJ49Kcxmv29NX6br8S4BVgoPz8Vm8MrH3HoS/u0jIqk
         co0a8MZSLzofnaUa96cBX24gPYVfu95XypQzLp4SQPOfmcVrn4pK4tNDhE/ljAfhha
         nK9FO5428wwc91KzeSWZUrBk9Eh2fLuvsH+ocaurwfC0W9h/H5GJAGq0DuZ20NMiMX
         e/Epi5T0pZIf6y8L2Ydx31+TJnAAm6GBi2WUmHwibJUjGLWjhtkAr0r3/LUtaXFZoW
         bha+Nw8IblTO2gHvEp36KVVEM9dacaIb3nyHBlvgXpAIJRvAQQOE+v800hYFJlIoen
         tdk8R8qeuQFzg==
Received: by mail-ed1-f70.google.com with SMTP id b7-20020a056402350700b004d2a3d5cd3fso18703052edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678745371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBMHeYCeRHGu2+rLkZfqPcI8agcZPwmUe8po8kQpky8=;
        b=DXiYUgb9LFd8CFBPB3L6LYBG/SZDTOdl/WUiUPqmqJdVoSfJuoLuG0woZwO3hOvWw1
         M7/BhAOZ03sPq/Lp7adTFAP24hJ6BxkXjNhRtC9K6bzWsVvt72WXdCHa1dsXjGVDjNhk
         d31zlSnKi+jSzBcLBjx1CfHjUYUERIOqpTi3EfCo3qsD1VzmG5OvnrJszME/nDaWBT8Z
         EoUqo47uleFX3TJrbqhrQWyhbD6iFLKF7FgS8stwnZi6GaAnFPwIonz2fbvXxpSSH8Hn
         fB+Le8xUi6i7QXGbmrCjW4Hde9MVZGHpkrzGw+3vPXDqt6zri1++vF9nb2MQEaX+L8D9
         Ok8w==
X-Gm-Message-State: AO0yUKX59r4vnp2bAxiAUwBjbl/flm6TrNk5eHmHxhp3JtKlwtIY0CFd
        HBRn4Lpnzl9fZB5tT+JUaG3qlEsWDCMeWB7B7dgN+A26CKE3gC3Er3kHBUuBSXLMbvcUHxN1/w1
        jFmONzycHuTyV5OmHhzHnPwaxFSXbCV7Eykd/GQHWNw==
X-Received: by 2002:aa7:c552:0:b0:4fb:e14:c25b with SMTP id s18-20020aa7c552000000b004fb0e14c25bmr6867377edr.33.1678745371405;
        Mon, 13 Mar 2023 15:09:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set/c1Fg2tlgnGWAqXlrqlvJt1JsHHc+0XDpKqNUfCJ8+/7M0lzfDWfTLamqPeXAAAhttkDyZ7g==
X-Received: by 2002:aa7:c552:0:b0:4fb:e14:c25b with SMTP id s18-20020aa7c552000000b004fb0e14c25bmr6867362edr.33.1678745371068;
        Mon, 13 Mar 2023 15:09:31 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id o26-20020a509b1a000000b004aeeb476c5bsm272865edi.24.2023.03.13.15.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:09:30 -0700 (PDT)
Date:   Mon, 13 Mar 2023 23:09:30 +0100
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
Message-ID: <ZA+fGpAdnvB5VwKW@righiandr-XPS-13-7390>
References: <20230111161155.1349375-1-gary@garyguo.net>
 <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
 <20230313214853.GY19419@kitsune.suse.cz>
 <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
 <20230313220234.GZ19419@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313220234.GZ19419@kitsune.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:02:34PM +0100, Michal Suchánek wrote:
> On Mon, Mar 13, 2023 at 10:53:34PM +0100, Andrea Righi wrote:
> > On Mon, Mar 13, 2023 at 10:48:53PM +0100, Michal Suchánek wrote:
> > > Hello,
> > > 
> > > On Mon, Mar 13, 2023 at 09:32:16PM +0100, Andrea Righi wrote:
> > > > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
> > > > > Currently modversion uses a fixed size array of size (64 - sizeof(long))
> > > > > to store symbol names, thus placing a hard limit on length of symbols.
> > > > > Rust symbols (which encodes crate and module names) can be quite a bit
> > > > > longer. The length limit in kallsyms is increased to 512 for this reason.
> > > > > 
> > > > > It's a waste of space to simply expand the fixed array size to 512 in
> > > > > modversion info entries. I therefore make it variably sized, with offset
> > > > > to the next entry indicated by the initial "next" field.
> > > > > 
> > > > > In addition to supporting longer-than-56/60 byte symbols, this patch also
> > > > > reduce the size for short symbols by getting rid of excessive 0 paddings.
> > > > > There are still some zero paddings to ensure "next" and "crc" fields are
> > > > > properly aligned.
> > > > > 
> > > > > This patch does have a tiny drawback that it makes ".mod.c" files generated
> > > > > a bit less easy to read, as code like
> > > > > 
> > > > > 	"\x08\x00\x00\x00\x78\x56\x34\x12"
> > > > > 	"symbol\0\0"
> > > > > 
> > > > > is generated as opposed to
> > > > > 
> > > > > 	{ 0x12345678, "symbol" },
> > > > > 
> > > > > because the structure is now variable-length. But hopefully nobody reads
> > > > > the generated file :)
> > > > > 
> > > > > Link: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")
> > > > > Link: https://github.com/Rust-for-Linux/linux/pull/379
> > > > > 
> > > > > Signed-off-by: Gary Guo <gary@garyguo.net>
> > > > 
> > > > Is there any newer version of this patch?
> > > > 
> > > > I'm doing some tests with it, but I'm getting boot failures on ppc64
> > > > with this applied (at boot kernel is spitting out lots of oops'es and
> > > > unfortunately it's really hard to copy paste or just read them from the
> > > > console).
> > > 
> > > Are you using the ELF ABI v1 or v2?
> > > 
> > > v1 may have some additional issues when it comes to these symbol tables.
> > > 
> > > Thanks
> > > 
> > > Michal
> > 
> > I have CONFIG_PPC64_ELF_ABI_V2=y in my .config, so I guess I'm using v2.
> > 
> > BTW, the issue seems to be in dedotify_versions(), as a silly test I
> > tried to comment out this function completely to be a no-op and now my
> > system boots fine (but I guess I'm probably breaking something else).
> 
> Probably not. You should not have the extra leading dot on ABI v2. So if
> dedotify does something that means something generates and then expects
> back symbols with a leading dot, and this workaround for ABI v1 breaks
> that. Or maybe it is called when it shouldn't.

Hm.. I'll add some debugging to this function to see what happens exactly.

-Andrea
