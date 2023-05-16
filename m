Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB37053AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjEPQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEPQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:25:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2543AA2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:25:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so25204434a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254266; x=1686846266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PXu56U51tiuz+1OMnm6ufBCGFIJbizyW7wqsREp9Wo=;
        b=Z5K4uSyOgZFCQqMHuaBOPqfc1oPYL0OMIYgoyVIwBeZr8I2yJPFLBcysS4WoyWN1Ib
         RQOoYuU6d6kWYRDCoqxH11PPpgjppHGhuKGy1CvNGOrRNxObt8zKQZvMg85RFP1jrjI7
         443ufNacw8nVj3wgdEsCJyYoI2PbHOv1kWY42ELhKnPa3ITal5BPzy+dnT0k8MDeFOPu
         stiMLAM9Ujo8JTb/1TtLj0M+PbmW1va8zdH/EnzhOWsCUzetNv28tJzjqjIMdMilWhIa
         u0KXvHU8fbpA4dzeGYc1x+hZSeJNcHtpWCUyPT7jpN4ktBUe1GD7LW/0awiepYB9Uh3z
         q95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254266; x=1686846266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PXu56U51tiuz+1OMnm6ufBCGFIJbizyW7wqsREp9Wo=;
        b=IhGecKc1PiRNReDUmlCT097KBUM9QCpl09Bj//OjwnP4tdxcID/vwW33YdnmtkzEM1
         JvZJrx0JET7ixR3v//bn91D5ayh2nPWEa7AqPRd5sL9uNbovY4Iyb7sxdKUI5ksGo0MW
         lvya2OCWfqodPMj6rDXRf2Yqmccs8jdGA14T8htBHjQmtkTwOkVY2LSVbhMnaSFwoG8T
         tpeGZ87J8BoAq2BKDU2wGOK4wFBbg1qsrjG/ew7MXlWZ0qj1YN+ePTJFh/y18CYbjXbW
         AC8OjfVVzh4DmuLnB2u+cihEnrfq0GOFzDbdPMJ6hTpfomvSxkVWuI1SyRbaaTNk1l5p
         ommg==
X-Gm-Message-State: AC+VfDyrp/4BEtdfGI4f7Nz7KSJV3PKDVDQkGASvzb+OnPviFNCO0I88
        wosSR/74reKwizAV22UBZT/sNw==
X-Google-Smtp-Source: ACHHUZ4cdsw81QW1v33VNg0aJW/gOJRLh3Om7Ri4RZN3YU0EcnjyMgtbK63mmeNO1NoQyYy5VBE89w==
X-Received: by 2002:a05:6402:549:b0:50b:f70b:9928 with SMTP id i9-20020a056402054900b0050bf70b9928mr30691356edx.18.1684254266342;
        Tue, 16 May 2023 09:24:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id j20-20020aa7c0d4000000b00508804f3b1dsm8445867edp.57.2023.05.16.09.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:24:25 -0700 (PDT)
Message-ID: <a92b6a2e-fb73-e049-3e01-ab258f4a6820@linaro.org>
Date:   Tue, 16 May 2023 18:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add support for RDP449
 variant
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230516135013.3547-1-quic_devipriy@quicinc.com>
 <20230516135013.3547-3-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516135013.3547-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 15:50, Devi Priya wrote:
> Add the initial device tree support for the Reference Design Platform (RDP)
> 449 based on IPQ9574 family of SoCs. This patch adds support for Console
> UART, SPI NOR and SMPA1 regulator node.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

