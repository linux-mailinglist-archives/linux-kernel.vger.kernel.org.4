Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5398734BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFSGTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFSGTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:19:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C339B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:19:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-988883b0d8fso167903266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687155568; x=1689747568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUK8dSl71LkLklLlosa67QeZlhaF4m6sTso85fZuDbY=;
        b=yPmWAUa/KjJZ5fhG6S+ldz4gIZQvoW2zGXupl6aNt6gAcLENYZogsLSjBORGOTgyC7
         TiuswjeJ1+muRQQraWW6aW8pi/1aOOwspJ91CQZJXBpS08uWb7Qxc7uTyV55SEMii0bM
         Q2oBcb9uustXcetR8X1/+7Jtnii779rzY1NlFYL1H3KGuIlAwl2pYAlHA6upmJlCPfHI
         MKVfpDMQeIA1ARIOQCYZAcA4MMzHA/uiRVvTDj6rQSOUDMVGZNgVTMrtcNIUfhH285eW
         FUskEAHwp9myHWSaCJoKiLa0w5rEUJvHaLWAZ1Udi3EkNL5hmAybN72lt1dlgdvgwGQx
         zjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687155568; x=1689747568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUK8dSl71LkLklLlosa67QeZlhaF4m6sTso85fZuDbY=;
        b=CtKn3iGNHCkC5Y0c/EJCZuu24jT2mWiUXlSbnBQgC2aLDJzTWPsfgprlOWeH60J6LI
         4Yf5SwCbOgGyazlnY9kbqCdV8vScTyOA5ekLwk06EBirn0WIGFw86KEBLyNQChxpo8qz
         VAF4hj65KoUctCEUeXDUQcqcPxW6V7BFfDYIvN7f/0prwGoCka8yyvEbKGJbTJjr9a5/
         5VoFJae23O1Zr46Jdpdn8KeQCSyYySigXojIVupvF7R6lnE/CnieuylpcKN8Y1y4B/Hq
         8eeH1UdAFYnXAohpDNe4SL3+CGOSktYtNpOiw6f3l4VBPjPvgxY9KFmeJgqekv5J8IBh
         5Msw==
X-Gm-Message-State: AC+VfDxIvMIp8Kd3ykQrP3vPJcUk2iI97mOOY37qlGCnPcigWJDFJFwl
        yfjLKOfHC563wwTOHAY1CZhdTw==
X-Google-Smtp-Source: ACHHUZ6OF2c/jqFmm4VkySNlU9SoxjzV70HZfWaE631Oi96Kdx05GVlZ5CwzTbjl3aaiEGU2X+DejQ==
X-Received: by 2002:a17:907:36c6:b0:974:1d8b:ca5e with SMTP id bj6-20020a17090736c600b009741d8bca5emr7575145ejc.14.1687155568140;
        Sun, 18 Jun 2023 23:19:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906684d00b0096f7500502csm14222118ejs.199.2023.06.18.23.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 23:19:27 -0700 (PDT)
Message-ID: <bdda97fa-6b19-324e-b244-8088a149cdd8@linaro.org>
Date:   Mon, 19 Jun 2023 08:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] dt-bindings: timer: brcm,kona-timer: convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230618144635.GA22166@standask-GA-A55M-S2HP>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230618144635.GA22166@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2023 16:46, Stanislav Jakubek wrote:
> Convert Broadcom Kona family timer bindings to DT schema.
> 
> Changes during conversion:
>   - drop deprecated compatible (it's been deprecated for ~10 years)
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

