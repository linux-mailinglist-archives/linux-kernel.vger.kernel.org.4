Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75066099DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJXFdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJXFdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:33:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A647B7A3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:33:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y69so8112237ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cncPzNhKHj3RYOK+yi0gfwTweMp4e49Izic1tzyj9aw=;
        b=lyVy9WcZQ7oju/Hdg/UskrapDqXlOYsHj14/fXklRTlYFcSXQNjjc3mlz20FCqFyLt
         liQlqPPEtlyGlp0soXNNYLuZW8Yz7KrEgYjfJ2s3TymAlOZ9Ov5TbdXuCAFVZ3ktkjNF
         UR/YmzyuXHOM5WO5s4vde+PePtvAdwDUpO6mHD+LRiUbjL1Osd6OHsuaccODZUz/hYvl
         7TY8iYbUlhyKbI8WqZs2nbfPFnqdFdLRYYjfQ0LRY0FK+JrCInuyR5fUWbqKW0ve1x9j
         bNHHUFtJnFbR9+DdNpzEy6gnLFNW5XvcNtkm7fl7JfmUu/qOBZHXap3KlZMeydeqSHml
         aQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cncPzNhKHj3RYOK+yi0gfwTweMp4e49Izic1tzyj9aw=;
        b=RuxyRMpeVQUkDEw613xiXWJQXdLd/zijFFr1kHsre2tXwEkODdP3BOSgGg7oyUSYD7
         c+w1ERCQDb9NOQdGClwfqQ8ftxRc2AhI+zV2sjMdUmXImnuE8X3A6GfCZmrOTGcknF8m
         +96LYqA+SV2OAMkPoG6EnbtPlmMG+dXRo1gziy6xXQh8R/vlilOuDpU466Va2s2OiNyO
         RlENvE40v/OMZRduSKMrNXVwyuYg0vaJLQ7ww7LuAyQwTdDvTzRJGTumSN4NNcfCRT53
         qDNJwojxhX4LP8pm7bbUjKoeSQz/jHm9bueon+voXhFYMjE1f3hU1Zfc/OGsyKRkXTyL
         cVBg==
X-Gm-Message-State: ACrzQf0ceA0DAvV7q9WBTs87bgE0URirHV9rbFM2uXU/lhoHqhPMMqCv
        z4GSCQcGNUDZvt+YhdyBFz0c7/9xdm4=
X-Google-Smtp-Source: AMsMyM5rRNebOpsJ4gLnTd7+6E9mfjH6kkI3LVZowjkSr0E4zP6fX2JdaPe7NsLtPbmIRWeSGlnZzA==
X-Received: by 2002:a05:6402:3213:b0:461:dec8:336d with SMTP id g19-20020a056402321300b00461dec8336dmr1166660eda.221.1666589623947;
        Sun, 23 Oct 2022 22:33:43 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906315000b0073d7b876621sm14823823eje.205.2022.10.23.22.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 22:33:43 -0700 (PDT)
Message-ID: <e66da59e-6f52-04de-990e-383f58541c44@gmail.com>
Date:   Mon, 24 Oct 2022 07:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] staging: r8188eu: some more small cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221023170808.46233-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221023170808.46233-1-martin@kaiser.cx>
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

On 10/23/22 19:08, Martin Kaiser wrote:
> Here's another series with simple cleanups in several places.
> Tested with EdimaxV2 on an arm32 system.
> 
> Martin Kaiser (5):
>    staging: r8188eu: use standard multicast addr check
>    staging: r8188eu: don't set pcmd_obj components to 0
>    staging: r8188eu: NetworkTypeInUse is not in use
>    staging: r8188eu: remove wait_ack param from _issue_probereq_p2p
>    staging: r8188eu: bCardDisableWOHSM is write-only
> 
>   drivers/staging/r8188eu/core/rtw_mlme.c       | 16 ----------------
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 18 ++++--------------
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  2 +-
>   drivers/staging/r8188eu/include/drv_types.h   |  1 -
>   drivers/staging/r8188eu/include/wifi.h        |  5 -----
>   drivers/staging/r8188eu/include/wlan_bssdef.h |  9 ---------
>   drivers/staging/r8188eu/os_dep/os_intfs.c     |  4 ----
>   7 files changed, 5 insertions(+), 50 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
