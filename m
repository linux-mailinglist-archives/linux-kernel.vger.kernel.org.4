Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C273FD19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjF0NqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjF0NqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:46:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C62120
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:46:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991fee3a6b1so162482466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687873570; x=1690465570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6GDo/PCyqeJlmAp+L1F523ncEm2Dlcbpi4EhLPM6dU=;
        b=VjJou39mArRU2SgqQPw9V/Fz0rmQl9FBZLCoxY1lHgZdRbLHHVGzyXkrWFhuuFq4XR
         R5pa8lUtxrOOEdaKith9uy4f0YD+o98lEuHj5GVNuivN6JEfk4qQRuMQeXUlZlO+8rqU
         rMihmvUxzZSY6fTIrlujRJKWA5yxkrtiQ6cgk2ofBJOGScGE6zlmwTZWCzX9X3l8e+XE
         /NLwgwbLVnFwsM6c6+tzQ/ydZOuGgJASHvbnNofhr5RzGitmrEr1nf0gu3TdH5U6Khg5
         FD8H9Ge4+ZJUGRY0uwAEA+xHePEo/2N1kNxvk5lHgU9qx3eUxxrphBTBxR6KUQ7daEvT
         596A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873570; x=1690465570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6GDo/PCyqeJlmAp+L1F523ncEm2Dlcbpi4EhLPM6dU=;
        b=jtOwU9Y6GpgAaNkPiyJy3t+WpQUEx6I99TaL51WjeIXgFvBaRoYH8sIXOPJ+ER0F8v
         YPP9VlqWj82ti1A++hDuMkLmGw9ZoyNQY/qTLs4ml/dc/9eKgmJxsDf3TS/GpevT4W7T
         a/1qow8dXTrl3NJ4eB/StYIKWgn7soVKvPsAYxoGNZC4Sadcd0zEzn14Yfd/3CWvwJTp
         p8GJV7JbjQgnZ4MgGKrcMVSgiBti7eShlNP9B8L1aiyUFkJt/jA3Lp+bZk/KLJt1J+LW
         1yYRz9o+q5xYGfKwv8aJ2uRnVcLPIdGk8gOzwnkqTaQjZU15s9iadsrjq3Vt6X+ASI4u
         nGJw==
X-Gm-Message-State: AC+VfDwcPBH+UC1F06yLhms70+ZFVgIy1+mXo56T9u7EW3fj8GOr2L57
        LjeIVsphxquG2kAo02zNB+lUAg==
X-Google-Smtp-Source: ACHHUZ7IYXJwXk1SNEMr8oz4RHlt3J2yBev4bixokO+Gc4xB2ZZl/W+WNtdQLEJHfex8XUxvCy52iw==
X-Received: by 2002:a17:907:3e16:b0:978:a186:464f with SMTP id hp22-20020a1709073e1600b00978a186464fmr31854500ejc.39.1687873570345;
        Tue, 27 Jun 2023 06:46:10 -0700 (PDT)
Received: from [10.230.170.72] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906bc5100b009920a690cd9sm1018937ejv.59.2023.06.27.06.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:46:09 -0700 (PDT)
Message-ID: <3b8156f3-ae92-b7ed-60d5-b7558903e179@linaro.org>
Date:   Tue, 27 Jun 2023 15:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/5] dt-bindings: ufs: qcom: Add reg-names property for
 ICE
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
 <20221209-dt-binding-ufs-v5-1-c9a58c0a53f5@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209-dt-binding-ufs-v5-1-c9a58c0a53f5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 10:28, Luca Weiss wrote:
> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
> in the bindings so the existing dts can validate successfully.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

