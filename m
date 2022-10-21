Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2D6075E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiJULQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJULPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:15:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB3814C50F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:15:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b2so4515456lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGR+GHvgRaXGJ8GYA/JSnsVO1HGR1HQ8rDlPdx2J0GE=;
        b=Z3o0lJQTWWf+sLuoqLF4dPCeL0HiQ1XgqGi3YTWdIoci3Pu5NCfL1G5IlOHFzViv/n
         9Q9ScniGL5TvZErLYHSOV1KIs1/JrcBJBFVe3DSQDCyi8Lh/dmfrv/eXf+9sPKCN9Xm2
         KSDszK4S46rhE/N0hEaJoN6+UIR74iqcMQ9nPyqlfBGA2lkgUD1eYg2oPPsw2QEKi5So
         xqu6DGpxjwWmG6wAqCCNPDN/i1lcWZAsPMlroDtA+4/QjTj2Azxb7JBMkwbeWwYodg/w
         UjYMmCfI9fA0DncXPSUP/ZpffTg3XkW0YQr2MdqbsYBu2XXKr5o4yAhgiKEYKcxGO0m4
         T29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGR+GHvgRaXGJ8GYA/JSnsVO1HGR1HQ8rDlPdx2J0GE=;
        b=TmGYyKs3CLpOOXzZCLM9E7is2lgkctYo3Pgo8ptIEcAnKib5uUM5fASm1UHIwqn0BB
         zsYCqtyT3+ZmnmbOUl25GlI/HKfOyb+NaaHLw9el/rMDLH5W+pamcAuPQmnm5bm0AL11
         GjicxBLTGkohM7KkmKgqhVTaA/Ddtf1hLT7VjDQAF8TfyMSy12wzG7VoT6LodXhUg4fQ
         V8YQ8fNg975hjZSTQZR//j6qeIEzhBRG83ilroPEkt8scJxTYQ1ASotz3q+yCRqbmX7Y
         SoILsu3nJeCFup+yEoBnlzTcKq97KftfaIpnPcKODzGXMwz0hLNxdnPig/Ui/vE9EniZ
         a9oA==
X-Gm-Message-State: ACrzQf1FpLYgJCMMCa7MHQ49LsyoCpI7Z/idcPdWqdmBBneGdfRhqbz3
        OcS/23legSlIOZnG56CT4xja9w==
X-Google-Smtp-Source: AMsMyM4c/eGqlpbOOHaW2mpXrdmycPI1J44m2HICJwRMS6hlVOFS7eNhqKrKuU11PFtWZaDto+hN7g==
X-Received: by 2002:a05:6512:224d:b0:4a2:7710:9b8b with SMTP id i13-20020a056512224d00b004a277109b8bmr6201264lfu.128.1666350936509;
        Fri, 21 Oct 2022 04:15:36 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id q11-20020a19430b000000b0049ad2619becsm3119222lfa.131.2022.10.21.04.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 04:15:36 -0700 (PDT)
Message-ID: <8b0389f2-66ba-b707-a026-0b7e06d9bfb4@linaro.org>
Date:   Fri, 21 Oct 2022 14:15:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 13/15] phy: qcom-qmp-pcie: add support for pipediv2
 clock
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021110947.28103-1-johan+linaro@kernel.org>
 <20221021110947.28103-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221021110947.28103-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 14:09, Johan Hovold wrote:
> Some QMP PHYs have a second fixed-divider pipe clock that needs to be
> enabled along with the pipe clock.
> 
> Add support for an optional "pipediv2" clock.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 25 ++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

