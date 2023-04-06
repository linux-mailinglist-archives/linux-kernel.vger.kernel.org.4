Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08BD6D9EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjDFRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbjDFRjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:39:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C387ECB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:39:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sg7so3228042ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680802741;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLr/157pDr+V63ARgidHtbEbDJDZaN+vcg4GWMu77Rc=;
        b=MrnltUbOhbxKlsGbj2Z20Wo+gnrLhLq/+dRUzjDW0BsRL2/M6Gs4XS60EtVYrG7vzB
         RUwYJq/m9r1lcP/UBbfPiCKX9ZBheMS1k4UaZsOHkNHBYsxwxDVWqf3xwxHDuLSSClwP
         +wkDxNajn2L7/OUMjq1ohvJfMmbCGGsjNLCwdiNb7WhQ/R3jtP1EtpA9+eKSE6+UxwPN
         K+KlNciIV6yMc3L2e3D0N9WfBQvYxWe3rKl2DmWaaz+2Hx+yWP0TbSkWhaiGd3ZbjlX3
         BAwUpOOiow4moOGqFiLdciqnJtoI6eHf2PrCy2B+WyJzRqNzHgcdYwHxsT4zwsyb82Ly
         PqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802741;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLr/157pDr+V63ARgidHtbEbDJDZaN+vcg4GWMu77Rc=;
        b=mhXi9sH1sVqfXRk732CstoPgNsoyB+wGRLy0MyEYkR1kCx2cSGXRE8+RWJiKI4Te6X
         +dBQWE3A5r8Rhz3RBGgufW2if+K3aDvFez8bGG4eD+WhKmOmZtwb98KI7C5D6BGvLlTc
         3qjvC884LmeXZIZLy97PQ505Cuy18GfWIX3z+nasFXIrF2r2ZHaPvpcsGpp5Onj6IO/v
         IQ71uTvLQ7slV0wsfTRDzOhclL2/AFVa3d9J4I/eMcKphaLZ0oAMiSH6xZ4C889ZsATu
         J+1RL+mNnn7VQ2/bJOHOzlHNMiOlaz2QPUwzHbJSLieEFtlGWYmc2T1OckSuFXp5mnkf
         NH5g==
X-Gm-Message-State: AAQBX9d6HInG8htB76If7D6zki4Lf3oKuYalzcdbCj1RFn+7n+k2C0sE
        WqeGu8e1jt0h0a71amhRo0FFwQ==
X-Google-Smtp-Source: AKy350bUAKfSDPCFnkHvtg2+71lCEHWPAyIRPaWuaKdCd6RyLlB34GFlG96RVwN5DwOH9pC+pXWDdg==
X-Received: by 2002:a17:906:4555:b0:932:3d1b:b69d with SMTP id s21-20020a170906455500b009323d1bb69dmr6893960ejq.47.1680802741214;
        Thu, 06 Apr 2023 10:39:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id qp4-20020a170907206400b0093048a8bd31sm1076086ejb.68.2023.04.06.10.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:39:00 -0700 (PDT)
Message-ID: <e778a869-6aa6-a38a-45c1-6e932a583169@linaro.org>
Date:   Thu, 6 Apr 2023 19:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8711: Convert to dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230405205820.6836-1-danascape@gmail.com>
 <24c505df-9145-a515-4b68-aa5806916430@linaro.org>
In-Reply-To: <24c505df-9145-a515-4b68-aa5806916430@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 19:35, Krzysztof Kozlowski wrote:
> On 05/04/2023 22:58, Saalim Quadri wrote:
>> Convert the WM8711 audio CODEC bindings to DT schema
>>
>> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

And a bit change of mind - please make it one binding (as my comment for
wm8523).

Best regards,
Krzysztof

