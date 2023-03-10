Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580EE6B4487
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjCJOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjCJOYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:24:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A31D58B2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:23:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec29so21101536edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678458218;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eE8vid9FM7x60cVTVIebF5BuQoaUundVFu4YvIZ1pg=;
        b=P1bPsHoUwW3cQQCFMX0G4KReC17NSYR6Ugpgpto2MXCW2Dd5TWs+qSkiJnsXxdtDum
         WrNvvs5VbKMCRqKll1h4Telz7X80bieZa2usRcl1ohozhCFIOaoj7tbo4IWpAT0oR4K+
         53K2bolfqcBbR06xt7greJiWKraV6KradSbZsY1/n/u5OJvRbibN2W+K1prL2tRdPc2f
         hlr96Db0hzDVVRPh1gyCrv0JOTNgeNtzVY8hBCEUIQEN84+lTeYS+x8bC53W91GlDMYd
         B7OkupxnaYaFDcOZG8CwFlOTKqkbpEbvhELIpETx0WsXZtjaLYFt6BAM30k8H0mciCgS
         P4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678458218;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2eE8vid9FM7x60cVTVIebF5BuQoaUundVFu4YvIZ1pg=;
        b=j2H10AIJHr+IgOLLwbDZ75U2sxKRB9XH+e32ZvBJfsPLzzAFNimGzOi4UjE7BYtzxq
         Lg6d1CEala30zmW2RlHfgM4InEZM3u8OB66wklitNIJPMmnwzRbKks3Xzt93sret7iTF
         Ouzo/tfkG7cTcm2Bz+Ac+o7+R1SSO0ST88eAQ7peWnv9osn4LiHoJncKNyih/o9o0cTr
         PvK6nX+DIL1TIKHg6N8uZ/xYFRlf6v+UTz3fqoZ9V1r3f6+u6Zjv2r/wzieGHWTLCA3x
         26wieXIbOtOnoeILe96pl6T3kLO+7mvCFqN0Hsz4AEHd0fkJ4TbNrboVMxJBVzo+6GYA
         XhAg==
X-Gm-Message-State: AO0yUKWOD7nCwI7wKqXAKXRjfLBW2TVU2RwM98CI2vnCYGBf98aC37Iu
        a05H28n0TQ1rqkmTlaj7nLs=
X-Google-Smtp-Source: AK7set9n9wsHVA0I7R07oQLeCZ4PHbeXCrxG7OO8HPOdKMat0zhCd8MpDGCEIF7K21bJ9R3cdfobZw==
X-Received: by 2002:a17:907:c28b:b0:861:4671:a834 with SMTP id tk11-20020a170907c28b00b008614671a834mr23321762ejc.71.1678458218142;
        Fri, 10 Mar 2023 06:23:38 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id qb4-20020a1709077e8400b008b17e55e8f7sm995895ejc.186.2023.03.10.06.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:23:37 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 10 Mar 2023 15:23:36 +0100
Message-Id: <CR2RS3YFFQTR.39A2C0SLRBJQY@vincent-arch>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Russell King" <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dyndbg: allow including dyndbg.h in decompressor
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Arnd Bergmann" <arnd@kernel.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Jason Baron" <jbaron@akamai.com>
References: <20230310140133.291594-1-arnd@kernel.org>
In-Reply-To: <20230310140133.291594-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arnd Bergmann <arnd@arndb.de>
>
> After a change to linux/module.h, dyndbg.h is now included
> indirectly from the decompressor for lz4 support, which in turn
> causes a build failure on 32-bit Arm:
>
> In file included from include/linux/module.h:30,
>                  from arch/arm/boot/compressed/../../../../lib/lz4/lz4_de=
compress.c:39,
>                  from arch/arm/boot/compressed/../../../../lib/decompress=
_unlz4.c:10,
>                  from arch/arm/boot/compressed/decompress.c:59:
> include/linux/dynamic_debug.h: In function 'ddebug_dyndbg_module_param_cb=
':
> include/linux/dynamic_debug.h:307:14: error: implicit declaration of func=
tion 'strcmp' [-Werror=3Dimplicit-function-declaration]
>   307 |         if (!strcmp(param, "dyndbg")) {
>       |              ^~~~~~
> include/linux/dynamic_debug.h:1:1: note: 'strcmp' is defined in header '<=
string.h>'; did you forget to '#include <string.h>'?
>   +++ |+#include <string.h>
>
> The decompressor has its own replacement for the linux/string.h contents,
> so the normal declaration is not visible here. Since the function is
> not actually called, it is sufficient to add a declaration, and this
> is in fact the correct one as it matches the definition in
> arch/arm/boot/compressed/string.c.
>
> Fixes: 7deabd674988 ("dyndbg: use the module notifier callbacks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
