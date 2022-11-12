Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2816267AD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiKLHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:33:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30E2D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:33:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u2so6843225ljl.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcHiUI9DGERAno0rUlyB48/qOHRTatayzGuU/OKYXhQ=;
        b=Pkn45t8/abunZrzIujANrGcPg1WRPhrPt0gULUKesLGYhpCLV+q+oJcIbbobDmS0M/
         m63GzfYoLg/SQi2PNYyYONMQXtaiADTf7wuJRSIJwvuGnzXHeQTV1gn1JLsyCzM6t83H
         x1gOfaIMrrazgCRQgwPzloWArLao7gh2CqvnkD78MvSQN3Aht3ck8DoymWaq7+435F3m
         bMXzDGaguJKIPoYyim2lIC/Zx8HUHDJWHroZhHi9C6R9nnapSUsm+WGY0duMbahu5KGB
         hcpVATmoBH0zElnOMdXq21rUib99dIPfIuYkcBUSmWsDdgbnOD+p69uOkmEvxfYF5ChL
         M+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcHiUI9DGERAno0rUlyB48/qOHRTatayzGuU/OKYXhQ=;
        b=LM8vahzq2467ejrvsxRneZ89/HrJcVYukfJ3DXrGf7rD7cM9Inw60FqqCLBFBSUJQT
         2aigaYfCgP54p9Na/TSO9Rmi5QHD/5FoLQQdxFnsiTU0ILb8urWo8nGRNqHznf6qchtV
         Ohl4LoS0imj2ZKa1WWbhZba5SSHKmo4YsjOC2YE5b+vGUMFH7GTQ5zkwyr/sDOCwOB5A
         eDswezbn5nBrmgCQ/sqSK6PNJ6Fh5TTBQ4hbULH6bZMyJc6ZsmaTVhJ7mm1N2JuH210q
         CDRivGTtxI0xNongc226O+73HgLX0fx6ZEreFsVJi0rojLKYin3V7SUVtorudRYai7pF
         94WQ==
X-Gm-Message-State: ANoB5pmOWdqwbRbawvPk4a8ynlwWYDSeit3zvV/rJ46csK4jVPFt0eBJ
        ZtWa7T6/wm4CvcUCpXQ3fEcZgA==
X-Google-Smtp-Source: AA0mqf7IYmIualQg3UXqEPIXTCGeFZKjAX/hHgShiK8f7MOBFqehwnnxzDVWFY0zfn47rDrvQkKnxA==
X-Received: by 2002:a2e:869a:0:b0:277:f46:617b with SMTP id l26-20020a2e869a000000b002770f46617bmr1514630lji.221.1668238422461;
        Fri, 11 Nov 2022 23:33:42 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e8e75000000b0027711dbd000sm761494ljk.69.2022.11.11.23.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:33:41 -0800 (PST)
Message-ID: <c77b34aa-e45f-f6c0-86e3-66d92079461c@linaro.org>
Date:   Sat, 12 Nov 2022 10:33:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 11/22] phy: qcom-qmp-combo: clean up serdes initialisation
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-12-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 11:56, Johan Hovold wrote:
> Clean up serdes initialisation somewhat by making the current helper a
> dedicated helper for the DP part of the PHY.
> 
> Note that no error is currently returned for non-supported link rates.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 49 +++++++++++------------
>   1 file changed, 24 insertions(+), 25 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

