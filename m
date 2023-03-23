Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74036C687A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjCWMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjCWMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:35:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B131F1EFF6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:35:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so85876683edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679574954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcdcFW2o7lO4HSULvRwKJuKAN+ANvBzfqs/0VanCNtA=;
        b=SKWgUpGw8QCzkIH0er3CYuYtajmychdMFo1YNnpHWm4cN3IEo4qhST6TCQxJcfR3p5
         tHUmRH559dEWePF3/X7g2W1n7qeIi+ruBMx83ysMDLJJJt9+CSFpH5pvoIaxeq6h9SW9
         kpf4m2otdltH1s5lzUaB3VpYPHLgZ9+oCreK6T6DWsunVGmMSFPD/0f6UXopMgUbt3mu
         oHA/JgSVqksydQW4Aeu3DeTQg5EMz3e90db/xCVvrCOqdhxpx4aH1Y7mrPQwj3JX2mxh
         wdlkEBaqRi6fPqVtVx3c0nLvsHzNgv9BQqZF9oC5ooyNXjYgNOCkwScoeX5Gj2lc9wPd
         X+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679574954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcdcFW2o7lO4HSULvRwKJuKAN+ANvBzfqs/0VanCNtA=;
        b=l+2H0tlaqRZZ6ENXXuinK42AQiESQZYJayJVr+3NEAPikeUI7b9QcV3UReDU0CY1Q6
         lKIMzoTI/PIGC6xLDlnekGlcQGKIAxpBPm9oVS+Uecg4JzjVy+MA/99jCpOK068XpSrb
         szYjfCKHzHzBzi+fa6bH2wt5RH3OZI5j0JxHrRo87pvXKFkVcBm5nuz9TQRbj636JJql
         kwM+G71yi/6M43YtTKb8jCvn6YXYy53u3K8KGe5M5JJ3GTg/XIrqDicNVfP9SRLXstSr
         LsVhbfrxmKn6cTQut/VU2+IUFJJ5NWsdYW+KYoVNFQw38iCsACkKfVPCan0Zk1lpAWCP
         Johg==
X-Gm-Message-State: AO0yUKXyjZjsYpSWR33gbjHPbXQEkp/5ojVIWgM0JBOwdkBmPWOO1dBa
        3ujNKCzDhSTHcKGk/6rHJnRcAA==
X-Google-Smtp-Source: AK7set9gCzPMq6UzpYkoDzP8fIbA330Kh0INBz2+cqIjPHXz2lglBtuGncjUGTCTLGJjiHUP+ffU3Q==
X-Received: by 2002:a17:906:4355:b0:92e:c4c9:7a43 with SMTP id z21-20020a170906435500b0092ec4c97a43mr9847521ejm.25.1679574954171;
        Thu, 23 Mar 2023 05:35:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d350:23b1:cb94:f39d? ([2a02:810d:15c0:828:d350:23b1:cb94:f39d])
        by smtp.gmail.com with ESMTPSA id k15-20020a50ce4f000000b004bef1187754sm9086863edj.95.2023.03.23.05.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 05:35:53 -0700 (PDT)
Message-ID: <04876110-1dec-dafd-cf4e-a6ed7a8b40b0@linaro.org>
Date:   Thu, 23 Mar 2023 13:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v10 1/3] dt-bindings: i2c: Add Maxim MAX735x/MAX736x
 variants
Content-Language: en-US
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323115356.2602042-1-patrick.rudolph@9elements.com>
 <20230323115356.2602042-2-patrick.rudolph@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323115356.2602042-2-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 12:53, Patrick Rudolph wrote:
> Update the pca954x bindings to add support for the Maxim MAX735x/MAX736x
> chips. The functionality will be provided by the exisintg pca954x driver.
> 
> While on it make the interrupts support conditionally as not all of the
> existing chips have interrupts.
> 
> For chips that are powered off by default add an optional regulator
> called vdd-supply.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

I just received this patch sent twice - as 1/3 and 1/4 - without
changelog, no cover letter, nothing more. Also other patches are
missing, but that I could understand as intentional.

This is confusing. New submission means new version. Attach changelog
after --- explaining the changes.

Best regards,
Krzysztof

