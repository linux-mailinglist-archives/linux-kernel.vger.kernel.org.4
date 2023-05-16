Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E93704745
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjEPIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEPIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:03:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382DD448D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:03:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso20680286a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684224227; x=1686816227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSFJbsVN3DzfivTTA40X/LpIY5LL5oqiGpzUJW2oCQU=;
        b=frm8m7g/MFs+OEOtXs4P99E4ju10KlP06200F8b2De0IfFdGl/ihiWNL/fcaQwMepM
         UIjDSSN/DcioZ0ujG1ABF3zRSuQABothlEx3YzRRLd0G3RnQCZ+FQz1b6eSQiHIhwl1k
         0E2NL/A5ZdBqXHCMf0Q/g0Vb8GsatTqQqjXGk13OEmCvulAx8Nxm80zA+5XTAyy8/caA
         WW05/Su3AS2US86XvXgG1tDSdzTBouQxVR2Fm0O76RelYddrCX3MN3Vy43cTmiVqKf23
         +gcnKpPSpHx/N7j2gInElH9FyBBUE6tvSLOc2YEIRXQUzlCxcZcRKtVaMDXByKSspZ8e
         7evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684224227; x=1686816227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSFJbsVN3DzfivTTA40X/LpIY5LL5oqiGpzUJW2oCQU=;
        b=DQEIwp+QqSOeoJS8jzbMCBHUyTmmx4R1zWzVdK2U2M+1ZGEQkzmkCz7dadRO0EkL2a
         DvbjWOPLde2ncFiIgDxh/yTwQVNrJ7afF7gdlIAlwnvFZTruNNvOPnXQ879pK0QN5yFW
         KYprkiJkgJaFIwBB83nbmWkIy+tfBV+Zm06217opCL5isXonVy3VLcZjAuLThkEL8Kky
         XLdVssodoFZTLUvBkJ6fR92Rvv+zQguj4ryFttx9tBTva5kb0JD7K/qzBOHG5ASPo+o7
         fH7ayjSj+BPbHe460ZRQTKxdd7ErXRsAZrdHvndAa4jqS1gl3jNTeRbHPjaXFQCFIVD0
         4+6A==
X-Gm-Message-State: AC+VfDywxnKOIu01+hhNgWKMTsIoplNnOEbp+Lsh34QDTTzeMe0z7tV2
        GMOKrwlMz3a2a7N77sxlrNMGtg==
X-Google-Smtp-Source: ACHHUZ5bvHxcHnitKexpHPgAaiebbarZn+Vk1DrCsRjyDEoNSRIouSQTtBivyhNXirfmJ5NopDK+sg==
X-Received: by 2002:a05:6402:b13:b0:50c:a8ca:3240 with SMTP id bm19-20020a0564020b1300b0050ca8ca3240mr28742318edb.24.1684224227652;
        Tue, 16 May 2023 01:03:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id v3-20020aa7d803000000b0050d83a39e6fsm8021841edq.4.2023.05.16.01.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:03:47 -0700 (PDT)
Message-ID: <4529262a-59c2-1610-2d7f-d2e3529bf867@linaro.org>
Date:   Tue, 16 May 2023 10:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: optee: add interrupt controller
 properties
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
References: <20230506073235.2770292-1-etienne.carriere@linaro.org>
 <CAN5uoS-U1h_Fx1K4PtnK3vHmyfUUS6wqCcSfhoaV=idgEOC04Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAN5uoS-U1h_Fx1K4PtnK3vHmyfUUS6wqCcSfhoaV=idgEOC04Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 08:02, Etienne Carriere wrote:
> Dear all,
> 
> On Sat, 6 May 2023 at 09:33, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
>>
>> Adds an optional interrupt controller property to optee firmware node
>> in the DT bindings. Optee driver may embeds an irqchip exposing
>> OP-TEE interrupt events notified by the TEE world. Optee registers up
>> to 1 interrupt controller and identifies each line with a line
>> number from 0 to UINT16_MAX.
>>
>> The identifiers and meaning of the interrupt line number are specific
>> to the platform and shall be found in the OP-TEE platform documentation.
>>
>> In the example shown in optee DT binding documentation, the platform SCMI
>> device controlled by Linux scmi driver uses optee interrupt irq 5 as
>> signal to trigger processing of an asynchronous incoming SCMI message
>> in the scope of a CPU DVFS control. A platform can have several SCMI
>> channels driven this way. Optee irqs also permit small embedded devices
>> to share e.g. a gpio expander, a group of wakeup sources, etc... between
>> OP-TEE world (for sensitive services) and Linux world (for non-sensitive
>> services). The physical controller is driven from the TEE which exposes
>> some controls to Linux kernel.
>>
>> Cc: Jens Wiklander <jens.wiklander@linaro.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
>> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
>> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
>> ---
> 
> Any feedback on this change proposal?

Rob had here several comments, so I will defer it to him.

I don't get why this is not part of linaro,scmi-optee driver directly. I
think it's the only valid use case because the others like GPIO
expanders seem  a stretch.


Best regards,
Krzysztof

