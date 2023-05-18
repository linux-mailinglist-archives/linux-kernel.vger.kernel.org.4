Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A633708012
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjERLq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjERLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:46:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2839D97;
        Thu, 18 May 2023 04:46:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9660af2499dso373905066b.0;
        Thu, 18 May 2023 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684410384; x=1687002384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnhl4cUTEaj6zVALSdB0vLIzRguGYPY0F7/rLjE6Wsc=;
        b=jXVKgetGK79X1UONbGG9KRLHXxsv3VGx0ClSxa8c6UuJvEKYe96TS923YOLxi5QaXV
         l/IjIbzNqpiTQNPg4JUhXNN6iVEtaaCfVOyx8FzAE03BnZ+u/YPiEYvu+VIc9usyH5X8
         BSQgkB0A2tfAzvtofjJGs+qHhpU6YcmJRgOBrAGMA4JEaGnRPrfwZzlQvTq8ac6HPj2p
         iBlXAoWa0OV1WNkQdxEUjkAk6FQQ4yKn+cuF3jBnr1+IYgmZ7c7o0y2duSZatQOtLuv9
         Fzgb20Edmf58b2G74NRlMpVOaqtltuoXiMdg4R6rbpvI4esQb2eEEx/lfXPDOToyn8yj
         vK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684410384; x=1687002384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnhl4cUTEaj6zVALSdB0vLIzRguGYPY0F7/rLjE6Wsc=;
        b=YCT4fMNqxjs+QioL3NBu9gvAo+zYXRf+KI+rqlW8mgxqgSmwSubf9Ws4EgFXer2X9/
         Y4JOOmA13QiNX1Ngy18Lmy+3sIsPC52ezyCmTInxw8SSxQFENxg3ZwUYwKI8JTUPZrTI
         ZzpvL2SWuqXWKNbgRpUXySKJQof1cjajzR/oSreezvlkhelSav+4gDyirfpQH3MMzfzJ
         JWxc8CcZr92A/UJVotI4ZZPoex0k2vU4nKmxDbfYcQaqJ1JFye6EkAXtQWjNnOT2rGrv
         mx8hhGYooVmmSIysJlnVs94yLSaHncrHFhaLaCuyN1hYq+7F/h3TSpfxUZ60LE2A47ok
         QqaA==
X-Gm-Message-State: AC+VfDzf9PCznqejNpq0Sr3QXy+mGtYDPDFFxLn7M681QZtu+6Ha5C2D
        I6Kl7Q0p0H+vhEwaLQ0ObRIABIcFPiU=
X-Google-Smtp-Source: ACHHUZ7CKjjBwD6V7wm83lWpktnKR7ZdW1d/RIEQjo1rcnMTkLlZPHJsCKUniNHeGnVY82RdpYXrcQ==
X-Received: by 2002:a17:907:3f87:b0:969:bae5:fa3c with SMTP id hr7-20020a1709073f8700b00969bae5fa3cmr32049655ejc.63.1684410384424;
        Thu, 18 May 2023 04:46:24 -0700 (PDT)
Received: from [192.168.3.32] (cpezg-94-253-130-143-cbl.xnet.hr. [94.253.130.143])
        by smtp.gmail.com with ESMTPSA id hz12-20020a1709072cec00b0096f3dedfcd7sm395219ejc.190.2023.05.18.04.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 04:46:23 -0700 (PDT)
Message-ID: <9bfd0abf-835e-8440-6f66-47385cbba471@gmail.com>
Date:   Thu, 18 May 2023 13:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Revert "firmware: qcom_scm: Clear download bit during
 reboot"
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1684408823-5898-1-git-send-email-quic_mojha@quicinc.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <1684408823-5898-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This reverts commit 781d32d1c970 as it causes regression(reboot
> does not work) for target like IPQ4019 that does not support
> download mode scm calls end to end.
>
> Fixes: 781d32d1c970 ("firmware: qcom_scm: Clear download bit during reboot")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/firmware/qcom_scm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index fde33acd46b7..a4bb9265d9c0 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1508,7 +1508,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   static void qcom_scm_shutdown(struct platform_device *pdev)
>   {
>   	/* Clean shutdown, disable download mode to allow normal restart */
> -	qcom_scm_set_download_mode(false);
> +	if (download_mode)
> +		qcom_scm_set_download_mode(false);
>   }
>   
>   static const struct of_device_id qcom_scm_dt_match[] = {
>
Tested-by: Robert Marko <robimarko@gmail.com>

