Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407E567AD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjAYJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjAYJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:17:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FCEC74
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:17:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so771916wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g89bMr3eE03J+TYQWkkytiL1T/BGnye7+WdWGuXhj80=;
        b=pElJrXqx9Z2iEcj0CeiqbotfV1L1GPhFvE/mB0VdGY27rqnksdG3jYxGErTQuRqBZA
         NVRz3+jxAHpLTk5SwckXcv/hU4T+OLa0aCrsYxeqR4V2kgCMK7cwS0Vzeww/6mQ0o0dB
         ExVUoyX9c4Q8CchbQgfvDbaQU7NWqKwZNPJytXu7Xrb7jByogSe0nlCmoTdT4C/qzd/3
         k6eMduO5FkYBKRxkT8xH7PMwnharj1f9dqsj+F4QqMOR8a8IyywAQ73z28TMGOR6N9xq
         FZkhzzZNrxLNjMPsKAT5g54pgCa6iY00Y4cwbSQeemClEwh7HjyHVdsDCN1vGEa4rFzs
         1GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g89bMr3eE03J+TYQWkkytiL1T/BGnye7+WdWGuXhj80=;
        b=uCUD6c90j+fkynTP+4kZdGZd09g+wIYyyyGmiPvrJqYNt9CvQ0Vl4SCPVnuk0ZSpTS
         3SEwwOPLVAQbLwfVC2K+XBKeTZCxMwWgRkkftbGFiBvMj+1RJt9lF/1VR9XNZ7xN3m6d
         rQQiCwD+hkZYATwWayD0xY9t9zWqAAQp9puUoJYso1UIkuJkRaDFfMFyiumJQB6B7blS
         dV0IXGFZTo1g0XjFX3ItqM/9Rq/XCdaxgm++sle4KQC0JiaDLpMl+ofPIl0HfB7GW7Il
         sFQIdWr9minWCboZ51m+HVNOM0eF5I0GylDMbAQEOXrTWt4Etsgo83coev2reo6mK7lu
         az7Q==
X-Gm-Message-State: AFqh2krkjglXLJmfRp6JiOHc3+ArGXYpVjl4ky6RGfGrP+DOZ/HNSqNZ
        TO7Z6gpXQGkIXWkwvP7ZQ/M68Q==
X-Google-Smtp-Source: AMrXdXt6qkMvVDN8MHnXrpvwuViLfxSnAY1YvtkHqbCUyxWLTcWNuZIL/5T7W85otq5EKVAoJZM4ew==
X-Received: by 2002:a05:600c:ccf:b0:3db:f34:e9e0 with SMTP id fk15-20020a05600c0ccf00b003db0f34e9e0mr27755990wmb.35.1674638273229;
        Wed, 25 Jan 2023 01:17:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2f:6fa7:d25a:7047? ([2a01:e0a:982:cbb0:ad2f:6fa7:d25a:7047])
        by smtp.gmail.com with ESMTPSA id f4-20020adfb604000000b0029100e8dedasm3862328wre.28.2023.01.25.01.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:17:52 -0800 (PST)
Message-ID: <5e99bf45-598a-7e02-7866-f542455cf910@linaro.org>
Date:   Wed, 25 Jan 2023 10:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: Kconfig: fix a spelling mistake
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
References: <20230124233442.22305-1-rdunlap@infradead.org>
Organization: Linaro Developer Services
In-Reply-To: <20230124233442.22305-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 00:34, Randy Dunlap wrote:
> Correct a spelling mistake (reported by codespell).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
