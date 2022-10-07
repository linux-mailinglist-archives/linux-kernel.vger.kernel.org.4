Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF75F75A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJGI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJGI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:56:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E0D0CD6;
        Fri,  7 Oct 2022 01:56:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF8FB660232A;
        Fri,  7 Oct 2022 09:56:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665132963;
        bh=eQnYDUglnn+OiK5+/TOurG2r3pVBcawFO1+tNo83sxU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FXNiWPZsX96QQWET/TBivzsajY8eR7KlP49kFKdHeWf87uZwErzzCJ7wOFHw2UJC0
         D/lI/qxQuvIP/jVo5/hB/ueC/hP60gizSgZ0wlK0ZlHijuyMA7OzHzAJ3GP/nF5iDc
         VVBwf+eeIyYiL5pAfil3Wlkpo3YOOQ8N8H8s4Yy5b/0tBWcY7+ePs+i0VAIhegLfpw
         w2SetvWQfo9bKobmHUPwtDSM+9MFKOqUStBBNybgC+cWDZtHg9U8mN0N3xe0W/RJiY
         9QzSroXZNtCweeFGOhTsAKTjBDhjCJK0JmTSevrpocRVzBz2xNpt+8LJoMmgxEDuIG
         awQIVrJ9vT6lA==
Message-ID: <399d5e6f-009e-210f-1ed5-88fd2aa5d3d1@collabora.com>
Date:   Fri, 7 Oct 2022 10:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/5] arm64: dts: mediatek: asurada: Enable internal
 display
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221006212528.103790-1-nfraprado@collabora.com>
 <20221006212528.103790-4-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006212528.103790-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 23:25, Nícolas F. R. A. Prado ha scritto:
> The asurada platform has an ANX7625 bridge connecting the DSI's output
> to the internal eDP panel. Add and enable these devices in order to get
> a usable internal display.
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


