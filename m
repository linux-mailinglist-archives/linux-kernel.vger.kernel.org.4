Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE56F98A4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjEGN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:29:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37121635F;
        Sun,  7 May 2023 06:29:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf21bb427so24794555ad.1;
        Sun, 07 May 2023 06:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683466166; x=1686058166;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEE4rFRcXmS59YkgFdCPJqdlH6NtKCZ8BAGKDvTzowA=;
        b=FHNzQR+I5eORzc0RHGXsRbCVlQW8SbqnyW8Z2xPFjiaz/gIMW+NGJ+WTRkWsMSMoEh
         fGPoPW794d8jyDZsV9kbYufbYcR6HAMYUX3vFKav/HxCZLZVqIhW2DFQODYBMifrNMHe
         EhZIpnXYFUcm4C6CnPJeYwNbGEK5RtFYX+r2yUAZcZf7n2pctqg0RC42hVK5tyxlg3iy
         9iLH3uztwfSZy3PUt46KbGZ6+T0mMn3L/cx4MN0ulTnZD69OPUbqOLMqrdDuX1z9Ap6M
         uhJJSAvFQym9/UrV4UrKBJqJR4WO/2/a1QNgmuvi2tbpg8KuYzVRxvijDJ/Be/Ck0QHn
         gusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683466166; x=1686058166;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yEE4rFRcXmS59YkgFdCPJqdlH6NtKCZ8BAGKDvTzowA=;
        b=ObPYo3xAAM+T+Q5GCBtgkjIBzMImTDLB005RvoMR6W/WjPAwKTIFC6Gvk4xF0N3DIj
         IIqsNmb1Sy74jmSLQ95gy9RvQ6/3+y47eIMucCq9byD3YrAicoe9d3yyM1ND9Gj3Iw/m
         MzZduBisHMmdFZIomj/wxCGudOpkICgbk4jMO8wi/Fb82O7CwaBcywVvdKI/bAMuAyMQ
         N1yOj7Ci8dbc/Er8SiWZakUJIYINxiJxGtr4spRs2w5TjGM1cMT2TTuOmF2dWofLfAnc
         aLkzhkKwjIiXvpwAzVFRbQGLuiAPyNXiVRxnOC/TXBmdDODbzmg9ADG5n47pfEB5YfbV
         nutQ==
X-Gm-Message-State: AC+VfDyfsZebwzYicR1XDuuNVQkxom/cvEEU+VxKFE/GLxJQFXp+nwPb
        ezg4fKmIksVBqEmcRidl2V5DwZQv+jk=
X-Google-Smtp-Source: ACHHUZ7P+KwUoR20+BmPPshdJfqIyGfWEcEyV5Xmu+2O8TtoKUxE8hlBnrM0SKp43+3+eE0TALOEqg==
X-Received: by 2002:a17:902:7881:b0:19e:6cb9:4c8f with SMTP id q1-20020a170902788100b0019e6cb94c8fmr6214043pll.41.1683466166140;
        Sun, 07 May 2023 06:29:26 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-59.three.co.id. [116.206.12.59])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001a9ac65ca7csm5125038plb.309.2023.05.07.06.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 06:29:25 -0700 (PDT)
Message-ID: <db732251-b6fe-c2c5-a0db-bac77dc84314@gmail.com>
Date:   Sun, 7 May 2023 20:29:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: syntax error in prepare target of main Makefile
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a year old bug in bugzilla [1]. As many developers don't
take a look on it, I decided to forward the bug by mail. And
to reach the reporter, you must log in to bugzilla.

Quoting from the bug report:

>  Christian 2022-04-08 10:44:17 UTC
> 
> Symptom:
> 
> make[2]: Entering directory '/usr/src/kernels/5.17.1-1.el8.elrepo.x86_64'
> Makefile:729: target 'include/config/auto.conf' does not exist
> test -e include/generated/autoconf.h -a -e include/config/auto.conf || (                \
> echo >&2;                                                       \
> echo >&2 "  ERROR: Kernel configuration is invalid.";           \
> echo >&2 "         include/generated/autoconf.h or include/config/auto.conf are missing.";\
> echo >&2 "         Run 'make oldconfig && make prepare' on kernel src to fix it.";      \
> echo >&2 ;                                                      \
> /bin/false)
> Makefile:1717: target 'prepare' does not exist
> if [ "gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)" != ""gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)"" ]; then \
>         echo >&2 "warning: the compiler differs from the one used to build the kernel"; \
>         echo >&2 "  The kernel was built by: "gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)""; \
>         echo >&2 "  You are using:           gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)"; \
> fi
> /bin/sh: -c: line 0: syntax error near unexpected token `('
> /bin/sh: -c: line 0: `if [ "gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)" != ""gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)"" ]; then \'
> make[2]: *** [Makefile:1717: prepare] Error 1
> make[2]: Leaving directory '/usr/src/kernels/5.17.1-1.el8.elrepo.x86_64'
> 
> 
> Note the double double-quotes in the GCC Version comparison !
> 
> This happens to me when I try to compile vmware kernel modules with mainline kernel from elrepo on AlamLinux8.
> 
> Since it is coming from the Makefile of the Kernel, I suppose this is the proper upstream tracker to be used. Please advise if not.
> 
> 
> This is the potion of the Makefile that fails (line 1717..) : 
> prepare:
> 	@if [ "$(CC_VERSION_TEXT)" != "$(CONFIG_CC_VERSION_TEXT)" ]; then \
> 		echo >&2 "warning: the compiler differs from the one used to build the kernel"; \
> 		echo >&2 "  The kernel was built by: $(CONFIG_CC_VERSION_TEXT)"; \
> 		echo >&2 "  You are using:           $(CC_VERSION_TEXT)"; \
> 	fi
> 
> 
> 
> I don't know where CONFIG_CC_VERSION_TEXT is defined. Which apparently contains "...", but shouldn't.
> 
> 	

To the reporter: It is helpful to try compiling your third-party modules
against latest mainline kernel.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=215820

-- 
An old man doll... just what I always wanted! - Clara
