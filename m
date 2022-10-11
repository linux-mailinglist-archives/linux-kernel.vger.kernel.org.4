Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881A65FBB92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJKTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJKTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:51:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB0DED7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:51:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z3so20668427edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS29to17MggO7McbTxW/LAIcMUXHWuk7ghRv6xBfm3g=;
        b=ZgpA4a44IhFwz8pZexcZWVkDd8Gf3MA5cIRk/kA7NWKwhEhiNqdti+BwVWQW38oLYI
         RQ8yTKhS92l3VBbpf+5rqExt0Ho1pSu9w8AX0/CkxhfmzoJ08HdlLCn1uzCcUCZVnzdT
         cUO5heCzGXIL0yL8E12fVx7sku+4b9oM4N83aJ6zwLLuaXzXWMjsfLsIzHIT7PD/ICqE
         Lf4zzf0E5+kXDJMTYwskuf0vqliLH8PlVe1s5mrUSyZdC1V8vMLRzhVruRCh592S1cJ4
         b5/qVdhlxtnqaME+dKtG45FsbEbx+KegG4f8el2Igv16BFlvv7YR5OMEoewDKbOAOa9X
         sJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS29to17MggO7McbTxW/LAIcMUXHWuk7ghRv6xBfm3g=;
        b=VJAd1TNYnnNm9Y9nOLmDWhjy5AsR7Ntoy/wF5fCcEcDyOwafV6asPl+dncf/8pXzTe
         F4L7uIfn+F13yT6yTE9gyLMn1c8pS2j948bN0GXviok3qsluvL3WH2qQ+ratXYQxNvfT
         6579KzoFlYYk/bmF9OupNntku4KCzcV4sSjm2JRikkjZDIKg5mFWHIIxffPJhMXftqbU
         0tC4/TNF15kCIebmjiOtCsmVfadFHXtytXItCZDBPcXscujwCKSkQ3ddGzkBp7CwbuNd
         FNYabm23A7KfpiPq7xATtEld9mkfYqMjz9+H5WUKCVH/IYFf1tcSMda3KviNqkihaqYu
         Q7DQ==
X-Gm-Message-State: ACrzQf20hShatqojmh7TWVEGVFMLqhNxeHlksQlj0jL9i0k1/KmfANK0
        bAMwBwXuVuLCvDkY3CdRgwU0/RrHCvI=
X-Google-Smtp-Source: AMsMyM6OeNWq2gP5Z62EeRRQiAnGu5KJPVZmltsOtB1fF1tMNV2KZFzLV+liSag/t/SwIjUNhLrAhg==
X-Received: by 2002:a05:6402:2707:b0:45b:8470:9147 with SMTP id y7-20020a056402270700b0045b84709147mr17901352edd.215.1665517864668;
        Tue, 11 Oct 2022 12:51:04 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id t22-20020a170906065600b00780982d77d1sm135279ejb.154.2022.10.11.12.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:51:04 -0700 (PDT)
Message-ID: <c86ba0d4-9c16-890f-6bb1-919a8be04dc3@gmail.com>
Date:   Tue, 11 Oct 2022 21:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8192e: Rename variables in rtl_dm.h
Content-Language: en-US
To:     Dragan Cvetic <dragan.m.cvetic@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221010190457.13199-1-dragan.m.cvetic@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221010190457.13199-1-dragan.m.cvetic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 21:04, Dragan Cvetic wrote:
> Rename variables to avoid CamelCase which is not accepted by checkpatch.
> 
> No test performed on HW, just build.
> 
> Dragan Cvetic (3):
>    staging: rtl8192e: Rename CurSTAConnectState and PreSTAConnectState
>    staging: rtl8192e: Rename Enable, cck_Rx_path and disabledRF
>    staging: rtl8192e: Rename Op, Length and Value
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 48 +++++++++++-----------
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 16 ++++----
>   2 files changed, 32 insertions(+), 32 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
