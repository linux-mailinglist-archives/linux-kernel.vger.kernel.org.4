Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116B26D582C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjDDFsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjDDFso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:48:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A71713
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:48:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fi11so2446513edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 22:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680587321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFT6IXN6PaGwozBWnj+vlreMrnoSTPvDNmEflqNWMF8=;
        b=za43rz5tmdMWbq49OjteZ33/ozPFMqpB/iR/ogfLLEIchWSl3vff+h+iR2Bt2mQqLq
         C7Ye32RwE8nV8Ueh5qMFY4jirg5WU58gUd+KJM6oqskADo+NQa/DQ5Xla7ZTr2p2jwyV
         k74XUrfAhIMeEIP6K/1aCf2pr+IuJ9XpJ9c3bqkD54jIh3PtF60ECVMEqDwnxqAZ8zbQ
         CTMLVqBDv/Xryi0NmDyDBwWKp/Cjp4FqLV9pwwuKQ1JXHNExvmB0Rf5tedfQsrPBr0xw
         GMn/md0LtJv3GGRSnYbdL78pIJSebqOF+fJOY6sUGOkR+QCBHoiyuQD/7zhoySzCNUpm
         GqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680587321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFT6IXN6PaGwozBWnj+vlreMrnoSTPvDNmEflqNWMF8=;
        b=qNZ6UYBguPCnHgRBG3nQf3U9k1ZRcxti/83EgTg+blRHxOP1pmcEtEOsnlC6IV89/9
         KdSttB/s41rS0mBwOrm/5yON4FX5W59+xrhQpnBteE/wKPjlLEttNOzQQRq8b+PDKniS
         Wmw6qAOZOIj/Pm+WEnnhaV8zNtMLA/23Pm+kxmV3ZQ90YknLU9vlsrF/Z/wFqvvnyNa6
         IQFOPN1/25f1FHP+q8Yaa7ElxZ5j8VMTbEXoV3Fg3DiHmOMO8qfBdUMDnWOljHZXSU8Y
         IJ7weXtBu2d+1mJVWiSI8u24vQk2/gB5I1c76ijkT3TyAZRliCjbYEZOslsf2c9MbWn1
         FOqQ==
X-Gm-Message-State: AAQBX9d407CkpSzUjyWM0BoroCFsfUlDPTKdobEBvlnVJqUw38yemz+r
        p4S3ajwGrzDisCDmlmdhkODoy84Z3p4fvwi1at4=
X-Google-Smtp-Source: AKy350aFspxX3/ClFdKBoL4Wf1Kvbgx+s9AkV8KoGPldaxLkkSqRcR6YiYY7WeviG/7/iD2jAR50cA==
X-Received: by 2002:aa7:c90d:0:b0:4fd:2363:16fa with SMTP id b13-20020aa7c90d000000b004fd236316famr1250104edt.41.1680587321395;
        Mon, 03 Apr 2023 22:48:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id b12-20020a50cccc000000b004fc01b0aa55sm5397192edj.4.2023.04.03.22.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 22:48:41 -0700 (PDT)
Message-ID: <07548c7b-fa71-032d-add1-559743f16d9d@linaro.org>
Date:   Tue, 4 Apr 2023 07:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: watchdog: alphascale-asm9260: convert to DT
 schema
Content-Language: en-US
To:     hack3r-0m <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403004138.326482-1-hack3r-0m@proton.me>
 <20230404022015.754177-1-hack3r-0m@proton.me>
 <WaJw8WW0_x3pP2NOWf11aNOJx0xB-gZuE9bMTmydhniI0kSNa5M2oJkCp5PNZR9O1ySeV7RRLRf8rkpfiqd_P2udBHGf58x9bHSUZ7Vl4vU=@proton.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <WaJw8WW0_x3pP2NOWf11aNOJx0xB-gZuE9bMTmydhniI0kSNa5M2oJkCp5PNZR9O1ySeV7RRLRf8rkpfiqd_P2udBHGf58x9bHSUZ7Vl4vU=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,PDS_TONAME_EQ_TOLOCAL_SHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 04:32, hack3r-0m wrote:
> Thanks for the feedback, I have incorporated the fixes in the patch. Warnings generated from `checkpatch.pl` script seems to be false positive in this case.
> 

I don't know what do you refer to. You top posted and answered to
duplicated email?

Best regards,
Krzysztof

