Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A006892F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBCJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjBCJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:00:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C392C31
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:00:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg26so3340852wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXoAdHhN/nXWyLyZPUiTv4Q4XmY1KdAGzUzsHG/Rk/4=;
        b=EQ75a+A2a/ajqx8kGm+he/MG5JqJRScsCs7zePqdvT18OKGHTuLnVCDHxC+mDWrDZG
         OhTQEQto6HF0AgYT4Avbgk/mQ65mHW52eY9ahBiurEBaJThzk8t/O38jeGsVQRWClp6s
         KHsYlkOwGaAKKTaHgKAE1E8arVdP+OD0tkAnJbahzPvSZqpqIwgb+nGudQe4bDkV7Aix
         zKqp9xm6nnThzNeQ9tw7xERnlLBPPmOF7KhlqhOCT/HW5te9PdcJNyjHCOKsNyP1HYGP
         DaEZwgiTY2cI/iuquNk0hUomjalP7z+V2eNFdExLL2DQcbjz4XJQr8w3lIdWqxzKo8tC
         Ycag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXoAdHhN/nXWyLyZPUiTv4Q4XmY1KdAGzUzsHG/Rk/4=;
        b=Yre587NDaq1od0YiySJFNtVXeX9J5VGuWs+dWa0hUw42mlo5lvx5xUOKG6OGS79QcU
         VRsmQOxySkfN+WLHecfbbr0uv+KCXeeeZLZxof9Z+g8BrNVTCYbRgsFLLVgtSPPO7X6q
         xwbCI6ECi7z3FdE84NXaIYAHKexg/o3y3ffMCFGtmm5qb58G3DERJ0r9xihZ5xgVXVBz
         cErozZC0d7tRXvR0r9NNGJ2vZy6giAolbwotosUhmNpIk3IjDCzeBRTpfjoT+ZM0Q2pK
         m3CggfIcs4fOgMmmayn50SC4oB6t4PnV7JmWXHixpXhpkL69fqjiUYbhGP9J/HKIybDX
         X0PQ==
X-Gm-Message-State: AO0yUKU8OXdNPjXx5WHHthLdK43GZws9D0rBKqbAjiblo0jIWAJ3wj5A
        kqNCwvf/cjmH8zRFcWfnNcWd8A==
X-Google-Smtp-Source: AK7set9UG7Ud3p7osiXX4INl9ByMEzwhEn6pf64Y4FQLsiE5MeXOWMKgknfwGwLF5zdgnCno4AhqXg==
X-Received: by 2002:a05:600c:3acb:b0:3db:f0a:8707 with SMTP id d11-20020a05600c3acb00b003db0f0a8707mr9116756wms.40.1675414822412;
        Fri, 03 Feb 2023 01:00:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c205100b003dd1bd0b915sm4170806wmg.22.2023.02.03.01.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:00:21 -0800 (PST)
Message-ID: <5de1f657-2632-9165-b6ed-96327fab1de4@linaro.org>
Date:   Fri, 3 Feb 2023 10:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add StarFive MMC module
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <20230203081913.81968-2-william.qiu@starfivetech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203081913.81968-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 09:19, William Qiu wrote:
> Add documentation to describe StarFive designware mobile storage
> host controller driver.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../bindings/mmc/starfive,jh7110-mmc.yaml     | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

