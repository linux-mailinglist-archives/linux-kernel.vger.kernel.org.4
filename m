Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC04712B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbjEZQzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjEZQzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:55:47 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676411B5;
        Fri, 26 May 2023 09:55:42 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 246C8846EF;
        Fri, 26 May 2023 18:55:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685120141;
        bh=6frG6Y6LuJoq+4JW6/RF24wFHuVYnnxTvxq9UXK5aGQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MBBgPDWNck7An4NuQmqGc4XC/iuXvMnwVSj55c2tTv1ZGtBzC7quNc17PtHo8IIvw
         gOAZcncXU4izX0kG+dwyM5apVKmMfPNKf9DT3r2Tl7yQak8zkMuGuzaocTmo+dEbw/
         OmOo3eonvGQxHR+5+8I2xIDfRj7mca2syvZjGr2vcfY9Hpt2b27etLqACwxhZWieUk
         ygAa56W+tZ0OiESjTZDeFnMW8NKFXmd/V7IiBejKRwJTuP9mQUyWodvI/7dVXC0rBI
         F0IEI2qqR/HLr7nEzDMdHxfPHDK/pSCZ95ppE1z4a8AMD8RtubAdHa6INGpH47N/9c
         HY3GSGtbsZUlg==
Message-ID: <2f8fde5e-68b6-6187-7051-7e51e58186c5@denx.de>
Date:   Fri, 26 May 2023 18:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/3] dt-bindings: display: st,stm32-dsi: Remove
 unnecessary fields
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
 <20230517143542.284029-3-raphael.gallais-pou@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230517143542.284029-3-raphael.gallais-pou@foss.st.com>
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
> "#address-cells" and "#size-cells" are two properties that are not
> mandatory. For instance, the DSI could refer to a bridge outside the scope
> of the node rather than include a 'panel@0' subnode. By doing so, address
> and size fields become then unnecessary, creating a warning at build time.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>
