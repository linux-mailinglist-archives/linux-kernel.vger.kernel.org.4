Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F518621E91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKHVdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiKHVdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:33:04 -0500
Received: from 002.mia.mailroute.net (002.mia.mailroute.net [199.89.3.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A66177B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:33:03 -0800 (PST)
Received: from localhost (002.mia.mailroute.net [127.0.0.1])
        by 002.mia.mailroute.net (Postfix) with ESMTP id 4N6LtQ46y5z25j0x
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 21:33:02 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 002.mia.mailroute.net ([199.89.3.5])
        by localhost (002.mia [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id 0CM0EMVOn62A for <linux-kernel@vger.kernel.org>;
        Tue,  8 Nov 2022 21:33:00 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 002.mia.mailroute.net (Postfix) with ESMTPS id 4N6LtN2rjCz25hXw
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 21:33:00 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id x18-20020a170902ec9200b001869f20da7eso12036879plg.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XvzS6IZtUmkiQUDObZubbiGEND3E6ynZXlDGWsaowMs=;
        b=l7c4lds6IThIy6cpCrJ8JMAWwePfEggJx2upPpc3rjIqN8y6Z7TTt3Do7NRhw8L5bt
         A5VacmPLn8vYrVg2Wm1+czEn3xk2Yh1DWhTJRfG5sk98G/xwwKhV4/v0dywSgk0Phfua
         GrHug2zpEuIkf4ghy1X197/cseDQCwSsfXIJEoP9p+ZZHZEwIVzgz+OO1qhCLJbNkf0f
         Y0t7LpoND24vEM6snXgeh5SK+NwJ0lrrLMDrhWQs6JuiKhTyvW38PklAgc1RBKMRSY9k
         DNTcxUeVwKpmIlUHRdBRuOizfXY40Czy99sshCHdA4s9gdwD8GxptqkHvUBRB6PI3q4l
         t1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XvzS6IZtUmkiQUDObZubbiGEND3E6ynZXlDGWsaowMs=;
        b=gbFBKsafRw1qr5lNlhvOJ1KHWtUi7VVNL8EpPjzN5nefaS3BPR5QhGO//2BsCqjTkX
         TYzvnjn/7NeiqIq3o/25DY0YvgEcUKi5KS/UsY8htP4OuM8Sdp6a1GDQAAnlUTntFbsb
         aIyv73z5ir5yZoBSFngv3u3rprvbZa2cuElnEi+cztOOpDeFz4lVHvoMZ+wxa4CJdQnG
         3XFyPHiwvZyE2bRuUxtUj4aOcd9102cJ9XSFos4mKwgJ0DeCreFSP0LSrWyTgG97Ls0r
         GscjFrf8pdnOKlBxK2yiO6hhAxecL8y2ICaT7WDuiFzHZzQUgzfyCdNNoYGRK1VgaWUV
         W8wA==
X-Gm-Message-State: ACrzQf0sTKjLsfWTs/f/hE+G/AFdZ9jx2jCQ9lpCyqJo7+0ZMasZFTTG
        E5NjKRzzsiJRVVEC0GGF/LoiBpnWsCjGVTQSFWEGx98jAKHaI6srEU/mICpEaz/2QvaQkPjRY2e
        G8hBs90FjTzw9kqEQo7/ezEMP6FPaBtJ7Rgn2FL+wPQq3qbOpSqzkDmo=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id y8-20020a1709029b8800b00188620d90fcmr27845606plp.61.1667943179059;
        Tue, 08 Nov 2022 13:32:59 -0800 (PST)
X-Google-Smtp-Source: AMsMyM74u/1SS2WCRO6VZM04gxufQf/tkIwogn2aFn4BzsnsFTbOeo04Kfkbq/L5Z9sbrGMnJiqbRFzjakLsbFoktOU=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id
 y8-20020a1709029b8800b00188620d90fcmr27845580plp.61.1667943178750; Tue, 08
 Nov 2022 13:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20221108133345.346704162@linuxfoundation.org>
In-Reply-To: <20221108133345.346704162@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Tue, 8 Nov 2022 16:32:47 -0500
Message-ID: <CA+pv=HOud9PMz7e9N=ffyF14OeDWU0ddDrZJADaqTPP-q7k6-g@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/144] 5.15.78-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 8, 2022 at 8:59 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.78 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Nov 2022 13:33:17 +0000.
> Anything received after that time might be too late.

5.15.78-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

Best,
-srw
