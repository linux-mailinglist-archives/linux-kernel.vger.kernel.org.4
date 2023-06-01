Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F171905B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFACH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFACH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:07:27 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B3121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:07:27 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33b6c47898dso1341755ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685585246; x=1688177246;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/M5h4harHoO86/1QKhzoJ2dsgkBAONv25mRd33XEaA=;
        b=q/iVbjxtwl2EmFwc1MbssJIBEKiREUQtXVzVmwW47tNe3q+xWVx0875dHHi/daZTGR
         9tEhvzb0hmNGMqIuGQyjTQtzJJIN1yuwP3nTd7o/Vlc8LBgUNA/xtOiX2KSnjiDcnSUG
         lqRZyXCkLHSpzKyXxaJgfIml2q4csqBiHpYY0cBdX47LpMehOksRW4QlNGxI6eDIOmEP
         XqtozDrK2XIrwxdcWkZH9c7XKehWAMJB1cPYliRUdWVwFBYLSagp9mGpwFZ+ivbjCKh1
         Ylevmv40t45vddyzbfpT1V+B2OkBQlEqu291HKwSt1zJbToa51Ny4d+o2p5QlBAVetag
         QdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685585246; x=1688177246;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/M5h4harHoO86/1QKhzoJ2dsgkBAONv25mRd33XEaA=;
        b=XsU0nfzvfcCDgKBt4KXD8sv5OsNOVft09mYwK1MxjTx96xGPtrB57UboQqrFJpwS+D
         Erv3O5xY/mmvRURGoX6uOYCqY9s9Ul1WqlmWDx0mofiIikkcRF9D/iar0iAYXM8xs4Hz
         uN3gq1zG54NJTWisGXYIqKRwx13t/8ECmXbHlyTFftzFdj999FPKLEaC2iDzDKos7m83
         D3RR5OqrYIPjZDSckdxwcD459bJ4vadCPscaZDOYMGaRXR/24iRg942EG/g6gJUFrhRU
         shTA5MEZr3cqURQHr2+iFZUCkHajx9IEP43yEkmZNQJM9t7HVLWyg4sGgxOb4JcKApS9
         HOmQ==
X-Gm-Message-State: AC+VfDw1DbmSzyMjn6+SnBLFA0L/hwZvZOsiiDIVOGsyWwCWPIMN2HFk
        EeL/NWi00mCkMY2wlZwzcXWue7BJYS2hRQ==
X-Google-Smtp-Source: ACHHUZ4rAxDLCqC6cBsT96Lft7pEoJHYbM16vXsm6msuGy2DgWo5yAvE403ZmDvihnLYyZvkZPvlww==
X-Received: by 2002:a92:d410:0:b0:331:7203:b8b0 with SMTP id q16-20020a92d410000000b003317203b8b0mr4847083ilm.3.1685585246357;
        Wed, 31 May 2023 19:07:26 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id i13-20020a633c4d000000b00513ec871c01sm1960407pgn.16.2023.05.31.19.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 19:07:25 -0700 (PDT)
Message-ID: <69dad53e-9363-c551-111a-d0051bb0265f@gmail.com>
Date:   Thu, 1 Jun 2023 09:07:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Started to get "memfd_create() without MFD_EXEC nor
 MFD_NOEXEC_SEAL"
Cc:     Jeff Xu <jeffxu@google.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stuart Foster <smf-linux@virginmedia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Recent kernels seem to generate this:
> 
> "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=3976 'Xorg'"
> 
> Is this a kernel problem or something to do with Xorg ?
> 
> Seen in Kernels 6.3.4 and 6.4.0-rc4.
> 
> Thanks

See Bugzilla for the full thread and attached logs (dmesg, xorg, bisection
log).

Anyway, I'm adding it to regzbot:

#regzbot introduced: 105ff5339f498a https://bugzilla.kernel.org/show_bug.cgi?id=217508
#regzbot title: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL on Xorg

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217508

-- 
An old man doll... just what I always wanted! - Clara
