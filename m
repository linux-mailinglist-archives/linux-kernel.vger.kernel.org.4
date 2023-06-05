Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1154D721FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjFEHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFEHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:36:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F08483;
        Mon,  5 Jun 2023 00:36:47 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E77F966056AC;
        Mon,  5 Jun 2023 08:36:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685950605;
        bh=J26N876qhqy+oXA3TrC9yeaPT4WUXxr7qA4zM4FsXpI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C2Z8ZECKZYSjFeJAZIJBBJWYXBQyp6GA2qaWGaPe31T4lfmm0heMZlDDhQTMFRAqV
         fu/4W/fDYFbfetIQ75qFnNS6pzkVkFQUPpuh91Bd2j63ZgjDEzIZP8UYRGawdFJha8
         YVhsahztRL0lLB+2bM4mVPJXZrVAhMfauyYJyuo2KVPAa0+BdwmCDsyZjpGJx2og/m
         d/Az85yPA0enqsBsyOYxaw393x3T4khEPuDBAfbGTSD7hmp5M/SpGf7CP8ZmTSzBdo
         ZguGSRDoVXKOZhO1cy14G9mbJY1eg/ePsVdfgxiZ3HDCQ+ZLe5vkG7YajM6YIaCEaC
         ighBEFtWA7KgA==
Message-ID: <1423b370-6212-7f19-3db4-a70102bf615f@collabora.com>
Date:   Mon, 5 Jun 2023 09:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] arm64: dts: mt8173: Update thermal node
Content-Language: en-US
To:     matthias.bgg@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20230601134425.29499-1-matthias.bgg@kernel.org>
 <20230601134425.29499-2-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601134425.29499-2-matthias.bgg@kernel.org>
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

Il 01/06/23 15:44, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Following the binding description, update to use
> thermal-sensor-cells = 1
> While at it also fix the node name of the CPU critical trip point.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


