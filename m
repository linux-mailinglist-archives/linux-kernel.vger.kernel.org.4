Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125B6267C6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiKLHsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiKLHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:48:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A949B45
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:48:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so11429986lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSYSecfwreONY34mR/p9SxmUxxCaL6B3q47OWMgC/dQ=;
        b=c8jLKpFSR9CWEdh/8j1pLH0f6oOTVCVLEY5bNqeCD6KKsfwob7cc0OPprxS3qZDZRf
         OizfysZ8awyu+6Y+gppWTPcL6nrbztUeWRNSA4DFmE3FdjumTssqmLoCQMCxf7wD6SoF
         jijfyAe0T8agfMA0M/3wEnRZ7/fIiyymG4OextOmb+P/avFBCEDUx80DlXWwIGdEfuUc
         a6Ct4GOlgVYgarg+THYNvkPfr0BAFQ1248TZDYuCIkW3WAxeJEU09g7tlq2Nntxr8RmQ
         slGSdXjwM4K0Pv62CN+chKCdoYd5maHvfjSRtkdJO7beZUdDiH7FIujrnzK5ds4o2j1Y
         SP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSYSecfwreONY34mR/p9SxmUxxCaL6B3q47OWMgC/dQ=;
        b=jiV4ypLWHcmaEdHT+NYI/SsklZej1+c5b4EWXrJeG7KLAs8QsfRtmJX+kuKji3hMHP
         rRQ/PYjWrka0kz3D0chY3kyzb0lNg15+aH6nnDBOm95GmKy3efzMjB9DX4JZgPDIRCJm
         BoB6pJJZicAU5CfGRlNURUGWUbFgP2qxT8IKFcP4Ve4J/b8YZkuMY9oSTi7oCIduCC9g
         kBjF/m/9aIiWQgACYEM4SVTj7V5aEk+wZavp1F3CKtUcCtXiXJ5w0iECnEKEZfdkwcrM
         bt5ARZWThtomE/RMRCPa7tPaPAkrwwaCqY5pdrKuvKaGfPIUUfLQamC1CYcnX5UfBV1U
         44kw==
X-Gm-Message-State: ANoB5pmoPtmIG91wRUNPbeNv9N1iKzZeFGbZZZHm6ybIPlscPDh4z4mV
        L/a6QekrmifnASbOS3encdrCaUwic/y0uWu/
X-Google-Smtp-Source: AA0mqf458rupvRoJ2WBHSjs87urAAsNZkQbPk3jX6Xnl59+IZmhqvVkMRxgEw/u2axc7B9qCm1KEUA==
X-Received: by 2002:ac2:58ec:0:b0:4a2:aef5:ceed with SMTP id v12-20020ac258ec000000b004a2aef5ceedmr1988111lfo.371.1668239282047;
        Fri, 11 Nov 2022 23:48:02 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b13-20020a056512070d00b00492ceda336fsm733520lfs.278.2022.11.11.23.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:48:01 -0800 (PST)
Message-ID: <50b2d285-8bf7-a4a0-9f35-1f11ba2d662d@linaro.org>
Date:   Sat, 12 Nov 2022 10:48:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 19/22] phy: qcom-qmp-combo: clean up device-tree parsing
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-20-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-20-johan+linaro@kernel.org>
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

On 11/11/2022 11:56, Johan Hovold wrote:
> Since the QMP driver split there will be precisely two child nodes so
> drop the obsolete iteration construct.
> 
> While at it, drop the verbose error logging that would have been printed
> also on probe deferrals.
> 
> Note that there is no need to check if there are additional child nodes
> (the kernel is not a devicetree validator), but let's return an error if
> either child node is missing.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 82 ++++++++---------------
>   1 file changed, 28 insertions(+), 54 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

