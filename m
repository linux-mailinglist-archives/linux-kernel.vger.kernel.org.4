Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373996092CF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJWMm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJWMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:42:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BF71BC6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:42:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id ml12so3980384qvb.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dNqRQRAFugjczsB3YU3yguRA5GGcr0CHWzup1MXaDM=;
        b=rJIgRZFSSqPE8eX3ph8ysh5ft6tckLdjjSGWzPe0QOCpnkhF3a0g3hF8F8VF2EbSvj
         LrPb1u0Rfu2l0AOjp80eeAaq+7SUeYMmXNE6Bzpf36u0U3G1hwtHyQqgT/V4fCDpBpmd
         FIYwWfOE7J9A7JXNwVYpKORVEcX4xXo+GGwEOMhc3nGT9xcgDiQIkjA1TkMUiDgYElf6
         lcUynFRHCC758w8BEjfeUz/d2YJ77aDdAErBP9vUhazovLIReszmEyeJjHamLH4asJzm
         ypuZyDDsEIxl0ErqU7t86+dUUS1uyjgP+20Gw0oceOK27IAOI0x4cNGBnTFkY0gIUVp2
         KKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dNqRQRAFugjczsB3YU3yguRA5GGcr0CHWzup1MXaDM=;
        b=i2A8EpQzfpQ9/202XSP6OVjQVNe94kL8qOboAmQK1P5WLv2fQ4I6LD4S/VXtkr23Uh
         uxBDGnRG567gH8hZlBsZ/EVx9vDrB3cZk64PAc0zSSbfP4A3c23xZwbv6ZKFuiYyzxLV
         +svhTuKn89aEEPMtfmfsrDV+Ioo5HTrBTp7AoHmuYnYRM1CPTqUKSZ00R8G+hY5eF7fT
         hTylYStP5S+RwTyVdTeJZS04qpIujhLpnEdsaYb6Mzx3QsdZk2vMuWbi7DSyklvEvFiU
         rSlDeMa2OMVsvHhlCLVoC+PVLfsPMwwTbEoHh2/0h8KUGh3K8kfihy/QtwocxwI/nHt/
         iXKQ==
X-Gm-Message-State: ACrzQf3/Kf03B09HWir5tNobhpF5/x7pwwwYnb3E6bEGiPqXmrkN8wcj
        /Rs9IUZ9GJ83kZMXPr4/E6J1bw==
X-Google-Smtp-Source: AMsMyM5bMYWoMRh4iQ1zK0qQlEgSZPq1CjqbrpF05xYkS8RNTfLOPbi5ypowUTLT/tdJv+z4pP+3SA==
X-Received: by 2002:a05:6214:23cc:b0:4b4:9d7e:6b86 with SMTP id hr12-20020a05621423cc00b004b49d7e6b86mr23398969qvb.66.1666528942746;
        Sun, 23 Oct 2022 05:42:22 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id v20-20020a05620a441400b006ce813bb306sm13036948qkp.125.2022.10.23.05.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 05:42:22 -0700 (PDT)
Message-ID: <652809f4-caf8-cb01-3d79-530f4288b00a@linaro.org>
Date:   Sun, 23 Oct 2022 08:42:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/3] dt-bindings: ingenic: Add support for the JZ4755
 CGU
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221023123944.4103876-1-lis8215@gmail.com>
 <20221023123944.4103876-2-lis8215@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221023123944.4103876-2-lis8215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 08:39, Siarhei Volkau wrote:
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Unack. You still do not have commit msg.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

