Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C210A60B88B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiJXTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiJXTsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:48:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88A2983B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:14:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g7so18040563lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2as1mhURYl6ztefkLaN+H4eFtyrR60CAeO5HCD+7zE=;
        b=okg3KNpZOsQ7UwA4Yg7gl9GHgVeOiE1JT2FYl7qeiV5w7U1lrEkP9rS4AQYhIGSrbA
         x3uJm37dGqrPZhwoN5XiTi3OHZvmArT1eHyTo/wJ31A1gTrJ4p1QmPrTKowRN6E+uSO0
         3RBo4wZ3MwNZwZwGCcvzUV4zcJfJUIrxfPCh4H/0NOgBzqDWL++ar0dqKuXEZ6uo8JV+
         BX85Ib7Mem6FJPBQQBOfOXJvkSJvedFsZSskyxK05MFg2uNtX4Ksuo3Z37KSNSoKVasq
         2NydzkRsUdyHEZ35xKvYLL0R3bMbu8k9hIEZgOHgvkNzs7WUemBujEYFZRh3AVMCrdUW
         ssUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2as1mhURYl6ztefkLaN+H4eFtyrR60CAeO5HCD+7zE=;
        b=sPtm/rcZX3GI0nFwTXOzmJ5Laz+Nxk1+rgApH+w3kZ0DiojStyj+iscE4g+JamskSg
         RkcdDfnlGU1WGFlrVqki57RUbjOFr+VAMUCw1h7LS2MTHYw8AuMv61kbhjQXq58zXObi
         5fwKFEdxJFIrZFTHOHDccdyYuFTUTEpkw4Ga4cItGmenCOxj2sFqwItR/2xOdbXZbZCP
         B35yXfp5stXyWjETQ3H7TkmHFg/Vc9KqlqsoIe9OlmWbgpfyOp/tJ2Qkf2LXqLQFl2FU
         ilPKJwyHZX7/zuTJ+VX5TgFZjfLLBnRv5LivD/IjgOOZs5yP2Vy/gnLEbaOnpg48pRAU
         RcpQ==
X-Gm-Message-State: ACrzQf0vUHOdXlmWcu4JC/xfa3sSVBYvugeD9CFGInh6MHrAOaH1sEID
        a1HQ8TjgVlQlz7V482/QXGTndbksAbBkCLiJ
X-Google-Smtp-Source: AMsMyM61FEPqaObKjORxFtXvRTGcSDTRzooCTowBzAoBkOFvhXvCx/oWfl/ICM45pj74XuOE2W80MQ==
X-Received: by 2002:a2e:8186:0:b0:26e:8893:fef with SMTP id e6-20020a2e8186000000b0026e88930fefmr12594550ljg.377.1666618434903;
        Mon, 24 Oct 2022 06:33:54 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id f28-20020a05651c03dc00b0026dced9840dsm4794607ljp.61.2022.10.24.06.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:33:54 -0700 (PDT)
Message-ID: <f27662ad-5798-720b-19b2-28bbf1b6a620@linaro.org>
Date:   Mon, 24 Oct 2022 16:33:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 05/13] phy: qcom-qmp-usb: merge driver data
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
References: <20221024100632.20549-1-johan+linaro@kernel.org>
 <20221024100632.20549-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024100632.20549-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 13:06, Johan Hovold wrote:
> The USB QMP PHY driver only manages a single PHY so merge the old
> qcom_qmp and qmp_phy structures and drop the PHY array.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 239 ++++++++++--------------
>   1 file changed, 96 insertions(+), 143 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

