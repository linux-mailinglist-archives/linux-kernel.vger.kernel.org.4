Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC8F5B450F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 09:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIJH5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 03:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIJH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 03:57:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB21804B4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 00:57:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bt10so6559857lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jqhp804BEoPC+ADQDzmqNl0ZgSvHbNrXdNN71VZt+28=;
        b=pOGRwOOjhrXv8IPsULsyy3bbbXOZKQrzj3JKrshQxRy67ZNW5AUC80C8JEM/kXiu8Q
         FuXgKLva+xuSOwdBLIawOtmLnmFB/3tD9auY+gQh+bvtjsjlxarF9QMGAXVjW+tpzqT/
         /Gperra4QARFdyrAf/z8GKofAM/Q9OCJwOTQfuHScriGVqpjm18bhgTsWIeP3wms7Btd
         sJBdE0j9M9ijUS5lXx6fSj/GX7xTT5yNh4QSRVQJf0phObaTNCOSglFM9oV2T06E6OQP
         iSGTLhjo0yBvzXml6t3m/og13uvczLTUS89MSSwxD97wpL9OibpJwtsMCOsSmoLQTDB4
         7vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jqhp804BEoPC+ADQDzmqNl0ZgSvHbNrXdNN71VZt+28=;
        b=VZfDZs00NIEFZEEvEOa5kcrLU7hmaQ0E/TOzQAWDJG79CvivjURX6qEie3X1fVHD7q
         K2iRwm85Q++sVO6MUkvNB+XSpSS0ohXSaDMEUJLsut/zLAhiIaKG0NfliuQ9lYWSAq8y
         RfPy+LHjPhekCaYdeEyx2rMndjW25n6XbjAoSZj/wdEVvf9NrXw93E1rhAYeA68LIkpU
         fCcBufxayAd07hSsdaapaEl3Ah8klx+OW9pNud4jFzksY+eibp5h5BdDtAz0wFPyDe3V
         gEYMZiGl38bbHeL6/vK5pTWAmmPZ/VPaRXNeap0IVgXsM/LVbNEs5UJkTOBR+kUEI3j3
         u9vA==
X-Gm-Message-State: ACgBeo0N1PsVLBzQvFTujmcE2wM2d34mBzVzD4g/Au5TDeaLkyfSrEtE
        On3AmAK6Z0oriS06B+snWol5XQ==
X-Google-Smtp-Source: AA6agR6/7INkCThnS+iVINNWPvlsIwHQLzpko3Hon45J1hx2d0KzURWIsDc5FqU8ZCvCd4IR13PkbA==
X-Received: by 2002:a05:6512:68c:b0:492:2f73:6135 with SMTP id t12-20020a056512068c00b004922f736135mr6007785lfe.480.1662796657470;
        Sat, 10 Sep 2022 00:57:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w1-20020a05651234c100b0048ae316caf0sm184088lfr.18.2022.09.10.00.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 00:57:37 -0700 (PDT)
Message-ID: <e3586d4e-fbc6-d73d-5b4f-f8c7e69689f9@linaro.org>
Date:   Sat, 10 Sep 2022 09:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v5 2/2] power: reset: qcom-pon: add support for
 qcom,pmk8350-pon compatible string
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, corbet@lwn.net,
        sre@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com
References: <20220909204207.15820-1-quic_amelende@quicinc.com>
 <20220909204207.15820-3-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909204207.15820-3-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 22:42, Anjelique Melendez wrote:
> Add support for the new "qcom,pmk8350-pon" comptaible string.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
