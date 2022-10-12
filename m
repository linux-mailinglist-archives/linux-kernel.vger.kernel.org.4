Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435855FCC58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJLUpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJLUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:45:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532FA5E556
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:45:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a25so21577ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sti7xlJS8BDmPeM82erSW44bu9sTdRGshhN8rLPU3bA=;
        b=RbhRt1rpSUaAOSD9pBZPyvuMFoWe6OutvYUttzUiIkADnJ4ofq2sMk1thS3vJa3JDX
         N2nGP+2pMgqi9t8wBUFAKEFGZ8dMIuhpZfnpdWV5TJhYX23En8L39Lk13fwrwZph7Rvz
         LSf6k0EbODorm4dKGTClNXmcko05jjDlV2+r211Z34RSwRg+nYN1V1QpM8shPUHNA4Au
         6RBolRLH1AJUeh0xmnMeEF5dOYE4rg+St0HQUe4GqHRA8tdmpa07JGKOHmrmtDphhcRe
         z318noV8MdCGzaomGb9ZZjBadvI6QG3wzg0Gc9GSEuGiJIxJrKx3iQks/vtGzQItVhQ3
         fm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sti7xlJS8BDmPeM82erSW44bu9sTdRGshhN8rLPU3bA=;
        b=of4JNeJ/pV8sa+OEYOn4A6XkoZZul+xU90GWs0A5T3H3nqqWizhpiHNyr+zLUskeKW
         aT5ARx1u9DMDow995ygnE5/lYWpZBq4Vkouv31UR84K/bXW9plKf9fXOe2Gp5h4uzMv9
         E9KonDMP9NpuIMwRw5u/MeQaTzkzXR5XSk9q6mRlcr5fRk6mu0orT824Ws8mjKDcpVkV
         SWhe8B2wNJ6v13QFBWlUaiV3e/wAWgmVSirAr0F9btDyjObFanC80oT3Mt94prRp2iH5
         vR0EN1fVwrR2b6xxgoBXImWfPwPxTfhMODJ/6XDU7FVl6JugNCzCU1CByGkVS77TGbSV
         T/4Q==
X-Gm-Message-State: ACrzQf3aj7+n/5k7SIcHgf1h9Sz0t+Lyv6NIVhBo+FWfr3JWqtiL1thg
        K/gAAfZM+ilVFckY83YdOBny1GQaUJzvGw==
X-Google-Smtp-Source: AMsMyM71pvu/vjt3lZgu3Ss9P4ecS3RXKZjg0NzEj/bQ//NP9sw6TtXb/w0ZyLNfe2xeJ4G3thg5Qw==
X-Received: by 2002:a2e:92c4:0:b0:25d:9d30:5d61 with SMTP id k4-20020a2e92c4000000b0025d9d305d61mr12046148ljh.202.1665607514237;
        Wed, 12 Oct 2022 13:45:14 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8ec3000000b0026c3ecf9a39sm115541ljl.38.2022.10.12.13.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 13:45:13 -0700 (PDT)
Message-ID: <b9ae4d56-3d16-cf78-91c5-ce52dad02daa@linaro.org>
Date:   Wed, 12 Oct 2022 23:45:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 04/20] phy: qcom-qmp-pcie: clean up status polling
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012085002.24099-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:49, Johan Hovold wrote:
> Clean up the status polling by dropping the ready bit mask which is no
> longer needed since the QMP driver split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

