Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F667264E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjARSIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjARSHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:07:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75330305E5;
        Wed, 18 Jan 2023 10:06:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d8so5438161pjc.3;
        Wed, 18 Jan 2023 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxGr9rOjQ2yaqoiQx0FCZlVaS0TlHYkQlc1FA+WU8H8=;
        b=a/BjP6c+RXvAJ5fpcIIE7Z3Df2XqmGu0WVjZhlCP4QZweEp1D6ia0ryuOes2T5daAG
         XypMlmzfAo19fqgw93mdtd4ekji3zoeJvxtGm8bUA1It609G5S/3qTzvQ243VF6UcFjl
         Ht+u1xSsmRzlBMY+aIaI4zuFJ1jc4+WcZTM5bYxpnJPd8L8EaSXaI0GcXZLEqMcBAvjc
         3+ba7eep3kAcDT8yDp40bK9hsP5tioL6C8dN+ndXdTLQ80hQPsaGKI9Ds6MJ08lYPCwi
         Qc0pone/sWpfxcmRHAOWvuu+kkejlS1oF/cJPy4nGO2O2fd0maHt5WVJniL1T7AAI9L9
         GRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxGr9rOjQ2yaqoiQx0FCZlVaS0TlHYkQlc1FA+WU8H8=;
        b=Ix01Jcmwgb8YZxGWXY5qXs66MoOQ6C/A70XxOa1suYtZcgRRjm0zdqykaeFF1AouYq
         AFa3hVJyUcRNYIR3PF7t3oEfCauPo1Hk9v6la9wJHm3JWFVLXagWAfjeemvshRG8DLqj
         yYUmLGiKb6SpO982ij+amKc0FEATfIX2gyIM7qZp3prZc/3g2Iiis4ge3TnV9Y8v0e1p
         +vnNj7c4Jovu6FH+2JOIS8JpDrKGAHdwUWHz+GcZBP8U5MOBK0SJgVkbhzAS7+nMgKwu
         bbCl0DYSuKBE30yLMr0SsbnxFbryPnGATKBsL2QxXcnoiC8Less1Hy2a5SCGWzEEEguw
         MZZg==
X-Gm-Message-State: AFqh2kqpfUHM4Rs6elzY/W80QowBHEnvIx9ARh++tJEh553/cKJMuzyA
        E5LQfZIfbkVaSAYxcAAamrSgX3+3Ucw=
X-Google-Smtp-Source: AMrXdXueiL3W/Jezt82y5r981JYjbBLjAmeVFwgCxnME+StrfxNCm+8TTZM1Gs1onLkI/fGuwOid0g==
X-Received: by 2002:a17:90b:3c0e:b0:227:1c1e:7529 with SMTP id pb14-20020a17090b3c0e00b002271c1e7529mr8356052pjb.15.1674065213863;
        Wed, 18 Jan 2023 10:06:53 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pc3-20020a17090b3b8300b001fde655225fsm2786736pjb.2.2023.01.18.10.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 10:06:52 -0800 (PST)
Message-ID: <2746ce9a-c44f-167d-7d2f-5dcd838af1d0@gmail.com>
Date:   Wed, 18 Jan 2023 10:06:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal=3a_brcmstb=5fthermal=3a_Use?=
 =?UTF-8?B?wqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, daniel.lezcano@linaro.org
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <202301181631362083446@zte.com.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202301181631362083446@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 00:31, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

