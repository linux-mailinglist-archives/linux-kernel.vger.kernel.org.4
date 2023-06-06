Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39512723CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjFFJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjFFJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:12:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3210D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:12:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977cc662f62so402256166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686042759; x=1688634759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3WN1je6v4B4Dvah+zjLHAtCz4SeNWd9ZpzLJFhz44Q=;
        b=xORk5DT9KXqk8Oic15QijshMr0gwFZmqB7cqA8dBujZw3oPsqLgsFbKkfbsU4QEuQG
         sqNATiGB9L/OBSPv/RHIZiNoSeXkVd6wHmQptWBXbPyCdmeVmJzvimKg1v/0PTg37PtW
         qMmsFIfkjwjOXgndEmL4dn6ES+LwSuVv27c1spnDKqNe3SG9oYcSGXQW5ftBfBBxvsNO
         o4Kb4COcvck0Lr9g2LSexTjXSmLQPIZs/mFK54Z01w/zf0aXmhpAlF1YOoYBnr9xcSX9
         aWZz8u8ta2VZZ8WcDNT5nVlISEwtpmkVhIg4O87yKD33zmXuvC7u4ZG11tIV3iK7f0GV
         E5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042759; x=1688634759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3WN1je6v4B4Dvah+zjLHAtCz4SeNWd9ZpzLJFhz44Q=;
        b=RaE98lyRcmIbVTY+ZfRI5Mf1IXgxxF8h7Q1gpea82zb+DKHXobb8eAlUG4gIkzQoMT
         aLTj7ed7ONYGwjeYnCBAoKeSf8x6B1Bz3C4AnH0ACVFzsbDLHnEJ++/YY2odoBBBaXtf
         LK6fBrzVcsXhV16ZG7kp6i3rSMUwYL/w9JzHBYtKOPM1gtErX8dEGYEbUtVhTmv1q76F
         oCO+MFz3ugEgDKAYpJigId9+AO/F03wTROhOkQucHKrq8g6uGUMBNL4LHX79fxprM9ch
         3wU4Qb1Q9gzGmRauNGZdQo/Hfzl/0cr6+f+ADZ51BMaK1iDmVmbzMk2KjybY7gNR5h4I
         rY+w==
X-Gm-Message-State: AC+VfDxnGDjSd1WqhDoJXIlrZ3znq+0eeQHSIeFPCu9Musnwm8otd59p
        tEGmcLcLqT+UVKjr1hSCpob5UQ==
X-Google-Smtp-Source: ACHHUZ6ER8OjzrnPiGlDlb+vJxPIK7gi5+1cw8bK+nT/iVLmBBhNrj/mWq7B9+5jEP67rOmqYqiL7A==
X-Received: by 2002:a17:907:971b:b0:96f:9962:be19 with SMTP id jg27-20020a170907971b00b0096f9962be19mr1627304ejc.31.1686042759160;
        Tue, 06 Jun 2023 02:12:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bo28-20020a0564020b3c00b00514b1d2759bsm4784634edb.42.2023.06.06.02.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:12:38 -0700 (PDT)
Message-ID: <5d911f83-57f2-84ff-2cd6-d7979deda7f4@linaro.org>
Date:   Tue, 6 Jun 2023 11:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/6] media: dt-bindings: mediatek,vcodec: Don't require
 assigned-clocks
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230605162030.274395-1-nfraprado@collabora.com>
 <20230605162030.274395-3-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605162030.274395-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 18:20, Nícolas F. R. A. Prado wrote:
> On MT8183 it's not necessary to configure the parent for the clocks.
> Remove the assigned-clocks and assigned-clock-parents from the required
> list.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

