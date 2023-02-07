Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094FF68CF60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBGGO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjBGGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:14:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC76C7D94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:14:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so9086856wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdFVGAx1covm2q2sRMPvEr8/Gomqfu0eE2NFLMvbVis=;
        b=qUHUp5lTo+vD5C+L09RH8OsMPhfhUpQD9HzSkAojyBHPMIONf4RRqfV1vlbMKHN+ww
         3xxq0gaSGbVukaICmqgE+JWF+981MTQnYw2tgWXnURPg/yAS/jQnIdAhDHnaCrIK2/i/
         SPlHaxjHOofEXZu0exov2nsH220rNcSL1GzKBohjgouqZG3ZRROq73ouMzwmUoyGK0kA
         ObiZdzE3yx3BnYmAC/RJFAkCsXf8O1oSh7uW5HecectHdMHPAxcHKO5oG4/dRLw6sJqY
         i9j9QwwM6ML2iaFfZZdEAqJqoQTPzOHMtpMO6Nh8P7vjYCkW/1GH64UzF1ph/TGT4nE8
         Jrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdFVGAx1covm2q2sRMPvEr8/Gomqfu0eE2NFLMvbVis=;
        b=LDgSg+AeUu5zw57kuG/FJqad6JmJmvHbKe5GVdtU4jALiA11Zx/o3/WBEiTlhsOKjH
         g4pyfGnfQn4qpbZmjpv24sv6/VQWrG6cNVI7zG10I0YpB2awP9CreIEOqGqpDyI2rcql
         B7f+PEBeeRanWV4cMOH1sgRxS1ZpoeAV/osduF3bQ5U/iaNsvm2wSLG8M1Kxo/xxFaYP
         84x+9lOcXNk9nCLXp4HJEMJshP9xtXeYLbPZcoZtLwpaFAtCd3acqkNLkcUvW9My5KHH
         z1t2P6y8ITjqP4hTRN5BRJyJptxC9yDQeFLU7NFzQfXtXIrH2Zpn+zpK9U8foz3nwUIc
         y4Hg==
X-Gm-Message-State: AO0yUKWHL30J3v178x8G6RD6kPjmojK8k01oHC7dqznPeJ9mdtXWN1Db
        5mJ+LPhX3mYWzdTI2c3Zl98=
X-Google-Smtp-Source: AK7set8ZM5RnRn+Xzs5gncopr+Ozvp526xs+XyfaFoMo9FhvENwHlCOcNQCRNL54I82Mqi9GWGxhgQ==
X-Received: by 2002:a05:600c:5127:b0:3dc:5b88:e706 with SMTP id o39-20020a05600c512700b003dc5b88e706mr2432237wms.1.1675750454410;
        Mon, 06 Feb 2023 22:14:14 -0800 (PST)
Received: from [192.168.1.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id o35-20020a05600c512300b003cffd3c3d6csm13821014wms.12.2023.02.06.22.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 22:14:13 -0800 (PST)
Message-ID: <684a1fca-9697-fbea-58ad-34d5860e3af2@gmail.com>
Date:   Tue, 7 Feb 2023 07:14:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3] simplify suspend/resume functions
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230206210124.150142-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230206210124.150142-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 22:01, Martin Kaiser wrote:
> Here's some simple cleanups for suspend + resume.
> 
> Martin Kaiser (3):
>    staging: r8188eu: make ips_enter static
>    staging: r8188eu: make ips_leave static
>    staging: r8188eu: remove change_rfpwrstate
> 
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 23 ++++++++-----------
>   drivers/staging/r8188eu/include/rtw_pwrctrl.h |  3 ---
>   2 files changed, 10 insertions(+), 16 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
