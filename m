Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2FD6F3E7B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjEBHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjEBHlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:41:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA9E7A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:40:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so4324820a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683013258; x=1685605258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoUt7yH66Q/K8nPBWlvpIiBfL6kSg4OZf+O79INR/oE=;
        b=XWEiELZLGQCzow2WaTnvNiIPRAbIgBLqAnIZGkA5bNP77nVgdFJ4KVp3SRCacPtc20
         Jls4LyAH+FZEzPtqPBPzjZIRirbrkpEcNZw4aPC7dPBk+oqboqAy/OFK4E9N9+ElxtK3
         AE4BpHsFpWuXdfzIqZPYI7V8Bppar1egeWNucTMpx6TF/A4/pnB7v+xHXBTi7Qk9XBtc
         CpGZ95uhyypM8sgZ1Cvt1d2jGAov0ciPp+I4JdRs5cmUExy3pe/5xDFyQc855H9YFUFn
         U5FKv5JMewoOkZPZVHhUlUKvrPX0Vv9xLH6ZfKxSowpVJ/caw23r/4FWroyy4bspmHIE
         yKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683013258; x=1685605258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoUt7yH66Q/K8nPBWlvpIiBfL6kSg4OZf+O79INR/oE=;
        b=BZqTFAboMrcHavI9w6VslDX+fLF2QXQaF/SlrL7HfYWIwRR8zhB58VQRRkFsQ8D7ln
         1eL6R8+y8HyOm2spxfSt+Q+7TuIlluO3PGYtJZVWlHca2f2UIAK6+8+3TrPrezA+FXnr
         +0mwAXez92AkOL3jMvM4s6ngCIRxoKmIFcLZtf5i5asG/Z1HM5o2mcz2xMchICdZGYgD
         52zKSbGy6cv3RdygHJVt9mtE2wnB9eSezfVwQ/WaXyW8jCMwaZOxoOEl/hvuNTKjTeEg
         ogJc+j0DxLT9sUc+oJTXhZimcynfLV2lmgtysUQGi2zeJgZt0/q5uB9NW+BUxUmiCEGH
         c9Og==
X-Gm-Message-State: AC+VfDz5qmo9hIh/FFO6KEe+gjrhiWkNccvnvVMfzJbK9q+gbZrIr9Jp
        xuxI0Kft+gdkqQDtwzKqT8rMMA==
X-Google-Smtp-Source: ACHHUZ7j8lXUAx3NbLI5D7HhgS0GjRNrm01YgFj4KZS8wCP4vg8VUQ562+4HE9EN+NwcILShF1jz1Q==
X-Received: by 2002:a17:907:ea9:b0:960:c5fe:a35a with SMTP id ho41-20020a1709070ea900b00960c5fea35amr12427402ejc.64.1683013257802;
        Tue, 02 May 2023 00:40:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id y10-20020a056402134a00b0050bc27a4967sm2589125edw.21.2023.05.02.00.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 00:40:56 -0700 (PDT)
Message-ID: <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
Date:   Tue, 2 May 2023 09:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: snps,dwc3: Add the compatible
 name 'snps,dwc3-rtk-soc'
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502050452.27276-2-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230502050452.27276-2-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 07:04, Stanley Chang wrote:
> Add a new compatible name 'snps,dwc3-rtk-soc' of DT for realtek dwc3
> core to adjust the global register start address
> 
> The RTK DHC SoCs were designed, the global register address offset at

What are: "RTK" and "DHC"? These are manufactured by Synopsys as you
suggest in the patch?


> 0x8100. The default address offset is constant at DWC3_GLOBALS_REGS_START
> (0xc100). Therefore, add the compatible name of device-tree to specify
> the SoC custom's global register start address.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>

Based on your email, rtk could mean Realtek, so the compatible is
clearly wrong.

> ---
>  v3 to v4 change:
> Use the compatible name to specify the global register address offset.
> If the compatible name is "snps,dwc3-rtk-soc", then the offset use 0x8100.
> Otherwise, the offset is default value 0xc100.
> 

Best regards,
Krzysztof

