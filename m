Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FCC65645C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 18:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiLZRiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 12:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 12:38:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3CB1CD;
        Mon, 26 Dec 2022 09:38:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so11147982pjj.4;
        Mon, 26 Dec 2022 09:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqWgRZhbII3r8RZbZotjyp/UgX3NJwE9v+OMpxa+fL0=;
        b=A4gCBYZAfoOTYl8PDY0elYtACBf/jY77vWTF1bhIPeb2p5vQZQcRdcYYJfXzLSP7Tp
         PezJoIobGDjPg72WeWGHGVvIBs+qtsiGlIAm7xDC1qVTQi6OVMfwdbwkbf+/38X4OfWw
         sKU537ufb6T1RF9r1UVJu0JK1xm9BiFxEEWgyDISrZ2JlhyDZM07cbBu8zDkOVCY0Dn7
         vZ0QV//YO+zV/xEaBbEUibxtYEM34QeJ39KRWhHsfty3fPfiscNaBNOpGQT4SW+7Mgr/
         V32fvtvB8FAgOBPiT2pbGmvDw6NmaN7GnTM7Whr15eIK+E2CtXw5Ftbj55Ux5ZqBUXeB
         z9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqWgRZhbII3r8RZbZotjyp/UgX3NJwE9v+OMpxa+fL0=;
        b=O4ytm8RkMwXkC3Smgq4KK2vPCA7ZYxZC2023YES7cKWfs+LYdW39CjZtID7YTgBfBC
         xiWSoj/QYPn0+8iDEEJPRhPt3fdFDjFz6dydMiPpZt5xtzAlDwxgUEqibe6FsT8L7PXl
         CsB/v8DjKUb2aPCwVNvetW9pSnpapabpnVI4ymhDiyLXG2AnDiC75VNBEW1zn02He5fe
         2W2Wj0UMpwbJJzzUNrxuf6iGnFLz55040r1rsWJm9ncuqsaJJvDz2VoabRUAOccNLxOM
         TNpqysDtxwUM09DboV0EemBriee/t6gNCYpaWfBTOp7jSVCtt7WQ4OFSzrbVClQe7+UM
         mFdw==
X-Gm-Message-State: AFqh2kqPo4xg2HSyjkphu7586uVRpXxSOnVRgGPzmroVe2SHC6KjXS1d
        sEf+SbhWi7++QC0fpyXpU9ofNLeLkZg=
X-Google-Smtp-Source: AMrXdXtOfWLNV6UHgCE8tom5ulotErJ9cfOVmX9OtHTMforCICV5J0J/Dk0qFEsGofac9z+IRuC9+w==
X-Received: by 2002:a05:6a20:8f26:b0:ad:db18:6d0d with SMTP id b38-20020a056a208f2600b000addb186d0dmr30943938pzk.59.1672076298591;
        Mon, 26 Dec 2022 09:38:18 -0800 (PST)
Received: from ldmartin-desk2.lan ([50.39.162.59])
        by smtp.gmail.com with ESMTPSA id v62-20020a626141000000b00576d4c45a22sm7332221pfb.147.2022.12.26.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 09:38:17 -0800 (PST)
Date:   Mon, 26 Dec 2022 09:38:16 -0800
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmod: configure.ac: In _Noreturn check, include
 <stdlib.h> for exit
Message-ID: <20221226173816.ii5hf3zt3pg52ww2@ldmartin-desk2.lan>
References: <877cyq6kh9.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <877cyq6kh9.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 05:52:34PM +0100, Florian Weimer wrote:
>Otherwise, an implicit functiona declaration is used, causing
>a C99 compatibility issue.
>
>Signed-off-by: Florian Weimer <fweimer@redhat.com>

applied, thanks

Lucas De Marchi

>
>---
> configure.ac | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/configure.ac b/configure.ac
>index 6989e93..12e0518 100644
>--- a/configure.ac
>+++ b/configure.ac
>@@ -68,7 +68,8 @@ AC_COMPILE_IFELSE(
>
> AC_MSG_CHECKING([whether _Noreturn is supported])
> AC_COMPILE_IFELSE(
>-	[AC_LANG_SOURCE([[_Noreturn int foo(void) { exit(0); }]])],
>+	[AC_LANG_SOURCE([[#include <stdlib.h>
>+	_Noreturn int foo(void) { exit(0); }]])],
>         [AC_DEFINE([HAVE_NORETURN], [1], [Define if _Noreturn is available])
> 	 AC_MSG_RESULT([yes])],
> 	[AC_MSG_RESULT([no])])
>
>base-commit: 6c5f2f13689e6a4668f87171752d7818bed4b602
>
