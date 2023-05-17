Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B67706339
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjEQIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEQIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:45:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9921738
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:45:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-966400ee79aso85021766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684313137; x=1686905137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkpEoV4fvWHofZFJGs95rC2ymcCgXT2vPbv2LelJ68Y=;
        b=fm0dTYeX7uD6iREM9mwljE+pR5Rz59+fdb7opWly/irSuhYwLr0ehAsz8+HlxQ843H
         uRQ66mXeouWe9DVEHD1VjZ0LbRRS6tJpK8nO6pXaH1ohMguXqLYJ0JVIm38TlatoR3ai
         CjBPw43NbhfDVUURDxyRas9VPVOTxPilDzZdFIqiHYgKRQvkg1WEQb1Sk09L+YgFItNz
         +5h9EgBHZ4P2hN07YBM6Jm5pHDb+B846KOawiU22l2SryJNnFbcirSTZkLCn/oSQQ0fi
         OvpipVR+yZeYNN55F8hhP6mUlv9/PBgMQNuE/NrAtPWUeqATxtx+RNUMPvduwuVksclt
         A9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313137; x=1686905137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkpEoV4fvWHofZFJGs95rC2ymcCgXT2vPbv2LelJ68Y=;
        b=e/3PWlhbF65a3qZKQyT19rG9PjKuORBWfJjIAGYPEep0NaNxn0b3mS/OeGGQ9UHa1l
         z2ZorcfVmGmnp08AdUY0Iie4+8qeAbyQaK/hSGXStNk6Lf/6HojDFVgEI38F4tndy5w0
         NByY8lGKzW0wP7TEQTQASmRXaQAh7b4CtPmQK0Is6/K+1Bi0s9AjXbEb7rfkXTeLHdEw
         xaBV9zKUKA6cRIO40RvIxwAMFPZ4c0JjQnNPihg68h7cFmDDNf9gEJXx/y94+HAFjOJ1
         Gzau6sQXkXHIwp/QFfW4O4DciYA+GUGNNToKBDaoaI9aJEc/WxpsY+ooyMfNML4K1Zjy
         D8AA==
X-Gm-Message-State: AC+VfDw8MGMCkP1aE3+QACflY/maAZMk0ot641BmMqTcKG8A1VrTAKrd
        SBRlaNhKcHH/GsjfvS1XC6YcWA==
X-Google-Smtp-Source: ACHHUZ5ptAWs3fEV6gNFAegVFJwj5kBSck0Xwq9/93ooM6PFOumf0BMKlFXgtZOhD7YpZRRWaDaHrw==
X-Received: by 2002:a17:907:2daa:b0:94e:dbf7:2dfe with SMTP id gt42-20020a1709072daa00b0094edbf72dfemr40456838ejc.11.1684313137392;
        Wed, 17 May 2023 01:45:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id gx9-20020a1709068a4900b00965d294e633sm11982610ejc.58.2023.05.17.01.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:45:36 -0700 (PDT)
Message-ID: <5a7b168e-6f66-f38c-3f5d-d05028fe45e1@linaro.org>
Date:   Wed, 17 May 2023 10:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
Content-Language: en-US
To:     Johannes Zink <j.zink@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     patchwork-jzi@pengutronix.de, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230516-lustige-usb-phy-dinge-v2-0-3383a0de34ac@pengutronix.de>
 <20230516-lustige-usb-phy-dinge-v2-1-3383a0de34ac@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516-lustige-usb-phy-dinge-v2-1-3383a0de34ac@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 18:20, Johannes Zink wrote:
> Add optional properties for tuning of usb phy.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../bindings/phy/fsl,imx8mq-usb-phy.yaml           | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

