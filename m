Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4AF68133D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbjA3O3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjA3O3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:29:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B7183D9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:28:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so1196873wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qKdXk/omSiAj1zB29OCY6KCCz70BntsFebdtzKnA+6Q=;
        b=qp5H5QXrd63klWczEQY29BOAI58DUzZ5uzYFsSFN1FiyRpRSZSPvQozWGE3ujG7MvF
         X7QSTkudv320mdeRZUPEopARPSuyQE4Ua94dOePKfcu5WLd0IgWTCv8SY3Y0UpCOa26c
         x0cJlS4RB5sV8CkLXZpPJ2kWNkVUBBKVoSsYri3F4Kvf7hq4QQTfADlrSF7sYh6XAQnT
         SxK7SlfdszGtzGR83Jw53www+SMOtr8w00Xgub0i7AmDdVdi+K1zu9ACbffy7CntqUWb
         fcoYK+VtCiH0268RmZbhtn27SaN9v4dwEO/tQNy8QAWTM2xqXP0gYa3cZVUrI5Jgq1AO
         i/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKdXk/omSiAj1zB29OCY6KCCz70BntsFebdtzKnA+6Q=;
        b=jOUV1xTFpyMaUjcK2qTxO9ZQH/QlK4sfXgyVzM6H3xIjWs08rNikydBB/PIA1I3LCw
         dSpz8YRIO9tLpRyiTgbW/vmY2+aoBF3JS64jiEfbX0XLrjhSWXv48T6iI8/A5O4KcRfO
         cEqGi6XSynDO5EazZV9XPbyXhucugOjP9ieHd+1b7DXLw17WuGYrqBOiYXtyVNlCVMoa
         DVtxDRA31eVoTvNsLNQVierDepSBiZYgKDH3+okr6Yb4Yw6mT8TGb1Ie9RXXPW4ZRzd2
         fu1AmlLovnh8pPsgWut1YLaulKfdEGBXr6LiZWp2Ws+HXYXDi+9M6DwVsa3abJx4KPAZ
         DHbA==
X-Gm-Message-State: AO0yUKVRiZY/mDJgNBuypbULGzzl1I8aMP4Ndnb6dwOsuNQ7u3sDQk+7
        BJPqc4MzHmJUPxoq79sgQFRT2g==
X-Google-Smtp-Source: AK7set8hAxBEDnJQdA7HZtbQF42tcRjmtazRUUcVz0a1nnzvOFQqd9FgvXHKEGKf+8ElIiixb6axMw==
X-Received: by 2002:a05:600c:a07:b0:3dc:2137:d67d with SMTP id z7-20020a05600c0a0700b003dc2137d67dmr19055856wmp.16.1675088885275;
        Mon, 30 Jan 2023 06:28:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f17:219:cb05:7cd? ([2a01:e0a:982:cbb0:5f17:219:cb05:7cd])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c17d500b003dc46242c4csm7805760wmo.10.2023.01.30.06.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:28:04 -0800 (PST)
Message-ID: <eed8c912-3da7-d6e8-e616-d35724e6fe3f@linaro.org>
Date:   Mon, 30 Jan 2023 15:28:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/4] soc: qcom: pmic_glink: Introduce base PMIC GLINK
 driver
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20230130042003.577063-1-quic_bjorande@quicinc.com>
 <20230130042003.577063-3-quic_bjorande@quicinc.com>
Organization: Linaro Developer Services
In-Reply-To: <20230130042003.577063-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 05:20, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The PMIC GLINK service runs on one of the co-processors of some modern
> Qualcomm platforms and implements USB-C and battery managements. It uses
> a message based protocol over GLINK for communication with the OS, hence
> the name.
> 
> The driver implemented provides the rpmsg device for communication and
> uses auxiliary bus to spawn off individual devices in respective
> subsystem. The auxiliary devices are spawned off from a
> platform_device, so that the drm_bridge is available early, to allow the
> DisplayPort driver to probe even before the remoteproc has spun up.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v2:
> - None
> 
>   drivers/soc/qcom/Kconfig            |  15 ++
>   drivers/soc/qcom/Makefile           |   1 +
>   drivers/soc/qcom/pmic_glink.c       | 336 ++++++++++++++++++++++++++++
>   include/linux/soc/qcom/pmic_glink.h |  32 +++
>   4 files changed, 384 insertions(+)
>   create mode 100644 drivers/soc/qcom/pmic_glink.c
>   create mode 100644 include/linux/soc/qcom/pmic_glink.h
> 

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-MTP & SM8450-HDK
