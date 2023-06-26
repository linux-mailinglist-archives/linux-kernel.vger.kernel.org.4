Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588F473DF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjFZMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFZMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:36:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36351E43
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:36:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3112f256941so2856678f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687783012; x=1690375012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfrXcbA6HvF/S0Rn0yQvpmT2HGr8JeCHR1AcVR0i49A=;
        b=rZd+nODzXzoMXSZFaU11JiBlWEw+J+aLZCaLTkvvxsFYDGirxnadRfBTGH4rmoeybq
         Mm+j2AEBtgqZz9wjNrw1RCK/3omlLz70YxVTW5GFktfHeEL6tjzSJGTQIE0+Yfi98dI7
         RT8LM5+0/b3cMvKe9XVKrqbeEz7U0m5ILzX1WECNewnn779Jokqzhe94Sj2L1Vj+EGpo
         m7mBFW6nPXntY7d8xReCgISuERUj4JZP3JCLZijswoBOfxQ0J+OcvjZUCD/zIyD2hVMF
         3RorXdMtZfrNDNsT/gBcugd5Nj0MKQj4FUjzsDaNKoHXrnQ2xpiRdyg2K+hq9FnHSHeu
         Xuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687783012; x=1690375012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfrXcbA6HvF/S0Rn0yQvpmT2HGr8JeCHR1AcVR0i49A=;
        b=lLnhzYFN4r9kEPvOGxsw2w0+L3g2QECBAnoO2FH3CryZE57ltsswsS5ZFT1w1xfC2Y
         LL650WR0C4+NTT95dnKhJVgQZaoxreXYj2dY07zvE88BVvR1sesgITK94yBHm22hY0kt
         F5s9GbvH91GSj/n9v/cshnRJirtC/v6W8X71KUa2wO97zIwBm68bFIThccvbjh4+fIr6
         rIatVRoQfXh0nFwJmOQ7fvGqu7kKmi8tPb0rWfi/s2DquN4+/ixf5Gbno2D88izAJNn3
         L71DQENY5x2x8e5q7O1yqm2Q1YM43YzkZqplYD1y0kjrL0vnp26NmX4OJKKyC7mkD19f
         h21Q==
X-Gm-Message-State: AC+VfDxuoNLXCW5mhHHFHRUKkJ7EX52sBoeZ7QzM/G/+ggjKnyXYpwF6
        Xm9ZcQPscJLtcE2VSEztRr95Gg==
X-Google-Smtp-Source: ACHHUZ72CocD+hMe36rBzxUgSHtnI4pO4crpB4ZTccpFA7Xjj0fHS6JBpfbcapIBZBJ/bpu6D0zbOg==
X-Received: by 2002:adf:e40f:0:b0:313:eb09:c029 with SMTP id g15-20020adfe40f000000b00313eb09c029mr3350821wrm.43.1687783012582;
        Mon, 26 Jun 2023 05:36:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5232000000b003047ae72b14sm7311935wra.82.2023.06.26.05.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 05:36:52 -0700 (PDT)
Message-ID: <0503b8fd-e8ce-ffda-577a-b851a9eebb07@linaro.org>
Date:   Mon, 26 Jun 2023 14:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: microchip,cap11xx: add
 advanced sensitivity settings
To:     Jiri Valek - 2N <jiriv@axis.com>,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20230626113740.809871-1-jiriv@axis.com>
 <20230626113740.809871-2-jiriv@axis.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626113740.809871-2-jiriv@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 13:37, Jiri Valek - 2N wrote:
> Add support for advanced sensitivity settings and signal guard feature.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

What? How did you get it?!?

Best regards,
Krzysztof

