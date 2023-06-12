Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADD272D485
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbjFLWgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjFLWfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:35:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CD91720
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:35:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so5542239e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686609340; x=1689201340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLBl92C9qa0zAG7ds7NkpKN6kwIhaHs+Lw824fOm4Nk=;
        b=htw/EL1xdHvJcuOWGC+caf5ZvqpIv8Gn0Dt3p80KWFUUmCtm6nxtJ5nh3rbhMNWYLO
         3HXPmk2ahVUNOOWOYU4mLT+3UCZyiW8Lqsnjy4LjLjcTrugH4VYpLaCiperKuEJw9m6J
         ufDQ6yep7vkKe4iLUn9LA+HnqA5FKwuzjRkSHIzrF9/9Ty+5w/vldV0l1JEyjJATLnhs
         kKS9rjcL+jMvx3ht7RzyGfvF6/UAJxB0Z89z/xa1FQm+OmMxzl4EL1bS1GNiv8DtE1Br
         gWRfgVtR6m7gwM+lKMQkp/MraNDKoxpiZhfBboC/tqtUrPaegXc2lQIaqd40IUALAJon
         B6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609340; x=1689201340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLBl92C9qa0zAG7ds7NkpKN6kwIhaHs+Lw824fOm4Nk=;
        b=WUVClCGqLsnpWULZvqChMX4VlyrN9SBV3qgZwYKU0x14ecMdcpc1zOjbMadM5rhBGY
         PrBRcExQ3qy/WccD3S2ERjMmC3IpR3pW5UvbasWW1B9qpWj21qHeQwQQ0kNeerWuLEvk
         gg2U5hwgz2L/3UWwPIA3tOx7dDnXZCzMDlM4tBh5GSNwmgfF+bFtPdRPYx0eVaaWhHAu
         oO9YZ1UxT6ADXLdWtrGDbakQ8/1Jwkby1zcQXNQe2uVwL+X73ROMr8Jx2ViOMJoOA++1
         nYtCYLBoFNKd0RQCoWIwhrrTCuFaNFVBYY4z5XHkmGRF8XMZ+ecxiyEvdj/Epdofh2BO
         g88A==
X-Gm-Message-State: AC+VfDzZ7XbFKJpA/dNRlg6YQ9g4VIahXCezldCNqRju0kPazYozbYiS
        OVy3otV0inrCqBYEefCzIEbi+Q==
X-Google-Smtp-Source: ACHHUZ4jWGX/txO61aKN6rNEdqW47kVPb6bqqYEI1A9N2jlRoO66L+i2A1xFaZ/XTIHxLJGDXNBjrw==
X-Received: by 2002:ac2:5583:0:b0:4f6:171e:493 with SMTP id v3-20020ac25583000000b004f6171e0493mr4864741lfg.8.1686609340593;
        Mon, 12 Jun 2023 15:35:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e15-20020ac2546f000000b004db0d26adb4sm1589142lfn.182.2023.06.12.15.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:35:40 -0700 (PDT)
Message-ID: <455aa908-5430-9ef0-5ebe-6322b3f2e6bc@linaro.org>
Date:   Tue, 13 Jun 2023 01:35:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x-primus: dispcc is already okay
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612220420.1884631-1-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230612220420.1884631-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 01:04, Bjorn Andersson wrote:
> &dispcc status was changed to okay by default in the platform, no need
> to do it again in the board.
> 
> Fixes: 2ce38cc1e8fe ("arm64: dts: qcom: sc8180x: Introduce Primus")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sc8180x-primus.dts | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

