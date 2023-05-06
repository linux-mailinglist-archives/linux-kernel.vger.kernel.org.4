Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F276F91CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjEFMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjEFMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:01:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0EAD37
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 05:01:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac80da3443so31346091fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683374481; x=1685966481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RAV8sfQEmLzeUJ9ZXGC7Rx9ZUYgZOx9nBASQ2NZDPM=;
        b=bnTu9QOo86v+Ewi/2fxoDNaS11Qv0B3s9A2c9dfLXJF4ouJ7MZ01nBLywCHdgI6fXL
         8tGuBmP4Lu23WW6cmn5Z7Q1caj4istbuoJFi25U9s5NIgf0Vruh4LXJ3J2lgtuoGeplC
         t1Wu0ceQ/Fs5eTSqAnOd5XfZKI95AIwRpVrxOHaM1cxB4h6FPOizLrhUlqn23gfaaIcL
         zHqaomYg4f7JNL9ilxMQSq0s7nt3SdU7SHV+BY3Qn7ZsfTMf41K+7r22/ov6DfRO6kLB
         rg/LmdJyLJxCUk6JdfxWnCdUolrzcIublUB7JZpHPvBAdtcUajH3SJhobY7gZJpDt22H
         Zd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374481; x=1685966481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RAV8sfQEmLzeUJ9ZXGC7Rx9ZUYgZOx9nBASQ2NZDPM=;
        b=V6kBSwHh7RsjhgUZRK1rvDBuVxWoUgJOQRhOP23lNPi36f7WmbFIGvNV89HJ1RWVlb
         o5Ozx5rMuD6W126x3Y/4OcDWw6VgPUZlFUY0LtkAfdSxLmHJEP8iAkEehuUsrtyqRY3v
         QRuOIE9YBaFXI1epzefnk6RVoIjOuUbIibwZF6P2Lm9oKJ7bUZifyqmRRqY2E0OOLYzD
         Hjr6d4T6tt3xQvOkCpAb2LMpJD+Y66tGOMB4ycd0svypt9qoXK7s1IXm+oYYs3z7gprW
         Cu09GsioSVqEGIJ66Q/uAXzOiE0C3mESTz453o7dNWywa8/jnmTRcT4FkNdMNx53ojOk
         NTNA==
X-Gm-Message-State: AC+VfDz0KzE2fJD7WAGppHcGgmy8tbr1iQB/ISUwujip8LX4y/ulaowc
        kkSdZg3vUXsl5ckteIi9mSLrZI+3N6YzTf5SM0U=
X-Google-Smtp-Source: ACHHUZ4jLhJXw7zSCEtYkHDIqxe8RlIj050GS4tWbGHzuMuia8tb9e3DL2SUIjY97tdim4gHMhqWUA==
X-Received: by 2002:a19:f50a:0:b0:4e9:c327:dd81 with SMTP id j10-20020a19f50a000000b004e9c327dd81mr1199408lfb.63.1683374481044;
        Sat, 06 May 2023 05:01:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id z1-20020ac24181000000b004db3900da02sm630723lfh.73.2023.05.06.05.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 05:01:20 -0700 (PDT)
Message-ID: <ad5f9403-7131-7a0e-4fc6-5fdb3454f9a9@linaro.org>
Date:   Sat, 6 May 2023 15:01:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/8] PCI: qcom: Do not advertise hotplug capability for
 IPs v2.3.3 and v2.9.0
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-5-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230506073139.8789-5-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
> SoCs making use of Qcom PCIe controller IPs v2.3.3 and v2.9.0 do not
> support hotplug functionality. But the hotplug capability bit is set by
> default in the hardware. This causes the kernel PCI core to register
> hotplug service for the controller and send hotplug commands to it. But
> those commands will timeout generating messages as below during boot
> and suspend/resume.
> 
> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> 
> This not only spams the console output but also induces a delay of a
> couple of seconds. To fix this issue, let's not set the HPC bit in
> PCI_EXP_SLTCAP register as a part of the post init sequence to not
> advertise the hotplug capability for the controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>

-- 
With best wishes
Dmitry

