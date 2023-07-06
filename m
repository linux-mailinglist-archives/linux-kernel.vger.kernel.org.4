Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0513B7495D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjGFGmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGFGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:42:16 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7921123
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:42:14 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C8A01D7E;
        Thu,  6 Jul 2023 08:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1688625732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzYZ7s45Fs2Q+QMEeOTcP2cLhvl0eQ2Eswiy7C6Hb7c=;
        b=Kf3TK7QSB4GIYFHU+3xWlezbLwGRf+r/he2H4cPJhpOMbz9WHaK6JHR+TknzGGYhnmYmX2
        7xExojDPVFpfsMQcNGH2M+eevsVEqgASoh6E6jaHeNMxJnUMHTXFOGYs04C8MX+43VkqI8
        bEuypSAAhDxhMvnZmMaBWQt02FTY+fYiGHWaKF2tlY6wiHB8jbv8+L9Mw6zsoVKf33TQH0
        C3mR/50l3UIsPrmpCK4317yYkhuLEc+w3wrzU6nEMCoPk71D6EQtJOYym00oPNM0QafYdh
        h3SdqtT5jx/Ys4EXBSFjAz+OExHK45FUPlWbUxgoK0VGXnmcF2POJBgw71tbIQ==
MIME-Version: 1.0
Date:   Thu, 06 Jul 2023 08:42:12 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mamta Shukla <mamta.shukla@leica-geosystems.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
In-Reply-To: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
Message-ID: <c1fe9a411e917778d70c7482568e8c63@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-07-05 17:49, schrieb Mamta Shukla:
> mt25qu512a[1] supports locking/unlocking through BP bits in SR.
> 
> Tested using mtd-utils- flash_lock/flash_unlock for MT25QU512ABB8E12.
> 
> Link: 
> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211
> Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>

Reviewed-by: Michael Walle <michael@walle.cc>
