Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB667B195
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjAYLhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjAYLg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:36:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E1B5865B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:36:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k16so13518086wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dVhlUNjqsBL30qFj7Fwhndj9IVP6//dpSPYEVekBIY=;
        b=Kfhm/onlZx2XNp3mdcPwUJXKM/RQ9cXvyvfCBFaza36IV80QSJlRXc6u8VFbj0YDCU
         5CaxDqL7o8JrgR9Qe7ocBOkJ1eLv8Rfx0irZCdhwepiMbfh1btuRiajQ36SlDAArAOqz
         3x4Lc1aLNYGJt9UalXa7G6rtWEBbCqkFmkSXOaizotUJndK5Ce9a/bhRZufzro8qCkhv
         y7ZU3RdNDDxWg56tKp5MQq+03MBS6vjUL6eHmqjnbo+AfYS24K/7Q19Xce31qkKfZJMw
         bo6TPMS/Q3BoZqAC4Td+Nm0J79kLe5u/5a4ziZDNgJCAP6u8ho6T4cgYO4GCZ9I8STeD
         F50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dVhlUNjqsBL30qFj7Fwhndj9IVP6//dpSPYEVekBIY=;
        b=rJUUhP32PaAb6HAZ+827/MB/Q0GNx9kky69w7ObSRLqqrRTxcbfB9yuC8XjNALD06A
         Pk0qkiu7p1O11d3LJ9yIeR2UswSnHX3WeHscGPETa6ZQ/8Oi9ArCGWe20rkafq4mAAKZ
         O3ko3pvX3TLSUW7JQ2ykfCbZ5T7uMhpxXbcqylZmMuRs4LYBrjOIwp0Lhxtgko89mA74
         T3zGpqlUXlZ4YG5vKnstI+9kKkSrYcFvbR4M0HIbhYZNxufHg4A7jrnINWFrdje2wr7G
         5K7F1CTUM6b59pBKF28VfxppxUtsqvpv/2mdlEwRRK0bzo1L6cq3eTwpRrhcRSK+ZO7h
         03KQ==
X-Gm-Message-State: AFqh2koXsCoFqPcnIOfRFFQjARKTJe5irmXF2V9cITv/eiDTkRxm9gP4
        xcrCerFGE0aZZ8NOO969Hg2dbQ==
X-Google-Smtp-Source: AMrXdXsIWEY9FTI1OV1UwP/0HQPv4v1+dM8bovEcXISKZKpdILaC0A7PO/9NZBTVAPpZTTdVsdtfqw==
X-Received: by 2002:a05:600c:3556:b0:3db:331b:bd2d with SMTP id i22-20020a05600c355600b003db331bbd2dmr20147637wmq.18.1674646577387;
        Wed, 25 Jan 2023 03:36:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b003db2b81660esm1642996wmr.21.2023.01.25.03.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:36:17 -0800 (PST)
Message-ID: <a768138f-a960-16b4-7097-9212638141a5@linaro.org>
Date:   Wed, 25 Jan 2023 12:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro
 (xiaomi-elish)
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230125112903.10710-1-lujianhua000@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125112903.10710-1-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 12:29, Jianhua Lu wrote:
> Add a compatible for Xiaomi Mi Pad 5 Pro.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

