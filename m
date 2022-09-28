Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF65E5EE10D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiI1P6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiI1P5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:57:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3C0DED51
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:56:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id iv17so8797391wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=dDShWwrvhx0VR1icMwP79MrRYhMPzc7W3e5rekv8htg=;
        b=t/SRZzjc+5jjgbhTwwdUCsFa3EU64WSIJ+bFwOqKGITlg+sfU0SgozLKTvFhuWxsDN
         cRl7ynGZ6WtdmxLib3TSeaOP8PGpwpDZdm0pyw6SNs8WulacjvbRbXAJKQN0D4sN+ADQ
         noe9yyrhD9j6tsrbdAsnpE6f6GaXW8UWt4aYiSY5bRmJxhx/O+YuGE4O/d+4rqPrMHdi
         XJG16oEqWQo/CjTKbfyIoUV7liH7ArOAmJvd3mkrrINEuQprfBCVi1x7nbjCvFGWENMX
         9WUDNiQIkgyqJbPl6+pu6yUzRWdaNjOVoyFeXNuFo+QbGpf3U2KnrqMuHJjvdJloW24L
         zLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dDShWwrvhx0VR1icMwP79MrRYhMPzc7W3e5rekv8htg=;
        b=eTNr/X2K3E9SHlfAFrv2jDJy2NV9qQ2s0F6xGECIpcsRRJvIsz4Tyo0KcILtFg1Ugr
         w+aqFL8kKnekvM/Yeo7xgFrG1TVM68CwfJHJqeZDzA86fBds37J567T27w2wKVaBIvdl
         /Wn4OjG9yP4quvBxjyeg24bCoCN87ivIU7c1twP/lGaHueaP+T/VHjIurVvNl+mDuS4m
         rRTodt43jLSy0oZFqo6/o6E5T3BEZTIH1MWi1YnEXnjqWNQqEckuPUoal4gEhdALEest
         2AmdfnTQ0w7YRZtvGr20eycC2UM+f8QQ14pmbi07MjQ/rTLdLmalFjO+ZaF4mW/6cMiJ
         dckg==
X-Gm-Message-State: ACrzQf2R5efbyMVet5YM0IRD5g2xTXHvnBInLZll3OFebMBlnx5S+V9V
        3RQmKFGKNDpWL+BCF4KBltzang==
X-Google-Smtp-Source: AMsMyM6N9kpPNaFjUA289IxvcNaZQDNnPPMbfwiV/i7ACz+D7197zZymQOiB8T2KkiqgSMUDJtLXlg==
X-Received: by 2002:a05:600c:1d26:b0:3b4:a677:ccc9 with SMTP id l38-20020a05600c1d2600b003b4a677ccc9mr7349169wms.121.1664380598283;
        Wed, 28 Sep 2022 08:56:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11d4:7c71:accf:6521? ([2a01:e0a:982:cbb0:11d4:7c71:accf:6521])
        by smtp.gmail.com with ESMTPSA id t3-20020a7bc3c3000000b003b4868eb6bbsm2373519wmj.23.2022.09.28.08.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 08:56:37 -0700 (PDT)
Message-ID: <444c7905-6dfa-c4f4-f4b0-c92ee4a4a403@linaro.org>
Date:   Wed, 28 Sep 2022 17:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/13] phy: qcom-qmp: fix obsolete lane comments
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-2-johan+linaro@kernel.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220928152822.30687-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 17:28, Johan Hovold wrote:
> All QMP drivers but the MSM8996 and combo ones handle exactly one PHY
> and the corresponding memory resources are not per-lane, but per PHY.
> 
> Update the obsolete comments.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 2 +-
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 2 +-
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 2 +-
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 2 +-
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
