Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AF669E63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjAMQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjAMQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:42:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8872C1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:40:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u9so53637192ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJVdNbcspSYRgKcM+ZFgG2N0c78b43lHtbU5PZvLY/c=;
        b=ulwENThj+zcdpo+u5T4tu64f4+W06KW0NjqHdP0CAjYD9E8fSI1hQypsyKelcd9r61
         46jTH6zAmtvuAvBSKaG/7ZPMCxRKzxbl5mrYqehx/jXXZRVfvxff3wr2PY5K5JsxucOX
         8GMnQpm68cc4n1KDhbH7ZdXnRzoyQ2+/M6ZmN8Kvl0HdwpBiz9x5yXWigTlfjr1qSvFj
         hS49OjE9b6NcUkPglq+pGqig3Yx1seb0VGCq7iH8vD8ZLr/x+gDzu5FdkycLKVE5c9iO
         fJZsAFldd7tDunxN8/cJ8qUdgA6F+UxNtRTdyzV6odu1lK80qarFAzPrXgt0b0ZOmJgi
         yekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJVdNbcspSYRgKcM+ZFgG2N0c78b43lHtbU5PZvLY/c=;
        b=byBKuEgrIXJH3y9ILR3LRCB6p8rQbx77f5QHt7u3HdRSDQMyJ1OZNfH/z1NxQri/9H
         r5ULeRWXojHsQtp/jybpyAeDoppvbe8iWTPrxNoPsO1XIb3Udw8vpaaPG0wmJtPoFuIJ
         sP2cgVa1L0O+9kF3En9epnSmGotgPFscDxmW1aUYkTGNciHaV6O1B2YSpIdsz0wHRLNn
         z28kEhHZpSo6nr1vOMA31d3o3hi6JxOJiWE0UhA+H1MQUr+zyWXdxt+jTSgm9cEuZsWW
         oUzd0Qp6O0nZ2wEJq9wWamjrn1l/yUq9rTrkHNHjrKyOiTX/YckTJ4t5aehq0JqeYEs2
         BT7g==
X-Gm-Message-State: AFqh2kqDUN0VSWX/e+5qwbxS73UWassaHoOEZ9AxEaUx6WvTdP2hyI6u
        QUr1je7MXS6tvMTmugzaJjltbQ==
X-Google-Smtp-Source: AMrXdXsA8YUB+S8/WhRiSWz78jje6iZC8vre9x5IREVMOmCpBFHtlYZ9jb2ekLpzYfGEmGc+nipcOQ==
X-Received: by 2002:a17:907:c30c:b0:7c1:337e:5755 with SMTP id tl12-20020a170907c30c00b007c1337e5755mr45064677ejc.26.1673628034205;
        Fri, 13 Jan 2023 08:40:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709062bcc00b007ae38d837c5sm8819902ejg.174.2023.01.13.08.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 08:40:33 -0800 (PST)
Message-ID: <823a9052-bfd5-3b14-191e-84f049a7693e@linaro.org>
Date:   Fri, 13 Jan 2023 17:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/5] dt-bindings: tcsr: Add compatible for IPQ9574
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230113160012.14893-1-quic_poovendh@quicinc.com>
 <20230113160012.14893-6-quic_poovendh@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113160012.14893-6-quic_poovendh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 17:00, Poovendhan Selvaraj wrote:
> Add the tcsr compatible string for IPQ9574 SoC
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Same question...


> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
Best regards,
Krzysztof

