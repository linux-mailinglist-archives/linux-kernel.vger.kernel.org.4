Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F0671477B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjE2Jy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjE2Jyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:54:54 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C1CA4;
        Mon, 29 May 2023 02:54:54 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 70C14854DA;
        Mon, 29 May 2023 11:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685354092;
        bh=lQTEdnWjjTtx4sq9do2rOkRe9c+JTLk6uao+OPCngtU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hHs4DxvURTENKVsIoE1/nRIsH5tkkSHGGjXt9G8nXaKvwSUY9+UQIEKtc2euMtWx7
         SXlTjvzrDPurWIppeTWFcMCzrV/rMQVa/yvK7ZhbLD3kxai2H9hwOd5aL3EF9YRnRk
         i5MgSlfq2KEJlRrt33ZsMqX3Z6yv4wfblwohXVizZ2BtAYImKGZI4iJv4SqRh8JLjz
         vjtKZodLjh1JvAMtB92dBUquylBDCwIFTzuRLbZ0r4VYqDeuLe6ay3D25YdDSTIkwb
         YRSbLxeFFcTWPdCsz0Jp6YwdeOpPDDk75yeAEbFWa/F1ElpaSMJgc9Zt6pC9J8OJ9K
         /zg7UfGbliK1Q==
Message-ID: <ee1c8e43-3954-c6c3-fec8-e8b29aaa5e72@denx.de>
Date:   Mon, 29 May 2023 11:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] ARM: dts: stm32: fix dsi warnings on stm32mp15
 boards
Content-Language: en-US
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230529091359.71987-1-raphael.gallais-pou@foss.st.com>
 <20230529091359.71987-4-raphael.gallais-pou@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230529091359.71987-4-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 11:13, Raphael Gallais-Pou wrote:
> Fixes DSI related warnings:
> 
>   * "#size-cells" and "#address-cells" wrongly used
>   * Changed 'panel-dsi@0' to 'panel@0' according to dsi-controller.yaml
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>
