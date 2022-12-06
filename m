Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E7644A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLFRVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiLFRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:21:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB53AC3F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:21:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so14847638wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNN8uk4LoV+h49kv6LcOlJpfohjdevi0JmsE7e599PE=;
        b=cTJUk+i7XUeEhmp/IiPt+U7G958PLg8NVYNJm+mTfjmHh+It3e0iAwPYoDczFNrvWv
         lsN1Iu27FFWXZfjQeeu41m0zQxSz1WYLAxdU2mJ5dm8K12zMJT5NpWXlIqUj0+cxkn6I
         LlPwug0inqRWq0pEK7pTlDa8/gHUErKh6nIn8su1AwbaOaPON6m50pX9bLkRBufd3/zj
         gpZ2aNGfYG1Pxv1kFdOn97kRIhA643dFtsICI6p5G+PVXy+26GH2hrWG1JIgBTSvt1iW
         7yIvk2sStuyQzofcY+lXuY+2o0BMkErrNdkNuThw6BpbbMu8K+bD0Bll+qcHEv7d1/WA
         aVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNN8uk4LoV+h49kv6LcOlJpfohjdevi0JmsE7e599PE=;
        b=IWZgBKFbdTSJxKls59qCcCJiMX6KbiMg5Mkg19ovMrKpXb/3cQ9EHLqU/cAP+v5TBc
         HHFW71vIpZzE4fXgHDHrPI8emw0LZYdGyp7WFCjcMv6RSK83NptGtL+EPENe1AKYFy2v
         HZmxKDBoQqq3iUBWO8XtQ3adNDWNNfB/kRwGkcM51IMuQEb4bvA8X43vsS4ZBNy5fKNN
         /3VzjgXkMnXt80bC288vqqY/6u59yEJqxpJzei+W3wvrf4W8VGzzJUu8yZrTRA+kKrrV
         NR+FV7883W2CFbVLx9g6lkhC5f6QezvE0FRrBksq0r6lVSIeX+g2z1BDuiDvcmn3Na+3
         A+JA==
X-Gm-Message-State: ANoB5pmZ7QDfMUGoNIy6PYycgaGMaUDdrN+LI3DO7ijVSWdS1/MWSjxU
        cLEDkmLfq8nx3K1W1CK0MdAXlA==
X-Google-Smtp-Source: AA0mqf7gm2xCP89/QOg/3k2lG5ouNJyby9r2wGnCo7mXF+hzuscgwBcgIIwQMgLouN3ahqN1GmnpQA==
X-Received: by 2002:a05:600c:792:b0:3cf:6a83:bd19 with SMTP id z18-20020a05600c079200b003cf6a83bd19mr56719834wmo.29.1670347286328;
        Tue, 06 Dec 2022 09:21:26 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d2-20020a5d4f82000000b002425dc49024sm7117374wru.43.2022.12.06.09.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:21:26 -0800 (PST)
Message-ID: <e0d9b932-79b3-47d6-529b-82b22639da3d@linaro.org>
Date:   Tue, 6 Dec 2022 18:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: use devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, rafael@kernel.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202211171409524332954@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202211171409524332954@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 07:09, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

