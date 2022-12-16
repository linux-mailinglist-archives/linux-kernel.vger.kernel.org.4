Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60564F4F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiLPXWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPXWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:22:19 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37213D71;
        Fri, 16 Dec 2022 15:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671232938; x=1702768938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rHmzNvIp4i4ZnpwcZV6eJ+Rg9c4LEbjzoc5annv1Nek=;
  b=umins327sk9Gd9K99FND3xmU4/sVAT8LNvqb/47PwQlPmai5yB80lWHV
   KtSyU0VSM9OS+/t7jtzh7oisMNWJ3/Ga/oHAmik2/FDg/Vn86gstxOi3v
   tUsCkJdDW7IHdOVSO6ZrmwOZ+Fu19EK7DbAEIFK7YX4GGnK+nKYUlSNnU
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Dec 2022 15:22:18 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 15:22:18 -0800
Received: from [10.110.77.243] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 15:22:17 -0800
Message-ID: <031d6121-c4b0-8db4-f816-fcff1e57f656@quicinc.com>
Date:   Fri, 16 Dec 2022 15:22:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatible
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
CC:     "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221216231312.22574-1-quic_molvera@quicinc.com>
Content-Language: en-US
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221216231312.22574-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2022 3:13 PM, Melody Olvera wrote:
> Add compatible for scm driver for QDU1000 and QRU1000 platforms. These
> drivers only require the compatible field, so update the bindings
> accordingly for these platforms.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> This patch is separated out from [1] and includes
> changes addressing comments from that patch set.
>
> Changes from v4:
> * rebased on top of [2]
> * removed redundant allOf
>
> Changes from v3:
> * removed unnecessary reset-cells
>
> Changes from v2:
> * Dropped qru compat strings
> * Marked no clocks on qdu/qru scm device
> * Revised rpmhpd constants
> * Updated socinfo driver to new format
>
> [1] https://lore.kernel.org/all/20221026190549.4005703-2-quic_molvera@quicinc.com/

Apologies; meant to note that [2] is https://lore.kernel.org/lkml/20221122092345.44369-2-krzysztof.kozlowski@linaro.org/

> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 8e6e9ebb343d..9312a0953ea8 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -38,6 +38,7 @@ properties:
>            - qcom,scm-msm8994
>            - qcom,scm-msm8996
>            - qcom,scm-msm8998
> +          - qcom,scm-qdu1000
>            - qcom,scm-sc7180
>            - qcom,scm-sc7280
>            - qcom,scm-sc8280xp
>
> base-commit: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
> prerequisite-patch-id: d5d17b3d720b358b8478cb1ad87e21a70992f228
> prerequisite-patch-id: 6c92672973fdc1524516942fa21c340e68e7c4fb

