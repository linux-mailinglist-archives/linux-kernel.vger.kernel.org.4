Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C393B67C884
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbjAZKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjAZKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:25:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488C34013
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q5so1307155wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RixHBTYJM1c4X6p4mjaa+WDjXHZY8ga4mSc4WsfiIqU=;
        b=x8pBahowr0WiMu31e8tTC1xmeDkvkArj45H9LK0shv1M3+iErOgKYFvRV2mSOa5Wis
         6q/RTcHKqCl8Uz4Yth/NHm8WAlyyzbeFiUOTcZ5ddvwikIPy2hl5HjiW1USDRVxAhMMY
         IFZQ1gV5grJOiDamwtiQgDe95TCa+cs7m34oDu0Ydwh09D7mgouvrlSGBLNkSFEcqnJ1
         IhLlQ/PKTemv/+VBlfEWIOJoi/lDDDwfx7s1qrr0gO7XpNYWebcbXoWZsZLyvI8oDrfz
         oirICnbMg5x2MKJsT4lZ0ACTTjti6mCUL48oXwQSJez5g4rFRmpJIgFGOH3K3rgce9KH
         3Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RixHBTYJM1c4X6p4mjaa+WDjXHZY8ga4mSc4WsfiIqU=;
        b=P4rIlZr+q6Awx9NIVeMarpg4K9gSR4PTA0MNAdzUa5N4I9zObHSXLBN9zNJ9l8OhJ7
         xKrM+S68T4yPY3+RXkjFZwnTjbFTWN7qYBwBbECSQSMDph0AQ/bkHoULt7srzCBPnWTg
         oHj0fyJ18ivTA5Qt0tumEAXmTSsiMZ8/sQNIv7o5209jQLBozRWfipHXaDmwjx0gb16h
         A0UqoY+6zbyLFs//E0wedo4G6bcYBaN3xsMr/Mx5Yk12n0WR4bzijBvIdD43qRYhFMkO
         4RQyfjvFgQfhyzdJubdoEoScfgCJ26ieOrFu86G0/Ytir4NjaK61SOlpTNZFi4KcDj7n
         Srvw==
X-Gm-Message-State: AFqh2kolNrqGhYQXqTnX2OXObivPMcUWdIsa5EtGdDW/cBgVJWg/hzh5
        S1gKY0D8staj9cBq7QlOAAq0pISn0L9zfcQf
X-Google-Smtp-Source: AMrXdXv7TVlOcr4l54XRp6be5Zhrx+v5ygLzHQZbm/j1GmDwcFQ6G+P019guhhWUKnJj25i80MDVbw==
X-Received: by 2002:a05:6000:1f14:b0:2ac:5b46:9c85 with SMTP id bv20-20020a0560001f1400b002ac5b469c85mr30123489wrb.68.1674728745557;
        Thu, 26 Jan 2023 02:25:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm886514wru.116.2023.01.26.02.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 02:25:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: axm55xx: align UART node name with bindings
Date:   Thu, 26 Jan 2023 11:25:30 +0100
Message-Id: <167472873009.13092.14642851158475305926.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151529.369313-1-krzysztof.kozlowski@linaro.org>
References: <20230123151529.369313-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 16:15:29 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

[1/1] ARM: dts: axm55xx: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/79a5b931a2af63cd1249abd696566a7ffbe44c17

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
