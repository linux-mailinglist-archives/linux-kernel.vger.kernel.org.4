Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B94663401
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbjAIWeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbjAIWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:34:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF031A3B1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:34:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vm8so23971250ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrfnj92qZV9YKD/X88FUYEhh1ZiUzM2jrGqzUrMkfuk=;
        b=ZEz0LqnW0DVKY426fn/ys0ikA02+XSjrZKzdMdAtQJfKWrkT0Wza+pSTE4ESvfPpHm
         UutkCwvBqV2/6Cf5dpx3HWzChM6Pvn6fPeonWBWZjsHxhsHwX6DTjSM9ugIqoMO/eXOd
         OMRFe7e5QAZ4Zfo9V4wOB+MHm2C4Q+V6FsNPVIh7QIiuNQGdAUIAhp2oqfTRdaNYqdmY
         Mi2E9hh5G3nBkziNjEFNRrkHOvCV6ItaEcVwKcqQEuEJIONWw1/QclfPb1JAQXYwVzNu
         ustDqipzElqrSYOfsG0JJ63qQgY4DX8Pnkssac0MfkddoVFKi4Moo2UJi46Rn6e5Iw/p
         /GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrfnj92qZV9YKD/X88FUYEhh1ZiUzM2jrGqzUrMkfuk=;
        b=ofrpqhZP+XWaIdCVvZRhnyUEukLMGsJRVPRyToKflCovlfDB5TrKRjjA0HK/oLb2sN
         pZfYwbz75z3ACwI+TT7qyORCRnU3tAwTATO9DsE6bscEoaOh1M1UMj4galJINYJgkhII
         N9QOF7cKJXD/FMW08Q0cKUSGg7Eu10C5XoEGcdTCTo6No+P3P1H9awj0zIrRlkpn7BzT
         ITEHXg7KSP4ExeJxji7kYwOJauc60G4fyAu3Yd37tzlsFFHPdxrFVUD7rsiOxuKqtS+x
         TuM4Fs/qjEnziZvmMJNfz1XgCFFH/hNxgej5nSmmjGCFn4y/igXR+mnUO33JpU7Ibgx4
         lhNw==
X-Gm-Message-State: AFqh2kqa6baY+Y52uqd/G1J3j4Gdy/31xaBybQuOSsDm376oWAZunnY4
        TgljQRoPi0IXd9FUcWhaLN0Iduk5eLA=
X-Google-Smtp-Source: AMrXdXsM+c1VHFzHaCsf3M6QGLEtt0pIt1VJcbyCJieByfpI6Uo/kcPt7H1vXOo2Cqe/b6zAgywJBA==
X-Received: by 2002:a17:906:280d:b0:837:c290:eb83 with SMTP id r13-20020a170906280d00b00837c290eb83mr14496758ejc.2.1673303659631;
        Mon, 09 Jan 2023 14:34:19 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id d20-20020a170906305400b007c0d64c1886sm4203377ejd.33.2023.01.09.14.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 14:34:18 -0800 (PST)
Message-ID: <fcbe9f78-bd22-4ec0-9768-9320a1c946fd@gmail.com>
Date:   Mon, 9 Jan 2023 23:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 00/12] staging: r8188eu: some more xmit cleanups
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230108185738.597105-1-martin@kaiser.cx>
 <20230109212852.75612-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230109212852.75612-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 22:28, Martin Kaiser wrote:
> Here's another set of xmit cleanups, based on my previous patches.
> 
> changes in v2:
> - drop "make rtl8188eu_inirp_init a void function" patch
>    (we should relay the return value instead of discarding it)
> 
> Martin Kaiser (12):
>    staging: r8188eu: beq_cnt is write-only
>    staging: r8188eu: bkq_cnt is write-only
>    staging: r8188eu: viq_cnt is write-only
>    staging: r8188eu: voq_cnt is write-only
>    staging: r8188eu: replace switch with if
>    staging: r8188eu: dir_dev is unused
>    staging: r8188eu: remove unused hal_xmit_handler define
>    staging: r8188eu: txirp_cnt is write-only
>    staging: r8188eu: remove unused QSLT defines
>    staging: r8188eu: xmit_priv's vcs_type is not used
>    staging: r8188eu: xmit_priv's vcs is not used
>    staging: r8188eu: xmit_priv's vcs_setting is not used
> 
>   drivers/staging/r8188eu/core/rtw_mlme.c       |  5 ---
>   drivers/staging/r8188eu/core/rtw_xmit.c       | 42 -------------------
>   drivers/staging/r8188eu/include/drv_types.h   |  1 -
>   .../staging/r8188eu/include/rtl8188e_xmit.h   | 11 -----
>   drivers/staging/r8188eu/include/rtw_xmit.h    | 10 -----
>   drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 --
>   .../staging/r8188eu/os_dep/usb_ops_linux.c    | 23 +---------
>   7 files changed, 1 insertion(+), 94 deletions(-)
> 

When applying first the 4 patch series and then the 20 patch series this 
series is working.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
