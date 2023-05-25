Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E538D711745
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbjEYTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242909AbjEYTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:21:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841472D66;
        Thu, 25 May 2023 12:17:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2538aa25873so74635a91.2;
        Thu, 25 May 2023 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685042140; x=1687634140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vD9x7QANhEDW3ZYK/Nv1s5u/+9spAL4qRvjdLuUEXnw=;
        b=gY/WqbDO2dsbcTaVqdWRDV93u/7xbCUOLAbKWzPEtNF4BRi2usRUXxby0auby2u9Sk
         Q4i/Cx9aaGiw0rNKzulopZU9PsbWQn+rulu1qCAbk9wCaa1BOPPg5MOuK4oz6WZmsNFo
         oY/amMsNSRvwHxylqMrWeUUz0EdRWQI5W335aA+VCY+2D/roy0SbRPSSZSbbBgvj6I+L
         hMqeNX+n+8/CqP8c09vzkD3LQitgzt91/+NSQZFscEAJh2Td+reFAXHZA1wbjvLvKEXM
         rlMh7Ns+hjLIprwo+5AIFNeZd+wN1Olvl+UlYNLEfdIqSmThzEcO4URgaSXqSHXvLWaJ
         zMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685042140; x=1687634140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vD9x7QANhEDW3ZYK/Nv1s5u/+9spAL4qRvjdLuUEXnw=;
        b=kFj5moLF3ULnG6ilsUfeQij+IGvle3OAQm8WMZekTKrSQnz0IvCFGg4mhFNsl1HM9R
         Dg9ZByIuNw3BvZ//vPfA23VyXSLzFvsMnAm8qyw2cxBSAoVVyjnVHePiBYAUrir9MGpx
         UxZOdpuqQzJXBeeTnMIacCfVMAXUW1NR/OW6BHD0+bZGxk1NWSvwar2/kKjj6kNssyH2
         KBGwMAH/u5iqzA+WnygEX2fPvISXCD7ZOnzJrlT+mcYVujoT3mTJ/ixVTWsV0nKbpzGw
         Neoo7SObheMWG44fAZNwkJDgk9zwZ5Sv8Bxm8fbp9dtJkgRreQQGpqLzFYWof7CXpawg
         vFLQ==
X-Gm-Message-State: AC+VfDzRXfdkG6DZVr/ton/pT4qJin4NRPGsnP6AUFqdUWcqE1ZOKZ3c
        DOz9HyITgDx/9Gt5CKKpfVF6O/zyJYJnQPGeifjmwTnM+Go=
X-Google-Smtp-Source: ACHHUZ6tdB8wkjjb1SWqZ1GhpGQ/2w3tMK5HlcJyzjQcAQG1inzfeSu3o0keKePlJynIx8D8qm86vKV0GCjYkTQ6bMQ=
X-Received: by 2002:a17:90b:3810:b0:255:6c5b:3660 with SMTP id
 mq16-20020a17090b381000b002556c5b3660mr2866730pjb.20.1685042139768; Thu, 25
 May 2023 12:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230523164950.435226211@linuxfoundation.org>
In-Reply-To: <20230523164950.435226211@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Thu, 25 May 2023 12:15:28 -0700
Message-ID: <CAJq+SaBU0WbQ+SF3FvcF45Jq_U9KMjuPDNhdmXme5HRL249+9Q@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/363] 6.3.4-rc2 review
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

> This is the start of the stable review cycle for the 6.3.4 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 May 2023 16:48:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
