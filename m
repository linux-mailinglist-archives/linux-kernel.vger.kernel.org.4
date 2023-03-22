Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE086C4124
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCVDhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVDht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:37:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCA12F79D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:37:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l7so323823pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679456268;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++z5vg7nTuFTCOY9jWVD7eHLCDic+UEiyXCtaLSu+p8=;
        b=UotD4Wr3NzH5ZjXGQL8mTzxOz2FuNSwdGJRz8hQrnRiHVrjpcivFqYT/SV4c981fBF
         DxciXvIDmq/skrZ6hiR3Zw+8e82Y22AbFQkQdq2V5/bAW+iXEQ+eQzeqSQqFgs55TM5n
         xVN/RkOdanFRVDEvKsqA26aqkkKg2UPaufILYVjZ2fri1d5pFXZU2cb8rorO6mxs0JKw
         Q6sysUnLLZDiRM8BAYEf97azWO+eSO+ge833ahmAqwQ59o5G7zELkj4rJZyflQRU544W
         Af5eagn9SlOcV2GxARtICFe1gyJI8Iyok+sbFmRhMp8kn2lxx5lerDgdzoJAbvu43Jcf
         D8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679456268;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++z5vg7nTuFTCOY9jWVD7eHLCDic+UEiyXCtaLSu+p8=;
        b=dz/y0UkrP0sYNKoc4N8WezwVd4dRmOA33kFluoUIfgCEaevXPLwumhN6PObed+dyTM
         JXRxuPbrC/S7TqQnD5r4JCnCmrJRWVrmRqJFg8Bq3CTGxveJpGmXzP5q+B/w7Al9kKnV
         OS02byMBvqi6X7hXeJPdvebd5Cpa/A60gojbct6qkF8jPWXCq/z//s+vnx5UEfUVY/8y
         nfutl5N3fz1HfiifR7Z2E5pXAz5hlOG3enZJJMqVWGDZc8OA0rRzNp2GgYDtypKBKzIf
         wOUhgzTbg+JvJsTR/hR9vwsK8feG9odkPXLBgs/IKDqwKAX5iH4Lltld1FRpiJd/Cm7d
         voeA==
X-Gm-Message-State: AO0yUKVl839GVOhLNAJGhegNy41gRSSLj/cU9PtyIJyFQBaA1IA6sU3W
        LIp0Z5X6Z/NUkwoqzpVe3k0=
X-Google-Smtp-Source: AK7set8QpHUwXpe5d0LP6vOIRpXwhnWJQfssqfbLzggcgOarW2oHOUo715hUqVuWPMj9eQ+UZW5Sgg==
X-Received: by 2002:a17:902:fa83:b0:19e:675b:a40f with SMTP id lc3-20020a170902fa8300b0019e675ba40fmr1184269plb.8.1679456267771;
        Tue, 21 Mar 2023 20:37:47 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id iy10-20020a170903130a00b0019309be03e7sm9500912plb.66.2023.03.21.20.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 20:37:47 -0700 (PDT)
Message-ID: <2f199872-87c8-c7e9-8d9c-b4e51bbc207b@gmail.com>
Date:   Wed, 22 Mar 2023 10:37:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/package: add back 'version' for builddeb
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Wang <00107082@163.com>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20230320110819.23668-1-00107082@163.com>
 <a05cfc82-a9e9-ea96-aaca-612ff9c14219@gmail.com>
 <3ee67285.5853.18704c2158c.Coremail.00107082@163.com>
 <1a2278c5-5398-2e7a-344d-fd5dd9703b10@gmail.com>
In-Reply-To: <1a2278c5-5398-2e7a-344d-fd5dd9703b10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/23 10:35, Bagas Sanjaya wrote:
> OK, but there is already the similar fix submitted at [1]. Please test it.
> 
> Thanks anyway.
> 
> [1]: https://lore.kernel.org/linux-kbuild/3351f907cfd0b5d8372e858a8ec9065cc2bd91df.1679434718.git.kevin@kevinlocke.name/
> 

Oops, the fix is already applied at [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?h=fixes&id=3ced71d273f8edf07bf01a831a49ca6b988e06b3

-- 
An old man doll... just what I always wanted! - Clara

