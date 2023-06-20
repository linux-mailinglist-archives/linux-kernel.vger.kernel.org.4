Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC17370F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjFTPu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjFTPur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:50:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D8A1704
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:50:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so1054092e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687276243; x=1689868243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skGRnWXbaDAmxSHLLNOUSIFxKxnOiD0CNtHSEWtxfdI=;
        b=d4mEUkeoY/NnvUZXnubpdarO/uMzKhmVAFiMQbasHk+/hjGoeLoT7utpA00IDdOaoA
         fMkfoPfCBWWG9pExdb+3TLMdtbIIyy46n7Fc/oIZge7F1c9MRbVUitRIeKH8DZHT7KNY
         QXgMCvqG5cXvcaqeTlomEtbqHYIm567PAGRKP6Rbr2IGDjg80P/oJISsZ/AnBMy+CCf3
         zzBIwhfcbeG1Yayw3KG1upHrYgkf9f/94QGwtDB/2ThjgdVpkTHMYxkYKNiVF7ZIUgYw
         TrNaKusELPXuo1jVchHAMmH9UFlhwbA3v6fqtuHAeX19jPbFtE6UlQvqF3l5Ws9MeLQz
         wUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687276243; x=1689868243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skGRnWXbaDAmxSHLLNOUSIFxKxnOiD0CNtHSEWtxfdI=;
        b=alw3hcvcqIvM41ngD0PA/j+X45xaPhOmsPlywDo69TCboQc9Eo/w5kuzjTrA050URF
         TNPe1Dl3HvoFC0R4syB+5qfdfOHTWRd2J/KeFF5TkB52tx8wIBgjbZphpghJczBBvJGL
         McLES3usNEJJ75XrAMf4Nlj6DMS8zD2ij9aHhs4OntbO90Z8pvEBQ4prlnikmMYCNW+a
         eTavCFuDccKkw1SNfzvd43Ks2m98cbbhIVSfVsTtfeaBtqUqXoTg1jeRJ3Av5FLh8S8X
         46iebryTUG9VnItSOWihQJIhdYQLhbTJQBr4TEmSd7C2pVPaBQ3kehnuf+E2IgpkKUQ9
         MfPg==
X-Gm-Message-State: AC+VfDyrQO4G/xnMT8yZBfoxT6CBwYKGukIxSzssNAb3IOjDAO/78rF5
        d7bk90pGoKuXlY5t2NKSL5GX7Q==
X-Google-Smtp-Source: ACHHUZ55fJimkB+yVIu5K0zMbf5nDTzXCwdNjDvgXHIkQnZK4eMJnlsOF+ipp7ITrLJO/iB/M241kg==
X-Received: by 2002:a05:6512:532:b0:4f8:770f:1b04 with SMTP id o18-20020a056512053200b004f8770f1b04mr2690492lfc.0.1687276243367;
        Tue, 20 Jun 2023 08:50:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y11-20020a19750b000000b004f4cabba7desm418853lfe.74.2023.06.20.08.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:50:42 -0700 (PDT)
Message-ID: <049f55ed-7531-224a-9d15-14f6c359bb92@linaro.org>
Date:   Tue, 20 Jun 2023 18:50:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm6115p-j606f: Enable GPU
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
 <20230620-topic-gpu_tablet_disp-v1-3-7bb02bec8dc0@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v1-3-7bb02bec8dc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 20/06/2023 16:17, Konrad Dybcio wrote:
> Enable the A610 GPU and provide a firmware path to the ZAP blob.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

