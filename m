Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A533D71F934
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjFBESF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjFBESC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:18:02 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8B98
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:18:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39a505b901dso1400519b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685679481; x=1688271481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaor9B7ytmBLnF/mg6K2j06Vq4pPXWveXsf5U762TYs=;
        b=P2TJ51Hcs8Z90748VedFGenHvY4i1qRFesaQUemqCGyMQAc4xNWVOeE6HvIhe1HhGO
         cfiA3tPESfpXybPf+neHGkx+tV1z8+PRFZFgtUqMcH5pjLUjJBJ+xs0FiYR/GOLCc8ER
         EGAStRTdrfY7TEfketa7P9QhOGR2KpkI0JxkdIg2AIOIhwHNr0hiExfpUGKxLPZqt3We
         Y3IgW7+tN5rawz2aQy5FHn7yPsmHSBLlWdMxCRuWhbD9WkP4Kr0yzHy1g/HbbuDkOCf9
         /xIk+pgoBUByf4T63dODK0EZ/KdoFny3Nj3gs49ZWbSvWu0sz4DVzNHlc+BKjqGTCIS+
         qUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685679481; x=1688271481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaor9B7ytmBLnF/mg6K2j06Vq4pPXWveXsf5U762TYs=;
        b=ENoZzeU2ryIl5bazablA0GA+6VIIaNZA6btWcewUzq4RklepzyrGc5ho8Dxd/G4/QH
         ivNFg/NPVuOx9dyeUKUV8pFDtNdoCEDZrQZADTEHkx9dp0raO5X+zToxdwc428ELgJZu
         VjhJn1glvU639DS2c790zzrj5GqYwBUzQVKC354rQNaWx69Q4NM8PqaeQc0rmaM5nzwa
         6S8/eYDkyPM/dDraEINyMkeejuhzCrdqogg/lf6OhC4mZCE6uGytNnBnpHkCv3v9zH24
         avf58tsIpOckBx6YblQWWdWkKpUi2T4yJph5p0msbyuzGnsA8XADwNGdYQXp+1+j2BAP
         zZ4A==
X-Gm-Message-State: AC+VfDzwau7uzDOJnZJFkeWz8HZxqrTGj1/Hw8f73J+Z59g3tkI71vft
        C59OC2JdsB2c95wRBX5MpzBv8jIjzOtMIs0MSDpq8Q==
X-Google-Smtp-Source: ACHHUZ5gFgl83oydMh7X1UbVitCRWYnh1+vdbphPi9Zy6PqX5Co/bKzTW4/pEL6saHBe1zPgQb6X1+uvWwf+XxEXcjs=
X-Received: by 2002:a05:6358:3398:b0:123:42d7:e6f4 with SMTP id
 i24-20020a056358339800b0012342d7e6f4mr7837897rwd.26.1685679480696; Thu, 01
 Jun 2023 21:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143331.405588582@linuxfoundation.org>
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 1 Jun 2023 22:17:48 -0600
Message-ID: <CAEUSe7-qcYwBbeFGKAOvf-rPMdgAMfE6t42Urnhjam9nWN-gFg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, 1 Jun 2023 at 08:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 Jun 2023 14:33:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.115-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build failures on System/390:
-----8<-----
  /builds/linux/arch/s390/kernel/uv.c: In function
'should_export_before_import':
  /builds/linux/arch/s390/kernel/uv.c:204:40: error: 'mm_context_t'
has no member named 'protected_count'
    204 |         return atomic_read(&mm->context.protected_count) > 1;
        |                                        ^
  /builds/linux/arch/s390/kernel/uv.c:205:1: error: control reaches
end of non-void function [-Werror=3Dreturn-type]
    205 | }
        | ^
----->8-----

That's with defconfig and GCC-8, GCC-12, Clang-16.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
