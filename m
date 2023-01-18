Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7334671DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjARNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjARNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:24:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A161E1F7;
        Wed, 18 Jan 2023 04:51:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBCD46602DFF;
        Wed, 18 Jan 2023 12:51:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674046296;
        bh=lRImklMheY/mkerDhgF3t+gOPWvx98JSfHVl/z55Mwg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eV9a7C/DAkgpHzFu+lxyYL9ggSGKrRwZI+eY2S0maBO7wTwByBqCpS52K8nbm3Pj0
         JkRVQzRW5k8xNiffu4Rrw8MEL2T+1Uud/zsmyVcI1+vaDCMnsJcVi1zk2INR1XH+YD
         bVW5JZYgehWiVirH7/uiIyIon/rMRkBK/PqOVybCRoE/RPB07kVbzSwV+/XAf1M6FH
         LqKnApM5JEFyTHxIParFd1sGZIQxgkDvocRx6ENY57BlEdkZ3t8KpUADULE7X4Uv0Y
         EslnVXL/SHC6sVwi36ridWXDoDXYGpqigm+g57dp7XCQHZUdW+5oxzjb3T8/v8gMsp
         YfEiNh4sx8laA==
Message-ID: <0488e63a-aa81-08ea-4b32-2bb608c957ea@collabora.com>
Date:   Wed, 18 Jan 2023 13:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/2] thermal: mediatek: use function pointer for
 raw_to_mcelsius
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>,
        Frank Wunderlich <frank-w@public-files.de>
References: <cover.1674012985.git.daniel@makrotopia.org>
 <69c17529e8418da3eec703dde31e1b01e5b0f7e8.1674012985.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <69c17529e8418da3eec703dde31e1b01e5b0f7e8.1674012985.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/01/23 04:55, Daniel Golle ha scritto:
> Instead of having if-else logic selecting either raw_to_mcelsius_v1 or
> raw_to_mcelsius_v2 in mtk_thermal_bank_temperature introduce a function
> pointer raw_to_mcelsius to struct mtk_thermal which is initialized in the
> probe function.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


