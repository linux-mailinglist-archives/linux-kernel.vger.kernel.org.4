Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042FA6995A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjBPNYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjBPNYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:24:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060C54567
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:24:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id fi26so2749202edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 05:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inYR9LenWiRC7ZL1osRQ5uLvoSronXeC63OQQGZ6mXw=;
        b=eQpemlgx8bXiW0mPZg5zRz/re/AHDpEf1PvdeJeQvA6VHp7SmNP0LXupT6oltlG/mB
         TNdiZkKjYl2a7mPaGeQUGsuvyiCW9uM0kYPPrAB6heVynEtrbBDNzV8vUUGy9UJHNTHd
         EECSyny2+P5QjFqtEyu4/gG9OMXcqLKDrXH/xjxFZpgtznxlXUYWoIxPjcfORzeFpchJ
         srpEAaS8sxS/e+Wj1Ni7AEBFjK1fA6gQqjRHj/++CM2ddBMmaA4WfsQpkntt6Zhcad5/
         YoU86nqmG34+pgn5ph04un39SE+AcRr8cWy9DL0ZjVzzpfPmmAjO2BARm78LNpEyxA4o
         A0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inYR9LenWiRC7ZL1osRQ5uLvoSronXeC63OQQGZ6mXw=;
        b=NCQAxDKGCIdb+Tp0tWhuw43BkdykIqVE/WnFisgHRpva9JbxzyKXMj5Czrvig1/Um8
         zseAiEeq7Ryms2Pqebk17+VPGZk255bYYYyu8kljF2fiL/51DyptsgRlj9KZajPZBU7F
         GZCrupBXxcIYF9XxlcmjPIlrKtF0+kGi4RFDRarzscp5o1SsQcuDTvEmfxIpmFGV0iqB
         D67Upmgvg15Ba3UC50t6VklKrLBRqHbyKIoY9VJBCikuXPUwZ8iA9lMQ+CYWckwe9+GF
         1wIQrk94k3TakG4fts2ZzsyqEX0L0gu/vilmj30fjw7cEz/GJ0hxZXeXBlJyFJp0r+rC
         6s3g==
X-Gm-Message-State: AO0yUKW8/Cl+t5cAz+wDXDa+1vWYd7j80AF9WbnwlrK1eLrTOb7z5BCT
        ecuCwL2eEN2ibyTQRzRveUI3Rw==
X-Google-Smtp-Source: AK7set9UdfmMefmjjDttGDFMMjgpoeHzKrI6HY++OKGZBr6ubR3SO+RsJl+6PB7WJ36NuNdjWrj2yQ==
X-Received: by 2002:a05:6402:180f:b0:4ac:be53:1789 with SMTP id g15-20020a056402180f00b004acbe531789mr5637904edy.40.1676553880285;
        Thu, 16 Feb 2023 05:24:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k2-20020a50ce42000000b004acbecf091esm866491edj.17.2023.02.16.05.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:24:39 -0800 (PST)
Message-ID: <b6f55c9d-89b4-5b26-1042-c4a047e32cc1@linaro.org>
Date:   Thu, 16 Feb 2023 14:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2][next] dt-bindings: power: supply: Revise Richtek
 RT9467 compatible name
To:     ChiaEn Wu <chiaen_wu@richtek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
References: <b72052c0bdfb209d5583ce0741686e8a2a9e8dd2.1676573862.git.chiaen_wu@richtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b72052c0bdfb209d5583ce0741686e8a2a9e8dd2.1676573862.git.chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 12:17, ChiaEn Wu wrote:
> Revise RT9467 compatible name from "richtek,rt9467-charger" to
> "richtek,rt9467" because it has to match the "compatible name" in
> the source code.
> 
> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> v2:
> - Add more description about this change in the commit message.
> - Rename "richtek,rt9467-charger.yaml" to "richtek,rt9467.yaml".
> - Rename "$id" as above.

Thanks for the change, but the patch was not created correctly - there
is no indication of rename thus it's very difficult to review. Please
use correct patch-generation arguments. For git, "git format-patch"
should be enough. If it is not enough, then play with -M argument. If it
is still wrong, play with -M and -B.

If you use other tools - investigate your tools to create proper rename
diff.

Best regards,
Krzysztof

