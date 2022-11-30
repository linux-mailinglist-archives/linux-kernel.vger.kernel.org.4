Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB42063D3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiK3LHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiK3LHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:07:39 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC964BED
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:07:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id r12so26426119lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbRunTbMP4tz0r9sw9HIT0LUH03qyOKbAKjkg7v1cT8=;
        b=MLosrlgsByRac1dlTwWOnfeRRemoVklCtoSeOOcLwXvcg23SUzydv3J3NGpzIUK9Qe
         aavmkMLU8y7BCbC9vXIm+MFmP3TAc2WwVudJ//0p5UiVFkGwCof1hFd8SBFFI8abEBiq
         hPfWo7uDkyXQ61aNSYjLUbHk06KfsjIYWWSGomWMtFH/1DyG0lPqfaGr+QmZmnbNpmKZ
         cwa6qRDR/p+NANzfy+Ua3k/io/vNJ6umBV8GsDcDvfLzN3XXqc+vwxjEja8kZDILRtw+
         KnbUTeq+FiV4lyYLji9oSnDRtphxZ8KKJMv7fayDEDseBmtP1X2Omfyr8trASgbdkSNz
         jJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbRunTbMP4tz0r9sw9HIT0LUH03qyOKbAKjkg7v1cT8=;
        b=40WSLFkpwFIeJ1YRxJpxAsbRGoBlm/epppJTHhuB0eJh07CcHebcJ6VNwftm8z9en7
         zC8Mu9SMmtcM5Rxlp7yvYr7MBu0g3kfGnbJsjpaEad0B/tNO8zLcQTSLUVdheGMZ95cR
         kLF9boE9BsK2dy8niRoZbWiemLzw5ANOLVpFcyV7DMP7wLEvoKQ+117oobogeCaBtAN4
         C0NM6gW3yQ0EkIyWmxQCXhtDB6uHYx/qSEasfSii0kB4uD7NEz3HHmpaa0ymKgaPnqer
         hFRvnW/GLhXbn62rclEAlXzwDTsVCejlutJAPhXOQNV6YOEYQfbotiuFqeHMCtc7C6wp
         qVqw==
X-Gm-Message-State: ANoB5pnuHohg6D1dPHigdV4YyY7puU9LABd99t1Vl8lpJd1U2Qd51L+E
        /kwFFo9QFMAh8HArwo0EkXZ/mw==
X-Google-Smtp-Source: AA0mqf7EbE0WvcfiBzwsneMSJd4JZFH92F15w8hlSMZkGyD5l7c2YIJYmmeqlOnCi84qMx0fxOd5mQ==
X-Received: by 2002:a05:6512:2523:b0:4a6:fac4:596c with SMTP id be35-20020a056512252300b004a6fac4596cmr14219018lfb.220.1669806453251;
        Wed, 30 Nov 2022 03:07:33 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id l22-20020a194956000000b0049476667228sm219911lfj.65.2022.11.30.03.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:07:32 -0800 (PST)
Message-ID: <3c8c3cc8-60b9-13e2-a80f-dc397d84adf0@linaro.org>
Date:   Wed, 30 Nov 2022 12:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] interconnect: qcom: Add SM6115 interconnect provider
 driver
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, djakov@kernel.org,
        a39.skl@gmail.com, andersson@kernel.org
References: <20221130103841.2266464-1-bhupesh.sharma@linaro.org>
 <20221130103841.2266464-2-bhupesh.sharma@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221130103841.2266464-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.2022 11:38, Bhupesh Sharma wrote:
> Add driver for the Qualcomm interconnect buses found in SM6115 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---

[...]

> +MODULE_DEVICE_TABLE(of, sm6115_qnoc_of_match);
> +
> +static struct platform_driver sm6115_qnoc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-sm6115",
> +		.of_match_table = sm6115_qnoc_of_match,
No .sync_state?

> +	},
> +};
> +module_platform_driver(sm6115_qnoc_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm SM6115 NoC driver");
> +MODULE_LICENSE("GPL v2");
"GPL", checkpatch should have pointed that out.

Otherwise lgtm

Konrad
