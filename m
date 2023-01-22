Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF26676C48
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjAVLVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 06:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjAVLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 06:21:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E6F1CAC1;
        Sun, 22 Jan 2023 03:21:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F8FAB80A36;
        Sun, 22 Jan 2023 11:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6408C433D2;
        Sun, 22 Jan 2023 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674386475;
        bh=hhL4owlHSb7bTGGL4JOXpwJorCM1k6EPqpOeVcz6xuk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kSrwphvoMzmfojC0Gr5hBMhrk/Zt+5W3hSe8664nYNogg1GCoZVD4xPRJppoVa1Wn
         giClbBm0b9FuwiPRAOK61GYWmnIdWYjw8443ol25fz1kSYhL66Ui00xscNYfyLKlt5
         cXd+w27p0pQyErVDTAfOptz9kCjBJK4RaeS2syg/AX6UoJUjq1K0PVWw9oBpzffINi
         pk5ghYXJzqxqRNy3vpAEmizr5+YvBZqCw6oyunbbqj3oa3KYOGW3ou5P+0WIbQcVBs
         tDz96oDRoyHkmprvuj+/fCbXsuXE86mUb60o2eRc6AOr0iL5h02Z4hn11QL1zVH4c8
         lxZcSitMEm3QQ==
Message-ID: <bbb4f42a-28a1-e54d-28d2-1c3c23fc9074@kernel.org>
Date:   Sun, 22 Jan 2023 12:21:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] ASoC: qcom: dt-bindings: lpass-va-macro: Update
 clock name
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org
References: <1674210685-19944-1-git-send-email-quic_srivasam@quicinc.com>
 <1674210685-19944-2-git-send-email-quic_srivasam@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1674210685-19944-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject prefix: ASoC: dt-bindings: qcom,lpass-va-macro:
(you got such comment few days ago)

On 20/01/2023 11:31, Srinivasa Rao Mandadapu wrote:
> Update clock name from core to macro in lpass-va-macro node
> to make it compatible with existing driver and device tree node.

s/device tree node/existing DTS files/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> 
> Fixes: 67d99b23c881 ("ASoC: qcom: dt-bindings: add bindings for lpass va macro codec")
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You also got this comment last time... so I don't know what to do more
here...

Best regards,
Krzysztof

