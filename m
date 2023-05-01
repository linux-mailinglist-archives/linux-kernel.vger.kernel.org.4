Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0440C6F3084
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 13:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjEALcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjEALcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:32:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C77170D
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 04:31:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f7a7a3351so483727666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682940701; x=1685532701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NL2MU/q3QR6APHYijTKYSuoIrTLKy57VWjk28xeYgrs=;
        b=I/hKeRmPOb0+DrLZH9/RKU6O/wSKDC7zHZ1zRHhbmLA5AEnI1/Jv+GX7F2yPZTaeeH
         wgdKb5MpD+Jx7eYwp9sCtVRr4dJLOfhW9hbfVX8x3kOH8amEd+U6VfTysa1hvVCW9cRj
         sYEn44sdlD+aVKFpOw4LrFFrl31KTeK/m6JjtCP9urelNylj7gLMllppAJgRicvw3YWu
         ebhG00cbYqkno0U4e+stAeaf97hPZILmcyjYS7G/iyekxnNMJW0KCBp0AaKkokft5WKI
         Mol7zWV0WRyY3UzIXEuNNNpKWI7+2J01ITCDkhGCGv/n2uq+NAyJntJZFYAjWN30D2zL
         VVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682940701; x=1685532701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NL2MU/q3QR6APHYijTKYSuoIrTLKy57VWjk28xeYgrs=;
        b=WrNQUDG066IpYsGU8/beKOLCy3WGFcw9JzB0vr4aW4MpcZQnMPUW5slSIKFVxZFHv5
         X35lHTEaN9t/75STUHjw9PMUrlyOXOeK/58Lywt2fahlRSDEjriCXF8fMWAZKA5rfTGj
         GYxlGtyUzDsF8Or+q20FDmxOrot8lPXSgmOLhk9FS67S6graPru32OkOT90zGuh1ZNAM
         VcW8goNWbJzBGjk/Tar2TNGAOJKsBlqktThqRGppD/3ZfM2AnztsHIkP84obGKR3Pjzc
         CwHP3PfwjriqozIouOAWRqpOl4zAMSty6Y6uRV/rUaqm78qyv01pezMQq/bExpOENtoP
         NY9w==
X-Gm-Message-State: AC+VfDziHK/28XUegs4WTUmntxRmm+itKI8JIASKs3lzc2nHbypaUruj
        y4Wl5hYllK860BihLv381CQypw==
X-Google-Smtp-Source: ACHHUZ7ELpwa7/HyRCAVUyymYSK+wLqDhhjPW3z7KkiKqTi3LW2F0EYf5zhwjeRCj3lgq+qUJryV6A==
X-Received: by 2002:a17:907:36c4:b0:94a:35d1:59a with SMTP id bj4-20020a17090736c400b0094a35d1059amr13319175ejc.14.1682940700775;
        Mon, 01 May 2023 04:31:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709062c0600b0094ef2003581sm14644001ejh.153.2023.05.01.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 04:31:40 -0700 (PDT)
Message-ID: <f106f0f6-f9fd-219c-4c33-a52ad0360db6@linaro.org>
Date:   Mon, 1 May 2023 13:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl
 states
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
 <20230501105832.1185477-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501105832.1185477-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 12:58, Bhupesh Sharma wrote:
> Add the default and sleep pinctrl states for SDHC1 & 2 controllers
> on QRB4210 RB2 board.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

