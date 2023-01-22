Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75599676C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjAVMAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAVMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:00:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D416336
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 03:59:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so8449802wrz.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 03:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2LDrF4mdXRODwHYb9g9f5UoWpcaY5wVZNODxK+6ym4=;
        b=A/PftIvd7aQMmaQ0+f6sTZ0jewQUlUirWHFFvCOzJ7Ev+bQEHqPL9sGZcVqPtRrTT4
         +HKdELZ7eUPeKPGPP4XSjYE/H1/IGaMmt6I8DaOY+buWBGECi26ARlyrIu7AkM7tD3Xp
         gNPe/n/FQqVK5VvYPnZaBbLXWWp2NZtn9/q3GzjIZ3g3TtevchRoA4AO5F8elhLUOCoq
         Ae07avCADDHnRi59CivBqOS+04pUd5VXgXI+wG4g6H4aKvPbCi1hKk9zrWT/WydjZVw8
         83YmRzcOxvcZKn51IUbNxPK90IEpR8U146OPllCcRMVYrOxpoEAgfAKWwV7/Rg6ObcAX
         wJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2LDrF4mdXRODwHYb9g9f5UoWpcaY5wVZNODxK+6ym4=;
        b=y/yZZMxnGjAGQVy5B+vLA+5GvdZ8nRY8omzjvqpurxcGb6+UlinKRJ0RyfNt/gRMV5
         6eqQmFpwJOuZSleMMUMvUAPAbBc5DlFP03DDE8Y0uWICm7ycP5fWgX0LwptuDS/7TDSY
         lCkQlPnrb7pxVidN0E1MwpouffYlTCDCmKX0w0vQxR/0MXQOXKpf4UPFeouULxz8YZ5h
         4KlK0cWrqiXA9Jq1Lo6eEf6xFyhbRRAOzRoB70yPRD7+TuTydidkFRt8PNfBtMO0e2Rd
         SbwAlln2GvyKtv6nfsZBkb88Kljn0/hEqyW1Mk+hK+LOC3E1LCvCbgVQl48qmvG1GzmY
         RiTA==
X-Gm-Message-State: AFqh2ko9JaMkqwGvdTaKtbNLT3iU+/o7Mu4YXj6Fd6KEPsXy9YKigw3t
        M5K/WQeFtqj/2WC1csD37+Zq2Q==
X-Google-Smtp-Source: AMrXdXuaF/TrZ4zpb+eoFpCMqA7VQH3RLErJJfzsKl1A7D8KW/Hodkc9JOcgF2DszJKKF2FAAmtjzA==
X-Received: by 2002:a5d:42d0:0:b0:2bf:9459:255 with SMTP id t16-20020a5d42d0000000b002bf94590255mr6565401wrr.70.1674388796187;
        Sun, 22 Jan 2023 03:59:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w11-20020adfd4cb000000b00241fde8fe04sm2739852wrk.7.2023.01.22.03.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:59:55 -0800 (PST)
Message-ID: <0b4ff383-d07e-6c18-9d42-f336f282d990@linaro.org>
Date:   Sun, 22 Jan 2023 12:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121112358.52216-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121112358.52216-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 12:23, Robert Marko wrote:
> Document IPQ8074 compatible for QFPROM, its compatible with the generic
> QFPROM fallback.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

