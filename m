Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9536E619FF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKDScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiKDSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:31:56 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6C40917
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:31:52 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u7so3740056qvn.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jv/VBBSPGfDMm3BuvCUb6KeKn+DQzFUitFYwYAfTSbw=;
        b=Gf4Igk3vYjYVzOdyjeQvBR+wn0fv9jCoK2u94IZ9RY/2cw8nU9sVSyVIb458qMAPtB
         HzbKuLwRjp58mdYEnl4x7a15rlRVbqpxVdbzzaPcJ+jzYgrrIoaEoCTV4xoGgJBxflSZ
         7rZwl1NRDJVbJ4lTHJfPFdiu2AQCzPsSzJ4uqwQBxHbcLR35xgeCU2WO/yzxOSo59JoK
         QYUSGpYd2BvBoRleK2z/rA5pI+DS5s3rrKXLwV3Ii1zd5AXWDJjHuO8gsHqRg0xTgmYt
         X5yDUgA7ctHYiZimR/DjS+frJl9XuI40oCizh+kuxhOmvVA4qWBXLeOmsFLWSUd3P+wo
         EJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv/VBBSPGfDMm3BuvCUb6KeKn+DQzFUitFYwYAfTSbw=;
        b=bYy1zLStkFVD6xHKTevXYmwhMHr+3X9A/5OXIeJxgoS58InZSTOPhwk+F8BKBUUsPz
         9J/hpiusvpqBi+NGMBzmXZLbxogviv6J+er3qo2w8pg1JSyyFijRvhC+ClFIoqrK7lJs
         hLu4f1b4ydc9Jj4Z5atVCFSsqw3lLdTBP1Nzlqxqdz7yXaYLf9d02I6Unv9Lid0ZNRcw
         fUgeHqgf68kvY9AjD9CTwP0B8a7kPbHVv/c6G2w6GQmDwF2L/KkUk8BwhwiYbg1u5I/B
         R1S8s+2tlsLT0CNOt0jzwnNKAAeK4mBBgz0jBVxVzMKBeDSRS62/rbs3OpP0Vet5Fk5Y
         SPiw==
X-Gm-Message-State: ACrzQf1b2AGXVD/6WfxkXXKLtkssFOXsI25/DI4qRvdeLYGD4q3eGhYr
        wHOsN4rVc2rG7u4WH2U/frlnig==
X-Google-Smtp-Source: AMsMyM6gLeFy71nSxk2gT25tUnCpxV9lEYdESGw3HGK02z1+OuPJ6eKzIpdPlsMCVsuRvg7YFgwQiQ==
X-Received: by 2002:a05:6214:625:b0:4bb:ff88:a937 with SMTP id a5-20020a056214062500b004bbff88a937mr25108338qvx.111.1667586711697;
        Fri, 04 Nov 2022 11:31:51 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id i19-20020ac860d3000000b003a5612c3f28sm2333417qtm.56.2022.11.04.11.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:31:50 -0700 (PDT)
Message-ID: <5eeb52b6-2ac6-0cf0-917b-149ba442285f@linaro.org>
Date:   Fri, 4 Nov 2022 14:31:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/9] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-7-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-7-angelogioacchino.delregno@collabora.com>
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

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> Document the qcom,msm8976-tcsr compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

