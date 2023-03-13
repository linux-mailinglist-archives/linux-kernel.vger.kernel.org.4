Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E56B71D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCMI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjCMI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:58:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3558B57;
        Mon, 13 Mar 2023 01:54:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F9E26602F64;
        Mon, 13 Mar 2023 08:54:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678697649;
        bh=admtLczq/Oe08BYYh7NJZInoBni+S8Ud4YDJ0IMS12g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UwnLBdLThDgg+25+IUSw1XTQ7/OdINQyaS8DviABkAmScilRD3qHZFNReItOksrA+
         OqeLi/0XkI/nKKgw4XZJeHTXqE+U1IkIEVMf7H1r/mpwd1tvIDwyfsGLaJZ3s0UMm0
         ht7zP23kA1l33vKWBY6XZCTyY37+gFPDAKsZhJ5I1QXY2LmalPOBSJz8CcScP6OHbq
         HkTswuQMBq4sRIuiAMynSMbONder9M+EkgZJPBycJKp1HDlyihRlzzdwWUbhLesXID
         rusHiBDDYlmG/oJAwUgkfO9w3YS60KzPxP3RGDYaT3uqjQH7Q7dv4KIwI526mOluPL
         gNkzY+aL1rdAw==
Message-ID: <d0a2eb84-4420-8b6c-bd97-e58aa47be289@collabora.com>
Date:   Mon, 13 Mar 2023 09:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/30] clk: mediatek: Make mtk_clk_simple_remove() return
 void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
 <20230312161512.2715500-2-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230312161512.2715500-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/03/23 17:14, Uwe Kleine-König ha scritto:
> mtk_clk_simple_remove() returned zero unconditionally. Make it return no
> value instead and convert the respective drivers to .remove_new.
> 
> This makes the semantics in the callers of mtk_clk_simple_remove() clearer
> and prepares for the quest to make platform driver's remove function return
> void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Hello Uwe,

since there's a big cleanup series that is well reviewed and that is touching
practically all MediaTek clock drivers, can you please rebase this commit over
[1]?

Thanks,
Angelo

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=726914

