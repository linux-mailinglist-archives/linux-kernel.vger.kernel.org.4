Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09B611445
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJ1OP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJ1OPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:15:30 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165DCABF9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:15:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z24so8541110ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1llsZlre5HYEk/5lJAL2HT8KNgEJ2nZJKCRD8edZfTM=;
        b=iBr2iDHVd4dGVM3VVTqOSRWYUfeNYWA7pnY9o3J+X9ZgTbfjd662xAEZxrnJyjY1l9
         jWQo260/mlrZL9n71uXS9gSGp5QEF2pYJwDy+jTtZu2VpOWRo1PfUBKNak0EJvFM3N6Y
         Yz5WJKohBW1kQOSYr0+tn/AB4XGpRq+1pfeWy5XIVTMmFhZvjRooYOUFBFOYPBmosZAJ
         Hdcz+nG2JHne7rX1Qnyd/XEYLXLIBqeqFc9iNiRY+XDz5X95ZUN9xjGWpnX2I7gjbbfL
         9d1yNKRaW0mMTb+CtP62LEIiEw0CB5oyJjbQxPC3N0dmk4S2LzzAEDVz1SdtUCtkgy5v
         SuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1llsZlre5HYEk/5lJAL2HT8KNgEJ2nZJKCRD8edZfTM=;
        b=XIsSWqS7HIzlgexR0+QBTwAjB3i27mOl+EZCuLkinrSMQLDEPRacB8AtPRW6RdBkAG
         VjBrw11V2LVIs0bfSJfIk/HMf8A7Ub8vvYHIU/t2mMYLOdvnqx81oc4JdizHrlIDJC6B
         y6iyLQBEPWdjyN2tP+20j33nuvhW5dEfTMGMl+Eai1eP43DYG4AmMvk3FfooAMhLll2V
         JYyY/5HlHQlAJLEik19rQe2qzR0bOD5quJRh1Oswu0xh5myT8fSVJk7YM2IGKJ/fR4Ah
         9wEyaKs6loQF9b5nzMVTeGUBat14g3rqwaxLYike1uGRLZ7Y4x3gtEFTh+WRtwde+t9I
         G15Q==
X-Gm-Message-State: ACrzQf3U8WdfOoWsZymJHV8o8AawjLS4IU2+zCXKLnurGkbxN2Y49d3n
        VI4Ui1f3DudLxZjqr3jqSrgrIw==
X-Google-Smtp-Source: AMsMyM6nJKSVLYCaGHCp7jA8wpaHC7MDQcdwjDvzbKyqdOLXc7VEtwG9jHUNZ3LlR1f9uKF26z9Frg==
X-Received: by 2002:a2e:93ce:0:b0:26d:cdc0:86a4 with SMTP id p14-20020a2e93ce000000b0026dcdc086a4mr20799921ljh.320.1666966526948;
        Fri, 28 Oct 2022 07:15:26 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o17-20020a056512051100b004acb2adfa21sm576358lfb.297.2022.10.28.07.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:15:26 -0700 (PDT)
Message-ID: <f0a45e17-15dc-4ceb-bbc6-54b36eadbb94@linaro.org>
Date:   Fri, 28 Oct 2022 17:15:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 09/16] phy: qcom-qmp-pcie: add register init helper
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221028133603.18470-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 16:35, Johan Hovold wrote:
> Generalise the serdes initialisation helper so that it can be used to
> initialise all the PHY registers (e.g. serdes, tx, rx, pcs).
> 
> Note that this defers the ungating of the PIPE clock somewhat, which is
> fine as it isn't needed until starting the PHY.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 37 +++++-------------------
>   1 file changed, 8 insertions(+), 29 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

