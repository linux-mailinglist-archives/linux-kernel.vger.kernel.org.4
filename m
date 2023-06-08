Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09F728276
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjFHORz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjFHORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:17:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86B2728;
        Thu,  8 Jun 2023 07:17:52 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 05F336606EC6;
        Thu,  8 Jun 2023 15:17:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686233871;
        bh=776w8Rc+ZB/YuVdJraNCHzBh0XlMM1U4N0G+6pRxdoM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JMMbGt1+Nw5ErNNdLFOXuT7JWP+JexiZNm3uVwy2MXjzbjmJ5BL26sRYroV9Tzqfl
         RBDdJT+HOpzjum+cY5BMHg9q/uHFWbnbM9xfEUvP+kAyUZC9N+LLNS29rWDJ4M1yin
         C86dIIC76EY44w4oF/BmejOvALRjcriEDfUCNInfwpTR7zwZY/kof7/lpU7MJKoje6
         h7KwEfnz0jIQis2bYEHXUZ1VbfSGV38gT9XzWS27BdvubhM4lrAeJObTF/5iMfzPv1
         /8+eN7bKqClVQwSMAKP1Y/snUnGe/X1K12kUZQKYi2re7Dn5wo12QcCAZG6JRUsxAa
         FaByVIDcYF2bg==
Message-ID: <626ae5b5-ca52-987f-855e-d188fa12511c@collabora.com>
Date:   Thu, 8 Jun 2023 16:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8186: Add CCI node and CCI
 OPP table
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230607090653.2468317-1-wenst@chromium.org>
 <20230607090653.2468317-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607090653.2468317-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 11:06, Chen-Yu Tsai ha scritto:
> Add a device node for the CCI (cache coherent interconnect) and an OPP
> table for it. The OPP table was taken from the downstream ChromeOS
> kernel.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


