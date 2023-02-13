Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218DD694993
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjBMPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjBMO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:59:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32621DBA4;
        Mon, 13 Feb 2023 06:59:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8715D6602143;
        Mon, 13 Feb 2023 14:58:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676300329;
        bh=GlHs18fNUrttNNSB3N8yeRwqf6SXxogII5LXG4D91q0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hCijmZqnjZUeDWhzsKYQ1G00WP/LoIo/0x6hNj3rbOQ4HE7FzVvrOoALQP0fzaiUT
         kFzDlP+KVxkSAv0aHAnkIp5UrEFipFArPUw6hEGWWQUccg4lk7iJBqPHC5t1SOOAM2
         IfRoyyR/5Cu9FDkkeI1KFWQrCVPIAfbx3Y5CpmHRrD/jqGf+7uG7KwsJGzPDEDyTMY
         xnv6zr660akc5MxDmH8Yji65FNQd27T6rDT+sB8sLI1zJ2HEMdlzwca7yynXpswUHW
         QEmIObEoomX6IwMuIeH7oDPcCPsn9ZrKEchIY2idh7O4mWdg04fA4wlsnoE2FpBBxP
         6hTYQbhs0TbzA==
Message-ID: <ea8a7c2b-002b-c1e0-99a1-7ce49887e32d@collabora.com>
Date:   Mon, 13 Feb 2023 15:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 08/12] remoteproc: mediatek: Control SCP core 1 by
 rproc subdevice
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230213033758.16681-1-tinghan.shen@mediatek.com>
 <20230213033758.16681-9-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230213033758.16681-9-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/02/23 04:37, Tinghan Shen ha scritto:
> Register SCP core 1 as a subdevice of core 0 for the boot sequence
> and watchdog timeout handling. The core 1 has to boot after core 0
> because the SCP clock and SRAM power is controlled by SCP core 0.
> As for watchdog timeout handling, the remoteproc framework helps to
> stop/start subdevices automatically when SCP driver receives watchdog
> timeout event.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


