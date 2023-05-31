Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAED717993
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjEaIGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjEaIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:05:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD410F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:05:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f6e83e12fso842509866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685520353; x=1688112353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7x6mIdtIUoFuvwTCRWIR9ijOzB6reHeMvwNhfcyLwj8=;
        b=ojh1U8lXdHwssrj9Y7W9djafLn06W34rivQK/WgW4vjfN/I9REuJK5yGklNQZRF5lg
         fIhg1v3BuhKTlR0PRijVx1GlogH06mYk3EDryyboMunXuDJeg4ePCdopwEXHJwrNiRqy
         6b1zYsq14f/SFYtKFFqm4U8aDwD5Epw6sDFFptfXMkhNw0AN8U/l+Co9GuSU7UIEdAHN
         uBITQAKPPnL9nhYWh1NvEfySCHD6FFnE8NhJo6shy34C+7IO8R7EnV5G9aFiIHcPVMfJ
         ZettLt8AK3wYEKoodCfPUmbPD8X4KA0ayQVeZoGwgb2nxRlYEnyH5j3l8KWWZ1j7OKUc
         PAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685520353; x=1688112353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7x6mIdtIUoFuvwTCRWIR9ijOzB6reHeMvwNhfcyLwj8=;
        b=dHggCDUg0hbN4pKwhO7q7MtIFlWXJjJBZ/nVIN2zOWH8CjLpVr4FdjY1sfN3ImW07j
         386Dd+o85oHj+zdJz6Y0/KZPLtlGbkaWZBLgD4sfcH7Jo3hyW0fDbUPAlU+/8GrwAAZp
         vm+0rvO29G4L/dix5Ehi3FsOfHk+wVYH/ca1+M1RWDVXEaAvO+VQ9PLD0qRVUve80f40
         os/Y9KfUsgXNWPSq5yOXEwSZDHkskJ8WnXt3Fngqd5fwF1ZkxsLgN5s50FwVL/YjCoHg
         lwV6CNpSfAXBlPro2da0meKneGt3qRiJdxAf/uuALlqY4vgPwwPLHTEpr0Sk2LATpmYI
         t95A==
X-Gm-Message-State: AC+VfDyTcVLHKxrcvyk6stA8ZM1HelaMzj2Vz5vRvKTNcovIMCLVSI8S
        e9+ib8KcJIe6lycsO04/iLL5i1ganR/LnxQ38qgMnQ==
X-Google-Smtp-Source: ACHHUZ7GExO9md3piU1CsvJBNCRNv6jAIVB1q3IXHVAw5pXEaSnR4GjikU4nSr36WyFGpBn/BeU8uw==
X-Received: by 2002:a17:907:7246:b0:92b:6b6d:2daf with SMTP id ds6-20020a170907724600b0092b6b6d2dafmr4367150ejc.77.1685520353318;
        Wed, 31 May 2023 01:05:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907212e00b0096f937b0d3esm8521072ejb.3.2023.05.31.01.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:05:52 -0700 (PDT)
Message-ID: <4337f333-0c78-8749-658d-3f7f69538571@linaro.org>
Date:   Wed, 31 May 2023 10:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: rmtfs: Allow dynamic
 allocation
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530193436.3833889-1-quic_bjorande@quicinc.com>
 <20230530193436.3833889-2-quic_bjorande@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530193436.3833889-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 21:34, Bjorn Andersson wrote:
> Allow instances of the qcom,rmtfs-mem either be defined as a
> reserved-memory regoin, or just standalone given just a size.

typo: region

I am pretty sure I saw some patches from Qualcomm also making one of
reserved-memory users a bit more dynamic (some boot-thingy?). Would be
nice to unify...

> 
> This relieve the DeviceTree source author the need to come up with a
> static memory region for the region.

If you region does not have to be static, why bothering with the size in
DT? I assume this can be really dynamic and nothing is needed in DT. Not
even size.

Best regards,
Krzysztof

