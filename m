Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37289665822
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbjAKJvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbjAKJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:50:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0D11A13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:49:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id co23so14454610wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5UTkJXjloBGekLVRDZ7QXDVwLg1lqR8XsOo+O7z1x8=;
        b=RHY6EdsCbQmNMYzKzRptGo5Ellf/+tkiujkhtRQdnhXnCTYUaSEj5hNyKF6KSINcLG
         fGdMDqcRRdN7UiaL/IeL4UlZ7isq7t6C76XP35C/oO95MzDA69/Ta//RUGajV6Ry4fPv
         sPfY+gZ/qF6XknseVnO79ulIJ5idm4LHktK5V9pDcevHwMII/UIDt4veTXQPy95+XWTv
         N7DK1H/TOngwOSOSpEn0myvD7f3WHjJH7dt29oLKTk7LtzYSKI81klNAT7ztosmyPKXY
         IZCbyzD1xNHVcj/TA83Dz+rk/VGw5K9o1GLBChq36xG0b51IQNhphZmgrmDX8aFC+Iqx
         qHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5UTkJXjloBGekLVRDZ7QXDVwLg1lqR8XsOo+O7z1x8=;
        b=6bUgM44/e9IMqydPipG/WDjwaqNlFzp/83LQmFv1nA3T6n916ApD9+VRsGJmkooJWE
         pgkuwVe7aIrxgI0YNSMtTj4IsfV9/J4R56OEUur6OcRm5wH0HzojtVXYs961JxtY0MEG
         CkZW5HwOGfTGNkw75pvanVBmurbPjwaVDxH7AMy5pHaYP1dbzW+uzolf+l+CjHYizKhH
         G7sojI9BSMGJEViLpEO/jDlxSKKZZXoMXR053V/psnVPUwbtUEbDVBBpW+zdYLEFWAEA
         pFu7V0MmRRXs7jSmuUsm0M00AR2GoISBRWqnk5acOdu4QpTAOsefm/QFTn0JfsnLK6Mp
         Boow==
X-Gm-Message-State: AFqh2kocpSvcB08KXPXPsXG3RY4LfND2wvrRNGevXoCatrgbD6dRWtSr
        21XLl8KXcGsHS22/aMGvCNma+g==
X-Google-Smtp-Source: AMrXdXteYQ4OHRd8SBeI9ZE1Weg4t+gmpyD9d9ms5k0M09eAGsByHTI8iRoposVi0flzbo4VWjY9mw==
X-Received: by 2002:a5d:5a04:0:b0:271:dd0c:8665 with SMTP id bq4-20020a5d5a04000000b00271dd0c8665mr40996847wrb.62.1673430573258;
        Wed, 11 Jan 2023 01:49:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i10-20020adff30a000000b0024228b0b932sm16119123wro.27.2023.01.11.01.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:49:32 -0800 (PST)
Message-ID: <7a795adf-3ceb-1c90-c723-22e4576a524d@linaro.org>
Date:   Wed, 11 Jan 2023 10:49:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] dt-bindings: input: microchip,cap11xx: add
 cap1203, cap1293 and cap1298
Content-Language: en-US
To:     Jiri Valek - 2N <jiriv@axis.com>, linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
References: <20230110152859.295881-1-jiriv@axis.com>
 <20230110152859.295881-2-jiriv@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110152859.295881-2-jiriv@axis.com>
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

On 10/01/2023 16:28, Jiri Valek - 2N wrote:
> Add support for cap1203, cap1293 and cap1298.
> 
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
> ---
> No changes since v1
> 

Really?

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

