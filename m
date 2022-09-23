Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D105E8113
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiIWRri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiIWRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:47:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A5614F83D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:47:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k10so1425446lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lTABx256oUVL2ZjGMhd78CKU5j+mrB0x+bRv7WFKIZU=;
        b=qTmbTfYZhgY6+DtMDeoFqIZg5SZ2wyaich993fmuHwFT+rTtNa3JrlTUbGg2FBzh+E
         ybgHELHGIO51fo33F4uQcD+j0t1wVoowdc8vB9W3S6jpxxRHstokrmsHtaLpRyYV3rEO
         EfMvCKH4L4TM99v+D6EONY8qpp53fhaWR6Bjlwge4JYDozZU+bhh3nENITvBQGlcP9za
         wGIlhhDDK+rCuH1HFFDi2shLvRryKs7OQqoV7S/JsrAEhJD3fzOOp/fXz1X10Xx1BD2+
         Hexgk40cIzxWc5nMmNM7cE9UqfT139u7bgx6wUeY1hzyWGlfEihzak3KR01CkbolEOPN
         JvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lTABx256oUVL2ZjGMhd78CKU5j+mrB0x+bRv7WFKIZU=;
        b=I+xY6RFl2kTxvewl3WisfMxydFwpOaMvAL2Cm9f7yRuKq/sq4jxb+YB7dbEnIIqz8s
         N2dbRsSsVwOPuAdsTyxtUxTYBmJIoqQsOpN6+Pk0qAiX3HhewPpjXicDUADvqaCL7KjS
         mIuvBmP5R/Eugyrt8/yXMFQFHgy8OUAt1+DskgKdQr2o8nrYgHs4ZdmoPMvgCziYNzfO
         Yzk5encooSi34d8slzZDJa6hfhyLloWaKqGM5e4VES2WXwYb9WmgnfLojZVRYBhZ5RvJ
         JyXFjSmK1lwy8uvNu2YONvzkwYsviGcX9oUIAblkX7g7ffV+Es9gUo38I29OiqRzQoaJ
         XyrQ==
X-Gm-Message-State: ACrzQf3rcRBiT9DnIZHIOOXwnkIshO4X3gVTf1LIx/T2YD+01dE6wjMq
        24ND9udJgJLXdz/r84Mr0uftlw==
X-Google-Smtp-Source: AMsMyM5dUbxsRMLwGgP1lNhkXKk3RrdWfbDCEqz5EvgWqieOxKXjhYSM2MNqJCYEUQuXVxTabxPXQQ==
X-Received: by 2002:a05:6512:1291:b0:499:f9a0:fb5a with SMTP id u17-20020a056512129100b00499f9a0fb5amr3589935lfs.129.1663955252728;
        Fri, 23 Sep 2022 10:47:32 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f12-20020ac251ac000000b00497b198987bsm1545671lfk.26.2022.09.23.10.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:47:32 -0700 (PDT)
Message-ID: <c86948df-1069-26e3-b4d0-725a804cf88b@linaro.org>
Date:   Fri, 23 Sep 2022 19:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] dt-bindings: mfd: mediatek: Add scpsys compatible for
 mt8186
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
References: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
 <20220923131148.6678-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923131148.6678-2-allen-kh.cheng@mediatek.com>
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

On 23/09/2022 15:11, Allen-KH Cheng wrote:
> Add a new scpsys compatible for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

