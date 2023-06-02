Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67914720127
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjFBMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjFBMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:08:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B21AD;
        Fri,  2 Jun 2023 05:08:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5148f299105so4276478a12.1;
        Fri, 02 Jun 2023 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685707705; x=1688299705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NX4MckBz+kMOWWfYXwQZwvt4Wo7nQreetEG9P/8etNY=;
        b=MDzogKGgpQt2NfKjKR2ABAnQ6PSNWZBvu0fv2J7+xfF5C41DC4RF+q3E1HGzB0ZMhV
         vHzp6MfzR3ujs2eivp/hgH73nCaEqHdwBbmjp+BzD+PFpzlXJJd62OaE0jrWUq2cCcbm
         gAaPwxRgLE1xCK+PlxIQXar26PrNut/5fYWOfALJs+aBTHb5TQ8uzlPaG15A4rqEJprO
         +KxRj8cRVm2tzTFShQp47ZqeyOr6Sb5mgGoLwlLlaBUEZP6ZVD1uEY0EX7Rmw0n4S8di
         sH37RgFaWRfkAfUwA15nmc9k2lLP2JDou/XXZTtg9KKBQZYPR9d2GMFLyR4vj8bpO4EJ
         Mzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685707705; x=1688299705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NX4MckBz+kMOWWfYXwQZwvt4Wo7nQreetEG9P/8etNY=;
        b=jrw4DU+kvwEaWUKq6ZJ2263aJ0AExk9b8yV0l3C76wu6m5K3WZFdGFvlggokPCpvRF
         95+bL/4l2mtBHjrajS46eLwONKiufcc4OTw6tylhg0bhWa6SlBL6xRMsjCkrBn7t/wNo
         UyyERL/TnLkVgZfxjwccX7bsCgkJZBx4jqUnxoJ5YjlGwxL+Nj+UAXAabrKPXwB5jiiN
         XdyVnZaqsFFf4cNcq+GFMCwrn17ECuJdvfx6haw9FK3ypGvjb8kpQPjiV9lAutIrO/PE
         K5htmEotSKrjXUd0JAJUfWoYMlzDpPHKFaxJKdtKdhqcUrmfarBjBdtH2kgjziV9eQyR
         DQfA==
X-Gm-Message-State: AC+VfDxmOZ0Wchw8HOM/qi5P9QSzBTlEXazkRxfzM2DJRWKj0xoEWE0A
        k7tslmN7njU7hl8xRCG/SL+Tj5WyVMCOHafY+zUCNJjMOVY=
X-Google-Smtp-Source: ACHHUZ7gwc/jkjRlVjHpwzT1u4y5IMyFOHYEnDBUueOVz04IhMv9WNJUyTIVgu1hKV5sLIk5Pcee5Br2y+E0OQbis5Y=
X-Received: by 2002:a05:6402:5252:b0:514:9e81:6185 with SMTP id
 t18-20020a056402525200b005149e816185mr2701109edd.16.1685707704786; Fri, 02
 Jun 2023 05:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143331.405588582@linuxfoundation.org>
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 2 Jun 2023 13:07:48 +0100
Message-ID: <CADVatmPDwobeqntQ5+LQibMSHK86FmwUpN+E3JUd+GMs3bWpDQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
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

Hi Greg,

On Thu, 1 Jun 2023 at 15:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

s390 allmodconfig build fails with the error:

arch/s390/kernel/uv.c: In function 'should_export_before_import':
arch/s390/kernel/uv.c:204:40: error: 'mm_context_t' has no member
named 'protected_count'
  204 |         return atomic_read(&mm->context.protected_count) > 1;
      |                                        ^
arch/s390/kernel/uv.c:205:1: error: control reaches end of non-void
function [-Werror=return-type]
  205 | }
      | ^



-- 
Regards
Sudip
