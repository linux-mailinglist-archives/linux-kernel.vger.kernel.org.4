Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1505F64EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiJFLK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiJFLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:10:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA4D9C20F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:10:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j4so2284170lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Fxr8OaADTEzmL855dNw0fpPbUC2hlJBaCHKjv6e93ko=;
        b=kBlcwIKjMI/OQ4B/Y+tt5aJzI6/MZmJUTrluSPtUfExDg3sgLYtbYAiPD5NXjJSqIP
         ImW54vsJgYPMV3nq1PiBCPzMenUhW3J0xDXg/qSyqAJt5zO8aySzoxapnsIDac87FsAI
         UyHEDLT/m1JJoXo2QbUdNPg62eb2GFUyGJQZdLYlwuHOEhu0jjg2MV7ftsH7c86o3pnQ
         PUY2uVMUF6VUX0W/zS+tZGpQjXB/Gq4O0lXXPZmqz3+mh/7SvYYt/ixsDvvL6yjKvuj6
         BnZ7pbDLaFuwozyA7fom3/F52QN+5xbg7iPcDlYWR88XVUTsb4JiBMTsViGVYgBbmOGh
         CzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Fxr8OaADTEzmL855dNw0fpPbUC2hlJBaCHKjv6e93ko=;
        b=5mHWq7ecdeer2ao+JnJ60a61J9GMpKZd+ErHAuGu4qZemAtQHfI4WKX7dgaH6MBHFi
         3q27CZkLGNxWbp9+5w6wynAFCWZOfvscfsr6kEuv7w3HgTeO5D648TBTc6qQsl2sbsOT
         xTmGCNt5U0vNZRQ1HxKQlEaQ3VUeYDdJIV4YNUngQfKYX76kGA43nmlvmTDSza3I7puC
         /3xdAdDFHNy946NUhLTW3l8c/qkf7WNCYv6XnKaoVSlkDQMSQYB/oR6qLMxgsnyYleAI
         Iqez9xYjVG9iUp0bV7nJG7uRt2HszdklmL3SXcquU9xDmmpJECO47UZBXRJrZ6ZSYhPf
         tixA==
X-Gm-Message-State: ACrzQf3KJG0VSnRDkfaFhfF6cYo6blIHg4450y44slfSFpuRODzByEK8
        F2OnTHf+WLXw+vMQwr/I5NgdCg==
X-Google-Smtp-Source: AMsMyM6S2tUawJfyzvQ7Ag5uB5FOydcGQtBD+V9HH/PYRxEppYlvy7ykgDNMW8a+OwgxRZb2chThrQ==
X-Received: by 2002:ac2:4a78:0:b0:4a2:2974:c86d with SMTP id q24-20020ac24a78000000b004a22974c86dmr1681413lfp.514.1665054635656;
        Thu, 06 Oct 2022 04:10:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o15-20020a05651c050f00b0026de7597bffsm957400ljp.10.2022.10.06.04.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 04:10:35 -0700 (PDT)
Message-ID: <480ef131-9d1f-8ca8-9808-e3f51457eccd@linaro.org>
Date:   Thu, 6 Oct 2022 13:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/6] arm: dts: qcom: mdm9615: fix pinctrl subnodes
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-2-0cbc006e2a30@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-2-0cbc006e2a30@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 11:57, Neil Armstrong wrote:
> Fix the MDM9615 DT to the expected subnodes namings.

Remove "fix" from the commit title and description, because it might
encourage AUTOSEL to pick it up. There was nothing particularly wrong
with DTS, so there is nothing to fix. One way to describe it is aligning
with DT schema.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

