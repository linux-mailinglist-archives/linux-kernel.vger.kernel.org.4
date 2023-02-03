Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C007D689576
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjBCKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjBCKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:19:09 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905F09E9E3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:18:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso3453663wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odqpSFJ0f+PZ4TN9H2HUGPRDThnkRj1i7Ss7xOqwBxo=;
        b=i451dYbIAyZj97RdoG0OxW6lW/PyYuGjExH7g9ddi2DZ/iAaWKdl88WX3qB7Ipj+AV
         pQ0xJzmT0VbBX2Tu67xPwbfUnLPBWyqH7rAqM8CYo0Cku6kip5DGsaZCqtSTthboB/TV
         Y2Bb0z4fb7ZRy/h8WGWotAROur6X5slJ/31Lyd6vG2X6WoPYcVcrqwN93Nzx99np0HO5
         CPHSVNSsUeLqaqsiW4qpGW/E2UkU6SnPnIIN4RiYTw/mIJw4SuzZoAsVl1IRrxZ/D3ea
         ilNUTDwEKHH2jgT0rP7DzXn8EMa58y3kFFvpeTWtfczQ7hlA76qrQxOffiK33Ud4Z1gm
         0CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odqpSFJ0f+PZ4TN9H2HUGPRDThnkRj1i7Ss7xOqwBxo=;
        b=HPaa/hYELiIt2nQjtS7pTck55Y5B+u3u+EYb8pdLOiWntuwuhdF4VGdZ/PsgTZqzNF
         d+5RbSUP67FgNL2i0U5opk/AVW7hKniedbyLJnOd4QIzhLQp5H4r+mtxH+AECLhRa3nm
         tPiFcJEbBVtzMHuaDp6a7so6t3kItjmGeWxi3QVda4oqHXtuZmjxUTn8FWL07A5Ile3y
         B3u9ILNVMTAxQ3TOZJX1muR0KqqjQ/rXDJA5znniaKcn6u5fGtqDE4P4Y7l6AF8vI//u
         tJWilkcbdqLG7xC9fwkN1g/DJ2LG8w72od3DfPKtG2aCCGW6a3a3J0LjUkcB9xWxxmaF
         PecQ==
X-Gm-Message-State: AO0yUKUSKQeF8NfeTJAJf0jLcUexAYeRu+Fb24MSNgQfzIVSQF3s4ple
        xSJXQwXtLzRQwC+wGK7MlC6jmi7cGvhTn4SiCtE=
X-Google-Smtp-Source: AK7set9aoXVU9IWToK+isfFL82L36CsVp6BwtwC/p4t87yEO8hLr12swDiuNMDdgXui8s7jCqU9b9g==
X-Received: by 2002:a05:600c:350a:b0:3dc:2af8:83c0 with SMTP id h10-20020a05600c350a00b003dc2af883c0mr8955937wmq.31.1675419506856;
        Fri, 03 Feb 2023 02:18:26 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b003dc522dd25esm2422403wmq.30.2023.02.03.02.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 02:18:26 -0800 (PST)
Message-ID: <dac961df-c43a-03a1-2d85-33075f75589b@linaro.org>
Date:   Fri, 3 Feb 2023 12:18:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mtd: s/a SPI/an SPI
Content-Language: en-US
To:     pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at
Cc:     broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230203080136.68505-1-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230203080136.68505-1-tudor.ambarus@linaro.org>
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

Sent a tree wide patch instead, feel free to comment at:
https://lore.kernel.org/all/20230203101624.474611-1-tudor.ambarus@linaro.org/T/#u
