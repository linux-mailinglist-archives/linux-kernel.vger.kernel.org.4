Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357AB62798A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiKNJwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiKNJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:51:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40501B9C9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:51:29 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g12so18409438lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvT8h/E8TkxdBRxEghX2zT3tz4XnVQnc/AkJAIw+E/o=;
        b=U4iX21QQXhXM5KMU1u5LA8FJ7CtQNv/8PssoggNNxu6oPNXsvmJXG003Qo0mOw3X01
         VYdMt0BgeVqKG956J1lVdtr2huYDkkZ8yQqc2U/9Yn1/zVTjyeKm5lzcv/9SGOnhWJXL
         Hj+ok9i0WIN20dNtGxjN2vyEeehFIdKFnR5FkUJAiZNq8xCyibnCcHaToEk1N7dCZ5B0
         h4Ol3lSxr0mWHMiLVh3SeEyqO6anbrMEVexnD3xHf1Rgxdn27cBwSpaBhyO7JUraMd47
         V8b2EwEAPKahFa92GeYU4VO/O6x6DnpDC7Cz8AjFX/JVx9FBVMvDvffvlxNMXlmjOBRq
         ELgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvT8h/E8TkxdBRxEghX2zT3tz4XnVQnc/AkJAIw+E/o=;
        b=JN4SVGJmPC/QWdNNIFgyCPn/hQOqAffnq3+cf1FKdIITDHSV3LInltAQKxcd7wnU0y
         5yncY/V70s/Np08FqzsaNDPDdyWu803Q08AmST71RXloIyXxOlyFmRk804ZRvF/89Rya
         tSpEcKNg4LqQWRUmhrYLV+7WgHRjzbCxLJYMMHsfrEbi9/gQ9ZTr35oMMSoMDelaekUz
         GyVTBQZ/B2DzhQqSjGT0vVuZRv3/vxP4fYYKEFYj9Aq7URRwMRnh3I97eNU0ow1jia9i
         6nbYvMtKW2LsK5TXA/x4TDPX/h6beRLLTQ0e+IVUg7Yb+uUbxYX9+F8fT/3jlnu9bkvb
         +Epg==
X-Gm-Message-State: ANoB5pnj6UjECr0uGtMYcOCSRFhqsVD+cb5z0FCMPhHiSK2nRjJbXJEL
        tAKgC9cu5njboqvjJFRn9h52nQ==
X-Google-Smtp-Source: AA0mqf5ejQfSqV728SIzQoTYjXNwN5CFalOYDT8JzKbcQESNDFhHBkFyc//2Zu+UHVRYC5NpquCyFw==
X-Received: by 2002:a05:6512:32a6:b0:4b1:4933:d0de with SMTP id q6-20020a05651232a600b004b14933d0demr3590777lfe.10.1668419488123;
        Mon, 14 Nov 2022 01:51:28 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 14-20020ac25f4e000000b004a03eb21c4fsm1748437lfz.288.2022.11.14.01.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:51:27 -0800 (PST)
Message-ID: <5170fdac-41f8-b532-38cb-eac0db634bac@linaro.org>
Date:   Mon, 14 Nov 2022 12:51:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/3] phy: qcom-qmp-pcie: drop redundant clock allocation
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111094239.11547-1-johan+linaro@kernel.org>
 <20221111094239.11547-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111094239.11547-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 12:42, Johan Hovold wrote:
> Since the QMP driver split, there is no reason to allocate the
> fixed-rate pipe clock structure separately from the driver data.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

