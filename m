Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F96FBF78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjEIGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjEIGpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:45:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FD8187
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:45:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso10256315a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683614722; x=1686206722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkkwZGYc3R6aqGWovPS6fL3TwhS7zHuNiOUzftljdYo=;
        b=uctgl14CoVJQucrPFkK7WMaQQJ6ULonHeHz1L1nnSfhm5BvS+SQwFUzKmBwwy44+U+
         +dYom9j9Qqqd/fFwMj7vzu8FKgAguvD0uaqmxVB7oNaKUlHgZ2BJkX80iC2gk4gJrf4E
         hmuIzN1bRyjB4LBQrKLrAzC46oBqVFahXOlQ+5BNlpfnIzefG5xnFNm2uYty1GrXM2+Z
         8cy92FoqYYyN2PCycDZRb+rCpOTtW5rZqvjvovhaA4WTIIMM3aQFJ5ubHAtLQAvv1WZ7
         Duhkh/dRqjHN1cThaLHWyP431cWZPkQiqHRPK4tvYgDE6flf67HfUGj9xxtZ4u+dDsMi
         Cj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683614723; x=1686206723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkkwZGYc3R6aqGWovPS6fL3TwhS7zHuNiOUzftljdYo=;
        b=GcuBr7iZV31sfcBB3nQtGFQL3tfK/q2H89mTPiJ2x2e1NzecyklBNZR02gY7dl+00+
         5098qi6L3dskaSlukB3+J38xPLMV+zfwlKGH15KnCloisvWonXZaUPaHSeds+0J5LwFB
         pCM6N0mENhznG/IdywJmIJDQXLhEUpVWOWtotSrhOHS9DeIMFhNEsVtc7/a9OppRN0pk
         ykW83EvT5d3kP7tWVjm45sSX+YBGVtsaPP4Yb0lpdI1kVgZM+Mx3kbp3MbWNzicbS9Eo
         4BKG1Pq84jj9lJAsz26TMcOHFOub7fMZrfJCgSuAo190lQkUTK9XUTKBU7saUpqOlgQj
         kRsg==
X-Gm-Message-State: AC+VfDz9n+POhKuaxotKxtL5Ac+RGIAVEVvD2FLvcXjag2tdb1Z1LVty
        NOjz0Kfkfsb54i3X3DaaoL4ehA==
X-Google-Smtp-Source: ACHHUZ4iebzY5pxA7CUQn0rCWjzuhqoulxx93nLAgMs6mvQTCKJHPxKnwE7U5KDVs3ej41XJI9pwBA==
X-Received: by 2002:a17:907:7f1b:b0:966:37b2:7354 with SMTP id qf27-20020a1709077f1b00b0096637b27354mr7154990ejc.31.1683614722744;
        Mon, 08 May 2023 23:45:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906055500b009584c5bcbc7sm906896eja.49.2023.05.08.23.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:45:21 -0700 (PDT)
Message-ID: <01be24b3-aaf2-e27b-d00e-f8649a497463@linaro.org>
Date:   Tue, 9 May 2023 08:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX93
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 13:46, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 OCOTP support
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

