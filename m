Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29660B6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiJXTKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiJXTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:09:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B4BC45A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:48:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z97so32836158ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e58V5kNvHigzWFOu8o+ewlZvVrXwGRuPYWmqVQmQEmY=;
        b=nHSPF+adEbn1VaIv7mOAVDJwYrX+fsluFK3y0IR4E3izty9NzTCCmJV7gqoKHTD6tx
         ltwVRoKjBkmv12U7T03vdUNFSVZAID37aKwZPQqh0osDSrRLpfXMwrZDUNmzdEb7XEu1
         xGkk9JYglNkXC5HIbchR4zuSChoFVop8tCKfF4vU45h2wvtSKTrZVMcXwdWRRJ21S5mX
         sitErKFvVsYazHQM41k6zBC84luLCMmU2uO6gRwTIfibYKdNqiVQtb3EYc6mvVL9EkpN
         7mK5HNmqQvsn2pMX10NqfEpXB3ERiYkw3hLjWfiG/HXTKbMnl1L8xSP55twtW3ukc8Wx
         i3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e58V5kNvHigzWFOu8o+ewlZvVrXwGRuPYWmqVQmQEmY=;
        b=m+2flx9m0M01Euz7cJcYVHhmSA1zGYeuMR2iu/NKT2nSFMUM3UdRPDeqRvlPp4wkIS
         wzuMG7ZR1/sZ3V7OicAgohvPFahMCx+Ajozl3QD4DpQYVtkSAItKuRja5QCt6T4qF91O
         S47R3haofDgEidvv0NmoVvlr43G7BKSThE7o2MvdpCq+XVAIQGyqI/dz+U7QkKXxWywu
         0d5Irss9AOAnbWrh/nDAP99RhgmonzXKNhNolrKX+gmRhTpFbTaQQzY22C57M5Sg2ZNN
         Na9IDmWne4jfytM5cmjFuL9IdTqFjVNcY9vjXxpZdIBXRwvaLE/QA2Fihl4Zuylb4oTs
         amiA==
X-Gm-Message-State: ACrzQf1uuPWmIfDsOUzYL/8C2hWZSwSNrfA7bF+//eb3eQj6Zphr1/+d
        WL00dV5MVTAkN/Mu9Cdpy9YPOwMp9g/REElW
X-Google-Smtp-Source: AMsMyM6qoEKHB2Rw6RfZf+iCAzSd54FmJAm0ulvY7o4ABQ1Z2GR2xQ9k3990ccS5FaCL800sF5ZDxQ==
X-Received: by 2002:a2e:88c6:0:b0:275:ad8d:f3ec with SMTP id a6-20020a2e88c6000000b00275ad8df3ecmr6737080ljk.273.1666618266279;
        Mon, 24 Oct 2022 06:31:06 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k22-20020a05651239d600b004994c190581sm1246628lfu.123.2022.10.24.06.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:31:05 -0700 (PDT)
Message-ID: <dc876500-e7b5-4c60-2664-056bfec1caa1@linaro.org>
Date:   Mon, 24 Oct 2022 16:31:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 04/10] phy: qcom-qmp-ufs: clean up probe initialisation
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
References: <20221024090041.19574-1-johan+linaro@kernel.org>
 <20221024090041.19574-5-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024090041.19574-5-johan+linaro@kernel.org>
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

On 24/10/2022 12:00, Johan Hovold wrote:
> Stop abusing the driver data pointer and instead pass the driver state
> structure directly to the initialisation helpers during probe.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 37 ++++++++++++-------------
>   1 file changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

