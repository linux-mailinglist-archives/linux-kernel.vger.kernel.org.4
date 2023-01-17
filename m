Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1747766E0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjAQOa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjAQO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:29:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2DA3C283
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:29:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v30so45303327edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UGD3C9WKKhoLcns/YO+k60vwTruXIRCWksL33OjZZU=;
        b=abmeYWOSlOCC0sm9Rn75XUSAgWCcUg+A6l5COGLADBxE0NlO8PyH1OPZQNvp61VOoX
         f+ydVjTYmeQPoLmRP0nsPcE8HSbDzdWN1zBU2VOoKmZbtkeOOgRad3kyh3Ja94bCKWCh
         j9H9C9WSPDWUjaPSn7PWUjeAU8kcZDVK/GQD/XuiOwnMaBYOEOh+FR+QRgkhGYex/UBJ
         X9PtxP2VhMuABAjzxXJQMW14VcUB2lYwR/N3bpjgh7RzFVC7fTpqpCelIkeiIsFHjzfY
         l6Il6TpAzqdv5UftkS6MWRsywpVOZmwtAsd79yosFw/9HbslH+1ifKrCbVfU2upyJLkW
         TsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UGD3C9WKKhoLcns/YO+k60vwTruXIRCWksL33OjZZU=;
        b=UPOxv/pfm4nb5gAq/6kd71i3GT8azCH8GaSjkKJWSQCsF7MJcT4aQthNCENrGmm3p/
         y2RTCrnPaIK9CcBwf8V4ITKZWsTnFuePKUL/OJkFpgSKiYYZNe+K9F6vVGRtL8UekGqn
         Ufwu7VbgU23I/H9x7n1alC2R1obYD7hinh2EJLtknyBBGzSw9VLxCbbvFLNJ+MuciosX
         Xo0EUSJ97NEjHgz0qPqAZ58w7oQ7QiQ9N8DXjdfcEfV3epc+cJxWehah7bLk6a2dhzYD
         CdrMlktE1Xm1GF5A03NOiPY9XRGcGp5DxKBRNgeOCxRztrrMxbe/LpFvSCBSVkb3Elgd
         kK4Q==
X-Gm-Message-State: AFqh2kqSfDECcdjssezC3/7yynq7GHMl8o68PEIGoDWjF682HKtUUtXT
        0maPuL4cNPdJP77kjOHECNxwZA==
X-Google-Smtp-Source: AMrXdXvxf9/ZCk1lQ4i0cJ8vaYUkXgZ2w4SlStRI/xVCppgh3t+Ic79lLXRd+Ny5+lB/YlZcgccXJw==
X-Received: by 2002:aa7:d7d9:0:b0:478:5688:7c9f with SMTP id e25-20020aa7d7d9000000b0047856887c9fmr12926771eds.29.1673965743743;
        Tue, 17 Jan 2023 06:29:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d3-20020aa7d5c3000000b004835bd8dfe5sm12988233eds.35.2023.01.17.06.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 06:29:03 -0800 (PST)
Message-ID: <49481b50-b68b-3c77-e398-8b0ae617ab06@linaro.org>
Date:   Tue, 17 Jan 2023 16:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 5/6] phy: qcom-qmp: pcs-ufs: Add v6 register offsets
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
 <20230117142015.509675-6-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230117142015.509675-6-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 16:20, Abel Vesa wrote:
> The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
> UFS and PCIE g3x2. Add the new PCS UFS specific offsets in a dedicated
> header file.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h    | 31 +++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  1 +
>   2 files changed, 32 insertions(+)
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

