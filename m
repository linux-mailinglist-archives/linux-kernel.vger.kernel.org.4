Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965D5FB3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJKNvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJKNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:51:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6669A7AC29
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:51:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r22so15594023ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+GJVBDiQoKlcdpvWj7Wr2feggyQRs292x8Y6paqx9M=;
        b=WYjxpQ0r945EtRA1I0SfwP401Kw9DUSKubLEunDI3iaw1WrlG2hLvDNR9uvWePEIb0
         VyWZ8ALERIUQNlKqZu7sBaCxhQm/ERYxWqKHphBVesLuLUOmExA4ddy4D4wG1NU13Gb9
         YYP49Q/8InnyneY7x99+ufgF4Gh/VI5Ur6d0PMhM7RCb5gMciyzYe1Wkha+ZKiZFiRCS
         b19aCBRNPL0AZl43l1uhfUjKvcL4gDrqFCE1wLCCHPNVEKOjWT2aEe8AsVIjRR70id9b
         UHIEeS60oALmBCphk6II45kmnM0ReY9eaXF1llcycLSolx2+sZqyB2MemzaDLTou1q7n
         cZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+GJVBDiQoKlcdpvWj7Wr2feggyQRs292x8Y6paqx9M=;
        b=Em0v+Oq6XDwiaFiQynp/NDOrlecg/XAYoHQAyQGRjNUP6iFhCIoM7k1fnkTek1iVAL
         sFRhNxmH/n3RyBOAU9hptjEbquLqnoHIk03kjWIp98tRFm+oYVoGDWuchzljNrOFpjDA
         MenkC8AwCs9ALZQ9SkWLqeSa5BdhTxo6kFjnULdec+1u07XGrOqi4c6rT4+MwPzPBfHh
         iqJC0riQzK1mzQ8LYqfJ9G0rFyfPziGDJFBpkbLvj/b0uJCpE3lu01SNawsRd/P2Wg02
         t6QA+EYuN4u6+vlrpN8LgL4dKi5PMI7L8aW+HMSXV0C+ekYw5/QAWoMq5mQqUQhM//uH
         ipIA==
X-Gm-Message-State: ACrzQf2u2ntCjQ4AUSRWR1G8yyZlvn73q6QQlRUD/cZkFGWYuuLcTR1N
        +zfjkJrCZu3fxjIaSfJtzEpHcQ==
X-Google-Smtp-Source: AMsMyM6E1eC7kLTPBDegKefLnqqmQ5YynQknd3ZkHYzAGzc+XA7Yo4cgEvFY5JgCpyhZRS1/ANlZXA==
X-Received: by 2002:a2e:a607:0:b0:26c:42c8:13af with SMTP id v7-20020a2ea607000000b0026c42c813afmr8574466ljp.267.1665496306686;
        Tue, 11 Oct 2022 06:51:46 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a20-20020a056512201400b004948497e07esm1876436lfb.15.2022.10.11.06.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:51:46 -0700 (PDT)
Message-ID: <8481f2aa-eee2-881f-5a35-c8a77f468689@linaro.org>
Date:   Tue, 11 Oct 2022 16:51:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 02/13] phy: qcom-qmp: drop superfluous comments
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> Drop some unnecessary or incorrect comments.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 4 ----
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 5 -----
>   5 files changed, 18 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

