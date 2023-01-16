Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0B66CF36
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjAPSzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjAPSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:55:19 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDD52005F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:55:18 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bk15so12659454ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQ5+dR99h72tUtxnkoNE7PckMkkfFnKUMjg4pU/+JPg=;
        b=OzjszqOAQCnL6z1DoHtD6eLfAvr4Mh0hjfKeL2YfdWRyy1Szr9TMUzwUnOSvsNd4gL
         Q8K91ubdll6Pfioy4vm5NDyVLDaM3r8Agb0RpJr1fXacMfyHgQ2lYf9gTzypS8g3H854
         kgDORIM9ZOkO/hZ9TcbUrYiLdk3nV4tjabWrzTWOliBRIlpES87cyetM2FzgItDQD2D4
         e7lMeLB88lpXHUvsWGdYeXl0xpw9QqzLBQHUQ9xMOWDlHIEASNqgy1xvu+bo1ICRtgi0
         GeMx6yYxOIlgppqssK9Ijovyvr9FfQQLFva+wMumKl6WAGKY2HLtKFWa/xKemVx8IcwQ
         NorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ5+dR99h72tUtxnkoNE7PckMkkfFnKUMjg4pU/+JPg=;
        b=a6MkBeT/2fEGuX+DlX/7ZWeFqEfLbf6SiUzEUncq/NxZVu7S+6yK8eK+RpnwRhWtBg
         BP4akSFHA+1h2X7REZ1/FDSxSzPxpk3aOryjolPXHPl8oIBJITjeFyLOnlx8XGHYIm55
         xORj5LFoHjYbgidzDiRLEfAniLxJPyqVubatWJCDu/usYotbPqEyOOWBgEaeCUt6Pait
         Vz3AD1l2dGXAqqpPQNGIMS/PovWmigBSCo1U7Y9OXc4GwzpZ+R3yZCc3yPtMVXuctcTw
         WWSAhMX7Xv6zh41TN8fiPuOGCfMKVuG5o1ikU9v75OF+a/x6tXRzsjl7mj2f98nAEtha
         1chQ==
X-Gm-Message-State: AFqh2kq0UX8P+WW1S++oEcBQCnel4B0TBCgJpizO12orphb+QJ/iq718
        A5fiRl+mqMM07W30t/uQ/TJGiQ==
X-Google-Smtp-Source: AMrXdXv1bRlqKcsUE5JtpHY0mnWjO/QVdoe4r1Cd8XVsQvQYX6OLMWo4Dk68Vamqrqu6SqQmRKOxrA==
X-Received: by 2002:a17:906:f189:b0:7c1:5ee1:4c56 with SMTP id gs9-20020a170906f18900b007c15ee14c56mr30117ejb.55.1673895316732;
        Mon, 16 Jan 2023 10:55:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906c31800b0086dee4e5555sm2871199ejz.87.2023.01.16.10.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:55:16 -0800 (PST)
Message-ID: <31d78b4c-1416-d8cb-a187-bf924168ee1e@linaro.org>
Date:   Mon, 16 Jan 2023 19:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
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

On 16/01/2023 17:48, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++

Also, there is no "hv" hardware, so that's not correct location. If your
bindings describe firmware, this should go to firmware. Otherwise, this
does not look like suitable for DT. We do not describe software stuff in DT.

Best regards,
Krzysztof

