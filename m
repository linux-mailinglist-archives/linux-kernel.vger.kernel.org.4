Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCE6C3580
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjCUPUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjCUPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:20:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E5523C7F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:20:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b20so28174394edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679412025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Da2jxuDTdjMSjUZ5oJaHx1frHV9AyEaeWV3IO9K8Rs=;
        b=RIZhyIZ9n0aS3DStByjSKQu/175aENkML4VQIuqDuR3TrTGuDi59cBsHTE2ZhqcIwd
         rTx4kVX5fZoY9GU7W/OPKD4Rps8U1hUsSqnzkkytb/5KH95gWW8BVcSC1Y4Kv3oCY7bM
         H4QUrxopAbXaCgr5BGAc+kmUs3WyY+ufwfnGEzXYIt22mDWF0WnoIaWKsm+GjRT9uwIO
         KKwlC0CEdTABkp5bZcBCE1AxjjQXhIWG3gW8DNVYBgLBL4u1XzgFA4T5uCijk9yP7oWs
         skNsxpAnAmm4Vj0yN8ZHUUcZv8mLj6rvLxWbnj7u2KrLMtdJSitv58VRNhVpfUdRatzm
         dgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679412025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Da2jxuDTdjMSjUZ5oJaHx1frHV9AyEaeWV3IO9K8Rs=;
        b=wbx4U3EfQYWDrBHPvdRUZLd5dMj9Q4jrFh9E9c+Nd8YnIsEA8wV4K3zlFe+59k8uwP
         kZxu1ihlM2tCz7JgoevhVaB7zNoSrGXcN6mTSlVT0zzWvqXcPURL24ib1ir3V0rdHAED
         +z1DXSao5GBvU5qvCyuo6CvHQhZhrcrErUmiTvlIUgoLdirCmhGW9IBLN5+RCNi9fdvM
         W+bI5MXIgBtMGyLr3+bdMslIUnE1NmCbDK+64lREBh57zPbknD0ND/uFOu67YtlvQGLu
         eCoViVroUW0aiaRa3gY59qr/rJGxPcbT1lDDzm34J90p2qulL3nrp+VIVHmvuiWIWK1r
         ikFw==
X-Gm-Message-State: AO0yUKUKPk8Rbvfq5dWD7WxeQdwdMFrCzk3BaE6nh4Mb5vw+YcxhYxC7
        PH8v+Y7p8sNY3O/BBTIeqQpBxg==
X-Google-Smtp-Source: AK7set93GdFlp6UxzAJRhP+TpVPdJfQCztzCBUEZMkFY2nmybXMPfjIo0Fvf6G9cxJLVi/gEQ8Umdg==
X-Received: by 2002:aa7:d84d:0:b0:4ef:9bf0:7177 with SMTP id f13-20020aa7d84d000000b004ef9bf07177mr3338986eds.9.1679412025077;
        Tue, 21 Mar 2023 08:20:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id y2-20020a50ce02000000b004c0057b478bsm6493930edi.34.2023.03.21.08.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:20:24 -0700 (PDT)
Message-ID: <bad282d5-9e40-a99d-0abb-d04163dcf080@linaro.org>
Date:   Tue, 21 Mar 2023 16:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/4] eeprom: ee1004: Add devicetree binding
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-4-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321151642.461618-4-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 16:16, Eddie James wrote:
> Add an OF match table for devicetree instantiation of EE1004
> devices.

Subject: There is no device tree binding here. You add OF matching (or
support) to the driver.

> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/misc/eeprom/ee1004.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Best regards,
Krzysztof

