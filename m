Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5984695FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjBNJqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjBNJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:45:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DC9241E3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:45:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id co8so11226199wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wENdEppTWRzvhOXqdWusZG/FqfghXofTMpdB8VyHcFc=;
        b=HJaFKAWImP3Ottv9pkv+ApZzW7XWh8/+y9JDcR7PV3oCma6mEi7aHOE2PBrRlBnGi8
         RWv8g9bzUaajwdKQrvrCr4cZ8fBjHV3d4IA/FVZbRw4QJr1rJQ5ICocLQxMYrHkauMvY
         vG2caF0fyzT2fnSRuaQUMOpxH61brKALtt7YRRfw1ydqvkYQcoUxglzCI9K2B9V5Ty3l
         OcLRm7q7vBvv5d4/F1NXaqJnLU2+SfQABITYy63JF9PFUy8m6LSZea/pI32s4DafzZAC
         NoVrNtfhZNTobocg6jYqekaxZFE66G0naJBnXnx3jcXR1xWLd5PgHQS9R9DC6bmpphAj
         oUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wENdEppTWRzvhOXqdWusZG/FqfghXofTMpdB8VyHcFc=;
        b=lGzRkSKvMwa+BYySMS33EoXMzjJ+6UXh7oBJDhFlgxzzbsDkkjAI1roodgJaiUerJd
         YdFqoau7a1PFIy2UBJ/Ry6237Wca7tzHosma7G8p0l4Ws0AKS9zaUjxMgIvKjzou9m0Z
         JpmR+qDtcpBDZ/HCYk4ex+3c0jlF44bEUTNR9Znz92XxDsmNPRopge47IB4NDzCD81GA
         ErHjemVh2L3DgOxtv1YVwtytZFYQNzJvYqyA/jEhY87LwOkh4FqEX5IIGNxtnA2I6iZ+
         Z9lWbHHOokUCTYBZTzYHRCJ9WaUFKNpZpQflsdPNwaSQ64YlCpViL+n4thaMxZ9gw88N
         yJ0w==
X-Gm-Message-State: AO0yUKW0FOa8Qp4Yt8vTwZpxy0h/J69C3B9jYGMZvrRzDW+Hfj7Nl8xI
        +hFQvRyGPeaoz1BNyDl6+7b8sg==
X-Google-Smtp-Source: AK7set/+59Rv1KeYgBl+dixolliT1zKZCIuXWoXM8qmMyMRRmXv9giawauUWm4tb83zCzErpGnny8Q==
X-Received: by 2002:a5d:4b03:0:b0:2c5:5881:be0f with SMTP id v3-20020a5d4b03000000b002c55881be0fmr1442097wrq.25.1676367950784;
        Tue, 14 Feb 2023 01:45:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e14-20020adfe7ce000000b002c54f367fe4sm7890580wrn.100.2023.02.14.01.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:45:50 -0800 (PST)
Message-ID: <59196a08-3fde-60b3-5d76-c8106e2c8962@linaro.org>
Date:   Tue, 14 Feb 2023 10:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: sti: add STi boards and remove
 stih415/stih416
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230213185633.15187-1-avolmat@me.com>
 <20230213185633.15187-3-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213185633.15187-3-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 19:56, Alain Volmat wrote:
> Add bindings for STi platform boards and remove stih415/stih416
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v3: move back file into bindings/arm and update commit log accordingly
> v2: update licensing
>     move file into soc/sti folder
>  .../devicetree/bindings/arm/sti.yaml          | 23 ++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

