Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EED76C3492
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCUOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCUOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:43:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF7B29E32
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:43:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y20so19449971lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679409784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7BDMNV63w/nRH0IlJ+LWLAMT7WkMKpel3X2vIkr+GE=;
        b=x7FEFvjPBZ4mJtbAdKPWIObXN71LRfNoK2qzcgzNz8wr3GEdJQF0hvNinmdtsGMeTy
         AJ2l/FxZXwoA75jz7CZv4DyIXaUSfwlX6R8QrEQyl859yjCsVFC/MTQ1gNMIyhylqk2P
         gojEU9aNix33lW8WNIWSaj8T4o0jUqwgLFCKr65pAAh06s/jLzReEBklymAMKUK4S7jO
         MooR6JWs2obroNOdZNAQIliRfhfr+hqPZw/nQ4kSVgfWDqpgLg5KYKGJjXQQCVqy/wxJ
         TxOeU4QMPqRBGq4Wvy7mCCyWK/X2cxqsChD64C4QxzzzlwOgv3V23EPw5QJxQYo/aO/p
         /yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7BDMNV63w/nRH0IlJ+LWLAMT7WkMKpel3X2vIkr+GE=;
        b=U/7EVl8fP2VE+So/dgnoQcIh5hU8Ihd/1Zz2bMCBF4eWwek6ZGv1txlARRZhUBVdM9
         agYNy9Uia253ESOW8bxotkB1Oq7EcpwWYseMWQie/u2JuoAt3+PxDdIk/ixfIoKVH/I5
         g+fq9IgLDq6rZyz+UUMyUX/kdMFK98NksdioxhD0hiWLAW74fmNbHAKGDDkex4ai6TC9
         lJ5UA+quvLyvI9WIyk/XeiZ6H41PXkJ6KSk8RPzVXSuft1GcOUe+P93AIGajvbAlaMo4
         5t9YWbE7GMG1+jNYHZZKRawA+eBHA57Uho3+bDNIz488HX8ieF4HtCIGRT81itvIO64K
         y19Q==
X-Gm-Message-State: AO0yUKXY1JYQURI7aaAK0CxiWf9zKD4GRbRySKqWzphgPSX2TcpXr2os
        Nf++5yoD+xoSUgivU06xcyeT0w==
X-Google-Smtp-Source: AK7set8NjKRaOPlkE21loVh+PZamQ3MqDcldA1NP940LXjsMxXnonUwSonjFS5j4YSrJ8Img293jdA==
X-Received: by 2002:a19:ad4b:0:b0:4ea:e779:fc3 with SMTP id s11-20020a19ad4b000000b004eae7790fc3mr777391lfd.25.1679409784538;
        Tue, 21 Mar 2023 07:43:04 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512014100b004d8729d4150sm2187363lfo.145.2023.03.21.07.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:43:04 -0700 (PDT)
Message-ID: <34bac508-21b1-a441-0987-6b5b5be0bb08@linaro.org>
Date:   Tue, 21 Mar 2023 16:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/10] drm/msm: move include directive
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <20230306100722.28485-11-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230306100722.28485-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 06/03/2023 12:07, Johan Hovold wrote:
> Move the include of of_address.h to the top of the file where it
> belongs.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/msm_drv.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

-- 
With best wishes
Dmitry

