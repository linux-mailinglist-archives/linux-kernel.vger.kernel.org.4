Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9256F2EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjEAHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEAHG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:06:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DACE55
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 00:06:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc34b98edso1634889a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682924785; x=1685516785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lbzi8KQ4ewDOl8/6+OjZmerGl8/Fh/n/WKcpF1UJuug=;
        b=aaOHqH0LGk6VIByEO9RGx59+hUQbAMeHNYJykED/CAFy0g91Sca0AuiuZC4Wy+r3SX
         Zv49g1IMWFbjO0oD9H0P9iy9nEoRMDCxymmAZbdKVehS3qAViZCmyYw8t/2EeqqdhoMd
         ciGOJmdvNIv45G0PHsOHy9VNz7X+4C718orj3+Y2mI9hwBiL1DRVQz+3JgRyKokNCddg
         +zmqfgKzWvWCY/3C4yVMYfUC6AtDYq0iaeIMJE7MiWGe1GSxqbiRVwI1p74LUYff0lKb
         6FiM33hTBV91YZn16qBOqfSN+4Ka/f6UiicMqbp+y0fNmk/qbhgMpu3UqiB9W9PEvdOU
         1JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682924785; x=1685516785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lbzi8KQ4ewDOl8/6+OjZmerGl8/Fh/n/WKcpF1UJuug=;
        b=Mhh6sJsRQMq+Q/BJqy/H+oA7kIwMxS5JM9M57rEAEz63+JwQ8WTK4gaDVF25c2e/Y8
         ivPTEpedWc+eicbF/f8ZeD9H9dLw0IbMA3QC+mgRet42G4hbYUto+g7oB3fBHmQ+nib7
         f99dKO59ahfsptR98a0elSfo6x69YrACPh2W8kEp638N4hTq/Vsj+Q/8/YAwtubzb6sh
         KQyVH7eMGOJrWJcM1eTlMDSZV6ds5+aQx8KwcEZyzKVT7zduE5DrXxsBWLOKorSzD/hQ
         W8s1MXi2QCPhOaoBi1R6cxUgDFQwJF3sH122mTsVteR+tusLsqV0h8rBDdCTuPc6nmsY
         Mfgg==
X-Gm-Message-State: AC+VfDzoClNitDK6lX7mvVVUYlM8Cqmonvm2FGoeyTFpd7rDVxqHBQoQ
        8xPVIe21rFE6pCIPAb2Q7rpG5w==
X-Google-Smtp-Source: ACHHUZ7iSPkCwcv4sQgaF1lfLUTeLnVGU9VnUBKEqIukwsm/fahS20txrOcdq3QSyl2wnGIIzFNLnw==
X-Received: by 2002:aa7:c683:0:b0:50b:c48d:5d5b with SMTP id n3-20020aa7c683000000b0050bc48d5d5bmr2250487edq.24.1682924785343;
        Mon, 01 May 2023 00:06:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c6c8000000b005068d7ccfb0sm11652041eds.83.2023.05.01.00.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 00:06:24 -0700 (PDT)
Message-ID: <67f91b8c-b8d2-3484-b637-a631232cd18b@linaro.org>
Date:   Mon, 1 May 2023 09:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: phy: brcm,kona-usb2-phy: convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230427190725.GA7730@standask-GA-A55M-S2HP>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230427190725.GA7730@standask-GA-A55M-S2HP>
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

On 27/04/2023 21:07, Stanislav Jakubek wrote:
> Convert Broadcom Kona family USB 2.0 PHY bindings to DT schema.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

