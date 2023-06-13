Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A5B72E8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjFMRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjFMRB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:01:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44719B1;
        Tue, 13 Jun 2023 10:01:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-543b17343baso2965547a12.0;
        Tue, 13 Jun 2023 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686675686; x=1689267686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LSg+HtxF5THiYaLtR4tXUP2FGEx8HowDn4GCS86HyFo=;
        b=pTqe8PY+j8IKfVkzpy6szR3DwptR6CjyvjE7ttEuqLKttRukf1tHI8QSLEuw2i8T85
         6a12tp94iLWF6G2On3JX2vjHoCCK4rsUi8AArKlX9JZpMnGZV8EZucX6b7LY4FjDL1Ht
         R57/Z3KWEHzoxshEJDEG1yAPz8XD39M7ApI6W34uzUa3BTyFmkkRIOgznrUXnozJMbvf
         9aTlGSphDvubKSI+LwXGMp+Es4cCJLmu1Nbbdbq7s4StKdf631s8n/sIDBUuX5WHwbDY
         kySAVFJJRiA0mSiO556cn75/CRq6cE+RMj61QNE3+wUN2q/TP7m2KrmrfTk/aP/Z6HPi
         062w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686675686; x=1689267686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSg+HtxF5THiYaLtR4tXUP2FGEx8HowDn4GCS86HyFo=;
        b=ZSoUSZnZdvkbV04/OPcrGdaiuLxhr700A+y63hJJV6VzvLTGUUmWucPn6eJ2vxlznJ
         JFtYDZQ/IcMOFI0z3J5cZIkdyn9ZzS6S53slreFKlpQN7DS6w8XQbmliU8BqkRCMAeVQ
         dpiQPZG8HCubPZ8zRrUEEO8oRDoN3YWV8Sbe6RmAr6fDzQCL6zTugEVCFsscCfT2s2rb
         IhdDHaTQELwPzI/ziZCA1Hy2sU04obnGrW+fzJdyalSgfhMTvlW5si2/gpMfrOfa7xtZ
         Xf+K4hHjwD3BG2+YdVq3vgLi/UixmCUbqJcp47TpVoWzVWLCv0HY9KpYA54po1P5h6qg
         3yEg==
X-Gm-Message-State: AC+VfDzqDDdKkaQQUp0Lq6iJ/zauu54s9JokzXwDcqkJYmyIHSUVkBZj
        8HiMRd7uEZPNPu2jc6D4jqdIv3bvdr9cS/wVgn0=
X-Google-Smtp-Source: ACHHUZ5OCZalL2yDi9uZjsX4uU3oHuRy0MIhAeXP7kaJBvLrfYUsH4IpjjG3LEkg/RIfa/oK4pUNi0ZXWgBfPQkBzaI=
X-Received: by 2002:a17:90a:4607:b0:25b:a9f1:9dee with SMTP id
 w7-20020a17090a460700b0025ba9f19deemr8562027pjg.0.1686675685569; Tue, 13 Jun
 2023 10:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101702.085813286@linuxfoundation.org>
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 13 Jun 2023 10:01:14 -0700
Message-ID: <CAJq+SaAdFH0n79w-U+sLQbKk1wwJhEx4WL=-Cj_mj1vMGyXxJQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.117-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
