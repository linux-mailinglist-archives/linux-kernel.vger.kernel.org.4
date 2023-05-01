Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AE6F2EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 08:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjEAGvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 02:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjEAGvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 02:51:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148281BD7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 23:51:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so3658733a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682923861; x=1685515861;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvlA7LnCwNQ1tqJrfgkUkBcliNefeRUSKJpMSbDu3B8=;
        b=aQIiZyVkHYs2d/ltdPea295iWkq3RJ4wpoLAucFek40h6b6GuNN4wOwGvyZhtpTa6U
         pqSoutf+++VIZV0EOwzOx6r9VuMZHgTZDM3pk0oipNLiVkClW04CqiAQ1CP3RtapD6zJ
         8qQTAu9am8vtvyya7JPl0039f4bOqiuGD+Jatf3ilMITOXuOLkGWx+l4iCTzCRc+DM6H
         nqkLA7XH9rAsrPVjmue/BgticjnaaScCey3ZJDEsCaYlIGFm1KH5LrQxTk8pn6BLnw55
         257fPakBWEz9TsRhcetUJOIgatiRtU/hUmmMjLzUMs8nofamZWXF4i2+1bZH1diDyhWX
         XbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682923861; x=1685515861;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvlA7LnCwNQ1tqJrfgkUkBcliNefeRUSKJpMSbDu3B8=;
        b=B/10bHP9NRCXtMphwnQe481qp+cItfF6SaVPMoNnzF2twesC1+qSbZCmRLojUYp/OH
         GZBfLxi9yGRr7j7/92UFXI+jfnNCnUUBg6tG0QfXk6DzpPeK8M1+TWgyF1XLoBQujTyU
         z/JfzJYTb15qSxgTvPOvFxnEr/gqeF1kdZ/+X07IKegf/tF6h8B1Y0+ctDlU5CZigGe4
         PxiPkE/TJ3wYN3ebwLUyEl43Ke1kOCBJGspzFSzHZBnG0djxUu3ivENg9JLFV1Zq0fAe
         k5MD5EAzbs3ESHGTY+5bE9zKv820ikZYadHU2G1O6K1cbJzRv/s9rg7B5eK0S1Qkn4im
         Pbow==
X-Gm-Message-State: AC+VfDxQjsFpbxfnT6hrVCdYrP0NI48SppqqdZWtfLHPRp0bSa73+SoR
        9DqSXCslZ5JofwqnQhh99FlO4g==
X-Google-Smtp-Source: ACHHUZ5EJ4CGy/aQDZbmK35ZjIBQP9RYPQlxfnI/mQYHPn63vEbKZkH3dBGDyzNpDA6359N50o5o5g==
X-Received: by 2002:a17:907:a04:b0:94a:474a:4dd5 with SMTP id bb4-20020a1709070a0400b0094a474a4dd5mr12620508ejc.9.1682923861520;
        Sun, 30 Apr 2023 23:51:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id rp22-20020a170906d97600b0094f3e169ca5sm14357557ejb.158.2023.04.30.23.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 23:51:01 -0700 (PDT)
Message-ID: <bee68068-fe21-c330-d085-b04b67b5a82b@linaro.org>
Date:   Mon, 1 May 2023 08:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add IDs for IPQ5018 family
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230429193336.600629-1-robimarko@gmail.com>
 <20230429193336.600629-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230429193336.600629-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2023 21:33, Robert Marko wrote:
> Add SOC IDs for the IPQ5018 family.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/soc/qcom/socinfo.c | 8 ++++++++

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

