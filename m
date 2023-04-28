Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2156F1D94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbjD1RnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346465AbjD1Rmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:42:52 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8674212;
        Fri, 28 Apr 2023 10:42:51 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-74fbf99adc2so3118185a.3;
        Fri, 28 Apr 2023 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682703770; x=1685295770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIp0PfLYwbyf4Zc/oKnBGo6p7i0B4STZURLC1RcDcMg=;
        b=lbUslbnhnDoU8yHLKndgdczTSBHW6Zv1abaAwJegPSH4G0eI1l+8IRP10G9r9XqpLc
         7eb5tLmiRn/7AtKL5rrk39CHKUN3IHIt+Bree7u7CzvHiBodSjoCy6jjFVYGUTjyA3St
         v8F6y/NdmatQp8jAgZpwYx44GxB9knxUC04BTjCKjIJ+X4ro0sRzQSB0iWYKayjbvq7H
         tPo9j2LbzGTp6WiVMgtO0kg7sbIt//3SzRVon7GDYf/lVcJIuAX4hYQ+pcOywz7vmD6F
         dFP5cea3hp4dOamDwiDlRT0G82ghat1e/WFdd3/w30p2hDxINiQ23DQ+6vzBf0Nosh5o
         OQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703770; x=1685295770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIp0PfLYwbyf4Zc/oKnBGo6p7i0B4STZURLC1RcDcMg=;
        b=S3C/55MrWBSgHoWWxdfGjoeKMe9bBFM9kzS94MoM307tm0Ylb49cdsx4I59b8FYX1y
         zn1fIhWsgtHTTMpx69l5OoaFiL1Cj3RWgcNRtAeXxFQa2SBW9G/c6VfGsPRTNiHijVB6
         oHz6nrZ8g0EUwSRRlTTVioObxz/wz81nYpj6uZmShsMvQzrIasL/wOmlaPQlbq8fUgrP
         mOpYEGcy44AKJZeMPJhJo7VSGjGy0OkVpPqCfZuacxgCkOFVSE3XY/hA5S241hfvtfy7
         dmFt7qUDx9fIYtj/YSqgQs/9LsMKIJAT9UdHp+UQAczCKHo1Jq/Yr9XqKvJd0zHdphua
         Aq+w==
X-Gm-Message-State: AC+VfDz00Eegg3pS1cW56kO+kO4lmUzSoy/GW8GKJ7FgjpW2uVXh8O/K
        aCCMMO/KQUVLDSsYIPXuvog=
X-Google-Smtp-Source: ACHHUZ5d2qF1BGFPnOTR5Y+3K4+zazXVQL0g0Ke6qHkBcOBB5jpv1S1RhUNmDBF0RLcXZPeA+Ab7kQ==
X-Received: by 2002:a05:6214:5089:b0:5ee:f961:4b74 with SMTP id kk9-20020a056214508900b005eef9614b74mr9243396qvb.9.1682703770707;
        Fri, 28 Apr 2023 10:42:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id eb11-20020a05620a480b00b0074411b03972sm6857470qkb.51.2023.04.28.10.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 10:42:50 -0700 (PDT)
Message-ID: <31bf7156-36b7-0c4d-585c-fd149963d6ef@gmail.com>
Date:   Fri, 28 Apr 2023 10:42:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -next] gpio: brcmstb: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, opendmb@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230428061109.102343-1-yang.lee@linux.alibaba.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230428061109.102343-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 23:11, Yang Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

