Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7432D664159
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjAJNM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjAJNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:12:04 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3388224;
        Tue, 10 Jan 2023 05:11:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c6so13121310pls.4;
        Tue, 10 Jan 2023 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nf6F824Dd4jORPczYBOw5Dqh4nvMQWoW3MEpdWdL+mk=;
        b=QA1K91gmePVfheH6IAe+PNMRxw+jbSyWWohy9akdRN6O3EYzS4wF36V8WBLF0CQQmU
         yP8Y2s8aWkkzxSPvofIBrU0wjeqWlRERtRwiCzqas1AQMzTvexUixsB8gxJ/skqL0k9S
         ltfCJcnu1Hv9YcIn37YEzET1OXAKRnNNBtmFU3bjoukOEnY7NMXD7oN1AoyPAvjxVtTA
         sqOseE3jI3Oa5TS6wJRKfSwGEmUhsG6wHambcrLRBRzT7C7ih8M3QbEv/QC7wh+j78Qz
         8K+ia5nZk0iOt4wRRKUTRxiCJYR8wP4e2zLsrKfPzn27uqeRIoH9p+H2/lKKdDPMnKCq
         zEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nf6F824Dd4jORPczYBOw5Dqh4nvMQWoW3MEpdWdL+mk=;
        b=Kot2hrbln2RRTGO3A8uvDbZMobWLYayZ+BDnNYgk6j6d6aKq9Z2/TuGpU85eUQEwct
         e2Gfg9Z6uzbfkjRw0zhZBU3Ela8ye3pIgey4WKgVVLbHSiG5BbiVAl7zLFRzNLtC8Bj1
         CnAqwQuMdN95YA40jCgBseSfjV9iPZsKG4yKSkrrj2lNtx/kcdaHUelHhO9bbh+Pgi5W
         lkzKMBdqcqmEIGan3z5mHY+CwmdzbSlgFEhOoc08Gzj063HIhJ4sboNP4yXdddLyaV/E
         F0U1CQb2tDLPmEDqguRE6d4kDnZusqphVIV+zAyckgxh0woXpmXFP2Rm4D2y2H1Lpe5E
         nq5g==
X-Gm-Message-State: AFqh2ko0QjmAxddphNKbLj6tkTba5a8p7idvy3JRySZi9haTZdNgU+0p
        F21j+y3cITCumX5r8SsKMF4=
X-Google-Smtp-Source: AMrXdXtXUWR91WwyJla3p3vmcfldIEjPuzt5tAhr2hFlBAEjHWia42ZoqdX+dlXoKW5LzZjZh4F36w==
X-Received: by 2002:a17:90b:1046:b0:227:1cfc:f5ed with SMTP id gq6-20020a17090b104600b002271cfcf5edmr5560533pjb.39.1673356319159;
        Tue, 10 Jan 2023 05:11:59 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a9c0700b00219cf5c3829sm7101545pjp.57.2023.01.10.05.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:11:58 -0800 (PST)
Message-ID: <b883f503-a6d6-e4a3-f505-baa2607b4e0e@gmail.com>
Date:   Tue, 10 Jan 2023 22:11:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clk: samsung: remove s3c24xx specific pll bits
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230105141231.2006353-1-arnd@kernel.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230105141231.2006353-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 1. 5. 23:12, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With the s3c24xx clk driver gone, the portions of the pll driver
> for it can also be removed.
> 
> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
> Cc: Chanwoo Choi <cwchoi00@gmail.com>
> Link: https://lore.kernel.org/linux-arm-kernel/0e0eff12-d8ea-72e9-d135-4259dda9a750@gmail.com/
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm trying to get the boardfile removal patches into shape for
> 6.3, and came across the comment from Chanwoo Choi that I had
> not addressed yet. I've added this patch to my s3c24xx series now,
> to be merged through the soc tree unless there are objections.
> 
>  drivers/clk/samsung/clk-pll.c | 181 ----------------------------------
>  drivers/clk/samsung/clk-pll.h |  21 ----
>  2 files changed, 202 deletions(-)

(snip)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

