Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA272BE65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbjFLKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjFLKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:06:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA265B7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:48:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fbcfdc7b6so673632f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563319; x=1689155319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlNSyW01k9RQ6r3TAUIxxl3gEy3tIBaKB2a3SyuONic=;
        b=xxOQI6NNANXTOWzWS32SlBLOHCGyjc8GT/MPA9syGH0nXWWJ9aMkSIyACTIqtJwwz7
         aYWnV86EdevV+5dsjqn/qWqqczxClLrLQQkvtDcNgXhqZGaAeGj/d3yarqk68XqjrEmb
         Vo/6ODEO9VnUPhXuJJhSWUIAW5cDYN4C85WUsQ6TrLtbhacAo23MyP+vXkEf2jTd8Gzy
         wFDB79XoTZeiYS0mYd7BIygw/punojTzRtBal0junmkVOpebP+ZN6XoUMx/gYLFJQhJ/
         PW7nmS7FcxFY3huNztvPY2T5+uvK+tVCpZxRsOLksYhr7rItDRC4yBSMBji1/Z9DKL7X
         TEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563319; x=1689155319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlNSyW01k9RQ6r3TAUIxxl3gEy3tIBaKB2a3SyuONic=;
        b=awvCVhna6yPfGR180khhL57papxqMl4mk6CsruMm4PqfDvrN1pKtqhLJjqQxA95/vT
         M9y4K4CQ2psyIUND2fYRzVbapIiej2rytIR8+BuOgj70/6AQllraShbYmtRuEO2WL+0P
         R0Fo/eNGVVfMjf3sag4bZErY5fedDcuzkas3T/aV1UHYUsgUpIasHtJwiXQPjucYN3NP
         k4ENdsWCRRRNA8aAmqvoYLFgaeZGAygO2AxxnA65RtL1jhTpHdAWyvOQO+ICCHjWAanf
         YwvH+cz5DdoUH3aae064LN/MFMGAPszFrw9VV5Wh3pdoOf1LdRXyQl9rnE/C6Q/aclg3
         BPwA==
X-Gm-Message-State: AC+VfDzDY22CyMYovANjiCJnG8UlmSpxsWjVJcHRSeIVkZ4cdG1zhsE6
        902cABtxalIR2d6SPe7Us639Wg==
X-Google-Smtp-Source: ACHHUZ6J0MuzEgB+zY5N5cGweR8g3pcXTay98BeXBUo3Yy7hzVoM691gG3iZCVtdC3Kll3oHg6ecTg==
X-Received: by 2002:a5d:6e0c:0:b0:30e:45a5:9476 with SMTP id h12-20020a5d6e0c000000b0030e45a59476mr4219195wrz.1.1686563318849;
        Mon, 12 Jun 2023 02:48:38 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.153])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b00307acec258esm11905152wrz.3.2023.06.12.02.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:48:38 -0700 (PDT)
Message-ID: <ea22bff7-ecd2-018e-77a1-1d2edaa21355@linaro.org>
Date:   Mon, 12 Jun 2023 10:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Build regressions/improvements in v6.4-rc6
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-um@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com>
 <20230612090911.1579029-1-geert@linux-m68k.org>
 <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 10:28, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.4-rc6[1] to v6.4-rc5[3], the summaries are:
>>  - build errors: +5/-6
> 
>   + /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: ‘op’ is used
> uninitialized [-Werror=uninitialized]:  => 523:27, 564:27

Seems that the report is not correct for this particular case as op is
filled either by memcpy or memset before use.
