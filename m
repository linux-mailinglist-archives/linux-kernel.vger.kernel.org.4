Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B3747EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGEH5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGEH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:57:11 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF8E12A;
        Wed,  5 Jul 2023 00:57:10 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b38121a011so3113146fac.2;
        Wed, 05 Jul 2023 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688543830; x=1691135830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKdzw+K/A/r9LcvonH1dvGk7XAlJzh4TTvoKnY9NDXU=;
        b=dITzMJf6lDrTGdRmmA7rnTZU8eiovhV9iQcs99L6BtK1MnpQcnQacLMsHmYEDogA12
         MA85jYSyxuIkVbSIrFEpJWQzG+r+Z9k6cpdVu0FelgQ1rwWfNAdZ8zAjFSlbMULeii7T
         gesXmYXK+3Use3fV2Gy9oG7O/tR8HXenOSh2d4A02CnBSAQlLexRQ3SHag49XUg/keVN
         BGmr8xagV3TrEJjO1Cf7/TIEKaJpjhpTtjDTVxjQYEf+cQEtNCP1/EMX4ijlEupXfSCH
         EtPDdSLx608R5RtKa2k4W1aTl+OZWUjI90Lm6vKb6aPaTAm98NbrIZK/6xB2EbWoiks5
         Ladg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688543830; x=1691135830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKdzw+K/A/r9LcvonH1dvGk7XAlJzh4TTvoKnY9NDXU=;
        b=cc2jfKJ1ZJbmaNl7iJrb4YptfsJ3paC4tinw0uytTvWGJPmiYqsvUIXjVe+Fi8VNZS
         kuAp4aLu9P8MC7y4UkrqyfCPcRiEuGdopnG39C5TwlJo6tRfs9YY8UHIZaAGCYoIXxAL
         Xb+WktPjEFekQ6/OETHYmku/4esgm0QlvOQfTnMFCNvEXZXO0GpM232KfwbxnZ//gYWI
         x3jlWKYsCAKYzZLSvDZw6ioHwuWkIhJePB7BFNkNEIllm/Eg1bsnApdmbTWhXaKTihEW
         bIElSr/bEigy3X3pi0WWjADnHLUZzXmECRx9I3bONhTx6kQ800qEB3fIyDrFn3YDTDOT
         pRYw==
X-Gm-Message-State: AC+VfDzizbRqQMDjYaFN2AWu9RK1MAiQcOLJ3fBgM4gVndeSL4r8OO32
        SLEOd6voQyQOtbFPGE0xlKo=
X-Google-Smtp-Source: APBJJlHEKd1Am/TM0U9CDA/HAJQ5YMq4hv4OX/k9EOjGuZLR0KmzKsJb94/SLqtMIDIg5W4Zl/UjOA==
X-Received: by 2002:a05:6870:be88:b0:177:ad57:cb36 with SMTP id nx8-20020a056870be8800b00177ad57cb36mr15890868oab.27.1688543829650;
        Wed, 05 Jul 2023 00:57:09 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a035600b00262eccfa29fsm866445pjf.33.2023.07.05.00.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 00:57:09 -0700 (PDT)
Message-ID: <e7be7df4-0c3c-6695-675d-f386a85c5f2d@gmail.com>
Date:   Wed, 5 Jul 2023 15:57:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/13] clk: nuvoton: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705065313.67043-1-frank.li@vivo.com>
 <20230705065313.67043-12-frank.li@vivo.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230705065313.67043-12-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/5 下午 02:53, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/clk/nuvoton/clk-ma35d1.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
>

Acked-by: Jacky Huang <ychuang3@nuvoton.com>

Best Regards,
Jacky Huang

