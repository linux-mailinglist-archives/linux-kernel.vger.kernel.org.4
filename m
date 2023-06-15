Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23414731A30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbjFONiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344469AbjFONiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:38:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4913F3AB6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:36:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977d7bdde43so167883666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686836179; x=1689428179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxhJfd2ll8nAFEQrVCzLMvEn8Jp9xjM7Kxtgv+YXz0k=;
        b=dsjqIHaT5wS4DUA/yheEW/2GYzurEmgUgIdHq8/vnYdTrOHAuOM5AodlutyPp2pYRJ
         L7WPq+XRdmZm+UUmGW728WTZtYZNBCJnUrTz4XR2sQq+h/myyiPXeBMI18MhZlfyPnpG
         Y0Ja9e0CPdydOd+P1qtJ2CYne6/7V+ddBVCuWqJ1N5IFdAENJ6MvG5NSPSM4HBcpUgTH
         ylPIm1TV3B+SArtmR0ttkf/wzafizoa9pOtEDljmAYnlKzH5aLQD88yY0BnS7m6auj9h
         V+iG+8YD7YpbdxhfDMX58LzUmPeXtbSu4ytX2Or+cxFPY0nB9ccu5RQsMckZpf7lYy+t
         zNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686836179; x=1689428179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxhJfd2ll8nAFEQrVCzLMvEn8Jp9xjM7Kxtgv+YXz0k=;
        b=O8HOiF3wLorafp/bqBRAtO4b9ly9wSaEIkBStnz/9KCSydoyiud6FZLzEA2ZYPzSAc
         pTo2HKknkKMLRl3PSjQxf+tpq0HbS2u6kqGEAES7JjvGaRsu5YiVdvQr0P7deAxuhZkM
         F4ofXUxAgEUtwCPwrGTKY3wOq83WnrcgEUVwWr+SbWsU5+MavRSYYxraWJkfdsYrek10
         25AyNWQTO1hNVDQ9SjFHq7XCnw4xD+yx4/QvIZzdcToqdFWBdWRKSdqtxPKHp9J++KxK
         GHHSL72GF2TbyPvqVS04pq1inlFWayIg7aRGUuGkySi6HSHqiQJzMhgz2jneP4MLi8vT
         NUVw==
X-Gm-Message-State: AC+VfDyHWxHnjkDK6+z17e3WCekayygKy3BB4RQ/5s+8W5hH1IbUMzeO
        w/uqRkqWReRokSqydoFzRfIc5Q==
X-Google-Smtp-Source: ACHHUZ5G2KDVI97s5jDk0HjvRJ8KLjMmTYTO6401STaAZBen4SFHRcAjha9stATuA+Qbd4ZYA9sCEw==
X-Received: by 2002:a17:907:948a:b0:978:9235:d450 with SMTP id dm10-20020a170907948a00b009789235d450mr5096371ejc.9.1686836178947;
        Thu, 15 Jun 2023 06:36:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709064acd00b009787ad3157bsm9470074ejt.39.2023.06.15.06.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 06:36:18 -0700 (PDT)
Message-ID: <479bf05e-342d-f94b-87f3-4cc0a95fb01a@linaro.org>
Date:   Thu, 15 Jun 2023 15:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/4] dt-bindings: spi: stm32: disable spi-slave
 property for stm32f4-f7
To:     Valentin Caron <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230615075815.310261-1-valentin.caron@foss.st.com>
 <20230615075815.310261-4-valentin.caron@foss.st.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615075815.310261-4-valentin.caron@foss.st.com>
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

On 15/06/2023 09:58, Valentin Caron wrote:
> From: Alain Volmat <alain.volmat@foss.st.com>
> 
> STM32F4 and STM32F7 can't switch to spi device mode.
> Forbid this property with compatible "st,stm32f4-spi".

Just to clarify - driver cannot switch or hardware does not support it?

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. (spi: dt-bindings:)

Best regards,
Krzysztof

