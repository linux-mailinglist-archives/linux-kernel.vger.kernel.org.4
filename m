Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620F55EEEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiI2HYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiI2HYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:24:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C412CCAA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:23:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i26so916737lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=esyvo1N+gEQDFFE9aYlOLsMaB1azheI0a2UcfMkbL2s=;
        b=VEFPX8b4WGsm4NmsL0IuayBl6rV7L13OuxxQD2rU2cKhhvzTnzLaNDOzObqriutUEY
         syNJTUCDIe6P2bCnrTrw6r7cr07EZj6sWNZdbzavpY+oWTfDblWjUGZ1GNK1UHH4lOyJ
         JeWmmUMqXylbCW6iVFdgNdIlQwT7yICuAJkwh6MA7tgqqDK4kJOArBNQYTMKcTtE2cek
         Vq3PDlRUgsTe9/j8CckZoG3Q/gp7mGLplpdD7cBzqMTHycfTflw6jgaiy1zyMSEMimxx
         RolWqf2I9KGIKjhNLtYOHqGjRgxD0SZ2ESWx2F+KTY7taDQwVBfLRRKzRNDcGoaeasdA
         dtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=esyvo1N+gEQDFFE9aYlOLsMaB1azheI0a2UcfMkbL2s=;
        b=zqxkynYYSeDlqA2BvR+v/eRsWS9fLHh5W2T8+i6Qg/c9dzpWx4cMomzp91nKTDQbQY
         q1CM42IX/dT6tOuu59jnGdhsT4ygOQRonWyjO1+cZW5/62jDQwMRxoSgDjw5xqx00tNX
         ZAftdRu7IvsPd852bbQR5IrvCwtz+/Nkj1ZoLYeyd5YR+Cf+OXkQTWRNSyVZDDNAyz/W
         PbGLG3fHVXtnVCHQ6HkGbyqDusg9+0Vyh+QydrSPUjFw5v2kWNJH14jue+nmGon8rx7P
         39JUBUkZny3BpnCjeSW2jNfseOQXlpYjurmSIUG2GkKfGdiJss874Hpwik4tj+1YKU2T
         UI4A==
X-Gm-Message-State: ACrzQf3nL9eZ5b1z7aXrxxrbGSNgFMSYD8w7eM6pxL1NMzKr/KRz2Rei
        7bSkV8OB9Knr4rj9CDdZtiN14g==
X-Google-Smtp-Source: AMsMyM7PKTciPv1b8hkVLu+URm+0q9tPBNwvxrPJyro9cIzA9VsAKGSl+yb0bGNdqKvTN/ucLgsDUQ==
X-Received: by 2002:a05:6512:a86:b0:499:f794:5cc2 with SMTP id m6-20020a0565120a8600b00499f7945cc2mr738095lfu.100.1664436210873;
        Thu, 29 Sep 2022 00:23:30 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h15-20020ac250cf000000b00498f871f33fsm703730lfm.86.2022.09.29.00.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:23:30 -0700 (PDT)
Message-ID: <89a6d523-0268-3e8c-2293-68e2de7081d5@linaro.org>
Date:   Thu, 29 Sep 2022 09:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Point to the yaml version of
 'qcom,ethqos' dt-bindings
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Miller <davem@davemloft.net>
References: <20220929060405.2445745-1-bhupesh.sharma@linaro.org>
 <20220929060405.2445745-5-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929060405.2445745-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 08:04, Bhupesh Sharma wrote:
> Update the MAINTAINERS file to point to the yaml version of
> 'qcom,ethqos' dt-bindings.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

This cannot be a separate patch - it's not bisectable.

Best regards,
Krzysztof

