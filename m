Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14115E6A36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiIVSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiIVSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:00:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444F011819
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:59:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a8so15905072lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4nT6yS+Ms6brVYACX39bRREepRISliXsPSyECtXbv/g=;
        b=ViufngUgBk8RQBloB7kGIRL3i/8RnbDCaKorhbHlDPeLgpzVHJESYpsDI2YLYGsoZW
         rkfEAkODgUVwMwyiGscqd0yWMI/iVh/Zqdub0MIjKtXImlLsmtHQjaBYlv1aY+PGsqji
         rFDIG/SpSwPQL+3NNtIoTHvkQIVX6ogo8fUVtXMpl8zon0mCY8dg//K85QNnBmaOfqyH
         cZNW5kAS47MQPYKbIbqaDd4OMyL/7lUAKllazLiXcC78b8I8rwKj0jYa0LXzqeehHjX+
         Np9v4l5YA6eCX33snBE0mXjvyIJc2FQv03m/DqcR6FkqRkSOdtGFmsdcCL4Xr0L452oD
         cKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4nT6yS+Ms6brVYACX39bRREepRISliXsPSyECtXbv/g=;
        b=pEFQDuPxLt8MYNxRkeM1bEsSrCOvR+zvycrZYzWYrOYilVnASoGmtV0MsQdz9lhpoI
         Fq1v8Unlz1q6oMPB2HlPIhutiu/PbXJRYh7BxorXOm23zceo94DYEJKCbpgDx/mESL2J
         H+21TTNwefzAgVegm+YeTlJ2IK6RhAaQZGY6YksPtO8VeMovwGATsmo1O/R2Q/CcMIKx
         5Tsf3LA+n5Ux6cbeYaX7EacRWNlC66WgxLZ7QDy5QbixPKh4zKd62v6OjbiVJnKjOGaI
         K/5n540pQ6W4fpkAGelkKPFB8gfxVPm+e1Wi01eGHVrIakfMHsEUfHVEjoATuZJ9Bn7O
         6k8Q==
X-Gm-Message-State: ACrzQf2gfcCMcD+MajAj7o5QgRDLt6y1gk/fRlGwaIJAfXYyTjsp8u8k
        0bPuhl7B8jzi2f2QW6nCHfL9cw==
X-Google-Smtp-Source: AMsMyM4JvnSQWaV2khSQzyKxxZ6iuIyN8kxKgl/0FAj7GfYhlIPb2MeaPM6B2Ak/LlcK5yohP1dahQ==
X-Received: by 2002:a05:6512:2a8a:b0:49f:546b:6cd1 with SMTP id dt10-20020a0565122a8a00b0049f546b6cd1mr1611809lfb.422.1663869566301;
        Thu, 22 Sep 2022 10:59:26 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d3-20020ac24c83000000b0049aa20af00fsm1045072lfl.21.2022.09.22.10.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:59:25 -0700 (PDT)
Message-ID: <84240f69-1b5f-128e-89b3-4e22af7bbbdf@linaro.org>
Date:   Thu, 22 Sep 2022 20:59:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 11/17] phy: qcom-qmp: drop unused index field
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-12-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-12-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> Only the MSM8996 PCIe QMP driver uses the index field so drop it from
> the other drivers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c   | 3 ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c   | 3 ---
>   4 files changed, 12 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

