Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8960F938
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiJ0NhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiJ0NhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:37:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35078181488
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:37:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j21so859699qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rzUN2Jp8f671eR0lEV54lOr9L1Q/5kabvw1UeEpF2I=;
        b=oOGuc/bPwq8xbd8fBfIxmNf2iCQNkBHnOZgPHf7VT+QH2pxFMwZDIFKN9hMo9lWqwy
         vlDwazNhzXJRKmQt05KbqcaXAHGsy8cAfz0zZi7adgrlNDzCfXT3AoTuQKyAmDKPMfrr
         4drboWNMbGOH7RnFGgDIt9MMKqWk0bRcVgw7p2uNvJDDcOnzgUmIReSsJsdexGfE9T68
         0mEa7PPZCzJaB9YBn868mo+bZp0k71EXup2PylDR4ZOl+EuhyTpsEcZHnYSCr7XDYUnn
         6kQHuXs4OA8jcYUf+WSEM/naNZvn6ybgUdI0T334XYz1pJ22GCznDjUmgi0k6VqvWo8+
         YJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rzUN2Jp8f671eR0lEV54lOr9L1Q/5kabvw1UeEpF2I=;
        b=79e1jL67dKVJLsM4oc7B0ZHtxyfIYKK6TyyMHuQWphCHWAR6tixhpn8JgulgAOZZ7C
         yrKy9ETgQc8fYYmg7SurgnUXRD+nUHA3M2h21fS3K1gS2CJqxHX84y7nGzzw9XKFQt11
         wcob/Y4LmhUvEIvm+fCw1xZiAJp5emzQ0Zgpqe4zxgnDz722FbVag/bJx38MxdU57Nak
         4eBCD7/psuJEgntTB3kNzxr2OK7cKntXAjGz/sUEHTQSBUP5R7xxU27hqzlYlkMv/mCJ
         ASnL23l9OGScwmG0JSUSn9jQWtWC02BjRFrKETx7zpVlw512RkKfx9Cb6Rj2PUKFJ9DD
         NTyQ==
X-Gm-Message-State: ACrzQf3LG3+MqbW4AHykOxtoq0nmB6zNddAVwlQFpIsNuh1RKKGKWEt8
        aOToGlSpi3dmAXq9owzBUNelqg==
X-Google-Smtp-Source: AMsMyM4mNLk207R0Kgr+IHrftadJ9IOoTu0ugDT2qJ5VjcS2fmHJTVwlh8o78sJAQ2uRd0n59QQUrw==
X-Received: by 2002:ae9:e501:0:b0:6f6:7af1:5099 with SMTP id w1-20020ae9e501000000b006f67af15099mr12750669qkf.135.1666877839352;
        Thu, 27 Oct 2022 06:37:19 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b006f84ee3a4f3sm998795qkb.48.2022.10.27.06.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:37:18 -0700 (PDT)
Message-ID: <68d9cc70-04bc-38ee-eaa4-e46aa5fe1760@linaro.org>
Date:   Thu, 27 Oct 2022 09:37:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: imx8mp: Add ids for the audio
 shared gate
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, shengjiu.wang@gmail.com,
        abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
References: <1666834442-5609-1-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1666834442-5609-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 21:34, Shengjiu Wang wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> All these IDs are for one single HW gate (CCGR101) that is shared
> between these root clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

