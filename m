Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F686716A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjE3RCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjE3RCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:02:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7D1E5F;
        Tue, 30 May 2023 10:01:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fb64b3368so626098a12.0;
        Tue, 30 May 2023 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685466106; x=1688058106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Skkv5yRuNOgDdy/LQmjb9R5cgeDnPANnKwqfWUb6vFw=;
        b=IWRT7UiG45FdKVpcwaCBTs/EE9DkWxFI1d3HZuU30E0O9+UtZF37JI6tUlSJfxcx+i
         srJhaOOxGSNo3ASCgH8ZOewrMBMiki6zHRg3hquezGOGkdrY9TYtmXEhVchMp2FKnskg
         GIRPZRzdUJ46qC/nUtF9d4dcsnP1xsxefjVbKfUDjLo8fZVVu6Kp/qKZr96zbCDOsR+Q
         oOiGKbnhU66vVWkpe5OdetKht2VA7Vf7laA+bjXu6gmF6wHRsocjymfFovyeYoLSiNFs
         wCrV2Nvq5AxPgeE5v46Wrz7e3atmR+F4KdrOtsXU9vb7n0i9itYafZ8y2B84jB8JsZqj
         Mweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466106; x=1688058106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Skkv5yRuNOgDdy/LQmjb9R5cgeDnPANnKwqfWUb6vFw=;
        b=AS5wBrUSvqprdf9ZzUtu4JVmB3CBVxCecHJONtARAQk1ZzXuKrLFQwd/5KjqzDUDT9
         cta9J1O10TsEj0HtCpF4UhuMBTLE5H6DMBDdQ6OuEbmSBfynFj5yoVhOx+yPqClc1vi8
         3kq9uCkBdTwbsD8DgadtVU99/3KdJWYIM5LyHkZ4wPZpHQ9WaPU8gKe0NolIheBOWJQD
         6duRmqQseDBPZOZHbKYPzaXwdrK2Ax5tGzuGiPpDiEqMfAkjv64meHKQs0vaiQBzSFHp
         3x9MWkGXMTAs+rJzPZ9DjcGoy1QzmduOX9hl6yhSxqmm82sivaCUgkMFreIZ8A/8vyQ5
         Ft7Q==
X-Gm-Message-State: AC+VfDxQoeXdLm94HxPO+UDxqwRsTsiL0QwL83DUzUNz4Ky0oPHUYjEw
        xfn2UqIIPfuqSDpkXlQl2+HydoWkqExMyY7cEHE=
X-Google-Smtp-Source: ACHHUZ7IN+ieDWp57f0DN2bS38aflUVrfKQd4EC54pasDNTk2e8cjXweqDiIMoaAgQg1M4RGqk4/bSKwltDH4BitA7A=
X-Received: by 2002:a17:90b:4a09:b0:256:5a84:c837 with SMTP id
 kk9-20020a17090b4a0900b002565a84c837mr3030534pjb.39.1685466105740; Tue, 30
 May 2023 10:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190843.514829708@linuxfoundation.org>
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 30 May 2023 10:01:34 -0700
Message-ID: <CAJq+SaDYbXd2ocgx8CUFW+y7_AH9BFoz0Tj099cqe9BGYqSrMg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/211] 5.10.181-rc1 review
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

> This is the start of the stable review cycle for the 5.10.181 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.181-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
