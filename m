Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215D574A103
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjGFPae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjGFPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:30:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B26C1BE9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:30:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98502b12fd4so25341466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688657429; x=1691249429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z1BlLxPWPKdxfGdvSEAnfzfEGC5OzbOtHCd5+Jzu/o=;
        b=ZH06GVHDnvnE9AgXnshEk4hPgxA8GrmUM5G0V92E2faBUmRMY96Hf2nHcOtfB22zbk
         vLX91tmLLepP/lIc0K4IqVHfJzFLi0fFPp2N3+LucCE892VFnwn9fskGkpKWnXoW2cmX
         xqRUXwe6iZcQ6oIvEaoYy/KpMmulEzVLy9bwmTHAwLYzwK20yZxIIu7EvEnEt5yfpe8P
         eOgy/5zIUtG+YEUk5Jwpb2xKxXTUU4uAEgB2yx1/2z5j7mI1NFZdn3Yqldqb1369Vn7K
         3kk5WCCI3F/7o+L0raPq+icWmEGiYMmoLSc+hUGLmJKI8xsdFBIKmxhzhQRGBc6hryKy
         lzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657429; x=1691249429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z1BlLxPWPKdxfGdvSEAnfzfEGC5OzbOtHCd5+Jzu/o=;
        b=k36vKG2D0Wa+hybDkKtdXsy+UXZXyNfmUeGAWRwUxeSf7cas8ChH8KYby4FPTTyuow
         agHoFJT1OCfdQCGRBfX6kXK2U8t9AqXvW/IguEoJSIpZ7WRFQD9t6WLTlKm3zEv5xPzI
         mt7MbwbBbkyIIc7Kih/GLMxaQh7Cs2ORywNNdicKkN3mW3VlT4bzfF5hc8N/JwgMBTxA
         ztOATpwrlCMr9vxsSWD4YcIqeCV95cMoZEBg3fMn2I6QFcHeRXtkHOQosgIRrhL7RqJj
         bhsIzxKtUO9vw/GM5lZrK17etJ3oy2jSuqL74IeU6HF/RfE+O/J5gE6Zmy2gllPqX6Aw
         ChUw==
X-Gm-Message-State: ABy/qLaaVmoY/4hf74b320wOzqVgblp9uSbsbtr9hsqejA5iqyiMh0sh
        NPeh6B/y7rI0AyUVgX42SCM=
X-Google-Smtp-Source: APBJJlEIFlAQoLHChpeApdMXnWcLayighaoM8TllhP6wKqIlXM7j2bfAcw4rAuX7pmcWNgOAK6T8jQ==
X-Received: by 2002:a17:906:7394:b0:974:5de8:b5ce with SMTP id f20-20020a170906739400b009745de8b5cemr1731313ejl.2.1688657429245;
        Thu, 06 Jul 2023 08:30:29 -0700 (PDT)
Received: from [192.168.0.101] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709063bcb00b00993860a6d37sm950186ejf.40.2023.07.06.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:30:28 -0700 (PDT)
Message-ID: <8e53be9b-8b47-597d-1538-95733eb16cac@gmail.com>
Date:   Thu, 6 Jul 2023 17:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] Trivial code cleanup patches
To:     Yogesh Hegde <yogi.kernel@gmail.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
References: <cover.1688299890.git.yogi.kernel@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1688299890.git.yogi.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/23 14:14, Yogesh Hegde wrote:
> Rename variables in function _rtl92e_dm_check_rate_adaptive
> to avoid checkpatch complains.
> 
> The patches are required to be applied in sequence.
> 
> Yogesh Hegde (4):
>    staging: rtl8192e: Rename variable currentRATR
>    staging: rtl8192e: Rename variable targetRATR
>    staging: rtl8192e: Rename variable LowRSSIThreshForRA
>    staging: rtl8192e: Rename variable HighRSSIThreshForRA
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 38 +++++++++++-----------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 

Please use the "staging: rtl8192e:" also for the cover letter in the 
subject for the next patch series you are sending.



Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


