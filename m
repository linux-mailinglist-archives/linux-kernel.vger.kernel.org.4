Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE357268F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjFGSg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjFGSgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:36:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F32103
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:36:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so2002065a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686162984; x=1688754984;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3nc7yvS38a66Hs/mYzWRVagS1AxICPdH5Cqth3w9cQ=;
        b=D88sJsHC5TTSdVjCNnP8dKHKMCecaWzVZpY/ySjxfeX/wCpPElfsvttMwSzcnkaj2E
         P4JypKreP1nAcb1QUqZ3pFxqYBhi2YsbZhDmCt9Fticnv8dwQcMwGDBB2/SJidLpZLgN
         73G0VSePPUsBfiQEAG3MeIUSHjhn2BkOR2Xt4mpzMbG+1NUO9B1gMPHED/seiV/xfkLR
         FTIw1eN8jnt53k2LBNOBdRUs8MI1nzP70EG41krrWyKD+/Wy5r9xIpyWAQzhaY9eeKRn
         OH0LovT6zCYnMlPDgkOfT4K3vCcBrsLeSXfxN97zuuucZ6Mhc/Xe8OuPjqJrcB6MKJRT
         qjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162984; x=1688754984;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3nc7yvS38a66Hs/mYzWRVagS1AxICPdH5Cqth3w9cQ=;
        b=jrhT/gMSJvX76Zmk1LdzIP5QrrqgXsbi1bC5mUHGYYPHJoBJUIjJS2Z2W9++2iEKCQ
         qfPjk2eqsBCuV6s6fGTvY3XXFsjxqkYCpvXg9mCdzscH16OUuyqbX1zl1xy6KXOJxDc5
         RGMXM+D7L5//x0r9kRByrBzFlJjdv6gH3wUcA8BwCmdNTCdvBIH1E0DR2RQvbg5WTQy3
         0sOg4ya0Cgdr/wiDheQYc4rPH3F6bXY79/loVPd9JTmEydcuctnkWsQ/pbaqDLbpFTBJ
         gj5MuNzU6CPMRH2GKVIbvVqSxIUy9LbXI/pw1UwbhgoTbeqWCYOXuEE3LbIs84ScLmYX
         8EyA==
X-Gm-Message-State: AC+VfDyjtjaZ5EKKAJNHcEV0v0mxsIhTjC6vfjAy88EhEJhFYF3a+b0k
        SH7rHy2w2xJWfDdILslCS9HFMA==
X-Google-Smtp-Source: ACHHUZ7nGuEhVJ38jsgvyId2kGf22wlefHu+wUCPOAjlvIRMer4MbAKklw+bmZjp+BFcARuqC7UR0g==
X-Received: by 2002:a17:907:9718:b0:978:8685:71cd with SMTP id jg24-20020a170907971800b00978868571cdmr2751998ejc.71.1686162984584;
        Wed, 07 Jun 2023 11:36:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s10-20020a056402014a00b0051422f31b1bsm6389826edu.63.2023.06.07.11.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:36:24 -0700 (PDT)
Message-ID: <21bfe86f-8257-d0ff-883b-bbe451d8f77b@linaro.org>
Date:   Wed, 7 Jun 2023 20:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 9/9] arm64: defconfig: Enable QCOM M31 USB phy driver
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <55f51785b36b9725fe5283a58230aee4e89b4d6f.1686126439.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <55f51785b36b9725fe5283a58230aee4e89b4d6f.1686126439.git.quic_varada@quicinc.com>
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

On 07/06/2023 12:56, Varadarajan Narayanan wrote:
> Enable QCOM M31 USB phy driver present in IPQ5332

What is "QCOM"? If acronym, extend. IPQ5332 - provide full name, so
"Qualcomm IPQ....".

Best regards,
Krzysztof

