Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF757418B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjF1TJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjF1TJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:09:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16312D66
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:08:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fba64d9296so3557525e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687979286; x=1690571286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V86oWjjNEuXl6o/EBMJQN+A8G5HNEsX04qkYSpw2R6U=;
        b=ekTdFutBVfgLPiwin9STCGajN3teM8Sn4JLaNZKFEK9hqi/cQMPJ2pIKT+tcjXzZHK
         GRIyQK1ZNbccLOyBFXq3bCPbgYZQtVDPLDhysXmxDEj6pEtGhOkxfSi3KVipFdhAU2tD
         WoOF3Ba1Kd0e3248tcsaukfguSYAN5GNAdxGFZwGle25+LsiZzV1YnzC/GPZ1Rht742d
         IP7lWFR/CGDBm107hg7okTVX4eOR3NqUdRNV8KiGLcuahWU+7QjlREV7IkObhzEssFyQ
         bFGGwnG2sZxhe6NGdTvGFTje3jPtWSnK7TyoJPlLi+IKlVaXzSq572JkmkwqsZj9OQxg
         Wzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979286; x=1690571286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V86oWjjNEuXl6o/EBMJQN+A8G5HNEsX04qkYSpw2R6U=;
        b=UaUVgh4RcRp7SziGgtezpI/TEiNBXCYnppV9AnCicb6Qp1BvBOZt4KYOb1FjqXJqN6
         PXatHn6FMmjBCCShkgD8A03Tbr4Hf25OSwbEnmq/BZc3IcN3xZA04+tfJCfGVLi6eWOZ
         CnySzFtqtxNkUF6dSKxKXD5nHAKl4sx16pCc/wV0kKwc8/BUcq689fAzclBW3DJ0nG4w
         K545s4fKE3jeyDTc980vNDmEl3t5k0TTIBEOjVafOfZqQLCLPgvJHpU/dMZwp/aVEQEt
         SWl0esb/Rt04YwcMjexcmmyRn9zi1Zhej/QpZfAbqF2FT7ktJYTaIYQsP9pMF00L7ktk
         LH1g==
X-Gm-Message-State: AC+VfDy73L6aEeT2AgeClFExthLL2+OEMstoOhb+HN6lAaQHgCShh7Tp
        u89G2QTr4b5HjyUwlQNakWVWNg==
X-Google-Smtp-Source: ACHHUZ78Fg2V1rudVBeS/mIA9GfU2hgOyo11nlnXg/6Lf833VhrxicHFwsQyHnumD+84O3BnO1fWgg==
X-Received: by 2002:a5d:58c1:0:b0:313:f580:68d with SMTP id o1-20020a5d58c1000000b00313f580068dmr6678255wrf.48.1687979286157;
        Wed, 28 Jun 2023 12:08:06 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b0030ae53550f5sm13941343wrz.51.2023.06.28.12.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 12:08:05 -0700 (PDT)
Message-ID: <924b819d-9d3c-e288-35cb-894028f40789@linaro.org>
Date:   Wed, 28 Jun 2023 20:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: docs: qcom_camss: Update Code Aurora references
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, rfoss@kernel.org,
        todor.too@gmail.com, mchehab@kernel.org, andersson@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230628190433.19050-1-quic_jhugo@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230628190433.19050-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 20:04, Jeffrey Hugo wrote:
> source.codeaurora.org is no longer accessible and so the reference links
> in the documentation are not useful.  The content was mirrored over to
> Code Linaro so lets update the references to point there instead.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>   Documentation/admin-guide/media/qcom_camss.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/media/qcom_camss.rst b/Documentation/admin-guide/media/qcom_camss.rst
> index a72e17d09cb7..8a8f3ff40105 100644
> --- a/Documentation/admin-guide/media/qcom_camss.rst
> +++ b/Documentation/admin-guide/media/qcom_camss.rst
> @@ -18,7 +18,7 @@ The driver implements V4L2, Media controller and V4L2 subdev interfaces.
>   Camera sensor using V4L2 subdev interface in the kernel is supported.
>   
>   The driver is implemented using as a reference the Qualcomm Camera Subsystem
> -driver for Android as found in Code Aurora [#f1]_ [#f2]_.
> +driver for Android as found in Code Linaro [#f1]_ [#f2]_.
>   
>   
>   Qualcomm Camera Subsystem hardware
> @@ -181,5 +181,5 @@ Referenced 2018-06-22.
>   References
>   ----------
>   
> -.. [#f1] https://source.codeaurora.org/quic/la/kernel/msm-3.10/
> -.. [#f2] https://source.codeaurora.org/quic/la/kernel/msm-3.18/
> +.. [#f1] https://git.codelinaro.org/clo/la/kernel/msm-3.10/
> +.. [#f2] https://git.codelinaro.org/clo/la/kernel/msm-3.18/

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
