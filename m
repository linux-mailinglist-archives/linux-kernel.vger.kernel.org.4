Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C646D44CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjDCMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCMsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:48:52 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06F5DC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:48:51 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D4AC2124;
        Mon,  3 Apr 2023 14:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680526129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxFIPyPfgG3AMigmPNlsaL+7KLePrBjVOrKeoyZBRyM=;
        b=J0P2Eawz+8IN/Vy894IUZdHtGbi+5IwcT1kjZ//HXf/GhqJwHT4/zS4C5+l1j3xfOVdx5o
        jJNKPXuwBNIlXBBbVoUqCwU/P9v5qZkH9yUWMIVSCG+Vk29NWCFK2cYkKuAJv8AA+SGkaj
        yvAKFTvGSe3rCLjuTHRhgjTVVwpUV8Z4itmYk+yFMTheKFB7xVBDboC7LTvtqWGOX0skO0
        z9x9NeYtS7xZlCUDmv+y0VN1Kc9opgTK2R3B5paq54c1b4YJKaOpiBojBdr5AI03qWoVfD
        h2xxTNsRN0CWBI11on8d42q9spef9k3zZv0bLuXZZ+jt0M/mjUXQ8CO1SAVSfw==
MIME-Version: 1.0
Date:   Mon, 03 Apr 2023 14:48:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] mtd: spi-nor: core: Make
 spi_nor_set_4byte_addr_mode_brwr public
In-Reply-To: <20230331074606.3559258-6-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
 <20230331074606.3559258-6-tudor.ambarus@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <13319920b52243b46ac6e08bfa681f45@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-31 09:46, schrieb Tudor Ambarus:
> This method can be retrieved at BFPT parsing time. The method is
> described in JESD216 BFPT[SFDP_DWORD(16)], BIT(28) and BIT(20).
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <michael@walle.cc>
