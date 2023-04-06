Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF26DA4C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDFVfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDFVfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA698B5;
        Thu,  6 Apr 2023 14:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617BE62D38;
        Thu,  6 Apr 2023 21:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F1CC433EF;
        Thu,  6 Apr 2023 21:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680816917;
        bh=klvO6puhDKE+MqD3D0md8Hdzzjg3QNMR84/fZATfffs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fz+eG2c8B2/Cx4X7vJDsaslk06S2nedje/qPUfnFS7j0K1d05ZXH3lGUzP7ocsVbR
         iueHYprpq8tWpJKKtiYrK8x4gzpjWJFKbQ/fK3qrm4oh0PMrv2tIqbS7iFG1+fOP3N
         2EFpt5NeNA4Kpcc+6QBGBUOVZAFLv0Kmkjx7TijFVcLPR6VUn30S9kzSFFFXsArNGt
         v7QPjkd9CR7PZ+skZD2EQZJh/Tovcya5YzwKq3OEeOaKc6ROBnuBp/W8JktzZq3/eC
         ScrZCjuU1hJzLhUEL2vGwL7dmy2e2T/LqXvxFX59OENAN20WX2Jw58H1BJdzkzaYZZ
         gCtemGQql2IiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A8E3C4052D; Thu,  6 Apr 2023 18:35:15 -0300 (-03)
Date:   Thu, 6 Apr 2023 18:35:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] tools: Rename __fallthrough to fallthrough
Message-ID: <ZC87E1QjLjGshw9i@kernel.org>
References: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
 <CANiq72ntFXb+ZhBqgBAMu2n8wcgJLZRZC1rmBVvL5m+K1Nhw2w@mail.gmail.com>
 <20230406195830.ieiozetmk7qjllol@revolver>
 <CANiq72=C4OCcbX4C-ap3YTm5Ni6RdskQ67rt4iWs0_1hTe1rkw@mail.gmail.com>
 <ZC81Z4p8WnYtVwFT@kernel.org>
 <ZC86NOtaBPi1lhtI@kernel.org>
 <ZC86emOOKlgysuwW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC86emOOKlgysuwW@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 06, 2023 at 06:32:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 06, 2023 at 06:31:32PM -0300, Arnaldo Carvalho de Melo escreveu:
> >                  from /usr/include/glib-2.0/gio/giotypes.h:30,
> >                  from /usr/include/glib-2.0/gio/gio.h:28,
> >                  from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
> >                  from /usr/include/gtk-2.0/gdk/gdk.h:32,
> >                  from /usr/include/gtk-2.0/gtk/gtk.h:32,
> >                  from ui/gtk/gtk.h:8,
> >                  from ui/gtk/helpline.c:6:
> > /usr/include/glib-2.0/glib/gmacros.h:637:28: error: missing ')' after "__has_attribute"
> >   637 | #if g_macro__has_attribute(fallthrough)
> >       |                            ^~~~~~~~~~~
> 
> I'm now trying with:
> 
> diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
> index 8f3e43d148a8560b..d2dadf3873fbdf41 100644
> --- a/tools/perf/ui/gtk/browser.c
> +++ b/tools/perf/ui/gtk/browser.c
> @@ -1,9 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include "gtk.h"
>  #include "../evsel.h"
>  #include "../sort.h"
>  #include "../hist.h"
>  #include "../helpline.h"
> -#include "gtk.h"

Some more was needed, folding it with your patch.

- Arnaldo

diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index 8f3e43d148a8560b..d2dadf3873fbdf41 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "gtk.h"
 #include "../evsel.h"
 #include "../sort.h"
 #include "../hist.h"
 #include "../helpline.h"
-#include "gtk.h"
 
 #include <signal.h>
 
diff --git a/tools/perf/ui/gtk/helpline.c b/tools/perf/ui/gtk/helpline.c
index e40a006aead87b9b..8ea95898a5bd0295 100644
--- a/tools/perf/ui/gtk/helpline.c
+++ b/tools/perf/ui/gtk/helpline.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "gtk.h"
 #include <stdio.h>
 #include <string.h>
 #include <linux/kernel.h>
 
-#include "gtk.h"
 #include "../ui.h"
 #include "../helpline.h"
 
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index c83be2d57f7eb7a7..bae21f336ae6d576 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "gtk.h"
 #include "../evlist.h"
 #include "../callchain.h"
 #include "../evsel.h"
@@ -6,7 +7,6 @@
 #include "../hist.h"
 #include "../helpline.h"
 #include "../string2.h"
-#include "gtk.h"
 #include <signal.h>
 #include <stdlib.h>
 #include <linux/string.h>
