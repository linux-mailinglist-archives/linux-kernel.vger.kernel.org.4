Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF3569E5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjBURUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjBURUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:20:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E92A9B5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:20:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p26so3805617wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBDm/V3dOWX3/jbMdcOmbJM4gblLKGXoKOJqVmsjPyY=;
        b=GGz+dY3TWr9J0BySMRAJ2PTAtOwbyQMqwUq0/t8IvXtzw03OYWepV6UXPwrbvvcjLy
         zfVbuJScDsKnqcoZpcdJIpWKoB8Ggh+iNi0pdVNT2jWISEgblEYzKOI8YY3ugU1Aqnmj
         EEwuPxANdRTW2CDMVKU8kImLc0QHaSHAdIEu8AQcH0z//lQm7U3F88XGu5xteVrSM7Bx
         XaesGqOGc7wAXQPluOZK6SihHN+9K51iKlbu1bT3n3dEQ+txfQTFuSUlGvflLM9/Mk8y
         3VdNwtFfxs7lgQsBqoooKCT/5UdgJsw1vOH1xCMg6sHvHttq1SB/C2fwVBVdsG0JXJih
         AuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBDm/V3dOWX3/jbMdcOmbJM4gblLKGXoKOJqVmsjPyY=;
        b=fKzYHVnj7YIvQi10BhZVyD+pEgR8fxKDAp/ogNEFd3nljTCaggTOn0EDyylEZQzbFa
         aHpAyukdnGyluQvGYSyYgh/eXGVEi9rFzGCwVSddTI1QE1RLPiclnTINFzgq/ww2O/00
         oFtF+KgJvN1RQWvZsPY5QYWIyTZiYImQtqLIxCSPSXm0Z13F3Lx9YINeAXlgYtJJlw6H
         SHzNawpOioZWPHfkv1PRLARhShFeI1Kl2egAPDhnmMervl0GndegG+G9QEtRqZN/Cvva
         0cAOAU8jbKc+xBELtXWg16a4CZ5g9o+mgpOYPguxLcuTyJ+ojSqacq2XYUe++gFdde45
         UlFg==
X-Gm-Message-State: AO0yUKV77obJiNJU9vMepXMGdAcmfmE2C0EAUy1os33bAh241EMQoe5x
        +bWeHP5IxxBud58h+2WUTZrPP8MjSPQ7UlFj
X-Google-Smtp-Source: AK7set8DyLazVtnc2FLAraCTGUGoNqce6M08sargmcE4R2NZf5mqmLWzZiIIRdsuW2MVyyTZllj+PQ==
X-Received: by 2002:a05:600c:3298:b0:3dc:5674:66e6 with SMTP id t24-20020a05600c329800b003dc567466e6mr3796772wmp.25.1677000011167;
        Tue, 21 Feb 2023 09:20:11 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c211200b003dc4fd6e624sm5364696wml.19.2023.02.21.09.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:20:10 -0800 (PST)
Message-ID: <78dfd8ec-967e-2bd2-9b8c-b7338ed62049@linaro.org>
Date:   Tue, 21 Feb 2023 17:20:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>
References: <20230221165400.1595247-1-kbusch@meta.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230221165400.1595247-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 16:54, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some users of the dmapool need their allocations to happen in ascending
> order. The recent optimizations pushed the blocks in reverse order, so
> restore the previous behavior by linking the next available block from
> low-to-high.
> 
> Fixes: ced6d06a81fb69 ("dmapool: link blocks across pages")
> Reported-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

