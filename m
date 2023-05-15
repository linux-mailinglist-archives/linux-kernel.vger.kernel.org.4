Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7764703126
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjEOPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbjEOPK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:10:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E8A2689
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:10:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965a68abfd4so2455487966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684163441; x=1686755441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4dnxS6bebPi30xTKUPU+L19vcnTGWL1fmevHJGOvyjc=;
        b=Nkwq2YIwWS6xvjHlLXRuxLoIL9KryOGpC29ZFtBRcKob5sCd+EWGTuvj/VSKIf+bi8
         GkQT5+afOwy0wJAi0jbL/2kyYGTiEBXp/PELq6QTTI0w0pENVL1G4XW8SPlOpKqYzSnV
         JY7+WGEZCPGQ6Fsl8nGw9UOK056dn+cn4GIjwLStzguiG/+bhWeEYbTA8IThyHiAgKIO
         ilcv2NnE9Zmyz+5qvUsMLqtDmpmWoVGZ3PshIWTpu66F0uV9OfS8Kl8JNTCVdWkMJTwQ
         Ur6GB4TcNciffZcZM1DQa3HM+qqlgkuK9s3liliV4bM6S9BD6aNRxpEnYTsmb/EnKiC+
         cV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684163441; x=1686755441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dnxS6bebPi30xTKUPU+L19vcnTGWL1fmevHJGOvyjc=;
        b=gANA1lvOy4TCWGW3pkUoPybJ/so0SfenRfOpWsVAdrNcHsJYY6TZ4dNTE5I8rOmowN
         uMn87jFDsfG7F7plJOTtmaGqwmD+rwwbL7lSo0Zqq1frrgDxEFZLEfWkP1QO4QKpEqjG
         hhEuzp+fSjvAmlb9P0hEJ3SjedVcbHig+bkIPLbtkjfXdgDicyVJrrG4HEePI0z/H7SV
         qYQ47HgcE5E45BM42SER/Sz7PMsphEJvphYjAZiueRPbMH+M34PreLOt4KFo3JBNMncw
         8UWvPYFvzCK+FSTEPgpz3kgJaORJ5HaH/zhH0/0xgt44by1aBK4smE5ioVqL7tXgV+K/
         Maag==
X-Gm-Message-State: AC+VfDwFr8QTdS+4OMKGq5q8GOqcuZS3WGijMjAJLuTzBSPceGZelLzr
        ra/e+8MWOvz1JP2BrSwF/dSr8g==
X-Google-Smtp-Source: ACHHUZ4uTt5hCbjW33/lWRj6gQsUI0Ta1IrSdDVfzipYmq6V6RjZMn6YIMulsQ6RaYB2frYhVPf5fw==
X-Received: by 2002:a17:907:3e13:b0:948:b9ea:3302 with SMTP id hp19-20020a1709073e1300b00948b9ea3302mr38985546ejc.1.1684163441102;
        Mon, 15 May 2023 08:10:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id og16-20020a1709071dd000b0096637a19dcasm9661939ejc.4.2023.05.15.08.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:10:40 -0700 (PDT)
Message-ID: <bca80787-f0d1-b42d-7e42-4c445f8d2ed1@linaro.org>
Date:   Mon, 15 May 2023 17:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
To:     Shengyu Qu <wiagn233@outlook.com>, Lee Jones <lee@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com,
        Martin Botka <martin.botka@somainline.org>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230426142740.GN50521@google.com>
 <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
 <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
 <20230515105229.GI8963@google.com>
 <TY3P286MB2611F5969DC0F3F11FB8689B98789@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TY3P286MB2611F5969DC0F3F11FB8689B98789@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 16:19, Shengyu Qu wrote:
> Hi Lee,
> 
> Why there's no news about patch 3 for my series and axp313a series?
> 
> It can't work without patch 3. And could we see the fix for patch1/2 in

You got feedback, didn't you? Patch is broken. Don't ping to apply
broken patch, but fix the patch and send a new version.

Best regards,
Krzysztof

