Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B616D667D91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjALSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjALSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:12:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB35B91;
        Thu, 12 Jan 2023 09:41:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A70562096;
        Thu, 12 Jan 2023 17:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA97C433D2;
        Thu, 12 Jan 2023 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673545279;
        bh=59i5RgEf1vjXvEXQpowOJVYe9y3HVOOG3D5NVnGGkXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDMhLduh5yDA2wwL6jmhnYwyhN5A6/f/TzweizgNgG1/Zo7NXfxvIt/6lhPdNQSBc
         fChT+HpoypfM1OJWHvLJJnyPusQ2SLWvojokWbDdo7PUnVGqZ9L5/4qVyrI6wU9GFd
         Gb14h68BiWU+ZiLmyiHynkdv1U6vGOlNg+pdxzjMSGBQDEM4OW7SDuJCcdldf8oihw
         DeZ647wGfJutTUnZmYT9TteX4IaDiG6LO43+91Aze7jHTwx0JkUT6yion4JqlvY+OX
         u3W7gwN6b+J3pC6yKEabIflA3h5tt882EBy5y7rxqDpyUG6YTtuVxcf7y2xNEFQE8M
         blKK1hH6CQEMQ==
Date:   Thu, 12 Jan 2023 23:11:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v9 1/5] dt-bindings: phy: mediatek,tphy: add support for
 mt7986
Message-ID: <Y8BGO7A8hxAV57tp@matsya>
References: <20230106152845.88717-1-linux@fw-web.de>
 <20230106152845.88717-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106152845.88717-2-linux@fw-web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-01-23, 16:28, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7986.

Applied, thanks

-- 
~Vinod
