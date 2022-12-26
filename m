Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B36563CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiLZPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLZPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:21:27 -0500
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Dec 2022 07:21:24 PST
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F2DD43
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=e9bygt9btbW9iwPktn9TB5j7OYW3jMUXCcPXvrorm8c=;
        b=msH6HEoDoiW4TnKVAkHA5AS/j7GFph8h3oWgxILBS0Mx1YCL/5UnqyOnoXAmTi2iXIjQkjTEqPz/v
         O/UykmRpq0vGnN/7iYv3sIBzw7cVc8wksMc7PvWXse/P8XiAjfZHlaSsztxmU5LE877ekdx/XaG7yG
         ag0A/Zt92svMepjPAGD6nT3vQ86VQkIoOfNzxmahvkw/T/qiDpTf9hhSC3MpVQEzasrVX7ddSiBtv8
         lhbXKxS02QHSFmpEbS8pqJk5RWFHY4vo8gatJSWcYeTD3h7Te9pBUz19Rfio0ZMhO2rDB/FCemmP1G
         uUXxENmWhMi1oVv+tsSNVJJCql5YrRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=e9bygt9btbW9iwPktn9TB5j7OYW3jMUXCcPXvrorm8c=;
        b=FFjtsigMz8bhHtfzvzFDv2aSfDXgi6MbaO27/WJsWwRut6rXOcEbzFvMIqF24Yiywxe93Wrdkvw67
         yJsRSBBBA==
X-HalOne-ID: b46d9cb0-852e-11ed-8ff6-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id b46d9cb0-852e-11ed-8ff6-cde5ad41a1dd;
        Mon, 26 Dec 2022 15:05:18 +0000 (UTC)
Date:   Mon, 26 Dec 2022 16:05:16 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] drm: panel: Add Himax HX8394 panel controller
 driver
Message-ID: <Y6m4LONOyoPo/+Cv@ravnborg.org>
References: <20221226134909.2822179-1-javierm@redhat.com>
 <20221226134909.2822179-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226134909.2822179-2-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier.

On Mon, Dec 26, 2022 at 02:49:05PM +0100, Javier Martinez Canillas wrote:
> From: Kamil Trzciński <ayufan@ayufan.eu>
> 
> The driver is for panels based on the Himax HX8394 controller, such as the
> HannStar HSD060BHW4 720x1440 TFT LCD panel that uses a MIPI-DSI interface.
> 
> Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Strictly speaking the binding should be applied before the driver.

	Sam
