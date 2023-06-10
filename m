Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783B472AD56
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFJQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFJQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:36:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D121984
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:36:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977ed383b8aso463631066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686414982; x=1689006982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7AY8vbgZJuMRuKGKhXc3CaPpdpOazXr/FWch842YUk=;
        b=VxbOVRcwsU7PAsw5hy2wRGW6Z6yIPXnFYabaHbIS/sC2RYXFxkQNn/X6dLOP4pu6gU
         huZXwYVOHjuj9hFVFpWr6BB5WUl8MtpABmqC2hutByzqwOg/NWJL945cRpWXRtSI7+UQ
         rf/vuoUhmUDkuaAcwdDP+st4mLnmkk3r8MfOUjaN5ko+vSwUN388mU8LtC5sl8jMB5GY
         CVx++rd20QqNx6xAMeoU90E9QCCFRhktgASe/7aIh/DFlqSBoKNspMkZz5KQzIbW9kvK
         KY4RHCYw5PurhLoyJsU/72kkl7Ztlx3Zeabm3RYiumxST8vChuBSNkFLJNFGHTbXv6TS
         Cuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686414982; x=1689006982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7AY8vbgZJuMRuKGKhXc3CaPpdpOazXr/FWch842YUk=;
        b=gkl09KjShmYlRL+2AGNV2zuko6MyTkojEZU1YTd1+kJLzqemtr0AaCqA0yz0w8QjjF
         NLTEnMsefr+YYaGl3DH0eSx2UHGARsCEnrZrcytqVJDqnf81lvFxTnV9GCw+sKfDrjg0
         cDa3kW8trB/JPMxGs5VuS0h1Bx5dImk6JP9L9fEVmeRqLwXsDxJ6XcyuqTbxjQDBPn7n
         fSCFChvOons4/vNv2d9gdxsPd/Eq/lDg/+mWwO4xpVpGSYM9u4lNJUohxHy4Ev/AzXuT
         Rwq1mEmcwi7e7GvyQ1M9LBZx+POq5yr8KwILcFpA3OOPy/40baMpFRx48S+9FzLeyNhn
         GqAA==
X-Gm-Message-State: AC+VfDz5bTokAqp9ELFaKrNTYlZvmW2cCKqhhJjrv+PudFwi35g9VK7W
        1LbOAdIDMPR47ZSRtfarfYJqGA==
X-Google-Smtp-Source: ACHHUZ6f7e9kt2rg7rJDTnmgDGuBIfEo9uR7tv20U+70roOf+SNw6N3s/gfAVo2mw6o+J90tvKqOhg==
X-Received: by 2002:a17:907:1b0b:b0:978:9011:5893 with SMTP id mp11-20020a1709071b0b00b0097890115893mr4670163ejc.37.1686414982474;
        Sat, 10 Jun 2023 09:36:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id qp25-20020a170907207900b009787fbc2520sm2734226ejb.124.2023.06.10.09.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:36:22 -0700 (PDT)
Message-ID: <c5ce8f8d-9e80-d8ce-3a82-36b2b4614766@linaro.org>
Date:   Sat, 10 Jun 2023 18:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add Gateworks i.MX8M Mini gw72xx-2x
 board
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230607171004.2018275-1-tharvey@gateworks.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607171004.2018275-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 19:10, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW72xx-2x board based on
> the i.MX8M Mini SoC from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

