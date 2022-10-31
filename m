Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0DA61370C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiJaMyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJaMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:54:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C519DFCF;
        Mon, 31 Oct 2022 05:54:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D301C6602387;
        Mon, 31 Oct 2022 12:54:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667220843;
        bh=6HSA0keXiYZHWd4vcyDkF3gQm80/JF/fbLuG1n/AqMo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N37IlxGOqcndjfZzddvIZLeK5SsGYsciQeEjs7xPNHKEjhmxMwcP9iI4IqMvbq68a
         JNfFVCYVH7p0viG67bO2WBka0AiS6fiCWmQJtTvlyNeRaq0okwgb1w8BBPqwp/4kV4
         hkJDW8B/GMNkJupIubEGMUI9jTVShxa2FrnCZqGLGQT/+O8lK/BIKV3PNOUPsiqnZl
         5W4E6Vq61N4RQmtOlM0uj+z3uwluDUFjPpkXCsRbjAE8oVKz1qg4022eFaIJqDG4C/
         OpwFm65Fb7HlnLLgW9ybZU1iEFQgUn6GgT0BUC1MEi65WZt3x9GFPhS51E+UUmHyd3
         WFwzkbXVS+qJw==
Message-ID: <068626e7-b564-7221-4645-6a53f8e015f2@collabora.com>
Date:   Mon, 31 Oct 2022 13:54:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sc7180-trogdor: Add missing
 supplies for rt5682
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-8-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028205540.3197304-8-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/10/22 22:55, Nícolas F. R. A. Prado ha scritto:
> The dbvdd and ldo1-in supplies for rt5682 are required but are missing.
> They are supplied by the same power rail as AVDD. Add them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


