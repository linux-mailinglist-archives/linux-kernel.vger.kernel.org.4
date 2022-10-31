Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A9613224
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJaJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJaJDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:03:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C4A65F7;
        Mon, 31 Oct 2022 02:03:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id io19so10160527plb.8;
        Mon, 31 Oct 2022 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChbMXt+xoehX4fXeGrOcRMGK2hCdOvd4KQqiBDTJsxs=;
        b=qbVoBN1RviJ7qU0bH0SrfrqNEzG974uF6Rt/htUzysoyahheBBAUuQHtl4x8dnt397
         kvZi/Ka9fZaBnin/pAnCazDvOl4E1Uwy3dFxLzVmI/kJPd0/fCc24fSwLmOA6OIofv5Y
         UHAtcD8lvcr01eIwt6Iw7QwuCBnPFuvJ1Wra/k1Jq2eD0JbK3JnNm/6oXH5AEjZY9oLE
         PCoC/vAf2EUxKhKJc6NX1Kp99W0ZszlzGk0WNt/JToU6KYZKHQiV4SXc2EgkmfHHEH88
         Fl4ipJkd5fVJE48hi1mc2T+J0Ko6eAavVKALACclSdLrkJDqdKGZ/1O7SeA20tjPPnkp
         LTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChbMXt+xoehX4fXeGrOcRMGK2hCdOvd4KQqiBDTJsxs=;
        b=205c0afYHrP889QUeP5JsG0oiio6Rr/7xEwAgYQN03MmxuDPoS19ieIR1miP93dW8H
         SP+xIMbXS0ky4Y7alPkvCGZQcowx3ubNU8BPCqyrutUR3m4IsHe2SFDsmUfsBCcmNCUz
         zT4N9vPMuOdjkwm8qNv2Z9T/iKBO3vHoP2GPdMPVY1Sl9qJLXJOSWaWAkJt0Oyzlf2yD
         l2Xnj8Vv+SB1SFhul7ksJHdJatfmbLIQ7Czy03G2fCtoLp94k2qyC//XyYH4+OfznzY8
         RGaF2VaYMGrZ9OoOOAvSgDLm3q33j+k0fB91IX88r/6Lod1k+xwuNrV3chujJaVzdaan
         BSZA==
X-Gm-Message-State: ACrzQf0D5NE67+LhTX6+8R+t5a4Ob9ZgMQE0AVDuZWXssHHblbye8bPa
        67AEcksHE3yh2LwIiV7eV6BjwrHtLPhwxw==
X-Google-Smtp-Source: AMsMyM4SXo0vmuZAxDh85Prh0JzNWlKNpZjZm9J7M7795hWmjbkyWT/zbYjSerZtxuec6Fct+gl0dw==
X-Received: by 2002:a17:90b:1e0d:b0:213:ae0:fcf8 with SMTP id pg13-20020a17090b1e0d00b002130ae0fcf8mr13730986pjb.189.1667206984090;
        Mon, 31 Oct 2022 02:03:04 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id i1-20020aa796e1000000b0056bcfe015c9sm4026309pfq.204.2022.10.31.02.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 02:03:03 -0700 (PDT)
Message-ID: <0ad145ed-6287-be0e-32a8-348b76ccb15c@gmail.com>
Date:   Mon, 31 Oct 2022 16:02:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: linux-next: build warnings after merge of the jc_docs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20221031170537.722220c4@canb.auug.org.au>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221031170537.722220c4@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 13:05, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the jc_docs tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> Documentation/core-api/timekeeping.rst:16: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:26.
> Declaration is '.. c:function:: ktime_t ktime_get(void)'.
> Documentation/core-api/timekeeping.rst:23: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:33.
> Declaration is '.. c:function:: ktime_t ktime_get_boottime(void)'.
> Documentation/core-api/timekeeping.rst:31: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:40.
> Declaration is '.. c:function:: ktime_t ktime_get_real(void)'.
> Documentation/core-api/timekeeping.rst:43: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:49.
> Declaration is '.. c:function:: ktime_t ktime_get_clocktai(void)'.
> Documentation/core-api/timekeeping.rst:51: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:56.
> Declaration is '.. c:function:: ktime_t ktime_get_raw(void)'.
> Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:68.
> Declaration is '.. c:function:: u64 ktime_get_ns(void)'.
> Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:68.
> Declaration is '.. c:function:: u64 ktime_get_boottime_ns(void)'.
> Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:68.
> Declaration is '.. c:function:: u64 ktime_get_real_ns(void)'.
> Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:68.
> Declaration is '.. c:function:: u64 ktime_get_clocktai_ns(void)'.
> Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:68.
> Declaration is '.. c:function:: u64 ktime_get_raw_ns(void)'.
> Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:77.
> Declaration is '.. c:function:: void ktime_get_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:77.
> Declaration is '.. c:function:: void ktime_get_boottime_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:77.
> Declaration is '.. c:function:: void ktime_get_real_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:77.
> Declaration is '.. c:function:: void ktime_get_clocktai_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:77.
> Declaration is '.. c:function:: void ktime_get_raw_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:87.
> Declaration is '.. c:function:: time64_t ktime_get_seconds(void)'.
> Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:87.
> Declaration is '.. c:function:: time64_t ktime_get_boottime_seconds(void)'.
> Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:87.
> Declaration is '.. c:function:: time64_t ktime_get_real_seconds(void)'.
> Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:87.
> Declaration is '.. c:function:: time64_t ktime_get_clocktai_seconds(void)'.
> Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:87.
> Declaration is '.. c:function:: time64_t ktime_get_raw_seconds(void)'.
> Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:101.
> Declaration is '.. c:function:: ktime_t ktime_get_coarse(void)'.
> Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:101.
> Declaration is '.. c:function:: ktime_t ktime_get_coarse_boottime(void)'.
> Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:101.
> Declaration is '.. c:function:: ktime_t ktime_get_coarse_real(void)'.
> Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:101.
> Declaration is '.. c:function:: ktime_t ktime_get_coarse_clocktai(void)'.
> Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:106.
> Declaration is '.. c:function:: u64 ktime_get_coarse_ns(void)'.
> Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:106.
> Declaration is '.. c:function:: u64 ktime_get_coarse_boottime_ns(void)'.
> Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:106.
> Declaration is '.. c:function:: u64 ktime_get_coarse_real_ns(void)'.
> Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:106.
> Declaration is '.. c:function:: u64 ktime_get_coarse_clocktai_ns(void)'.
> Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:111.
> Declaration is '.. c:function:: void ktime_get_coarse_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:111.
> Declaration is '.. c:function:: void ktime_get_coarse_boottime_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:111.
> Declaration is '.. c:function:: void ktime_get_coarse_real_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:111.
> Declaration is '.. c:function:: void ktime_get_coarse_clocktai_ts64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:126.
> Declaration is '.. c:function:: u64 ktime_get_mono_fast_ns(void)'.
> Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:126.
> Declaration is '.. c:function:: u64 ktime_get_raw_fast_ns(void)'.
> Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:126.
> Declaration is '.. c:function:: u64 ktime_get_boot_fast_ns(void)'.
> Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:126.
> Declaration is '.. c:function:: u64 ktime_get_tai_fast_ns(void)'.
> Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:126.
> Declaration is '.. c:function:: u64 ktime_get_real_fast_ns(void)'.
> Documentation/core-api/timekeeping.rst:154: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:144.
> Declaration is '.. c:function:: void ktime_get_ts(struct timespec*)'.
> Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:148.
> Declaration is '.. c:function:: void do_gettimeofday(struct timeval*)'.
> Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:148.
> Declaration is '.. c:function:: void getnstimeofday(struct timespec*)'.
> Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:148.
> Declaration is '.. c:function:: void getnstimeofday64(struct timespec64*)'.
> Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:148.
> Declaration is '.. c:function:: void ktime_get_real_ts(struct timespec*)'.
> Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:157.
> Declaration is '.. c:function:: struct timespec current_kernel_time(void)'.
> Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:157.
> Declaration is '.. c:function:: struct timespec64 current_kernel_time64(void)'.
> Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:157.
> Declaration is '.. c:function:: struct timespec get_monotonic_coarse(void)'.
> Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:157.
> Declaration is '.. c:function:: struct timespec64 get_monotonic_coarse64(void)'.
> Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:166.
> Declaration is '.. c:function:: struct timespec getrawmonotonic(void)'.
> Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:166.
> Declaration is '.. c:function:: struct timespec64 getrawmonotonic64(void)'.
> Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:166.
> Declaration is '.. c:function:: struct timespec timekeeping_clocktai(void)'.
> Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:166.
> Declaration is '.. c:function:: struct timespec64 timekeeping_clocktai64(void)'.
> Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:166.
> Declaration is '.. c:function:: struct timespec get_monotonic_boottime(void)'.
> Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaration, also defined at translations/zh_CN/core-api/timekeeping:166.
> Declaration is '.. c:function:: struct timespec64 get_monotonic_boottime64(void)'.
> 
> Presumably introduced by commit
> 
>   d24c911bd031 ("docs/zh_CN: core-api: Add timekeeping Chinese translation")
> 
> but I have no idea why :-(
> 

The only other place in Documentation/translations/zh_CN where
Sphinx C domain syntax is used is in doc-guide/sphinx.rst, but it is under
code block (since the doc is about writing the doc itself).

Cc'ing linux-doc folks.

-- 
An old man doll... just what I always wanted! - Clara

