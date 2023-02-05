Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51E68B10E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 18:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBERJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 12:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBERJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:09:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4DB18AB5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 09:09:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so5703143wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 09:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4QiDXFr4mw240bfzl7O2fxCsJ5gItiHfX5GZV8KWs0=;
        b=MfGb2jnj85yUo0O5qUfMu5TFbaUgFTQ6R9c22GpHDRQ6kSBCFJm2ExS13SfoiFETDV
         2+l+SgRn+6fiHGC+SA6PGSDkfhFRqL8+LWhbuAY6L5Alnso2JC4z/S4o7LfePbuEKmcZ
         hpTE6XKHLj1hi3KGH9MEPlosm7/9a4cAjGSaJ8Uhdd5QFG/oqCoDHUUY358SrSrQw7a9
         jbBZBLGC1MxfeyYM3uYlSVfvgLz1jXlGm5zHD8BfxnUGGy+I9bzENsqeeEd7PZZ5YuGb
         Ji6ens8o2PIABPaYdrQX3rN5psMKwMSq25mgPbMV/yNTLAjecILZXAyl2hgx8C12YZHY
         NtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4QiDXFr4mw240bfzl7O2fxCsJ5gItiHfX5GZV8KWs0=;
        b=FFsFK1D1MhPdxdAaLyZkAyTKgdiI40zfF3QSeeVKTrOT1tShkfgq4RcQt5cICwubcg
         Los4uOAY4SJaZoY2PyT62QStMLEP7fin+yc1PGmvOPYRQsLQyjNqvr0Ca+Xnj5HnbS0N
         uSrwTIsKspDiXXesSREPvGAzwua6TsVc9T1zt/+4wuzNz2orC3zWphgUErmP+Nq2rBHz
         q9gNyoTPMel95E+Vhz2adtzu80skY7NIOc7gu1v4osRl1tyWGaBRsUqyBP8oEhAKRjfH
         V1cpSInUZrybrz4+I6cePaAsgQTxDGIecvzI7SusS5NF21BBv2DZXlml9VDCI4RDTk7M
         lwHA==
X-Gm-Message-State: AO0yUKVit7f3bcjVgIcQJln5uMCgHEpJvFlFMPAdO/ZJYRFzB3TDDZN5
        WO71F3DaXutoGwr4L6yTCGE=
X-Google-Smtp-Source: AK7set9AaQcIhMbVdATIo7OI8LzRZGYzrEufzDnETwznpV2KfLtuXtAkmQV7lfP0nh7pLov8WaJLxQ==
X-Received: by 2002:a05:600c:1d9b:b0:3df:fc67:cfe4 with SMTP id p27-20020a05600c1d9b00b003dffc67cfe4mr1924532wms.3.1675616967388;
        Sun, 05 Feb 2023 09:09:27 -0800 (PST)
Received: from [192.168.1.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d4e10000000b002c3e4bec4dbsm2021392wrt.89.2023.02.05.09.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 09:09:26 -0800 (PST)
Message-ID: <cf5e714d-dd02-7e30-bfe7-7b32cd198c82@gmail.com>
Date:   Sun, 5 Feb 2023 18:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] staging: r8188eu: correct error logic of two
 functions
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230205080559.8319-1-straube.linux@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230205080559.8319-1-straube.linux@gmail.com>
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

On 2/5/23 09:05, Michael Straube wrote:
> This series converts two functions away from returning _SUCCESS and
> _FAIL. Another tiny step to get rid of _FAIL / _SUCCESS someday.
> 
> Tested on x86_64 with Inter-Tech DMG 02.
> 
> v2:
> Removed the initialization of the variable err in _rtw_init_recv_priv()
> since it's not needed.
> 
> Michael Straube (2):
>    staging: r8188eu: correct error logic of rtl8188eu_init_recv_priv()
>    staging: r8188eu: correct error logic of _rtw_init_recv_priv()
> 
>   drivers/staging/r8188eu/core/rtw_recv.c   | 30 +++++++++--------------
>   drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
>   2 files changed, 12 insertions(+), 20 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
