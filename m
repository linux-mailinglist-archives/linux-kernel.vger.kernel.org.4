Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC7F6EF580
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbjDZN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbjDZN10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:27:26 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC235BA9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:27:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso28479015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682515632; x=1685107632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNLBoeGm0DGvn60lh6VTKng50f10ssXE+mPMmGjHlY0=;
        b=Jyvm5UfmNO+PVsVp8ST7r9Z8VYKIm6lc4lXwlfanlf/je09SZ+5J4ZdyFCz7fVqOQs
         V2HrnOKbXl4QKHs0VdQmceE9gpG0iMWpyFC3fnl/xJ5OiQcStA4aqpaUJQ0XnVZR2F5Y
         71vgD4QFa2hso5yBt7q1P3uJknSGg2YLgacwa4Vc2KPIrIDHGW9RIcj7c0xgL/yAe926
         hfE5SzRHYoXER4MSiPOh4vDvaJFh2AH3GMOuQGnJ1QtzeFLKIvf5UxctUQiGgNAh2TZL
         8IcO5xrZRECBN4e51bvppBMrETt2VqVSiXlR8jNi98/QV5ABF9TH1VVJJGQvjZ9SOd9W
         gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682515632; x=1685107632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNLBoeGm0DGvn60lh6VTKng50f10ssXE+mPMmGjHlY0=;
        b=V6eyhZksS/3jnmUkb2RDibQIsa07y0SriGGEdkyhFlAsjvsghVfnwGjcojLv5T6kHo
         lPTLVq5EyPaS9XBluXWanzRxQ2scUubvnAMtY9vkd4cqpv1EhgqCLU2dtoMZnoqe4+YI
         2nvMab4CtnmjpDSQdqnnh1Gbuna0mkONr4d4qz8+HHSDz3Hb92nz6z+Eqkpbl+bwCaup
         o1oDpLbclTbFSiU8r+A1FhtiHaLh1sNXP+u05xP3I+fMLrh6fELh11FY+apU+bFrGWw9
         fUDHrLBzOiqNpIj4c6+Fa9HWL/I6VDvWxFoBbViXn506GRPTUFQbxqES2tzFtTV8ScFx
         XSNw==
X-Gm-Message-State: AAQBX9ffvozD5u1GvLj8Mbn4uiK0279ehaqD2c0IEW27El1e33s9dQzO
        KUm7L4p+MPpAGLFKTdv8ROHaCA==
X-Google-Smtp-Source: AKy350bUF6F5y/p2qsJGdH8ETViHNt6OWWv1GlxnfKf1+6yPtlboJ8kvQxNHapIilrlphDiIe9Lq/Q==
X-Received: by 2002:a1c:4c16:0:b0:3f1:9a5a:b444 with SMTP id z22-20020a1c4c16000000b003f19a5ab444mr10645939wmf.15.1682515632020;
        Wed, 26 Apr 2023 06:27:12 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id iz14-20020a05600c554e00b003f175954e71sm21482213wmb.32.2023.04.26.06.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 06:27:11 -0700 (PDT)
Message-ID: <da974b57-9eb5-9380-2eaa-174e1b6280b2@linaro.org>
Date:   Wed, 26 Apr 2023 15:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Missing signoff in the thermal tree
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <c7a60bcd-f7f3-49df-a209-7b6e7c3ce753@sirena.org.uk>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c7a60bcd-f7f3-49df-a209-7b6e7c3ce753@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 13:35, Mark Brown wrote:
> Commit
> 
>    2912d341800bb ("thermal/drivers/cpuidle_cooling: Delete unmatched comments")
> 
> in the thermal treee is missing a Signed-off-by from its author.

Actually the Signed-off is not missing but there is the email only.

Signed-off-by: wangchenggang@vivo.com

which is the same as the author name

Author: Chenggang Wang <wangchenggang@vivo.com>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

