Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31160D354
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiJYSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJYSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:17:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BFBD4A2B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:17:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fy4so14821117ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiQ/FKVprfl/2j6yZVqBybauBhLs5z930z+sCk9K3nM=;
        b=LyzJdfBL3yMDCxf4Qm0esMjRa21JjpNLc4v9SM6AJF+64S0ORaeKR5qTB/MDl+njxI
         96a4HjyvMqBivfDIc+RS49ViPavuFAwTYBCTevrlS5cy9ZXirBRSXGthluuJUe1Ut2q3
         J11itIc6Blxie8j5wFFFpivd7qd4cMXdPfpPeBe7FxMKiPI0k1DVeRZL2Ds9TKlYLRw4
         SIyrE/On7pOntxu3tCHFLPTbVhHM5cDBHSUzBBNjwoFFHEZSJFJmaJzkOSb4GImwypyT
         GZJO3lTPCc2t8pVyShvq+TZYeQS0uKBT5CGh/uOiuHdGHdEluoJmHtQxPVYOd0VG950W
         Yaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiQ/FKVprfl/2j6yZVqBybauBhLs5z930z+sCk9K3nM=;
        b=Mgxok+rIYMb9gVEBFoRZkBrCJPSwWguHBnjyEMLonWFERky70petNedYPUedJxu4f6
         O7NCAy0DJMVE5/2bV4n21grEi8cjIJD08qSxFCHV2On8jBtnI+wYBZcF6/zovkdmLlaG
         F+zF7H9bZ7Lkpj68wFyDwb6fhqgwX1gnRE8Y9tsz5kAPhgi+ItaLGMCE7PX7DJ9YxDql
         SeZlQI5g2nvfgYBqFpoVRvOi6NxaSTpjvClaKhd7Z0UVgz8tIUpDJilDeb2otAQCHkrs
         sSTJtj1B1lCKVMz84n7bLs5x4zDX5HZ8XsFbA+gxz11MVDuMiTaeoY8oL0V427oJ8wVb
         svXw==
X-Gm-Message-State: ACrzQf2UFod/4EN5jXDP0UUp4ROaDJzo1sH10L910evBsmylm18ktHdy
        Eu8OstDw+zzZuL36bWAv2RY=
X-Google-Smtp-Source: AMsMyM5NbyC+Op50jHKNtYvL+5ipB36yuW0xS2E6j5aONwfU9fzrWIBTsu3w8xNHOJ6SAud6KYzeYw==
X-Received: by 2002:a17:906:6a18:b0:78d:7228:7a52 with SMTP id qw24-20020a1709066a1800b0078d72287a52mr33141434ejc.363.1666721828058;
        Tue, 25 Oct 2022 11:17:08 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id gk19-20020a17090790d300b0078b1ff41f05sm1775924ejb.43.2022.10.25.11.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:17:07 -0700 (PDT)
Message-ID: <4a8bbc23-9d17-c6e0-5da4-a799cf7d332d@gmail.com>
Date:   Tue, 25 Oct 2022 20:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/4] staging: r8188eu: cleaning up unused variables
Content-Language: en-US
To:     Kang Minchul <tegongkang@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221025170621.271903-1-tegongkang@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221025170621.271903-1-tegongkang@gmail.com>
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

On 10/25/22 19:06, Kang Minchul wrote:
> This patch series cleans up unused variables in r8188eu
> causing coccicheck warnings.
> 
> Difference between this patch and previous patch is that this patch series
> include making function rtw_sta_flush in r8188eu/core/rtw_ap.c
> into void function.
> 
> Kang Minchul (4):
>    staging: r8188eu: remove unnecessary variable in ioctl_linux
>    staging: r8188eu: remove unnecessary vaiable in rtw_recv
>    staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
>    staging: r8188eu: make rtw_sta_flush to void
> 
>   drivers/staging/r8188eu/core/rtw_ap.c        | 7 ++-----
>   drivers/staging/r8188eu/core/rtw_recv.c      | 3 +--
>   drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
>   drivers/staging/r8188eu/include/rtw_ap.h     | 2 +-
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>   5 files changed, 6 insertions(+), 13 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
