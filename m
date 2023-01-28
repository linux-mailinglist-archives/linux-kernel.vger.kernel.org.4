Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808267F2CF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjA1AM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjA1AMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:12:24 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E13A24E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:12:23 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so6584362plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfSzQb0mn3RsZbwmCdOsGY9lWarr0Do0dd+IyLOh3eQ=;
        b=YsKia6MOuy//+Z37k2hY2xgGXTbLVtiw3/nid7Qq8fybenqEUubul9iFBJObRGElFg
         azPE0ymJFwv0eb/aQ0s/Y0lA9ofMSuIZv3581HFUBRC0vwuo8tRKP5/3ElQkTcAD5rHh
         5afwIZth902Z2uOukLw0m/2Vsjgi0g8aBB1j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfSzQb0mn3RsZbwmCdOsGY9lWarr0Do0dd+IyLOh3eQ=;
        b=yIu2daGyUgGhmgAzBvZka7C6C3GQcQHNfg5U0agJ94+/kQuxoXKnOsUDkxGwNSeAES
         lD6rd2XyhTeQQFhhK7v3CmdS/myNFYd2pXfM2vRp+ZG2OaIzjNqGIXE6cvuO1mNyVR66
         p78zdM+6Z9BqeVbgLzbf3L9i8ft/Ddr9UpzNPbL5g9rLwrn0lZLTo8lMHWELYP2qyN70
         iscqwrU5UxEGJZfAsHmCfsX0SkcsPbl6eKS5LVMZgG+KRPwHPS0DWLXYy+yxd5AYpEbQ
         Vuad+zByPo38irZvmLNfCocA5A6c5osR1r36X3gswK4VoqtZCRUf6xI4C3CDL99yzIS1
         9Bxg==
X-Gm-Message-State: AFqh2kp4Xo5kzEXQafQHO7l/j3TlZ001G4VzVI119GPk03ZXOyetg6Rp
        vvGxSKab5p5ZmKakWz/eahfYvQ==
X-Google-Smtp-Source: AMrXdXutL9tt03XB19XKLEssq4U1X4SNds46C2Sf+vO2QepCIinzcIrLmOLgUqNF+kyyyUggQZ4+Gg==
X-Received: by 2002:a17:902:a40f:b0:194:5ff8:a3b0 with SMTP id p15-20020a170902a40f00b001945ff8a3b0mr37807189plq.7.1674864743313;
        Fri, 27 Jan 2023 16:12:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001928c9d772bsm3386016plx.206.2023.01.27.16.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:12:22 -0800 (PST)
Date:   Fri, 27 Jan 2023 16:12:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts/dtc: Replace 0-length arrays with flexible arrays
Message-ID: <202301271609.15F0E5EB15@keescook>
References: <20230127224101.never.746-kees@kernel.org>
 <CAL_JsqKVp57NtR11JV-eXktMU9_dQ+8sF8YSPe7KyazrvJB-eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKVp57NtR11JV-eXktMU9_dQ+8sF8YSPe7KyazrvJB-eQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 05:44:13PM -0600, Rob Herring wrote:
> On Fri, Jan 27, 2023 at 4:41 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Replace the 0-length array with a C99 flexible array. Seen with GCC 13
> > under -fstrict-flex-arrays:
> >
> > In file included from ../lib/fdt_ro.c:2:
> > ../lib/../scripts/dtc/libfdt/fdt_ro.c: In function 'fdt_get_name':
> > ../lib/../scripts/dtc/libfdt/fdt_ro.c:319:24: warning: 'strrchr' reading 1 or more bytes from a region of size 0 [-Wstringop-overread]
> >   319 |                 leaf = strrchr(nameptr, '/');
> >       |                        ^~~~~~~~~~~~~~~~~~~~~
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  scripts/dtc/libfdt/fdt.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Changes to dtc/libfdt go to upstream dtc first and then we sync them back.

Ah-ha, I've found it: https://github.com/dgibson/dtc

Thanks!

-- 
Kees Cook
