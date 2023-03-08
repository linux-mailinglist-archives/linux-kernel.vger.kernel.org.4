Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE246B0C24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCHPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjCHPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:06:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C948BC781
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:06:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1516095wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678287976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jlq6HsXBOX8/TTgRxtIwvmQ7gwNs0+Rlm9IvH1W6h4g=;
        b=C+h6+J+TldxZYIgHVT56E88ivFauvQ9OmlMo+xSyqd7IUawl9ltT7QwrDRaJzajwdl
         OVtYxvAdFWzuEAclRlYdv28i3of+wtuXxCQ4pD0n07iiAFIlk1/GNkn0c3I1IN1bRU+Z
         yiBs+1FbCDUqtDTWwtkWXFaPk1Ink4YTVXIg2DyEUV5lQ6kjGR2htBycYPSpxpJp+srL
         zC8GUrs0Np9ZCOAI2oLKbazECgqfjb57Z5bqvkWltouiFwsVhhomb8xdqGb+fkvn6470
         DXO/b4C3xYGkVKIsLP8p0EYVshW9mVjSw3rSBWu/aMMFSSj6f6y9ztTj1mWNd37tSt59
         ztBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlq6HsXBOX8/TTgRxtIwvmQ7gwNs0+Rlm9IvH1W6h4g=;
        b=wIpXDYB4DNJCoaNwJK3xAhWcSC99htJ+5mmdlVzIuHyErEU1KlEoXUrMO6oLrDCfoi
         gAg5+GwVXx6brKLPdWweUJw6gRa7DiPPlhVBkTU+VWDdjn0pClNVKDQpzKkbJg5dweI3
         ZFj+pR5YPttAB1CRdKK7yw4wAfGDre9fWDe123JuYhQK9vYKoepuUI9t3VLqVPDV961i
         /CnrGknt7LdROay5iKcFJwl8G+VqK2PK2Q/GZJM8WtV9S/5vjGt4v7tIKfsHbR0kMOUd
         U8Vv74/kyZdssmfgOW65fRpynCsrxl7LwIAs5+YQRuBeEgukxV1jEHpq6s0ZEAZmEsuN
         0JmQ==
X-Gm-Message-State: AO0yUKXb2pgQA0CIGRTW695bL5lFtPM4xQU/ZjFvgULtrOTUvCkSzBo1
        Spp3/V58vFnHs9Z+m7XFrV+a8w==
X-Google-Smtp-Source: AK7set+iIivd7dT32ja+ph0vH+bmv75rrrZhi++cEMgzO8Ydqk36ufMLcdlqbh65RDKDVa7uRXE6gg==
X-Received: by 2002:a05:600c:548b:b0:3eb:39e7:3607 with SMTP id iv11-20020a05600c548b00b003eb39e73607mr17343211wmb.4.1678287976049;
        Wed, 08 Mar 2023 07:06:16 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b5-20020a05600c150500b003e91b9a92c9sm15855461wmg.24.2023.03.08.07.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:06:15 -0800 (PST)
Message-ID: <7908960d-da82-37d3-03af-8cab0c062221@linaro.org>
Date:   Wed, 8 Mar 2023 15:06:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/4] firmware: qcom_scm: Clear download bit during
 reboot
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-2-git-send-email-quic_mojha@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1677664555-30191-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2023 09:55, Mukesh Ojha wrote:
> During normal restart of a system download bit should
> be cleared irrespective of whether download mode is
> set or not.
Looks like this is a fix, Fixes tag would help here.


--srini
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>   - No change
> 
>   drivers/firmware/qcom_scm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54..51eb853 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1418,8 +1418,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   static void qcom_scm_shutdown(struct platform_device *pdev)
>   {
>   	/* Clean shutdown, disable download mode to allow normal restart */
> -	if (download_mode)
> -		qcom_scm_set_download_mode(false);
> +	qcom_scm_set_download_mode(false);
>   }
>   
>   static const struct of_device_id qcom_scm_dt_match[] = {
