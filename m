Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2DD715641
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjE3HKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjE3HKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:10:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960E9C;
        Tue, 30 May 2023 00:10:01 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9BD4B66059A8;
        Tue, 30 May 2023 08:09:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685430599;
        bh=gbkeXGoZObwdN2ipj3haLfblttLYhE6XU/0z3iE9Wkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aFxwnxPfuAk4Jm9ojPCyvi9YLIrh7MCjtu+w4j6SAfK0FdsUwkjVANz6sM/XBkOwX
         1oYF/nvrOEVHn5/rb4Zv5fgMqy1Wdj/fWnu8QMICf0wbkK3OwXwBIDkcZbOhpPevqr
         z7WjnVD1ALHlu0RjcSMm/UrXJvds7b0WczRQduMXFLiaKP9hxG7czljCC0ptvbN/gY
         A/0okV3nBpsS3RyxUJv2+L4i9poi2pri0b/W7k2I2fMqDEA2vb5ba+0/kTZkp1zLrR
         1S55V8wm0ne6tpUtyxbpR/OXEYIJAUmos0bY9eVZe71lJpJLAcTsgtM0g5Yxy5HAJY
         9xjjdIh1UhlMA==
Message-ID: <4f22b6fd-4801-33f3-e3fe-978c465d37dc@collabora.com>
Date:   Tue, 30 May 2023 09:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
To:     Prashanth K <quic_prashk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1685421871-25391-1-git-send-email-quic_prashk@quicinc.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1685421871-25391-1-git-send-email-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/23 06:44, Prashanth K ha scritto:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, added a new constant in enum usb_role, last_role
> is set to USB_ROLE_UNKNOWN before performing initial detection.
> 
> While at it, also handle default case for the usb_role switch
> in cdns3 to avoid build warnings.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


