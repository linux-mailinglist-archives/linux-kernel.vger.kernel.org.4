Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB89694DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBMRHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBMRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:07:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD61EBEC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:07:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so12955848wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2InQIExYmP5Jgqnc5AiUW3/d2IV4ctPWBKAcygB36v4=;
        b=D21IBKd5duKNwSZD2lHnVwMweGSumv4jTyAqy03/XwI8B796iqCUO8aE1pFXpyk6Aa
         qJXtcld4Li+Z8PzdSbHDoYR28unCTtepqvBlN9UlvIsQYFQQ5/QkhvsC9S9qIdwcJm2I
         lF6vLSFEbHmIOXFlg7FtYJUZwXq1wMgDs3hU2uvAU20qBQC1NFyG9uwoDmX8lndaM7WS
         3wmSDXdctqtwL/rupvBCfI6uphuzDTCcK6aP234JVsfOu2AI6BDslLDXIlzFomJgh+Ra
         RrU32Jm4vUV0Mt3vMYRpvc68T+eBqtFIpTwNoOXqRAJrkPnqiVMXmfPvTmmQTBaMfYcQ
         +bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2InQIExYmP5Jgqnc5AiUW3/d2IV4ctPWBKAcygB36v4=;
        b=qTCyYKsmQgz+oSiqNTqH0LMh8zAGaL1TNdxyDrqnHmNtcpvtJkVTauYO++6Iq1gX3H
         NdHN1saWLqNir6Wlbc1Db2GPEpnO2NGpcxh9jD6QsYKBrurmtCmKzx018PiNdvaFn9W2
         O1h4rQVO+vCRMEESrwGIIrXdNND1dMSFA697lJwf2MQujTyOL2opLhtjq5DLbc3+Bulq
         vd7EGp1txh7fGLhaPoZjUf8VqyWzy+TEW+3PcgqpSfms90xtEV2WTy9JJlaPTRea1Rm/
         v0FzdHzQwK2XrhnxlB+/42EASDkoxiKmcrVVVHM06r7ZLSKsGfKUdnNNSJQcN2bBXrKi
         r46w==
X-Gm-Message-State: AO0yUKVIcJDQlbJEHxMvhDo0oSufEOXRD9E49UzajaGqfLQE/8+u2W26
        udJxkBFG6Tt/yZnBhu1OyGAvxw==
X-Google-Smtp-Source: AK7set8f8iVV15Q5bQ7Ofj85okM/P5EZ0M3GD/i8DQmT3Fhlf9NzOVveTl8eioF4PukoueqHH8l2DA==
X-Received: by 2002:a05:6000:1369:b0:2c5:4c32:92c5 with SMTP id q9-20020a056000136900b002c54c3292c5mr8649659wrz.25.1676308059660;
        Mon, 13 Feb 2023 09:07:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i14-20020adff30e000000b00241fab5a296sm11030147wro.40.2023.02.13.09.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:07:39 -0800 (PST)
Message-ID: <9c53ccd6-ea38-82bf-2284-d606fb2293f2@linaro.org>
Date:   Mon, 13 Feb 2023 18:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: sitronix,st7701: Add
 Elida KD50T048A Panel
To:     Maya Matuszczyk <maccraft123mc@gmail.com>, heiko@sntech.de,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213153816.213526-1-maccraft123mc@gmail.com>
 <20230213153816.213526-2-maccraft123mc@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213153816.213526-2-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 16:38, Maya Matuszczyk wrote:
> Add compatible for 854x480 Elida KD50T048A panel, found in Odroid Go Super
> and Odroid Go Ultra
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

