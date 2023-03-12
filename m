Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B196B683A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCLQYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjCLQX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:23:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92923A42
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:23:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so39511366edy.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678638176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+xZrChxZkc6JrPh0xGVIIzxchyzDK5KbwG2kHyM3LRc=;
        b=ZUz15jVisj5kNtfOH06lkDcSBNDfdT/lXA3aHmV2d9hVxP4hpGbWRZY80T8hKeuYTD
         6T2mXF+W668+h5NOvc2BjXtMjGwP4Tkr4opimWqMwVUHsQk3EtNJytvTFra7ZlubBAxa
         2FUGNDqPfb/moKaebAGIe4WPqkoeDPLwhhgCP6hqvpYtyTDlf4ksjy6U6erxbFY6HWkH
         mWorRKDMUnDRe12oCoYmapaWaYEo3W/8ykacUjkQgJMA1dpQFIzPp5lE2Q0PJVmyXsJ0
         bs0dJVlW2s8fhcVTf7uppd8qamV2TN1FAi+UdFgPfverbv/krFdy94liEf3leBTLaynq
         0dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678638176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xZrChxZkc6JrPh0xGVIIzxchyzDK5KbwG2kHyM3LRc=;
        b=3+SpoNT5uGaAO+ceefUkJOdXJ+nwt2pOccWyG9wgnIPey1cVfebxM9fSSY91oDIQsp
         O7oAI6fEHGVMVGEVJk+Es5HQy4lC2YE2BBRlWa9fQMVeLdrrFd5bDZrDBNbCoV7SItoE
         1+t6VZQ0AhW92NqR+VZz8MBSZ3K5Oq7E2u9aOLGYBbs782BYtJSO22QHIi6X2zqW41C2
         IRGfiBnPAmRC2ifL+YQwUcTOTWAD2HJbOQB1mHiVNbmuIHHoheaZaTM5DGaOH4yL9Sfo
         U1UpXQ8JP34dj6e1cGXV09DzqJaMWVj7JaXpj/E+jf/X29cjco3nQ2o+vXl5TBLmhLhI
         np/Q==
X-Gm-Message-State: AO0yUKXWBbbqOcpBj77n7jCyQdkv2YIHoLBekrd51oLbci8IKGnpLQmn
        Bx905eSX3rKo73W48cLqzyWBDN7tthmLZ3Klt9A=
X-Google-Smtp-Source: AK7set/A+que5qx2g6k/Nv3GDCYZJPcex1mjy+LxdlaNFrRsLCAOGWDOJ+k50aSzL3tfDGryksGYTg==
X-Received: by 2002:a17:906:2756:b0:878:79e6:4672 with SMTP id a22-20020a170906275600b0087879e64672mr27703036ejd.42.1678638176627;
        Sun, 12 Mar 2023 09:22:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id ks14-20020a170906f84e00b008ec43ae626csm2359153ejb.167.2023.03.12.09.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 09:22:56 -0700 (PDT)
Message-ID: <1f39c602-20ea-94a0-caee-54ae3dd10bfc@linaro.org>
Date:   Sun, 12 Mar 2023 17:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 14/30] clk: s2mps11: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
 <20230312161512.2715500-15-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312161512.2715500-15-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 17:14, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

FWIW:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

