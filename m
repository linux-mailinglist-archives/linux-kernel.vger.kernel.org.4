Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AE606FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJUF7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJUF7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:59:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EB4E40F;
        Thu, 20 Oct 2022 22:59:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w18so4554824ejq.11;
        Thu, 20 Oct 2022 22:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YEiLrINto3OfhATRDo7il8OOpbEVODXHzBub1SpWzxo=;
        b=dU82oX6EYusd5s+JqKnuaoZGuHlZ8VZ7kNohRINYDKTsWw3YUFTKBOFn2Vp/t+57L8
         zcN1xjdnldwKfhfkmbhyYf3df/fT6TtzZv6nbws89fcoBJt7AzYD8yB7G9rkdBVtagZN
         IjaUQ1PIgxiyeBK2xO2+wxR7aX0+M4lCQ9R2wQEJ8vjKj8fuxYWs7FqdxybKHpE7TOJZ
         eq9xLxKjv4dwiEC9b9vrkJobNZVfXDNCgoWKvfJdt9Hb988Q8IuaUwcHMs8odK3ZtySZ
         QRzzjyHUkosgZnnnUytA2IzT+lbacPpELiCJwcDAyUpY7IjPaZD2cY7WeEYe3QqBSP/s
         rsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEiLrINto3OfhATRDo7il8OOpbEVODXHzBub1SpWzxo=;
        b=3Lwk7HGafpGM+7rfVpiYrDYWe+a/sXpSYHzlz2wMmMeduGp9Qsu5fXnegoVBRPvjD7
         NCDdWEwTG9MAqOUUvfZxNVcnxgUoRYPioJ0NNbfMnDJv1jyrQkuFSlR3xQFwJQKQ3mra
         EpJ/s6XFAAS8lTFJk0/1OWrAE4AA8C5spZqeE87VabdRhxgjagE+I+uNYS/xLbu99hRm
         lX5isPcyvCZubx5B10G1Pg6ohUQtFsmCPH7NuCot8FTwcjeZjqV9JLzcMcwSVz7M3D8P
         XRl1hrEwpPKE+WKNIm1ndWUjzcrkz6qxbCt/Gzb2IRuqjOuKgWgRVGysTyTx1ucAFUvN
         fl6A==
X-Gm-Message-State: ACrzQf3mBQf0X+gzXQuunVooj8LPB7B66Ic6YVPpc+eZuafkW5Ex7DKX
        HDQXE70j6n0p76K7BJCL5g==
X-Google-Smtp-Source: AMsMyM60XkWKQKT3Ac3NZ9xwlVh1NouJ5Daas52aFUJobFpgWBoFA5TT4vK59YS8i+aHzzcGddreDA==
X-Received: by 2002:a17:907:16a7:b0:78d:f586:e446 with SMTP id hc39-20020a17090716a700b0078df586e446mr14040167ejc.252.1666331981460;
        Thu, 20 Oct 2022 22:59:41 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.171])
        by smtp.gmail.com with ESMTPSA id c22-20020a170906155600b007081282cbd8sm11140994ejd.76.2022.10.20.22.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 22:59:41 -0700 (PDT)
Date:   Fri, 21 Oct 2022 08:59:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <Y1I1S86zbBmeJ+jq@localhost.localdomain>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:14:54AM -0700, Linus Torvalds wrote:
> On Thu, Oct 20, 2022 at 9:28 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Nice catch.
> >
> > Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Can we please try to collect these all in one place?
> 
> I see that Andrew picked up the original one for -mm, but I think it
> would be better if we had one specific place for all of this (one
> branch) to collect it all.
> 
> I'm actually trying to do a "make allyesconfig" build on x86-64 with
> both signed and unsigned char, and trying to see if I can script
> something sane to show differences.

It is very entertaining, i've given up and started patching sparse
but it needs more because char constants are ints:


diff --git a/evaluate.c b/evaluate.c
index 61f59ee3..ab607581 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -321,6 +321,10 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	if (old->ctype != &null_ctype && is_same_type(old, type))
 		return old;
 
+	if (is_char_type(old->ctype)) {
+		sparse_error(old->pos, "XXX char");
+	}
+
 	expr = alloc_expression(old->pos, EXPR_IMPLIED_CAST);
 	expr->ctype = type;
 	expr->cast_type = type;
diff --git a/symbol.h b/symbol.h
index 5270fcd7..8e62aca2 100644
--- a/symbol.h
+++ b/symbol.h
@@ -455,6 +455,14 @@ static inline int is_byte_type(struct symbol *type)
 	return type->bit_size == bits_in_char && type->type != SYM_BITFIELD;
 }
 
+static inline int is_char_type(const struct symbol *type)
+{
+	if (type->type == SYM_NODE) {
+		type = type->ctype.base_type;
+	}
+	return type == &char_ctype;
+}
+
 static inline int is_wchar_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
