Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A375674DCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjGJSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGJSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDDAD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:02:18 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b71cdb47e1so4285789a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689012137; x=1691604137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsHm4asAiCOk33uCZVwENCOzoNNk6JHzs23yJyW+awA=;
        b=JYE/vTETaRRYvBFabD7fu9Ksz5ZUxoF1Gb9voreULcOStmUu17vWFHYOmrSjK1ko9r
         YxNuCrAGy0yUUe081sbHCdyoXKhG3IX/gFvkLrBXBiqqgOpGDGVV8UEpz7+iXmduPRxP
         ggaxziEBxmFwAb/od9McZO2odqNfK7Ix63+KYuuxUzpkEAqX4SUODJiGJTt87ydMkCuW
         OpzGJQRVSx3IeEXJngQAZjAjvaBPSXeQlRQDN2fxu5Zig4t7M3NUz4ASWRHam2U1PUBr
         QBIOMOrBVmecjnU9SgsThsEpkz+nAW/1RtM+kDj9F2y0zi2avgt7EtkKmkn1UvHe7t1h
         5BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012137; x=1691604137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsHm4asAiCOk33uCZVwENCOzoNNk6JHzs23yJyW+awA=;
        b=ImfrDRlkl/JNDlHsWAZuNIxIyuZah8PJFxOOQNUacZZYErMB5jIuZZGm5imZ7GpkkU
         1L7dF2XxdE0CFyqpxq8ItWX8UeUa7Gl6MVdZG8spUyJ8YVMeqiDXlys9OxDT/S8fw0gY
         /c/FY6PFHyQuQ2TQpDx8ZsauSYfAie6pbR6Lzm4CZkFIxtVUPehc3am2yvD5ML0fJR2K
         vsJ3AstDLIrY+3j801xuhGLcI42NMYjbgW4xY0qQ8u5UUjO08c8Ocl50WDFo8ySVef2q
         KmMfF8ZDuNtBvIDKUgLYNBUhuFt6H4AKjKESWWH5FH3N6mhNDtkAfwT3ZdHU+SES8tBg
         M7nw==
X-Gm-Message-State: ABy/qLaaQhDYSgTH1817X1CJQw01LSkQ/oEvuWzFDxaL4wJfuUzYUCa/
        pzg0PmpDp1oqXpDgtRjsGpmW+W/ESbWVsAGR/KXT
X-Google-Smtp-Source: APBJJlGL5bp3qdIiL0+HM4FKThICi3Lcz8FRmqtymyT4mNrm5kCmNADx7L4kmNfJ9c3slmET4J1NBIRi8J6DJjCpH5Q=
X-Received: by 2002:a05:6870:e40d:b0:1b3:904a:51da with SMTP id
 n13-20020a056870e40d00b001b3904a51damr14455342oag.35.1689012137450; Mon, 10
 Jul 2023 11:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230702170857.15603-1-pairmanxlr@gmail.com> <CAHC9VhSLNNjXsW74bLbHX60Lco+Hjc6f4hp7Eb5hgC==_afPag@mail.gmail.com>
In-Reply-To: <CAHC9VhSLNNjXsW74bLbHX60Lco+Hjc6f4hp7Eb5hgC==_afPag@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jul 2023 14:02:06 -0400
Message-ID: <CAHC9VhRpO4oGvgAA1AMXD8HYuJvqM+OuZ0AKHzWX4Bk=FBJUmw@mail.gmail.com>
Subject: Re: [PATCH] LSM: Fix typo in a comment
To:     Pairman Guo <pairmanxlr@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 6:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Sun, Jul 2, 2023 at 1:09=E2=80=AFPM Pairman Guo <pairmanxlr@gmail.com>=
 wrote:
> >
> > Hi maintainers,
> >
> > In the description of function definition security_file_lock(),
> > the line "@cmd: fnctl command" has a typo where "fnctl" should be
> > "fcntl". This patch fixes the typo.
> >
> > Please merge if it is the case. Thanks in advance.
> >
> > Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
> > ---
> >  security/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This looks good to me, I'll plan to merge this once the merge window
> closes.  Thanks.

I'm merging this into lsm/next now, thanks!

--=20
paul-moore.com
