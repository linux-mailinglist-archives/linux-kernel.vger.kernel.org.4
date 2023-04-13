Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B26E12AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDMQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDMQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:47:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18824AD12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:47:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z9so11976128ejx.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681404450; x=1683996450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51DVCd/h3/cJO7cjSlyrYI32aoEqdT9dgNs9Eih2opE=;
        b=nwu0GWON8U6TXZ3AT7gmRhnXNlY7lxqUiwgRLU2Uw3ieZXA+uUVn8nCJ7nbTT46IVu
         wwLwRAaXeAkQoRk45Ctu06Gj5+w2VTE0sNRhlPVtvb+AVprqq6Mdk+suH2aNI6BYPsiB
         6cNLN8+zEtGyNX/KyEoBvn46OtTtt2tlVT85GHip2cSO1/PBq/JhKMCRQNv9eIztyRY5
         w0q2os13wwQcZx6p0frcHHUtOiYimZakYu6fNc8RLvh0Y24ZX/hjuJYP7ELV1yb5wJJC
         25g8s6YrMZYnPPeLL4eVKHQqkfBw8CBaCSw83aYue3fTj6hcTSKEfMrhPzS81jXREH2C
         PvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681404450; x=1683996450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51DVCd/h3/cJO7cjSlyrYI32aoEqdT9dgNs9Eih2opE=;
        b=koSOk2h6XbldtKLlM+RJyj3pbkB2JbzojoaCF7thJ4YVFtgUhrbxiZtqT0B4lWYSyY
         XitvdgMgbdxXJJm0poYK8snzkCXg0Qrf4OGU3OoDnNu9HLt1xBjavN2qzf+worUsF/34
         ITSeniAKTW7+JG/zNzzqOjgiy9xYCdC2IYaqQskZ2sKbxaud0vLu5HXRmeEb7HF8z5nR
         8f40DG/Q14CPIcpQW0DHNNKvWal65vdJlKulHKBAK9bilTOQ6WTZetm5fX0q2qjGGWEv
         q6kT/Fk2Wp8J8U7jFdaTIjSzdpq5sb9eFpn9LAbBpdG4WEIbqEKFFczjhkl+dg2DwEm7
         sJOw==
X-Gm-Message-State: AAQBX9fXTdmFl/iW2+Hsyw/a3Ikygs3Yl4KLkHykuGD8gwBn8T2vqmGz
        /mpjEsUh2qCCULYcwkiDobQA2A==
X-Google-Smtp-Source: AKy350b4Jz7APW0X824PXsHeC5e1sHTqjV9UgCwCrxjufPBWxBtgGffJCq1hAMMiXPCq9xLeN0mhEA==
X-Received: by 2002:a17:907:3f16:b0:930:f953:962c with SMTP id hq22-20020a1709073f1600b00930f953962cmr4155726ejc.1.1681404450522;
        Thu, 13 Apr 2023 09:47:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id ka20-20020a170907991400b0094c67e537c8sm1208815ejc.38.2023.04.13.09.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 09:47:29 -0700 (PDT)
Message-ID: <d11b6acb-b072-9496-5ad6-0635357394f1@linaro.org>
Date:   Thu, 13 Apr 2023 18:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 05/12] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys
 compatible
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-6-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412053824.106-6-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 07:38, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add Nuvoton ma35d1 system registers compatible.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>

What about the tag? Why did you ignore it?

Also, wasn't this applied? Why do you resend (incorrect version)?

Best regards,
Krzysztof

