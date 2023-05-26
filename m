Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A34712B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbjEZQz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbjEZQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:55:23 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990FE1A8;
        Fri, 26 May 2023 09:55:21 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6D0CE846EF;
        Fri, 26 May 2023 18:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685120120;
        bh=TDL/5pkk1HH5CR3koHDtyH//neQKpUvPrVWTDhNvaFo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PGNmN3NtYH5BzbQtpboTI29V3xodt+mYuEaFxTyztuaXPlp/d+mVMBnVjlnewkilF
         Q6boCsoIlCDgBZcd4u4+owZ/ctOjIRmlAqB1YgnyE9ViGCeAnbCizvXO8ShP5cp1p4
         +c1CEygRksUk75nIcE3LqDn6oBjXh71ZROTLZy6Zka6+Wc3svboRSJAINO8+69V9w1
         V83Cgum4/kh0WDtEgvt2foyCUOz8LIFYo/KImXBOBB8qH2g0KgzcXYfLh5OHdeoZaz
         ifcudq6PfV5l2iKbOdBXx29T3JLIe1GQ6RN43xJ9mOW11EknoORfEgM9S4lJ9AXjc7
         FFrn6SZareSfQ==
Message-ID: <e4973081-a0c3-dc82-7efd-ab94284c0813@denx.de>
Date:   Fri, 26 May 2023 18:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/3] ARM: dts: stm32: fix warnings on stm32f469-disco
 board
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
References: <20230517143542.284029-1-raphael.gallais-pou@foss.st.com>
 <20230517143542.284029-2-raphael.gallais-pou@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230517143542.284029-2-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 16:35, Raphael Gallais-Pou wrote:
> Several warnings appear when building and checking stm32f429 device-tree:
> 
> arch/arm/boot/dts/stm32f469-disco.dts:182.28-184.5: Warning (unit_address_vs_reg):
> /soc/display-controller@40016800/port/endpoint@0: node has a unit name, but no reg or ranges property
> 
> .../arch/arm/boot/dts/stm32f469-disco.dtb: dsi@40016c00: Unevaluated properties are not allowed ('panel-dsi@0' was unexpected)
> 	From schema: .../Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
> 
> Fix those.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>
