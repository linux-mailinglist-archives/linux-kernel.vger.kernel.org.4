Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79480674F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjATIVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjATIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:21:02 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFC44CE7C;
        Fri, 20 Jan 2023 00:21:00 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id A129B123C;
        Fri, 20 Jan 2023 09:20:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1674202858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2YGMvOkJJ3edSwKTwvliLo6LlI8cpRsq5B4Ascd4k8=;
        b=ZPL0LXsWKcu3D45/yajKnPOECCDYC4/69KzUOf8VExmhzWgBQeiwLe10pqdeS/ILOZYl5o
        +LquF8+/m5x66baKOoiOXaCyq0bC/l9z3m6JkYSFLefvPsH3bbkYZMtgTsqZrxBum5Ay5T
        H98sGqYoJy4Wym+AD1y4wFyIAFVTxGeL1F8XtSkWUKoh03NxDJ+Ik7o9mpe5e4oYguJsT8
        8wLgn37Mh7JrXqaSjwhLqWX3udnHWDmxMpzqvpcvbojef6D2LQz8RvM4RAcOl1Og9SaFi0
        9yUp7ce6WUwnhDgwmyvi5uJjOxQ+o/X425xY7st62PYSoHCdr2cV03VLCoE11Q==
From:   Michael Walle <michael@walle.cc>
To:     amergnat@baylibre.com
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] spi: spidev: add new mediatek support
Date:   Fri, 20 Jan 2023 09:20:54 +0100
Message-Id: <20230120082054.610626-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
References: <20230118-mt8365-spi-support-v1-2-842a21e50494@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Mergnat <amergnat@baylibre.com>

> Add the "mediatek,genio" compatible string to support Mediatek
> SPI controller on the genio boards.

What is the use case of having the spidev? What if I want to
connect a device with a linux driver to it? It seems like you
just want to expose the SPI bus on the pin header. There was a
similar discussion for a mikrobus connector [1].

-michael

[1] https://lore.kernel.org/linux-devicetree/YmFo+EntwxIsco%2Ft@robh.at.kernel.org/
