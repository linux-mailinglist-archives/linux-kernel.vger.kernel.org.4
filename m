Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB56E4549
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjDQKet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjDQKer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:34:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA5810D3;
        Mon, 17 Apr 2023 03:33:48 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A640666031ED;
        Mon, 17 Apr 2023 11:33:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681727609;
        bh=QLUjIbjUcIOPLd9/HNG4iW89fNegx9KVDgzv+yvDcyc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nzL9QRipUXU73q1MTpw4f0qNFUAEmxqXqnKReO2VZRRPU/UQbLY+1yMKYB+055EVV
         A4CotFWYXRtiMBoTmYh2vHXmH3vV14lK1xbyLZfa21JjVThxkQ9Ytu7lbAcFQLiwUQ
         L1olJSx9osoYRbn9/Zz0gdcPc+M8J7K22qqgFh2Qg+tq8Jbbm+azGr7psJg7mTW1El
         KV/DQioS4fiI/BJBNXuLa8zkdAn6aRwZ3F1q2+Sp8wLvfQvXkgRZWt8qNNkPTbkwVc
         9BuUSqtvxZwhgG7fjBdVlYhKiZr6eiGNVmjCRUQssId8F6tNdEwZIY/ZWM9qi3b21j
         TSJLDgx0Qv8gA==
Message-ID: <eba25ba2-0815-4461-416f-6b5ae5d5e5a2@collabora.com>
Date:   Mon, 17 Apr 2023 12:33:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] soc: qcom: ramp_controller: Fix an error handling path in
 qcom_ramp_controller_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <84727a79d0261b4112411aec23b553504015c02c.1681684138.git.christophe.jaillet@wanadoo.fr>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <84727a79d0261b4112411aec23b553504015c02c.1681684138.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/04/23 00:29, Christophe JAILLET ha scritto:
> 'qrc' is known to be non-NULL at this point.
> Checking for 'qrc->desc' was expected instead, so use it.
> 
> Fixes: a723c95fa137 ("soc: qcom: Add Qualcomm Ramp Controller driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



