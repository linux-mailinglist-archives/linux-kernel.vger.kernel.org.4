Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099DB689C3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjBCOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjBCOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:52:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3059D5A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:52:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o18so4886163wrj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltwYJraDGOw3xJJWw2ZgRTh3wV27yN0rkRHwVT68lHc=;
        b=zp7wXfSixeF9dCrLv0Dvqg8HYJgR4FCkYR79P6pkT+bx/7PhDsXyRjN5BP/vaLhrLl
         yksnBQ5WPqb9td9Mvrg21pZZWC5T5Q/yGF26fON2Vs323sA/eVgTa0FDk1nGKLZZIEaE
         gV/lh5lSmi+KQ0YmGh+hX66M4BBLts7b7Zl3fUvzTN4JW7IMuLaNPcQrFPuRYpqMxKIw
         vfvCkCOhrUQvvU6eagyKIB/AMAx/5bLGTmWKO9gW5rPWW6L2aonm7FE5HCQg1L4Y4ZcG
         nrSyK+i+OKrwhP5VsC4lHbHPCcRryVcj/ytK/47I/n4mCmKa/g0azPHgIhy84i3urUih
         bpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltwYJraDGOw3xJJWw2ZgRTh3wV27yN0rkRHwVT68lHc=;
        b=vZqECNoU/RnIUecR4JsqvB1ExdFsbR9y0XNOqqpX10xa5Rug6wTR/Dw6mroxGFs6li
         R1wTfFCldv++uJhM9xs1cJJz4zFZh+23MzvSHGlZ5kN3HLnoQtjB5om6DV2lNNYM7yAv
         RWtCKCOA46LmwZ5b/NtumhF1CC8Wyg1yXcgCTqVswx5xcYRP8z4kRAU0s6Uz36TlvEbv
         SHmfT3WJmzUE0O92c2StKFGhqjEb6QC2VfTQ+zttuSfCgeK8KP6A4sx+iqOj2cjOrUoO
         8kdySusysJGI0W0pdINo9tHuIGIJVVp7RELFeV/vsVcM0JlJ0kNIn23yZR/ZUvAT0lB3
         O6Jg==
X-Gm-Message-State: AO0yUKVY9ZeKNh9B9GzqRJ3QSYhYU4p97I+gatp0q8JVPlyop/4hMY7E
        SlTY7MvVpyGCOpqEsDPjSeRbuw==
X-Google-Smtp-Source: AK7set8wZRxI1h1T+oa4MePP3zzp2B2mJrkeXhuLlSS7xkHMvz+aCEKBWIYorZPm6HmgGAySdNR+jg==
X-Received: by 2002:adf:f452:0:b0:2bf:b217:e365 with SMTP id f18-20020adff452000000b002bfb217e365mr9322357wrp.11.1675435962563;
        Fri, 03 Feb 2023 06:52:42 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id o10-20020adfa10a000000b002bfcc9d9607sm2226488wro.68.2023.02.03.06.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:52:42 -0800 (PST)
Message-ID: <1daa1b9d-21b6-5c44-0500-bd4ec4766161@linaro.org>
Date:   Fri, 3 Feb 2023 14:52:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mtd: s/a SPI/an SPI
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230203080136.68505-1-tudor.ambarus@linaro.org>
 <dac961df-c43a-03a1-2d85-33075f75589b@linaro.org>
 <20230203152203.55f584a9@xps-13>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230203152203.55f584a9@xps-13>
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



On 2/3/23 14:22, Miquel Raynal wrote:
> Hi Tudor,

hey,

> 
> tudor.ambarus@linaro.org wrote on Fri, 3 Feb 2023 12:18:25 +0200:
> 
>> Sent a tree wide patch instead, feel free to comment at:
>> https://lore.kernel.org/all/20230203101624.474611-1-tudor.ambarus@linaro.org/T/#u
> 
> I'm wondering how relevant this change is, because I ear a lot of
> people (including me) saying both:
> - "an ess P. I. controller"
> and
> - "a [spi] controller"
> 

Right, I already agreed to drop the tree wide patch. We can choose the
article that suits our own pronunciation. I find the following useful:
https://www.merriam-webster.com/words-at-play/is-it-a-or-an

