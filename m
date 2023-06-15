Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52C73120E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbjFOIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbjFOIXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:23:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B581BF8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:23:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-982a99fda0dso38200466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686817383; x=1689409383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbmVcYLIlPS0DHtDeqS3ZubLc2DlQ1dwCFfetTypgB4=;
        b=JA0UKC/uTCTTXbSjWMKtYiOs7C+nPwDsKdRnSWeSKrsmu0g+PTPaMCTNRzxHZgB9CE
         wsnZPQCyVGmj6i7ZD66fWaB4NMcif3DihHMDKrYanaR1HW2zr/VRpEm0gLwkoIrfDtWt
         gOLeylkxqy7VbpDexDxzHwgN0j9FCCyUJOig9KOsQ3xhaUEf1zpbnlo/XpIvnUgKieh+
         lRgHYtV0iEv6UretPJNm1ELInlIbilok3E+TzfWMKg04utJ8do2Ojg4/DJURAU/QDwzW
         zxnI/oFUOHQpqCqSQdbvG1scCS7CQawwgPR+CHk/ybX9sAbdj7XE2ir4x4lSKdHTTVsq
         PhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686817383; x=1689409383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbmVcYLIlPS0DHtDeqS3ZubLc2DlQ1dwCFfetTypgB4=;
        b=G5h9NK/VIzUfd0s2hKqr3jBXDlhMGLbTleQ8tsajmDey3kaqkc9sQj8CoaD99yOIgl
         zhUp5mt0SRL+PKWsXu8FWTUFGu17xZd+rQ6b0CPcqMvpyhzQcXl/yRPaZANosvy0vt2/
         W+rXTLrPRg9ciH6JVTfJjQHoD2RYJP0VmFHD/UjnjsOaUeK2+RMVnVdqZSSV7a0qvyvJ
         FAjbWwXeFRCA1OFSg7gaZksF+dxtJBz5GcDIIx6zR8Ddor4x/PI5NQchQofO0QyKnJ1g
         Bgrdq1afXc8tBGrrQJRmdCrO8phfwlj9h8gxf38VS/+fZm/XS7Lr5GPbbO8x7jLXk8+Z
         OkvQ==
X-Gm-Message-State: AC+VfDx8J6Ootf0KOj1r1gkI1H1Yius1BvE/0Sbui30zWFOAd+0/HQq1
        Z0ziMpdidpjD15PxMux0R2/74w==
X-Google-Smtp-Source: ACHHUZ5Ayr1lYS51e5Fu6lICLqbiWy+mmk5M47rHAxINk5BfWxKxPYOWJcLo3Po0CmRWxNsO4oOngw==
X-Received: by 2002:a17:907:9414:b0:979:65f0:cd07 with SMTP id dk20-20020a170907941400b0097965f0cd07mr16316887ejc.38.1686817383326;
        Thu, 15 Jun 2023 01:23:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i6-20020a1709063c4600b00982a352f078sm503388ejg.124.2023.06.15.01.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:23:02 -0700 (PDT)
Message-ID: <a3f053e9-b6b0-29a8-8b43-7abe5a43057b@linaro.org>
Date:   Thu, 15 Jun 2023 10:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: cdns,macb: Add
 rx-watermark property
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     git@amd.com, michal.simek@amd.com, harini.katakam@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230613054340.12837-1-pranavi.somisetty@amd.com>
 <20230613054340.12837-2-pranavi.somisetty@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613054340.12837-2-pranavi.somisetty@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 07:43, Pranavi Somisetty wrote:
> watermark value is the minimum amount of packet data
> required to activate the forwarding process. The watermark
> implementation and maximum size is dependent on the device
> where Cadence MACB/GEM is used.
> 
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
> ---
> Changes v2:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

