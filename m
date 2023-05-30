Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708CC716191
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjE3NWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjE3NWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:22:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507ADC9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:22:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f53c06babso790844866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685452924; x=1688044924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rcd/m8WcNQQtUZ5t+JPMtS7xHuDS2RmOZsx2AqUrBI=;
        b=AS8lKWQsAFEX70mEx4xEjeYR+oPg2B0T7AP0fFII9tibVdLUUJKgWAzt7OkW4rnTHY
         iT0NJS5a/KOM2+PPGHp+NRkEDecy+5fIXXzqBmw6270DUgBj63WrYRJD8ZQs/AswAb16
         4PVHxgOyliC9OFowe6c7YMsU7N4GuJ7TTt5GQ16/+35RWyMbjq5ict4nS+kkeRICbDh4
         b4B6w0s12yQ+EGL/08WVAtg12e6iJVvZhSwY5va4NwnILA9qlRKnTmv+sH7/awJxtRtx
         eDfLk9dfMcC9uHvi3avCG3Ae7i/s56WmzBb/Id1DWHjnqnEYpk3J6m4/Jy7Io0ArIsuu
         iueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452924; x=1688044924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rcd/m8WcNQQtUZ5t+JPMtS7xHuDS2RmOZsx2AqUrBI=;
        b=GJzrjtYGpo6fQZD1P/PmH5UxddyOm10Zusa6xCouD2SPH135zrn5B1fbeQfzyn9zoo
         It8J+D3x9qgmQMgA1AYqHhL3QQdtXfMpbFmbmpanhzfkKgoJEbPapTB6IXORyh5PjNgr
         EKGWcDab1wpXpUBxfMHYeM8dU+l1XR092yblTTHlM48WEM0F6XlTpswnEEI++JV4n2d3
         wNDVuWTf3HO6aDNUWMrQi0AfiBJENKM5qBTWDptClDnGUe3TcE10lRd7wKBe8t0gD8+P
         qt2L9ABhYQaxqWUMZqEWmVxLQaBJ1+RD4XNxroe5cIhUQEBYdi7G+Le4HiE60fMN27YH
         BxDQ==
X-Gm-Message-State: AC+VfDwqidfwthPHVYvyqdbnbvYlG9RagxeA8fBf+XTtdr0xhArBKn7Q
        l3pYY5t7RN1zM4Ps8VAR04ZPqQ==
X-Google-Smtp-Source: ACHHUZ5swZnIqt/3wRBv6QMXu4VLN/2oWK3Mm/fnIbsjpD9wHV2n0FuXPUqTpTyuZ4aBVdIFouM5qA==
X-Received: by 2002:a17:907:3e8f:b0:96f:181b:87d3 with SMTP id hs15-20020a1709073e8f00b0096f181b87d3mr2782421ejc.37.1685452924691;
        Tue, 30 May 2023 06:22:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709067d5100b0096f72424e00sm7337450ejp.131.2023.05.30.06.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:22:04 -0700 (PDT)
Message-ID: <fb65244e-ab3b-c473-57b9-2da80e67be4a@linaro.org>
Date:   Tue, 30 May 2023 15:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] dt-bindings: Add qcom,usb-hs-phy-msm8960
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230527040905.stmnoshkdqgiaex6@ripper>
 <20230528001010.47868-3-guptarud@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230528001010.47868-3-guptarud@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2023 02:10, Rudraksha Gupta wrote:
> Adds qcom,usb-hs-phy-msm8960 compatible
> 

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

Best regards,
Krzysztof

