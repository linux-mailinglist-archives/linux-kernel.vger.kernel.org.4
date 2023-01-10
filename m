Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC63663C30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjAJJF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjAJJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:04:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9C4D49A;
        Tue, 10 Jan 2023 01:03:30 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAB7A6602B36;
        Tue, 10 Jan 2023 09:03:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673341409;
        bh=fmZCtUW0HkZGmQJOBbUNGDaB7gq1MKXT27ZjTlNHUvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AZUAASBSCWSP3voAmesJIm17oVaFZCS0lhdR8BQq/eFPSYxoqyLrgINeFrEXlNzhY
         CS1n8jC5j7b0Yy1PZV6IrO7sVj41vKrz1f8WHMAsaOL7eY7R1WoI71FtQWfMOqwO9x
         ynHOoG1XTMpFNZat6tnzluWrIHo8SOlFUT5Svpe1Pj3UD68Frm8L32MZouk4QrFCjV
         0zTae3xWX+1EDBWX1/5449XV9649LKOkCEUUZyMy3yNbit5+0HR65bTqXM+KYRZQZB
         U9aCGq/dLhCZ0mtPilmTru6L0mKrBzfzTBFUF6Khf9Q2wBhbX09H2YrKxWsMp3Cto1
         vGRbo6WS2kOFQ==
Message-ID: <61ae2f3a-0c2b-5e18-3040-e7ad08bbf08c@collabora.com>
Date:   Tue, 10 Jan 2023 10:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] soc: qcom: ramp_controller: Make things static
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230110042004.2378444-1-quic_bjorande@quicinc.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230110042004.2378444-1-quic_bjorande@quicinc.com>
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

Il 10/01/23 05:20, Bjorn Andersson ha scritto:
> The five msm8976_cfg_* objects ought to be static, as reported by LKP
> and sparse, fix this.
> 
> drivers/soc/qcom/ramp_controller.c:235:27: sparse: sparse: symbol 'msm8976_cfg_dfs_sid' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:246:27: sparse: sparse: symbol 'msm8976_cfg_link_sid' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:250:27: sparse: sparse: symbol 'msm8976_cfg_lmh_sid' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:256:27: sparse: sparse: symbol 'msm8976_cfg_ramp_en' was not declared. Should it be static?
> drivers/soc/qcom/ramp_controller.c:262:27: sparse: sparse: symbol 'msm8976_cfg_ramp_dis' was not declared. Should it be static?
> 
> Fixes: a723c95fa137 ("soc: qcom: Add Qualcomm Ramp Controller driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Thanks for catching that and swiftly fixing it!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo
