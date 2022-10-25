Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3788460C290
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJYEUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiJYEUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:20:19 -0400
Received: from 001.mia.mailroute.net (001.mia.mailroute.net [199.89.3.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA8280F45
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:20:13 -0700 (PDT)
Received: from localhost (001.mia.mailroute.net [127.0.0.1])
        by 001.mia.mailroute.net (Postfix) with ESMTP id 4MxJd84cxZz2KYJT
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:20:12 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 001.mia.mailroute.net ([199.89.3.4])
        by localhost (001.mia [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id zVRaAoyQkzrm for <linux-kernel@vger.kernel.org>;
        Tue, 25 Oct 2022 04:20:10 +0000 (UTC)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 001.mia.mailroute.net (Postfix) with ESMTPS id 4MxJd62lPlz2KYGl
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:20:06 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso10525861qko.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8mS3ZClJNgqsihJ0X5F4JJv7HMLZyAYVyP+E4+4PFQ=;
        b=Bgcd3Fe9GWwD5o3guJVv+HFd7EGNj2a7NcMAuybPhotU2LA9XCINi4sy5Mx2gvkx+d
         dUqxmmnJJSH3zPebrcyGBxxRC8FCy1rW4tI7Tbn3q7rxgQTxRXjSmtghSnf+qjc++BgB
         mYnOnV9KksPEnccXrANKW9+ghvlwgrDfC2m9kzZJSNj6lXIri87abNkNcbqa9YJdBJy6
         PngCi1J5XJ4c1jfbPK5902tO6tN+RNt+maPmdB2NW2Cv9Dz51jzfEjRHib8RTeguoyvR
         emZf88e5uRB7SsXvM13uc4A16/5xqeTF16sfrtt0luyzBlqHXwRffCVbHCNDyfsWggjs
         JLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8mS3ZClJNgqsihJ0X5F4JJv7HMLZyAYVyP+E4+4PFQ=;
        b=BbPUm5r5opOUZQy8AEkamYu9iU9rctR3iTdBpt9tjS9OrvHsjrrh6rh5aCQDHwJNLi
         4VgUbCs3a5O95UyXH4tXAQwRGAsKRmJ+vjiApuguKQagSDsuTNhhiz3y5jB69rk38uaB
         G6YneHbhe+XPqRsgYfTsvxfIoJFJ+XYZ5njqHY+ZnSw9F7viarG2g56Q6Gi6hqh3zGHz
         nmwaPwYLpczM2MN6B1ALUXyL89t81Vt2llNnjWDSlvVn0Uh91YumRATkki7IJeh5JquW
         //Qn+cZATU2taJxhYXX7nX6jleW4qFXKooCJvChU7t48G265rn8gd0A8GaFt+z8VWm67
         /DvQ==
X-Gm-Message-State: ACrzQf13r2utZUaUBhFSHeiboBREqsmEKK41OZK6P5/elU3yx21eY3zY
        FEblieRduw6m1VVMJXqYsKrqMS+NoKOp1GytCj1JNPHNqmm9VcBROuy1k5jIUcxi/KCbeKZfoGp
        0UHK5MjBLCabTYhVTOKD/Fpwebo5ixzkTtci6WKc=
X-Received: by 2002:a05:622a:1751:b0:39c:cbba:d07d with SMTP id l17-20020a05622a175100b0039ccbbad07dmr29555972qtk.30.1666671603762;
        Mon, 24 Oct 2022 21:20:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6xVT20BgZkdY5nyA12mPCd2F8hd4CAbsistp3630quXgcK37atx1RNrleMQtbYgcGa3U/RIQ==
X-Received: by 2002:a05:622a:11cf:b0:39c:d63a:d79 with SMTP id n15-20020a05622a11cf00b0039cd63a0d79mr30201344qtk.260.1666671592404;
        Mon, 24 Oct 2022 21:19:52 -0700 (PDT)
Received: from [192.168.1.39] (pool-108-4-135-94.albyny.fios.verizon.net. [108.4.135.94])
        by smtp.gmail.com with ESMTPSA id a1-20020a05620a438100b006cea2984c9bsm1264662qkp.100.2022.10.24.21.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 21:19:52 -0700 (PDT)
Message-ID: <9d34e1f3-ad51-0850-c6d5-1c0550f38c58@sladewatkins.net>
Date:   Tue, 25 Oct 2022 00:19:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.4 000/255] 5.4.220-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com
References: <20221024113002.471093005@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20221024113002.471093005@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 7:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.220 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Oct 2022 11:29:24 +0000.
> Anything received after that time might be too late.

5.4.220-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,

-srw

