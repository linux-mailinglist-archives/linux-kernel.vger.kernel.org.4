Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC886C2A68
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCUGbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCUGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:31:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5196AA27C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:30:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so55481881edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679380256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtXq679OJ/FIrK3g3kVlHTX3gVojiUyZp+6IKIS7pZs=;
        b=Wv+1vqEObwxo9calNUYn/t+GawnEDAAY2hAeTEWRkc08odgZVVkgG5coS9Nw16L9Iq
         ekmZl2nCy211PXiDmqrB7Nd6H/D9O1HAf3x1MjUIk4k72fJT92cG/DlF/Lz9KeRqmkWE
         heMfbp5OAS1fhZY+PoQnorNueBZt3vjA12OeQT1ON1n+yi9fwSMeFl41Eb47SfTEjzSF
         k8cIJGN65zeDP6NPFXH0vTZ3ER5XGQVr1rIqoyAhfDTqpr7DoOo3TmFeDhH8MydePgVM
         gczTGFwBHzJhocLzxnn2K7dSLV6elaDlD7IGBeApmgi5G3/BUUqxrc+zvasA2BdKpICI
         KUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtXq679OJ/FIrK3g3kVlHTX3gVojiUyZp+6IKIS7pZs=;
        b=icJfEdHMHiyxuD0qScqx7Ud6kxPK9iZJrNTPrbfb8/yaMSjunrPUjrwPBoE2rGNP36
         3brJX08zG088exdNYoUiJMwFbILpykNdiI2wJb+bjM0nVpjj2ap8RfC8roE1ALLX3tti
         dE4vIgUjDPZZa7Wo7put9rOVzIUWczHl+PydLrKDrTn+IfQ0ULQdG7dFIafumz0B1ETZ
         pyUMmMs8TTaBpw17VJd6u9747645yUlTKAF6QxjMCKKGBkfJqgEQosvi4WhIhMTppCe6
         mbC7FFffj8NRHMdNbYGIOrSHQEmjSFdgszpb/wCaHtR9rE/vRs09kO2akngFAT3oqfMu
         oEhw==
X-Gm-Message-State: AO0yUKUJGOOnx1CKwciu++p9Nto98Z74YpeYxqnQWemQ0+qCZFq7PJSg
        xParliLbJ0GKxX+bgw5AXfTxYsobGW5YNoAf6A0=
X-Google-Smtp-Source: AK7set80LUNjh1G9EBpKWXI3imk0ddcLWMzDbfmPyv1UDsxj7oX6wfyLIRkqf2AUFM+irNnoQRYLtw==
X-Received: by 2002:a17:906:7cd3:b0:932:c1e2:9983 with SMTP id h19-20020a1709067cd300b00932c1e29983mr1560257ejp.15.1679380255840;
        Mon, 20 Mar 2023 23:30:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm5840271edi.36.2023.03.20.23.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:30:55 -0700 (PDT)
Message-ID: <ddd0dc9e-07d0-729e-2dc2-8a32364c56e9@linaro.org>
Date:   Tue, 21 Mar 2023 07:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] checkpatch: add missing bindings license check
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>, robh@kernel.org,
        apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com
References: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320203350.13696-1-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 21:33, Dmitry Rokosov wrote:
> All headers from 'include/dt-bindings/' must be verified by checkpatch
> together with Documentation bindings, because all of them are part of
> the whole DT bindings system.
> 
> The requirement is dual licensed and matching pattern:
>     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> 
> The issue was found during patch review:
> https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
> Changes v3 since v2 at [2]:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

