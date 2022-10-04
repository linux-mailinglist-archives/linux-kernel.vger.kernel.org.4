Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1505F3ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJDIwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJDIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:51:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881D2CCB6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:51:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn8so1108665ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uGiILmiYg1M9WfKx8PdZUl0MXEfqaaVj3qebogNp8XA=;
        b=b/gA1aORj0ap1sPS8T2QhjWkj71yWvR+b7fqpTWEi4onljQTnGollVyUcvgkbSIQwW
         ciLFDdjAy6gmkhn71aGLIdgIL9SBLwGvRHJCvN7Azrkcq/IsY/XuHKA1KEKqmNnfsGtM
         1ohaBimDuavYVm8rO2p4+J3SWxkPGsCb1oeMVtD4JxinoanjJ/tBwqkGal95DyPVjc9e
         cC47IeU30xB0fUZTLXxOPSMflBAtWh/V44geHaPyXl7FgoEFT9AKVzFQsQTlkutdCl8J
         zQntgMuqByHCiJ9E2UazG0zNG/OlxQkezqpJz/tWTbCb9H28DLtmbqSE3vTdio96VZRf
         f25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uGiILmiYg1M9WfKx8PdZUl0MXEfqaaVj3qebogNp8XA=;
        b=K3KUlRX1il15sl/Nfvw9EBpwIVstcICj9KtDIftHRchZXY5B+3Epa8v1aud+g4faQ6
         Y9/cb3TAnv3kwX4UW/cgAgJASV4NYbSKqDC7pCWUibvqkhMEj7YDIrcJUxt+QXB9PqI1
         TjiTrrZjlcAtu02nOpFCZ0WQM8RVofGBXe9totLIwuGgvonsQp7y7w7u718OEQhB2oZx
         jtLRptv0EUMGLB5AMTKc+BZ/Q9wfE5CM0mrfU3BqJi13GBPr8oXci6UZj+tZmlm0caye
         7Xi/9Og1vacWMnUN1JZABuEN6y3mNJilhHtFDUZlus/8St4em/JBTBGv7LWk10/U3zMa
         f+Ew==
X-Gm-Message-State: ACrzQf1ksxpQOKaO3Vi240XloHOg5SOcxiI4HD/mcSPgcrreDM2cH3gZ
        1hAwE/a6wuZFrZ0HJy9n4X4qew==
X-Google-Smtp-Source: AMsMyM6IvtviVn4B4cxv4nxVOEucOOgOhoX9ZE2+BAl0dkpkbfSbBNMoihrnoGxH/DH0H1F1UvMjWQ==
X-Received: by 2002:a2e:2e14:0:b0:26d:d636:4972 with SMTP id u20-20020a2e2e14000000b0026dd6364972mr2958189lju.221.1664873513308;
        Tue, 04 Oct 2022 01:51:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651239cf00b0049735cec78dsm1828872lfu.67.2022.10.04.01.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:51:52 -0700 (PDT)
Message-ID: <0145501a-f478-9479-f5ab-fe903d208cd6@linaro.org>
Date:   Tue, 4 Oct 2022 10:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 01/11] dt-bindings: arm: qcom: move
 swir,mangoh-green-wp8548 board documentation to qcom.yaml
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v2-1-87fbeb4ae053@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-1-87fbeb4ae053@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 10:08, Neil Armstrong wrote:
> Document into the main qcom.yaml as conversion from swir.txt to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

