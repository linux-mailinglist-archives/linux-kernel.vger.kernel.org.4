Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDD6D0B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjC3Qdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjC3Qdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:33:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597CC168
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:33:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m2so19713039wrh.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680194008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTAy36BLiNsY+GkgrBrUwBdOqLgTRdyYQkO3DlArkGg=;
        b=ykj9ItrhNGUbv3CLkEnrHIDWenINsrAnNwTGgbRlrB7UtpwbpGwUJG3pPRS0Q3Gjsq
         C0za0JX1ykye5t24XjVKO+IxqsIgdWPisYLm0N3ihpp4+IEzA49R7J/xoRALzmX1oQG7
         LKKTPxPyFWJUnxsDF1aGcfKxEwiWlHRNle9zG2xIXb4VumSEuG00LzhyJaeDmmu1APrA
         l4h0dSuOwE+DjnK7DNPSX+x+cW0zXAkxsJZ5PMym8eb7s5rnF6mRNzFCCQoii+JKEjTI
         qpPNAm4oGkElOk/1g1b+gSN4eocx1J8w1cc9cds4XalHSK0cxhMyMLq9XdwuIKHE4Lj1
         J5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTAy36BLiNsY+GkgrBrUwBdOqLgTRdyYQkO3DlArkGg=;
        b=zOkB2QrV6+mcik2lEYCZ7wK0kd1pk7PZ/SWsQSKk4GhNi2lNoUanqK3inXQhvcpele
         p+7MGuA6BCyvadp5t3BRsNZcVxyW6xxZAuqV0FfdUPH7H/7KhKy1RfdAumRlX9oP7Bgg
         rvEJvPYB77XvWnQVCbpnK5G4LCEiU95Cqec4pUbJLZmZT+bqAanUq55tot43z3/frEw+
         +JRKh2JsnGdZ6OwY5XjXTzMJlDziLrzpH96aV1STDxk2MgWodJuB0WTHbLBxFnTk2+b5
         5f7XaI44hmFqCdI8n6tm/1cJqHuIALiu3iZ8r2iy4V2hVlwxSaDIOkowpjI+2u6UcmCY
         aqDw==
X-Gm-Message-State: AAQBX9c/s6aLeVkBLYhx+6xqK0UefPZEvejsy7Woe6XXVK2QdYnw+APa
        0q1qYShQuDFGe1CVy4F+b2PNbA==
X-Google-Smtp-Source: AKy350bcRapicwm5w7+VNlWB7IP7tnaAHFf7ULeuGrQbhL5+YP/wpni6b+q+nRFmJNuZzpji+lzLxQ==
X-Received: by 2002:adf:e4cb:0:b0:2ce:bd2e:1fea with SMTP id v11-20020adfe4cb000000b002cebd2e1feamr19906723wrm.26.1680194007864;
        Thu, 30 Mar 2023 09:33:27 -0700 (PDT)
Received: from [172.20.10.2] ([37.166.66.243])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm33209463wrr.88.2023.03.30.09.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:33:27 -0700 (PDT)
Message-ID: <d099f038-7c73-9765-fa4e-c245bf8d0951@linaro.org>
Date:   Thu, 30 Mar 2023 18:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8350-sagami: Add PMIC GLINK
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230321-topic-sagami_dp-v1-0-340c8bce4276@linaro.org>
 <20230321-topic-sagami_dp-v1-2-340c8bce4276@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20230321-topic-sagami_dp-v1-2-340c8bce4276@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/03/2023 à 23:12, Konrad Dybcio a écrit :
> Sagami devices, like other 8350s, uses PMIC GLINK for various
> functionality around battery, charging, TCPM etc. Enable it.
> 
> Worth noting:
> My USB mouse is unimpressed when connected to the device via a
> non-powered USB-C dock. Microsoft HD-500 dock refuses to estalish a
> PD handshake.

That's interesting... perhaps UCSI is required here ?

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   .../boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 60 +++++++++++++++++++++-
>   1 file changed, 59 insertions(+), 1 deletion(-)
> 

<snip>
Anyway:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
