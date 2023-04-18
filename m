Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD4C6E5EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjDRKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjDRKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:34:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859919B5;
        Tue, 18 Apr 2023 03:34:19 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8187E6603209;
        Tue, 18 Apr 2023 11:34:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681814058;
        bh=g3ZoOiOIzuzWSrTVc/rLTnS4Nz5d5QQ3aAFUIpYfhps=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bOAO2HCmwNOfic8bCkFEl0rpiQN0kTxdIzLjF2IK9P3Wc7wKdPl4+wzwLKnMnAQO/
         L6uLvqNXayr7YQ55nX+C84s0xli1XFJB3GqbPqNmV0VoFcIwDY0hvT/SfJFtOOR6uq
         N5HVfxVOU6fOmV94IL93moNIs+R3EsMTSLsW9SoYgyAx4Z35rZTlOQeOIpW5tJG4/q
         xtm+JBn+jYz5yA7YhzdlgvTxycL+m8OfVxJsx5y5BeEeQKiZWAaOWatfqMWElYjYIl
         EptK4nf50bbdO+YfVwREbta0YtguLFOYUOe/Wu2Pn1P5uN7xLto9keHvdnWas8TMCn
         wpLI8FbqkoHgg==
Message-ID: <c2fe7e09-024c-b3f7-c7a6-0c2981cb3ba3@collabora.com>
Date:   Tue, 18 Apr 2023 13:34:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: timer: rockchip: Drop superfluous rk3288
 compatible
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230418095344.274025-1-cristian.ciocaltea@collabora.com>
 <20230418095344.274025-2-cristian.ciocaltea@collabora.com>
 <2436573.fIoEIV5pvu@diego>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2436573.fIoEIV5pvu@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 13:26, Heiko Stübner wrote:
> Am Dienstag, 18. April 2023, 11:53:42 CEST schrieb Cristian Ciocaltea:
>> The compatible string for Rockchip RK3288 is provided in both the 'enum'
>> and the subsequent 'const' item. Drop the unnecessary entry from the
>> enum.
> 
> And the actual rk3288-timer case is handled in the separate
> 	- const: rockchip,rk3288-timer
> at the top of the list too.

Right, in total there were 3 occurrences of this compatible string.

>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 

Thanks for the quick review!

Regards,
Cristian
