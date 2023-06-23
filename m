Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652BD73BCEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFWQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjFWQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:45:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B92735
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:45:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-988a2715b8cso360951766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687538727; x=1690130727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycjuEtN0uXcYndHOcMc8tzNbPomYE5hkNkU1HJRea9c=;
        b=kco7mEC2nU2l/8njnz4AB5g1T6sh9tcmO/0FbKrQ7K1WHpQu9ypcjSrbclW8otVHII
         eDNpZTtfX45eGoUx0HxhxvscBSYGul1akjC6TT8ZHlkfbik03Z5JEs/dcniMf9w4GhuA
         qURyMEECs16llwiASjbyBeR59lXFhKE4zOikP2dwX7ThXNA4UQryRb+wYJ2LmrYHyaFF
         ynCt4+lfsk77P00Ym98qqs81OAuXkBYuH7+iexH7I0N02QHNd83HUaefv30wbjXmdcYi
         tHLFajhVJcqfi7uGxV4CTaiXDzgEtnU67pMBy1MkLzNqoI/g6ZQ8GoY8M74Djnrmz6EJ
         1fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538727; x=1690130727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycjuEtN0uXcYndHOcMc8tzNbPomYE5hkNkU1HJRea9c=;
        b=DgMLSVWI+NQvSCmF5NYTbWEkO9iFQf5iU69Xv1noZnQ3wJM81oVBq9fp/k4jz5PCVr
         TBAimZV1z4jEQTIJnLScDYWXMX+MZD1t6FqP+nUtD0BuNiLkDnr7zvoNjBUpdPAGB5fv
         PP7YSZd7XhmjnCpdi5ajtMTEDt8t32wbGd/AZlu07GsWhjGkHTBxs5KQyJHH/sxkyQ1Y
         ww+pEZUPWIzjHHmq60BF1IM0DFo6V2XkblJYjEmTNPmnLg8iTQLzadx/LJWYPcCkGIlO
         KgxOASMpt7lDG3zc9GmQlqYI2KECFYTwyRtJjXOkEPMK1IAYFrsF03nkc/9XoUggGBfg
         IvCA==
X-Gm-Message-State: AC+VfDxKkUGxGAkDnuGovI4uo2MzLsTelCfQUxc88g5ltflX+ffG45Aq
        Ng/m/mpZP2U+jMMnDr2um+4HyQ==
X-Google-Smtp-Source: ACHHUZ65Y9qdSPYMa/h86b9I8dKJ5Euvnzcn94PKEK27KI/Ch/4JXvK4w9qYmPoOmc6KXbE6dqUGgw==
X-Received: by 2002:a17:907:1c0b:b0:987:4b4a:916b with SMTP id nc11-20020a1709071c0b00b009874b4a916bmr20839517ejc.24.1687538727667;
        Fri, 23 Jun 2023 09:45:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s1-20020a170906168100b0097404f4a124sm6227107ejd.2.2023.06.23.09.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:45:27 -0700 (PDT)
Message-ID: <d625261f-6ee6-2647-523e-2d00636f2216@linaro.org>
Date:   Fri, 23 Jun 2023 18:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/5] scsi: dt-bindings: ufs: qcom: Fix ICE phandle
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623113009.2512206-2-abel.vesa@linaro.org>
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

On 23/06/2023 13:30, Abel Vesa wrote:
> The check for 'qcom,ice' property is wrong. Fix it by checking using
> if-required clause and expand the clocks minItems and maxItems for
> platforms where 'qcom,ice' is not required so that it includes platforms
> with single reg entry and clocks that do not provide an ICE one.
> 
> Fixes: 29a6d1215b7c ("scsi: ufs: dt-bindings: qcom: Add ICE phandle")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 9 ++++----


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

