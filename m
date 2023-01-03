Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20A65BCF2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbjACJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjACJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:17:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7BE029
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:17:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g13so44805937lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9Wv3FdFZUA8KrBGuSYP/aqmUGr0c3p246TWkk0lSEw=;
        b=BScJBbEP3xsvpBGOF+42qKUXZnbwU6kdalonSqYyRk+bjVotSjVe43xZL7KKmoTB3k
         vAIlOfSrGmuHfnUdBf2UanB0aF49xzBejuNPWS9zACsLduFVikc6ncjchZjbuICRsCfL
         SqWJZRwlyvOw68mJkuK8Rskc+yp9cRwcou3mJ1PEXt77Wd0jWcyOt4YoB3fmd0PQMV8x
         0dMQNjEDmnJV37yOIhbGIidz0I9S31ElOfQrbxsMMEcGRteaWsREEzXJu+FPv029LmSH
         DcRJwUsOxJ3uFTvHRdle8slsonugd7SMT4Y4s47++ZKN4TKdz9VG378kR7W5UiAsNQAC
         Mt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9Wv3FdFZUA8KrBGuSYP/aqmUGr0c3p246TWkk0lSEw=;
        b=gRiU/lfVg+3QYpEurm8aJ4xP7+WLXWyzxAQnU/wysz/VnjFJF4g/zuOQtE7rtpSBN7
         +vV+3yrgwifmw9+On+OXyVsr6ph+tBK86IPCCP007VoaLF5GbVUQTdbwRPTu+ps8P8rj
         otlK9YOJIwuZ83Wn+mgcrMI+WFwrkOd3oT08gUkLG6HLSGNwSMzzL5vfZbd0fC8lpaGb
         rvArMsCA59USaMcaQw/2tU7iFnkK70l+ZUTOQtDjIDU0QqIWwFHKMZrXKTfwvvPj3KAn
         keLZKUY+Tcqh8/k3eCIyW0QxLi6/UnH2XhW/hlDpZEGFI4KoHIAM90ys1F8sdQy+oj0l
         ZD+Q==
X-Gm-Message-State: AFqh2kq42KwqmUBdpqAyAq1kYI1DEjYgpf1CYR6KwjC/J5CfjD8h9nq+
        X7UPUocKV0O4rIjmohhNF1nGAw==
X-Google-Smtp-Source: AMrXdXuR7LoWumsRY5WP6eNKvUecQts2oGh+/OUbygbiKZyvAzR2uYKF7qlfpaZWszYPdncbwTdHDQ==
X-Received: by 2002:a05:6512:2624:b0:4cb:42ad:e895 with SMTP id bt36-20020a056512262400b004cb42ade895mr129068lfb.32.1672737477043;
        Tue, 03 Jan 2023 01:17:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q16-20020a194310000000b004b5634f9b9dsm4804805lfa.115.2023.01.03.01.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:17:56 -0800 (PST)
Message-ID: <9d8b0fca-2806-e405-f643-8a57bd55ffb8@linaro.org>
Date:   Tue, 3 Jan 2023 10:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-7-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-7-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 02:09, Bryan O'Donoghue wrote:
> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
> chipset.
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>

(...)

> +
> +&blsp_i2c2 {
> +	status = "okay";
> +};
> +
> +&blsp_i2c3 {
> +	status = "okay";

Blank line.

> +	tps6598x: tps6598x@38 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "ti,tps6598x";
> +		reg = <0x38>;
> +

Best regards,
Krzysztof

