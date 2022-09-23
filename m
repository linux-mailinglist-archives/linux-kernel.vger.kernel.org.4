Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85495E793C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIWLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiIWLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:16:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049D13570C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:16:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j16so19304765lfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=imfixrLTcFv0DjzU/dBzDYnTw5P7/+vfO0bvwY3AaxI=;
        b=MoPAeC2L93mgPRD5pDgFVI6zu+tIfs/JI3Z5NQ5sk6nDadC/eSzT/hsTzjUOTbWEOq
         tOdtkpPuIqXaYzi6qUcbd5WMDaDx6qAsyOrSWU8pTT0GUbXRXG/Fgbq4NmyI9XESozAK
         0SMMy/CMOljs9VJUyp1n70p2iKCPrZXmAZxGKLOLbI4usnuKaVlDwZIW8iaM194o6Ahc
         UIr4yZiSx+eG2Y+L16RfslOBJHlOlvHOgxdqhXCF9U1O0ZgIvBeX9LXW9JwULrdJYDw7
         Hlv7soEyuVBmuKo8akucgCVfR5PrtrimIfOpAT8xh3qNdOSKBOLOqQjxRMpbeF2YN5wv
         L1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=imfixrLTcFv0DjzU/dBzDYnTw5P7/+vfO0bvwY3AaxI=;
        b=DzW3YfpRFROFCPm+doSTeweigYALi4rLt1KliQVcZA5PjdoRgpch3lq76uRc2L4O5N
         U24b6J411wjMT+WMfe+gQyxZM1lkPi+38nfXt5owrYnqd3Qwmta0aQKUmGKxwKdEpctY
         ZZ14hrMPTCRQGk2NLwKtsR2IXIPzuojmWttDJPH0ItHQv8dVLr2laJBRDM1jnhMc26kc
         oCv6kp94LZDhg+Uw5nwvetW1+oovuUbGCvzNlavpYZLocOJFvSV13ySlqIkMx+gZ5YGf
         ZcnMpRll3LnHjq9A8E+LLl8xQNlV5whVUKpu35sIgsTMmZE8+E0wsGP0rWKQR57B8lBV
         XdMA==
X-Gm-Message-State: ACrzQf14rFXNPSV655pb3a1luYSyYWKT5jgU3mu4vhxaC0lTYKWUMVC9
        3FRyfVQZPYmUiYtJjepH7lTzug==
X-Google-Smtp-Source: AMsMyM4gSgqslj/MXw3qZkhMqASVAraPUn/Jbo4yjv87pRK0j9zeCR2ZBNA3WHH91SMkygEjXeAtgA==
X-Received: by 2002:a05:6512:3d87:b0:499:f2b6:7021 with SMTP id k7-20020a0565123d8700b00499f2b67021mr2854963lfv.103.1663931790576;
        Fri, 23 Sep 2022 04:16:30 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g8-20020a2ea4a8000000b0026c3ecf9a39sm1348838ljm.38.2022.09.23.04.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 04:16:30 -0700 (PDT)
Message-ID: <33e9babb-0492-2f41-d055-45ed32d55906@linaro.org>
Date:   Fri, 23 Sep 2022 13:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: display: mediatek: dpi: Add compatible for
 MediaTek MT8188
Content-Language: en-US
To:     liangxu.xu@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220923014227.6566-1-liangxu.xu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923014227.6566-1-liangxu.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 03:42, liangxu.xu@mediatek.com wrote:
> From: liangxu xu <liangxu.xu@mediatek.com>
> 
> Add dt-binding documentation of dpi for MediaTek MT8188 SoC.
> 
> Signed-off-by: liangxu xu <liangxu.xu@mediatek.com>

Where is the DTS? Where are driver changes?

Best regards,
Krzysztof

