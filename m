Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2E6417BB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiLCQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLCQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:21:11 -0500
X-Greylist: delayed 88 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Dec 2022 08:21:10 PST
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAC12034A;
        Sat,  3 Dec 2022 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=NdcOIwh7jH2NLDg8q17GpPYOPgUAra9TG2q90s/q5d0=; b=Bx62S9QYTn+h93Reu766DcUuqo
        IKHf//g8i+huz6J95GONDSIhr2SqvAoUgK2nKQiUP72oUwhdCwJc1xfzpoVDeU2mNIa11y1hkiLWA
        AnHMgBTlnboREybcZ45rd8rpWWs2OXfW54IEBKxAgkYTu2pzOIMIxzuPVscRgcUkfUPsnRpxroYfd
        TUsGYuuZrAinJf25cdzisXP1OJW00ojvO6agffY1O6yK0uH0oGktG35LFiO9wBwLoX6vTw4JGVSko
        lxIvbID5CzucBGGlMPRy/GbK6FDhBuDYVHHdr3xLngBEyb66gBDLZoTTIUOpX5z09Xk1TodE/3JnE
        f/rg4Rjw==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=57152)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1p1VGG-0003tm-28; Sat, 03 Dec 2022 17:21:08 +0100
Message-ID: <3e2ff466-d573-d932-467b-3307da90c697@tronnes.org>
Date:   Sat, 3 Dec 2022 17:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/3] dt-bindings: display: panel: mipi-dbi-spi: Add
 io-supply
To:     =?UTF-8?Q?Otto_Pfl=c3=bcger?= <otto.pflueger@abscue.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221201160245.2093816-1-otto.pflueger@abscue.de>
 <20221201160245.2093816-4-otto.pflueger@abscue.de>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20221201160245.2093816-4-otto.pflueger@abscue.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 01.12.2022 17.02, skrev Otto Pflüger:
> Add documentation for the new io-supply property, which specifies the
> regulator for the I/O voltage supply on platforms where the panel
> panel power and I/O supplies are separate.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
