Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA36D7E14
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbjDENv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbjDENv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:51:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DBA7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:51:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ek18so141314403edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680702684;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uPqH7o+0wiRlBmcx0MUrrIJplx2idVv42J11sE3f/KY=;
        b=HSDwUFhV0XqGiVO+Xtk10tawmjOw1BmkD0h5DCHj7+7lDSU9h0va60K2EuqPQAJ0wJ
         vh17eJDGLMXGwvFJc2Lh7N8y2Qzx+9BDw+B1XDfjJkbEGmma5uQ7p4GXrdqzdGPkhiJK
         /cuLGMpm0w1aC1SsAKpQI1+Wp2q6E0EWUe1eTmgk6R2V1/Wa7KAm8RYjB7TgXo1DUSOr
         mxGdz4W4ZfehzI6DY7FqsJiQCXFTMYPWhm1VbcuJhNHqhLFTR8YS2kVzAdhBTHcepKIY
         3m4qwI+zq8LlvwesdwMxCViebZRXhiKtGuCHxVd8zkGSu7+cOz906fFSNDrtV+ez+Yyq
         pM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702684;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPqH7o+0wiRlBmcx0MUrrIJplx2idVv42J11sE3f/KY=;
        b=q77ba1yBXHcAN0Byt37KmmDvk4T9QGxcUXy+EVUVXmdNY1ccG8UuN+7FxrVycCRqCp
         vtN5kvo6ME+ZO6ZA/MQ5Pte0fUWTNJ5RRaeED6XnfiPwVjEfi9quA5ZLwqVS5vtN6CSG
         bNHGszIszm1IcdlFw2PbP4Zq2+5+HKVnmdvvNJ4WKV4bdeGCKsqRnBy43Z5i/2rrnd2m
         35eCc9Hiso1G6FcA4dRL5Yr9Fg2LezCTii9cAY9hOAo+wsbyBpL/t1s1NR2xRCT3y+Ra
         MdHDo9EGX/UimhaKl+CkUNXyysNhhA7EnbD3T13AMMP0/Vewfb7Rdc1lupRu3XQv+gSa
         VM3A==
X-Gm-Message-State: AAQBX9eL2or65aQwSydAHaRv+pHIBmKveqvujXlX7BJsnBXyjOGFb7SP
        I9qn+sKlxYx3ptILTrj+z5A/RA==
X-Google-Smtp-Source: AKy350aCSBtfQNEG9ivhJDXRScDkDl7K9FxzN5uKgWKy9JhdSLbTTf3hT9NuDFad11cE5iNMfsxaLw==
X-Received: by 2002:a17:907:8b95:b0:932:c1e2:9984 with SMTP id tb21-20020a1709078b9500b00932c1e29984mr3530013ejc.58.1680702683903;
        Wed, 05 Apr 2023 06:51:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id m23-20020a509317000000b004fbd365fb33sm7391465eda.38.2023.04.05.06.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:51:23 -0700 (PDT)
Message-ID: <5bbf9452-43b4-4b7a-8879-003efa26b0f5@linaro.org>
Date:   Wed, 5 Apr 2023 15:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 0/8] Enable IPQ9754 USB
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1680693149.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cover.1680693149.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 13:41, Varadarajan Narayanan wrote:
> This patch series adds the relevant phy and controller
> configurations for enabling USB on IPQ9754
> 
> Depends on:
> https://lore.kernel.org/all/20230217142030.16012-1-quic_devipriy@quicinc.com/
> 
> [v8]:
> 	- Update bindings for the clock name change
> [v7]:
> 	- com_aux -> cfg_ahb in patch 7
> 
> [v6]:
>         - Incorporated review comments
> 	- Resolve make dtbs_check messages
> 	- Fixed pcs_usb offset
> 	- Board dts file name changed
> 

Thanks for the patches. Three submissions within few hours it is a bit
too many. Please slow down a bit, give reviewers chance to respond and
wait with new versions at least one day.
Best regards,
Krzysztof

