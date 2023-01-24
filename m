Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4567953C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjAXKcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjAXKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:32:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145983FF01
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:32:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so13377765wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vgx+byQpBO/6No7Ir2bnN8fVUuZMRKX8+w8Wat/wjes=;
        b=OuQJqxRtNYs7Sva3jrKvhV17n3ni651EJpq1zFt7cdE/1SM1pSRe3/GTkhENJ6ZfV0
         gTxh2TNBTcLl9Zjwz+RGr4KglC9pWlQPiOu7BlZ5CnFBmjUoY3iYdubioHbIxROkfc7d
         9o88HQvLa09KqZsfskNQBm2C30yyZcamjU9EOLvZGpT9OxYj6/mjQjG2ILB2+U7GDzT1
         CmqyXx+7J+IRNWHyVY4hBrs8QIUy3goWTXPH7SGSAfD+xg7w7IE/sItMi5450IatozaQ
         3XfoRhUfmSB8BOIrL5OKxL0oVsfa/wOAblvk9ZyNJGQ6AlsAM8hkiw1S+cpmPf5PIzQX
         v3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgx+byQpBO/6No7Ir2bnN8fVUuZMRKX8+w8Wat/wjes=;
        b=g9eZK8rXAYhsyc+WU8kTzy4NyNxkz9hgFDZx1D8wvl7g6bEB8Q7r6yOhizbN+lQXnK
         EEGP9ZNIiaoY3LdTDgLCRlXpl6DVjBM/quX8n6ULznvcNrmLRqLlHn85wJuZ89sBoIPI
         rgCiHkEakJ0VaEUszbBXHNr/GcET053pzXpA/Z33KiyeBnMlJGDYQVO5ohmKq8EQGvkX
         NIRk3sRqPxqdJ+kxsqxFHyJswY+mGnxeB/BGZrEf1J0YddLub1qjrYKZSwGjNyFB4gdQ
         GFMJ7qXL8Lbwo+P1i9tXcBLPQS2PkLSj8GfOC/20lGnPRkdQg9JQL+jenX3uSXaoHmrt
         LolQ==
X-Gm-Message-State: AFqh2kr3cqAKHZGDIR10XCHQF6aJy5t5TCCa5Aw5GlhYEPhft5PaxE/r
        joKyYbpZ0TwMVDt61VjIt1EtdA==
X-Google-Smtp-Source: AMrXdXsRbdzhAPpI+JnXWb0o8J0R9VSbSXKp5V9FYY6TChaGKTvDrXPVuu8lgDC2/XJw3EmKa9i5pQ==
X-Received: by 2002:adf:ef11:0:b0:2bb:dd87:3485 with SMTP id e17-20020adfef11000000b002bbdd873485mr24895602wro.30.1674556329374;
        Tue, 24 Jan 2023 02:32:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t9-20020adff049000000b002bddaea7a0bsm1556999wro.57.2023.01.24.02.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:32:09 -0800 (PST)
Message-ID: <09396c7b-1cf5-8ce6-e1ba-3c79a9e8ec56@linaro.org>
Date:   Tue, 24 Jan 2023 11:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: tcs3490: Add bindings for AMS
 TCS3490 light sensor
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20230123231028.26073-1-markuss.broks@gmail.com>
 <20230123231028.26073-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123231028.26073-2-markuss.broks@gmail.com>
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

On 24/01/2023 00:10, Markuss Broks wrote:
> Add device-tree bindings for the AMS TCS3490 Color ALS.

If there is going to be new version:

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---

Best regards,
Krzysztof

