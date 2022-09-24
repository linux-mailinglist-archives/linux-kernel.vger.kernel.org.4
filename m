Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F955E8AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiIXJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiIXJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 05:28:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD48E124C01
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:28:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z25so3725627lfr.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jrh4qRmQUJ/q2crYkL86oyhAjsetFbiilFq4gqr3q0Q=;
        b=QOARMQx3jWwWSNNym9bN+dqTqtNFMO346NSAbKi+sHtxYz3niuhAkF8jvGa8PQifIu
         hEV2GDPyL7RUQWD1aUoG9Qj4lDDsoLEpzJ+nQltJrCFsS6CN/+zC6RK43Y+LrT07g5+q
         mRyaEXyuMwTJ8w3+2ig4SLEw7vgsSI7XXjCE0jR/sbc3c26d5dJ4FZr0g6GtW/lPCX6R
         uyhNYw+enYW5zFMo0ytOW48j8CxK4cY1CsJrE5V6uxnVYpJYJZe/YmG/75U5yt+GhtK0
         dLeMUGbLPC2/Nq5YNv7LnSfYGLU1kigOAwQEJGvUcGoPisR7MrE1OeJQm8BxySiE78e7
         4OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jrh4qRmQUJ/q2crYkL86oyhAjsetFbiilFq4gqr3q0Q=;
        b=AzKiIbFnN25x7RrqXiRnbU37lSUSrc+/hznWGEPyv80PMr7EdXREQGaJweDmR5gbBj
         /cNscyOZNgLNNhcA+9/JbSac+jEq+HdJyO2xNb5vwBksjB2qzuXFjByXNj0a+nXdLfBZ
         sERoS9lLBb6LAv1jeaThPSL5onauv/0qItYX7WpY1T7WzE71zLy1CzB16NdCyX+kBf+x
         Dnzzb7CWA24lFA5QaYWQvKerQDyzLUPMY43eTwrVhvwy01PrBJuoMbxXtLQGK7OlmIkG
         PjJZBQ5BYAERKkrseqqwH5T/hNXLp+WfK6PwbUURytBBxZBQqqXRSJmNHG9clQyARJby
         WXFA==
X-Gm-Message-State: ACrzQf3I61EsuO5mwXX+DIKJSieLR4JkE3sE06wj+O+J3xCWIDB3554J
        z0NKZvc1gJD4PnfAvPT4ltUtOA==
X-Google-Smtp-Source: AMsMyM6L+QLbgAo0uHKr0nyiFyYCIgXYnkUMDWWP6xNyu7162NORyWwVQJv4gT+qyCHIuS0Vp/VrqQ==
X-Received: by 2002:a05:6512:3e10:b0:498:f317:e57e with SMTP id i16-20020a0565123e1000b00498f317e57emr5178516lfv.328.1664011729227;
        Sat, 24 Sep 2022 02:28:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o7-20020ac25e27000000b00497a8f04905sm1836220lfg.251.2022.09.24.02.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 02:28:48 -0700 (PDT)
Message-ID: <0eef32f2-0092-746d-7428-983f10ad4565@linaro.org>
Date:   Sat, 24 Sep 2022 11:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] NFC: hci: Split memcpy() of struct hcp_message flexible
 array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220924040835.3364912-1-keescook@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924040835.3364912-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 06:08, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated. This
> split already existed for the "firstfrag" case, so just generalize the
> logic further.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/
> 

Looks correct:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

