Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11145EE609
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiI1TxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiI1Tw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:52:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F17C74E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:52:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a8so21905562lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TmHquM/S838I0W3etX4ILh+MW3CKmq4SAxyvSg/zqqQ=;
        b=WNn2CNANydh4/XvjrZU4pq+uN1MCM1mmEmEVJVpIRk03UtNVlkmBQCLDwuqkoy8DT5
         iKzdxJLRZGDmKsnvwDLB4pV2UCwMHtNfuZiMEoJxG168LAo0H02/8Vr5Xj5T++3jUf6D
         NuUafSzd4uoCH5YbnSMv757AcRg/aFlAVKNruq8/1L+fr7otk44ewBbVq6BPvZKaTDAc
         fvz3jQ39pn7CsYrzq37aR15oP75WOJcJ2nlcit9oi3dseEmuJooTU+vLP+17ykkBnCrJ
         EPLTaCHp1u4lsNPghYnAo7hUk+Jh40LtO2f0DAKy4U0Jq8xcX/IoJcGUrxf7QPNTMJAe
         NDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TmHquM/S838I0W3etX4ILh+MW3CKmq4SAxyvSg/zqqQ=;
        b=EFI8IKvPt95YGDqxXLgFcvmDghlLWfPHANG8+Z0JU8wwoRipcwcrv0JmCgggb5CwQw
         mJAL+cZkfPlfXHxK+NwciiG58XR2Hr8t1SGNqiljoaY2ftNjmmqpbsXK/s6BCNPi6CT+
         iT5fJHx9FDCKCsKAPRRPOsUas1kyVEBEeNEUcJeJIf2HdC2s4IN64Unq+UtTM98vU/6j
         10JuLIp3B/dimVosAR3W8SJ85ou4OQs8opk4TOgcWdTxDwI54W0rOzWecMB4mTqYvSq2
         LzMRR6NVfQmhukH+L1S5dxF3o6ytuQldv8TtgRa65HUD+78iZvdvDW658wspn9Iyyc7x
         1MVQ==
X-Gm-Message-State: ACrzQf0NsYkk6Wvotei/O/dekcA/AEOdfcvU6r3n68kC6EKXue8PoToQ
        0HzUXiGNaQY8XwGlBz1WOZJ2Ow==
X-Google-Smtp-Source: AMsMyM5Xy2LGiEAAHSyv+eyoHBGwNAg3gEpPQzXoDqwmf2+HceMc19AxWpGniC+CBQEWDpCG7dd+Qw==
X-Received: by 2002:a05:6512:b97:b0:497:5c43:2d61 with SMTP id b23-20020a0565120b9700b004975c432d61mr12860680lfv.251.1664394773836;
        Wed, 28 Sep 2022 12:52:53 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b28-20020a05651c033c00b00261ccf566e3sm511392ljp.65.2022.09.28.12.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:52:53 -0700 (PDT)
Message-ID: <d03c2b1f-6af1-ddb1-4324-cc5e77faf320@linaro.org>
Date:   Wed, 28 Sep 2022 22:52:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 09/13] phy: qcom-qmp-pcie-msm8996: clean up power-down
 handling
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220928152822.30687-10-johan+linaro@kernel.org>
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

On 28/09/2022 18:28, Johan Hovold wrote:
> This driver uses v2 registers only so drop the unnecessary
> POWER_DOWN_CONTROL override.
> 
> Note that this register is already hard-coded when powering on the PHY.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

