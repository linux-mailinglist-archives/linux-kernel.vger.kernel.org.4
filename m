Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDFB6ADA22
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCGJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCGJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:20:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A9B86DCD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:20:01 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id da10so49639439edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678180800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzQo7ACRtABeHVtQ4D7zqYvAtCiwC9n8/XfqHD2Rxc8=;
        b=FSvUJkm4RPpLhAHF8QisYObMMowi0+kIX2o0u0RvT2huAi97xCjE0PfI6PwnO1QlRf
         Zl2Ppb2i2/nAIr4+v7y5FmgWyvChaOA/SY2y5vrYpUuzwXiWWfU9n8o3aIb3wBaZVw7V
         auGH9SwatTumL9n9cK6l6KJ/5w0ysUdQArFUSR/7DTUfeIYNY+wDjUWgqySK/vxAHNTP
         bP+/ZbWwXGFwmDQw72i7RT/fkpJuuzxixO5HwYh8KfF0M3+X9+fZ8rNcPj7tHVP2Nnhx
         iZF3QQC2Unf7B+8jrCJAeQsHfO3c6Fh2AdWZ9ioVRYBnWJXgT4eKkZpDooKRiPwSugdK
         xqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzQo7ACRtABeHVtQ4D7zqYvAtCiwC9n8/XfqHD2Rxc8=;
        b=7s+B1nS60VXFOTW4+PegSWlPOUJ0uYDPgB/NTCfCnv9CZnyrENQCYOhD+tMv1wkGU0
         AnnEkTXvDN2Oe/le9HdUHCgLKEUySpxTehl34iiiEihyI51wS+uXViXIHZhseL+c384L
         lTJVFJw+hJm79mjVibW2dJcRBYpAtli3wsX+rod1AQv7z2k8CEZciKGU2943RYERu/dD
         0fa7HPFD0kUbP4kDJeQfGh+oJ8rwg2sAOlJo8RVaIq1M4Ok67XrOuS5o21ZfbF3tY60m
         /d4RsCUqWU7Zt08fFKS5BMojv6tEtxu8F4xPy9oQrxCJxmHC3tGexmahZQ42sTO6bZ9E
         ETpA==
X-Gm-Message-State: AO0yUKWGalqiAnfkyVWU6mcPVlsBv3IwXjWaL0S9fVlvjQbjI98pB40c
        ZYyFbekqD7BseyaorwesDL2zuQ==
X-Google-Smtp-Source: AK7set98ksW9rs50yKitdSxLDce6QStPj3hvHEQeoO0MfL6r8ueGUAWtmey0LhC8oeipnH4yqo5uIQ==
X-Received: by 2002:a17:906:434c:b0:908:6a98:5b48 with SMTP id z12-20020a170906434c00b009086a985b48mr13239479ejm.40.1678180799975;
        Tue, 07 Mar 2023 01:19:59 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id v30-20020a50955e000000b004bf2d58201fsm6399243eda.35.2023.03.07.01.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:19:59 -0800 (PST)
Message-ID: <a81ee827-87cf-e7ea-8e91-e8d790a9984f@linaro.org>
Date:   Tue, 7 Mar 2023 10:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] nfc: change order inside nfc_se_io error path
Content-Language: en-US
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
References: <20230306212650.230322-1-pchelkin@ispras.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306212650.230322-1-pchelkin@ispras.ru>
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

On 06/03/2023 22:26, Fedor Pchelkin wrote:
> cb_context should be freed on the error path in nfc_se_io as stated by
> commit 25ff6f8a5a3b ("nfc: fix memory leak of se_io context in
> nfc_genl_se_io").
> 
> Make the error path in nfc_se_io unwind everything in reverse order, i.e.
> free the cb_context after unlocking the device.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

