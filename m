Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF372EA34
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjFMRqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFMRqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:46:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C48EA6;
        Tue, 13 Jun 2023 10:46:08 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b2a4cb5776so3812391a34.0;
        Tue, 13 Jun 2023 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686678367; x=1689270367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r+5mwwaA6A0ULLPC2ogIpHLP4usp/UGrYH5kzIP5CcU=;
        b=Xi5Rwukde4hySx+dADQprbbqtXFg27ORxv40DoaCuyfYEqZsATebk5ZxwPqxdpYr20
         4ZDqtaICcRXMkQDMA+pMwpadAEv/5HhzX6AJ9yOJ0C4sSo/GumoX5zJXG5lclW6e9wKq
         b8pYGA/lyCOscOOo+cJqVD7R9W/rQPu2X+EpPRtjWLriqZikEq+EdWVzGEKSOb02j4Og
         qB8P/3B+vpaGKWlgnFcJG7nr3GnJtI47SGR1gsF8o4b7B82xKvpe3LSxu55Do1MeO7YR
         G1lDQAu32+6HKzptIooiCDtOvtLwVikauPmZW9e5Aya/sO0fVGJP2s4pmQsue5KNueYJ
         Zh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678367; x=1689270367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+5mwwaA6A0ULLPC2ogIpHLP4usp/UGrYH5kzIP5CcU=;
        b=JwKMjoX0WE1ynoRKsM8qc3WmXYZ/ma6QQycsXVJ8yRY/wHXHDUzzES2e/TgN8wbEqP
         Rr/DLY6OeCGeWLUazlUqdLpruja6P9TFooXo0hSgpN4Hw6KK6zPsCsnHC+FKesx/qwj7
         joh55SgfV7sd4QiORVBIATXp6CmY/KwZtZal5MYtnV5C6JMFDeXkfUpSbM4/hZo4TQxG
         92nay1/mm9HCVAoN4IECgevEsnOQSJsKb0r2biglO0h9LJPG3TJJrHRivjcm/AFA4tv9
         VE22zD65EZF7TIU3AmTXl9ioiVMLIbLq1McUXUniVbcU3M1iDXwQ9RonmzEAKEO64bzL
         3RCA==
X-Gm-Message-State: AC+VfDy5NJfJV7yyiOnilqSwrXpEyrdkx4/xeafjfXhnSKkPUfZm6gaB
        ytBPsyGxB4Jz2Tx8S1VzlGf7tQ5PuW43KA2HCpM=
X-Google-Smtp-Source: ACHHUZ7rAuJaneU4XmHOr/sNK6EYX6i3ZzOzTFK+UCnoMHQU8H2iPTj6JJkrv3m9uGffddzwLg7nW26CkbWKKAMC7Mc=
X-Received: by 2002:a54:450c:0:b0:395:eada:79d2 with SMTP id
 l12-20020a54450c000000b00395eada79d2mr7802606oil.52.1686678367345; Tue, 13
 Jun 2023 10:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101658.437327280@linuxfoundation.org>
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 13 Jun 2023 10:45:56 -0700
Message-ID: <CAJq+SaCrwy0JkryrFFC5Nq2WVH4cX2um6HJdqYksoV8rxTx_cw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
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

> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.184-rc1.gz
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
