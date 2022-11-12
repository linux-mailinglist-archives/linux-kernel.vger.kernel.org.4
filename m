Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696DB626774
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiKLGU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiKLGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:20:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F9E2BB0B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:20:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j16so11232978lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSHCyJW/WKrtroRPB27Mpcv1HvzmA++gkg6zKF4rtMM=;
        b=jPshzJXAhKwWnhsY4+cTKZm9bi+KfBS///w5x4Bay1iZUYk2d4eSY1HR6T5zuVJUUT
         X7OOs7SOTzRG1mrUXBGFqL/PbjeBkJEh7c0mx67wYc9u311s/Jr8VB6MzOhA/aTmu0cW
         FulkVPUutExORE0bNk66KyDsdtIYobFRXeDhH2oNJ5lp3vc6NzB1QqGWACD1RJv/5UNh
         ELZCJXiIvnPG6xRQEUJoz4EccKaR/PsWw9m41Ke8xhC3WatfB1QqGIWHjBxst1IXPoDv
         OuR/DreTK19BAYXPXjUFUPcWxUM4uzB44jYgsRKxO+mYSmkH4TuvAvlQcDbb38EX0C2e
         ITQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSHCyJW/WKrtroRPB27Mpcv1HvzmA++gkg6zKF4rtMM=;
        b=dz0Tgx71npCSiXhKz0irqTdOF5+JhMKXxwKRF0GzkXZyjbDRZbgFdsNz6tb0xmnO2T
         3ODSrZvM3yvLvhHZqC56P1R/RhVkszIHl21bZ5K7lUqySWLTpaMYEh2YO72U6zIjiPr6
         BR3CSuG6g1hL1fwxCjvDnzT9G1NGKsSbNejjN5Iprzv7N8W9j59kgH3V06OBxCNn3FQ8
         kS5FbZauAGRoR6irgQlVSMPfkWSn4VlWwdsmMmCsHiNQmmiG84S/ElXActzkXuskTt+r
         WOak7JlFYKf9g0/zqyHByCknW8j+4wX2pyZ1yLDhQdjaTDN9iQ9F82mP4pgPb2hk5JO6
         Qh1Q==
X-Gm-Message-State: ANoB5pk8cpJA20Mt4wgVETWx5F9P6DuaRXfjuPfB+duGBnquC2vANgQi
        ZQv2AjWpHJUPPi/O5xqLdZeXYw==
X-Google-Smtp-Source: AA0mqf6PhN7VwzvnKs8hYhV5cIFdgzWCjX9hJIYz4X2ijUJaQ84SCIg1OHn+mY+caZMl2mX3j+ZKXQ==
X-Received: by 2002:a05:6512:3490:b0:4b4:6ca6:c669 with SMTP id v16-20020a056512349000b004b46ca6c669mr1628892lfr.338.1668234022820;
        Fri, 11 Nov 2022 22:20:22 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z5-20020a2eb525000000b0026c42f67eb8sm763665ljm.7.2022.11.11.22.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:20:22 -0800 (PST)
Message-ID: <afd6f3a1-4106-dec5-3e97-ec7f4a8e8129@linaro.org>
Date:   Sat, 12 Nov 2022 09:20:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 06/22] phy: qcom-qmp-combo: rename USB PHY ops
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-7-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/11/2022 11:56, Johan Hovold wrote:
> Add a "usb" infix to the USB PHY operation functions and name them
> after the corresponding operations (e.g. "init" rather than "enable").
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

