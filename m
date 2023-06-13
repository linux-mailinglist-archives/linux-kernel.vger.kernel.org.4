Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A772E371
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbjFMM53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjFMM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA1184
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:57:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b33176880bso21869741fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686661044; x=1689253044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IOtugteg27Qs3cUmW6TBtan0ET5d8v3oiWN8auOS0yY=;
        b=aZJuwwutzfHxC33CEHo2wEtpbF2txC+HbBJLBT25nW1rs2v1hT0QRFACk+m/4U2qW+
         AeBQP42yJEO5xfi76O/M/QaeYWyJVNmPcpRhuLQhzYOxRwVZlTtRTdB4DlO0OSn+KQDx
         Gbj6IbgjnUmkQkxQ3sJi4Un5sDNRf/yeIZAbhUoZ3ZVXWE0Nnb6PEddX1jFSso8/rOLP
         N7qSsfNcX/vE3kRqgJ8nVRcHGNl4WKajBdJeGCsEjndSZLf8IPGl0KDMJa8e8HY0sZ3C
         x+6ikrRaxQWVtjyBPCfQ9drexH/B93wuNrkMfJJtjF0qji2lm+zoM0l1S5jN2xuR5Z6N
         aQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661044; x=1689253044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOtugteg27Qs3cUmW6TBtan0ET5d8v3oiWN8auOS0yY=;
        b=KGoYqG3xykGOlkvI6cEWyouRSS3yChf/uTZNH8ISqO4zu1ORQa7P0d6JPM4jp1TQWr
         nw4uTV7ROTbsIRgqA0W2fBIa4b0VU4QWIBtfocOLU4S4DCq+PrdQ4okAmz7zsPgVrhxQ
         1+Vt0pLbm+vojJB4qf69C5cddO+dE6IrKQEDisnDmOmqDcNfRZzRxrGKLGMSxCUZ1F69
         dnkg1DfG1ttJorStEGDUEinVKL/8qGfZFf5sQ/50Gm5tlZheNHsoAxWaCXeEDl7w19b/
         KMbkRqtL1XHu0eu84ACthOIMjb8w9G0oSh/4rA4ivNmPWIVC63T37+CKpvCha2VQ91vQ
         q3Uw==
X-Gm-Message-State: AC+VfDyTXK9BM74nTwORA8qGeNuP/Pza9OWP0jX5QBKLidaOLx0Drau/
        jY8pyE0xveuuwBfzJs/hC5YS4pyKixqwuC+RfPs=
X-Google-Smtp-Source: ACHHUZ78PSyLNXs4FBh18uue1H920tw1Gp+R6J566Szf/z3zIrAvhmP+MKqDcDZt01XPxGXPjOilug==
X-Received: by 2002:a2e:978f:0:b0:2b1:dbdf:4524 with SMTP id y15-20020a2e978f000000b002b1dbdf4524mr5563503lji.9.1686661043429;
        Tue, 13 Jun 2023 05:57:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id s20-20020a2e2c14000000b002b1a8b926f3sm2137293ljs.3.2023.06.13.05.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 05:57:22 -0700 (PDT)
Message-ID: <a838693e-e441-2ea2-937a-5cad9a5cd512@linaro.org>
Date:   Tue, 13 Jun 2023 15:57:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] soc: qcom: mdt_loader: Fix split image detection
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612215804.1883458-1-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230612215804.1883458-1-quic_bjorande@quicinc.com>
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

On 13/06/2023 00:58, Bjorn Andersson wrote:
> The enhanced detection introduced in commit '210d12c8197a ("soc: qcom:
> mdt_loader: Enhance split binary detection")' requires that all segments
> lies within the file on disk.
> 
> But the Qualcomm firmware files consistently has a BSS-like segment at
> the end, with a p_offset aligned to the next 4k boundary. As the p_size
> is 0 and there's nothing to load, the image is not padded to cover this
> (empty) segment.
> 
> Ignore zero-sized segments when determining if the image is split, to
> avoid this problem.
> 
> Fixes: 210d12c8197a ("soc: qcom: mdt_loader: Enhance split binary detection")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # qrb5165-rb5

W/o this patch loading mbn files is broken.

> ---
>   drivers/soc/qcom/mdt_loader.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 9418993a3a92..6f177e46fa0f 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -275,6 +275,14 @@ static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_na
>   	phdrs = (struct elf32_phdr *)(ehdr + 1);
>   
>   	for (i = 0; i < ehdr->e_phnum; i++) {
> +		/*
> +		 * The size of the MDT file is not padded to include any
> +		 * zero-sized segments at the end. Ignore these, as they should
> +		 * not affect the decision about image being split or not.
> +		 */
> +		if (!phdrs[i].p_filesz)
> +			continue;
> +
>   		seg_start = phdrs[i].p_offset;
>   		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
>   		if (seg_start > fw->size || seg_end > fw->size)

-- 
With best wishes
Dmitry

