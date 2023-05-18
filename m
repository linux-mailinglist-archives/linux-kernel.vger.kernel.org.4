Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FD0707ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjERHT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjERHTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:19:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3179530C1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:19:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510b869fe0dso2952886a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684394377; x=1686986377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwTSnqzLtgeY9emNU+hbMq75lDoh1HWWm3NzweFDwzM=;
        b=T1Sh4+2lzD3bSfN+/8TQjBiWh//n6l4kRKk7o+RQH2YHCftCBoMPtYd3+su720dt1U
         1HAA+HeN/bsMSPqKMK/G4wRUcgNsODGtAh3QkPJSpk+eXAegja/NnFblfv2z9TO/3XEa
         rDF4Fgc+xLFFryB52X8JhsYJSUhtTT1g663g4TeTrXG/Il3i/bGzfinG/nU9BpajBJmE
         LqvU5CoQxzBdfH8vUYCxKI5wCtCyrc6KM75gm/oELl/h7zQ9H3F4vEOq1vxwkVmLQRNG
         RD7R/homvc/vH/wWdUwvzKTDgQHxJjRYKDnfEKYD/L/i+U1pdkcBIeVmRwJ0+I0aLtO9
         eZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394377; x=1686986377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwTSnqzLtgeY9emNU+hbMq75lDoh1HWWm3NzweFDwzM=;
        b=KKjNkm7avXE4tUmSZNwfvguOxWShgVWr0bRlh+84wTB9Ed6f60PzOdb1ukP3ZnYR4W
         nfEQKNQ5zqUikHow1YAiKM1Bn+gEPeXoBMiLXEqrbSlyWI6c0omlq9dUayXKGkXkgFUj
         gieXPecy3vfnOGOrByRwBa9TJXQ+cYcyivVghKdUIZwJueQCDIe2oIVRSs1XtoLAa65Z
         SOPu5KTsgcdPw/krMOxfaXpEK0MoGL9TSO5fEZ+PYSKyQuGZPew8Kv5MKncooWNhdTaE
         lUhQBHOCdPuPknFp0aQmx8rRxfeRAu4mBBBsEMnXA/yakgnMBw7twmCACN+zH1LDYbaE
         4DKg==
X-Gm-Message-State: AC+VfDyXuVUg4sFOIkgDtKJnmwt/UMLp2+u9pzHKrj9JBTK78WEcB/7z
        ZlxiMgJjKIqYHS/mdLHH9dWOyQ==
X-Google-Smtp-Source: ACHHUZ5XEZF63Sg6MWtZ1QEpfQ0vG/iSgAb42WkV0+odOmHmWrWTo1Ioka+202Jw6cmQ/NA5S8/fXg==
X-Received: by 2002:a17:907:9712:b0:967:b02c:b06a with SMTP id jg18-20020a170907971200b00967b02cb06amr37912471ejc.27.1684394377719;
        Thu, 18 May 2023 00:19:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009531d9efcc4sm573376ejb.133.2023.05.18.00.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 00:19:37 -0700 (PDT)
Message-ID: <f99c1fbd-d6b2-f6d4-cbd6-1ddb17430e8f@linaro.org>
Date:   Thu, 18 May 2023 09:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pmi8998: add flash LED
 controller
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com
References: <20230518061328.146847-1-me@dylanvanassche.be>
 <20230518061328.146847-3-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230518061328.146847-3-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 08:13, Dylan Van Assche wrote:
> Qualcomm PMIC PMI8998 has a 3 channel flash LED driver which is used
> by many phones for 1 or 2 flash LEDs. Each LED can be used in flash mode
> or torch mode. Add the flash LED controller node to PMI8998 DTS.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

