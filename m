Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3062B5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiKPIxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiKPIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:53:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D671AF0C;
        Wed, 16 Nov 2022 00:52:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 836136602A81;
        Wed, 16 Nov 2022 08:52:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668588777;
        bh=R54KFgfJ4OyE41N0DG1cL5j9FFmQznXDsqIoA3UGQDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c6Jn+VDJtkIr5H1tDQxeKd+KUFZByR+oF+vyiouOd36xqQmoQIZ7LoDbwbhLcxnPu
         8h0IT31HYSMWn7EUUsQGY6PaiRVPmsuJm4qVGFlwTL/OLODlDIZTuSgA0NOUJZXjX6
         I58WUBSs3XzrTAWN6i0j//d+s7FEkweMhXRWboLNz/CYg13LVQoVRL/mvo2/dQONfi
         cXz3udX/DAzhDaJ2byyD160sgrzblRMUKPzYEp5LxZ52yQ2EgRah4Dgnqh7IX+p2Hf
         J3x+NpMUT7hehLLK1q19Pw6gTW8MXUCXv4vRFkCkJgU1UnZa/5U38scPNvCv2gWRoC
         2Fptt47jpO4vQ==
Message-ID: <9f3e88fa-0aaf-2edd-366e-c3f5b2269dba@collabora.com>
Date:   Wed, 16 Nov 2022 09:52:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 05/11] dt-bindings: mailbox: qcom: Allow syscon on
 qcom,msm8976-apcs-kpss-global
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-6-angelogioacchino.delregno@collabora.com>
 <14947ae2-c8d4-de86-ce9e-29175e73cbb2@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <14947ae2-c8d4-de86-ce9e-29175e73cbb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/22 17:44, Krzysztof Kozlowski ha scritto:
> On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
>> MSM8976 supports SMSM, which needs this node to also be a syscon:
>> move the compatible to allow that.
>>
>> Fixes: bcc8d70f912d ("dt-bindings: mailbox: Add compatible for the MSM8976")
> 
> I am not sure if this is still a bug. Maybe just a missing feature?
> 

This changes how you use this mailbox across the entire devicetree (as other
nodes will not use mboxes = xxxx, but qcom,ipc = xxxx as syscon), so I think
that this is not a missing feature?

Cheers,
Angelo

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> Best regards,
> Krzysztof
> 


