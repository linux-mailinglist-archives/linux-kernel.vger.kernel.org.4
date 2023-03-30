Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B96D12AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjC3W5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjC3W5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:57:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DB10D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:57:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g17so26604028lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680217019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyKfQObvopk17NVpiPNCRsq0j+VPLHa0MW4Rc/CyGMo=;
        b=Ji7nj7WFIrSFmsSZwyeeP6AwUE/ae3pup9Vl7d7C/X1lI8/RkqVM2oRl/XONGjv25C
         jjXrxWlQfmEEKKps5mm+WG6JkWPQ5E/cIe8642EMhW4f8NSIW/CU6bKx29rrZ2NxKvtV
         yjLthdVLQcxDiIh1WXBnoFbR6XIxav+h4O/vXqOAAohbEAxAJykydGNVJK+h8ApU52fi
         wwgEONFNeOF5j4P+FG+gGgWdbOP51hoNYkpOt2yjY58/9uB54VVpUUu7cB1QjupsBNIQ
         N4nYW1TWmm3rs7U4G2bp66Jhd6CBDwpeg6sGA7h1TT4rRD4PJpmh3HFF9PLFAfs/KGSh
         LO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680217019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyKfQObvopk17NVpiPNCRsq0j+VPLHa0MW4Rc/CyGMo=;
        b=a1+4sfPd3BdWw/LclUTXM7L77FFg7cKdw9y+o5XS5agj7li0vMV4N2W4XaWumPayCS
         Vdz6db+85rovD62ZfsMlDQ5C0bYfgzaews/r4ckDJ+AcemVlCLc7y7WFTgpKx84lX4f5
         HtiWm8tEG2wBXnud8COI3C7PZFK9+MxQiUkm8qQ7wCvg1bw3SXKXZhCaraeXncNtp9wm
         kETaPFb8IxMUQxmmEdDclsm1+Ihrf7lohrPIEnD+WyMciHi37+hkaPXEqPrdUPeL5oBB
         z9eeeTp1fjKMLJ/n+P5y+32yu38UWONvPu8TVeGljEVcTO0KN7AeRWgUXnC0ETNu3pUe
         CCZA==
X-Gm-Message-State: AAQBX9etr0GJVnER7Melvv1ZKLDzUZN9mOuyFGUKdwSeJJsOhgdYPnts
        xk5PcTaRAASxcIqye+CZaET8mn/Kzi9QRCfXcjU=
X-Google-Smtp-Source: AKy350YEKYG2Ghd6pDF92L9f6skCBtKsWaPZ2RHNu3AcQXKQxltWKyLbsUk+nvYX4gucmmlu8Qocgg==
X-Received: by 2002:ac2:5473:0:b0:4e8:5e39:6234 with SMTP id e19-20020ac25473000000b004e85e396234mr7655500lfn.16.1680217019433;
        Thu, 30 Mar 2023 15:56:59 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id i13-20020a056512006d00b004e83edd8ce8sm119241lfo.196.2023.03.30.15.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 15:56:59 -0700 (PDT)
Message-ID: <8685b710-b74d-556a-815d-0ffef2b0eeff@linaro.org>
Date:   Fri, 31 Mar 2023 00:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/1] dt-bindings: firmware: qcom: scm: Updating VMID
 list
Content-Language: en-US
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20230330165117.26348-1-quic_gokukris@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230330165117.26348-1-quic_gokukris@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 18:51, Gokul krishna Krishnakumar wrote:
> Adding the full list of VMID's, which are used by different clients to
> pass to the secure world.
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
> V2 Fixed allignment issues in [1]
> 
> [1] https://lore.kernel.org/lkml/20230328214703.12093-1-quic_gokukris@quicinc.com/
> ---
They're weirdly ordered now.. I think Dmitry's comment was
just about the usage of space/tab such that git would not get
confused. With that fixed, you should be able to get a diff like:

+#define QCOM_SCM_VMID_LPASS		0x16
#define QCOM_SCM_VMID_WLAN_CE		0x19
+#define QCOM_SCM_VMID_CP_SPSS_SP	0x1A
[...]
+#define QCOM_SCM_VMID_CP_CDSP		0x2A
#define QCOM_SCM_VMID_NAV		0x2B
+#define QCOM_SCM_VMID_TVM		0x2D

Still, I really appreciate you providing that information to the kernel!

Konrad

>  include/dt-bindings/firmware/qcom,scm.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/dt-bindings/firmware/qcom,scm.h b/include/dt-bindings/firmware/qcom,scm.h
> index 1a4e68fa0744..7ad6cbe623d3 100644
> --- a/include/dt-bindings/firmware/qcom,scm.h
> +++ b/include/dt-bindings/firmware/qcom,scm.h
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
>   * Copyright (C) 2015 Linaro Ltd.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #ifndef _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
> @@ -13,4 +14,25 @@
>  #define QCOM_SCM_VMID_WLAN_CE		0x19
>  #define QCOM_SCM_VMID_NAV		0x2B
>  
> +#define QCOM_SCM_VMID_TZ		0x1
> +#define QCOM_SCM_VMID_CP_TOUCH		0x8
> +#define QCOM_SCM_VMID_CP_BITSTREAM	0x9
> +#define QCOM_SCM_VMID_CP_PIXEL		0xA
> +#define QCOM_SCM_VMID_CP_NON_PIXEL	0xB
> +#define QCOM_SCM_VMID_CP_CAMERA		0xD
> +#define QCOM_SCM_VMID_HLOS_FREE		0xE
> +#define QCOM_SCM_VMID_MSS_NONMSA	0x10
> +#define QCOM_SCM_VMID_CP_SEC_DISPLAY	0x11
> +#define QCOM_SCM_VMID_CP_APP		0x12
> +#define QCOM_SCM_VMID_LPASS		0x16
> +#define QCOM_SCM_VMID_CP_SPSS_SP	0x1A
> +#define QCOM_SCM_VMID_CP_CAMERA_PREVIEW	0x1D
> +#define QCOM_SCM_VMID_CDSP		0x1E
> +#define QCOM_SCM_VMID_CP_SPSS_SP_SHARED	0x22
> +#define QCOM_SCM_VMID_CP_SPSS_HLOS_SHARED	0x24
> +#define QCOM_SCM_VMID_ADSP_HEAP		0x25
> +#define QCOM_SCM_VMID_CP_CDSP		0x2A
> +#define QCOM_SCM_VMID_TVM		0x2D
> +#define QCOM_SCM_VMID_OEMVM		0x31
> +
>  #endif
