Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A64723F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjFFKd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjFFKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:33:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66810F4;
        Tue,  6 Jun 2023 03:33:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-976a0a1a92bso653867166b.1;
        Tue, 06 Jun 2023 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686047598; x=1688639598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v72gOkh5ySs+rPb5lkghVzJGN7aHk5temS9sTulamdI=;
        b=WUhN2JTRz4tz9v6i4p4vfr36PhFx/ZVjLtuf929wzGGw8zucpdhoofpv1fuUx5Y+7Z
         ol7oO2BhyVLfH+GiQTDQDeSXH8KCNiW6q7Ipb4Dt83btHM8n8Kv5F5apy30qC9U/ljkB
         2r5FExbOzTbLh0POTe/SymlcdSA8GITcMNDm+wAPikf7NUAp45g032i6kmx+DjDd+ikf
         waeTqqIc3Rgal5oQi4N8ZSvmqODR5etv9wwZuHKo/fDk57eyNfZFY4hij+35FAg2qM0i
         NbH7i5Ao+PMHK1gvkLYeuPPMjt/XugnlIv8Hl3/poL5h1GOrVajeCNx7mqVRlQPUNVZW
         6PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047598; x=1688639598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v72gOkh5ySs+rPb5lkghVzJGN7aHk5temS9sTulamdI=;
        b=ZnqhNkxDANjKknKLf5nQx35zVXVeghMwZJz5VoK05GLXzRVT6I1MluYEzAb4c0uBdM
         hVlZor0UOS2iqUwYjL0Xz9GnNXmcDNY8iKX1gzhgnY4WYTy8gpLORm22SwLS/6hCQoXm
         YMRlsC3NiCTuWZf5ZasjmAUqFw6Umjq8KazwxNd/psDQ1dnikutHnaxbHODuApP0a7ts
         F5jYs4CNYT2DrrLLNfMOceq4bG7n8a2m2VHg5+ilCwn4C6Qsmi0rr48yDCjrV79b9D+B
         lDEYW4cvyrA+te6Zfew1mXC0t4Xk6os24bvvphZv4LFHVVkwTYJ8XTT4GTk4gTMLJgfm
         rE7g==
X-Gm-Message-State: AC+VfDzolMTF04a440VhjtNFv3IX9HhynzNWWmYhGWt6XE92xEAxxil+
        AMwYZ/vNdxyaUPc1G5+BqOs=
X-Google-Smtp-Source: ACHHUZ5FDIT31lLqX+d2WZEVgpfGdyYvHd2yEZzG/gvZh89/R/9GO/DRugEllHwD8Ir0IYypcprYuw==
X-Received: by 2002:a17:907:16a5:b0:978:6be4:7efb with SMTP id hc37-20020a17090716a500b009786be47efbmr1803714ejc.7.1686047597821;
        Tue, 06 Jun 2023 03:33:17 -0700 (PDT)
Received: from [192.168.3.32] (dh207-99-62.xnet.hr. [88.207.99.62])
        by smtp.gmail.com with ESMTPSA id q27-20020a17090622db00b0096ae4451c65sm5349886eja.157.2023.06.06.03.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:33:17 -0700 (PDT)
Message-ID: <955b8b78-eb50-7ee2-f5f7-6b66a2daa963@gmail.com>
Date:   Tue, 6 Jun 2023 12:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] soc: qcom: socinfo: Add support for new fields in
 revision 18
To:     Naman Jain <quic_namajain@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_kaushalk@quicinc.com
References: <20230602032600.14790-1-quic_namajain@quicinc.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20230602032600.14790-1-quic_namajain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02. 06. 2023. 05:25, Naman Jain wrote:
> Add support for below fields coming in socinfo structure under v18:
> * num_kvps: number of key value pairs (KVP)
> * kvps_offset: the offset of the KVP table from the base address of
>    socinfo structure in SMEM
> KVP table has boolean values for certain feature flags, used to determine
> hardware configuration.
>
> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>

Hi,
The socinfo struct itself was moved into a separate header[1] so it can 
be reused,
so this patch series needs to be rebased on top of linux-next.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/soc/qcom/socinfo.h?h=next-20230606&id=ec001bb71e4476f7f5be9db693d5f43e65b9d8cb

Regards,
Robert

> ---
>   drivers/soc/qcom/socinfo.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index c2e4a57dd666..a76006ea8a37 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -181,6 +181,9 @@ struct socinfo {
>   	__le32  nnum_partname_mapping;
>   	/* Version 17 */
>   	__le32 oem_variant;
> +	/* Version 18 */
> +	__le32 num_kvps;
> +	__le32 kvps_offset;
>   };
>   
>   #ifdef CONFIG_DEBUG_FS
> @@ -620,6 +623,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
>   			   &qcom_socinfo->info.fmt);
>   
>   	switch (qcom_socinfo->info.fmt) {
> +	case SOCINFO_VERSION(0, 18):
>   	case SOCINFO_VERSION(0, 17):
>   		qcom_socinfo->info.oem_variant = __le32_to_cpu(info->oem_variant);
>   		debugfs_create_u32("oem_variant", 0444, qcom_socinfo->dbg_root,
>
