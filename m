Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0A6B81BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCMT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCMT1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:27:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF97B48D;
        Mon, 13 Mar 2023 12:27:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r15so25870158edq.11;
        Mon, 13 Mar 2023 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678735623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fskuyX6dGFWefRxPFqS8/6jtOJXTxSop5LICOFSjoko=;
        b=pEgxH0csy4TCha8z49vvNLTGFTR2dkPXCh/2UsS1WNAnHCpW0WPoeNIeLwE6ANttyy
         Jp/B7KgamuzqDNU9kwdBkrO5tqjdTHrM0+yi2EJFGzDw6iH4FpTrFWeobt1o8arHuizo
         MBMWPVDlb1UB3ZD3Dlg+eRR1Y4xLgssrb/P19QMJWpAYPs6a+MA9n9cG2iK4ySpEY8PG
         r1NBP2i5+ZijFkpqCL7vtez6MymcNroQM5KuE+xTwaTN7DJ4oGY3DI/NobBqjsrJl/Yg
         D4lWdChEdEFnbiVRNkWjKk0nAA8APGdMZRpcVwDCJ04OTnLGVAfyJ9oMfKBLNaku5NYl
         9lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678735623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fskuyX6dGFWefRxPFqS8/6jtOJXTxSop5LICOFSjoko=;
        b=wRpyiBYN14MRm4tMGM1ofmt2FZxa4Gao7tDyZz/woKo3MghWJgzSvL8Zj1Lzt/QwiP
         B1/PDrxJ7zV35gUODowidC1gNnLFQsysdTct9O4yhyzLUnapOIiAMkJ8ellD5kQqxJX/
         Ba/TpqM7Efb2Swp/B0DmBKdNcmyOTYBi+pF2uHEITAVEGIp9/YC3VbHc2j1K0UTAZ2F8
         Ezl3YlaGvwtn5Tdnzvr+t/2v27Na8kcO3gDOfC/JShkwzpkObW2QfQZRLN0uYur/233F
         KV37xLTFQShz0E8WirGc3ZqtpT4s1n+RuCqfiLX09wCEEwrwPHeoIrzTQoKPMyILM6Zk
         dgVw==
X-Gm-Message-State: AO0yUKU1Xg99o+hfrIOhCk243ubJQiWY3l+XIAg+BzZ9ysiH0miVf5Q4
        1egn1MEVRgkrTU7GnCXmZ4fTaxoMTQ==
X-Google-Smtp-Source: AK7set9MtL4jDO4Lg6s0yzNdJyD4Q25nOg0yRFbxJSV31dbpRpwdARYwzWTHGLW5H5V7bwNxWM9zMQ==
X-Received: by 2002:a17:906:2dd8:b0:92a:3b19:9991 with SMTP id h24-20020a1709062dd800b0092a3b199991mr3839897eji.69.1678735623296;
        Mon, 13 Mar 2023 12:27:03 -0700 (PDT)
Received: from p183 ([46.53.254.249])
        by smtp.gmail.com with ESMTPSA id op1-20020a170906bce100b009222a7192b4sm164630ejb.30.2023.03.13.12.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:27:02 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:27:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] menuconfig: reclaim horizontal space
Message-ID: <1f228646-0cce-4183-a4cc-6982b69e887d@p183>
References: <20230311114248.36587-1-adobriyan@gmail.com>
 <20230311114248.36587-2-adobriyan@gmail.com>
 <26a291d8-49c0-e5af-846b-1e29f8266ba9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26a291d8-49c0-e5af-846b-1e29f8266ba9@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 05:29:24PM -0700, Randy Dunlap wrote:
> On 3/11/23 03:42, Alexey Dobriyan wrote:
> > Draw the menu box from position (0, 2) so that there is less unused
> > space available. Horizontal is not _really_ important but on small
> > terminals maybe it is.
> 
> ISTM that the first sentence goes with patch 3/3. ??
> 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> >  scripts/kconfig/lxdialog/menubox.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
> > index 5c3addad89b0..5eb67c04821f 100644
> > --- a/scripts/kconfig/lxdialog/menubox.c
> > +++ b/scripts/kconfig/lxdialog/menubox.c
> > @@ -184,7 +184,6 @@ int dialog_menu(const char *title, const char *prompt,
> >  		return -ERRDISPLAYTOOSMALL;
> >  
> >  	height -= 4;
> > -	width  -= 5;
> 
> How does this work?  In my test patch, I changed 5 to 4 to recover/reclaim the
> shadow line.  To my surprise, I don't see any negative issue with this change,
> but I am perplexed by it.

Ehh? It is calculated as (getmaxx - width) / 2, so both 5 or 4 do
the same thing.

> Anyway, it worked in my testing.
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> >  	menu_height = height - 10;
> >  
> >  	max_choice = MIN(menu_height, item_count());
> 
> Thanks.
> -- 
> ~Randy
