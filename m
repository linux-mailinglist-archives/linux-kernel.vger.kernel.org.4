Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47568BA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjBFKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjBFKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:35:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EEA22781
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:34:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10393330wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7w5/j8A6TwxWgniH1DhNmNJ1hey2l2xPmhTfoCmqwnQ=;
        b=Umu+PxAs2lrKymRLs6IpTYlFho2kPDweUy7445WesXu0virZut4foPzNq2gJmDQbH5
         d6YIWEiLzdqpu+BuJ1rOks51IS8EMdbG305v1DxC6G81gJRC5ObT/TwaSblRlYR/1ICg
         1qmGfxIuSOwUsbbxbX1XR5amleBzOceuEQYXAC79U+E3Tbiy+U346TgseZmJl/n7xosa
         myYsg/6dVtNiQjVPpGha6BSIubMNlWZrwzGl5W5zMtPNwsKw+KT9RUjFeD1Ia9H92B1q
         37RkSzXkuVS+3ZuV44VyAXrfOUNId+DHwaIyhFpj3KB8huO2jCqXtUwMn9wyr6W3ZsdC
         WLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7w5/j8A6TwxWgniH1DhNmNJ1hey2l2xPmhTfoCmqwnQ=;
        b=12kTGXvJtzZOGHMXn2ZtOTL4EB7XYgcyQ1G9ycx9pLAZKF7Uli83OOshqsmNRPMfTN
         +LT8qZEtzS8xbUnZKH5CIin5GbU2lq2xnn6i67UqsvKUs3uSOULipMRqOixi5TnXgGQ9
         2XYkFjiUMDyXjr28TAKU0yOyMZNiOVqq6WIB3XnwI/f+KJ0rLzZpfaEXK0GmuWOpQXyj
         fHbjKRO+ZrbL+a0klw/wwfchRgYh4IAGhQTBT/od4zSnq9AO46nzuxPI+IU45jEVePtK
         sjBCsOMTqfmtfhCnPFzo5hqOploYi1xC21/RcG/76WfUouLy/gfL39gjO2xfgE8lnZ8Q
         dalQ==
X-Gm-Message-State: AO0yUKWycwftDw1O1SLG5KICZPNJcvQsQzoNpIf7Y84qXyA3rmfC2Efs
        pHxmJkc26jaEra2tNT3w2CVyFw==
X-Google-Smtp-Source: AK7set+4CdpmemgUQ7IjRMXwE8ZKkcoaPqPjwCcV7bWIVY3qhO5Q2gmMza28BCUAJjAFZvnH7exAHw==
X-Received: by 2002:a05:600c:3baa:b0:3dc:4318:d00d with SMTP id n42-20020a05600c3baa00b003dc4318d00dmr18747276wms.11.1675679679637;
        Mon, 06 Feb 2023 02:34:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003dafbd859a6sm16713948wmq.43.2023.02.06.02.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 02:34:39 -0800 (PST)
Message-ID: <48effa0c-897b-fa55-4e83-e1688489f873@linaro.org>
Date:   Mon, 6 Feb 2023 11:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] arm64: dts: Add support for Unisoc's UMS512
Content-Language: en-US
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230118084025.2898404-1-chunyan.zhang@unisoc.com>
 <41fd5c2a-9fc5-8af8-b66e-45bb83b24179@linaro.org>
 <CAAfSe-stZ4cJw8UsFtozccVfzeR4=Wpo6+sqnfzj8McsfqrBgA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAfSe-stZ4cJw8UsFtozccVfzeR4=Wpo6+sqnfzj8McsfqrBgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 10:28, Chunyan Zhang wrote:
> Hi Krzysztof,
> 
> Thanks for the review, and sorry for the late reply, I just came back
> from a long holiday.

You quoted below entire email, so I have no clue whether there is
relevant part or not. Trim your responses and do not top-post.

Best regards,
Krzysztof

