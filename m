Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCC64090F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiLBPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiLBPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:13:29 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C36D7DB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:13:13 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8EE0F88;
        Fri,  2 Dec 2022 16:13:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669993991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMd+8gwhXm0Fts7QCJ/QK2hfDZAHqyWO5aLUxQbiTRQ=;
        b=J1Wzk2PgyZvCZMvCymQSd0PjvrBIyptWHSY5KUv2QVIy5BPV/31hQyu/PJmEnXeoWY+FGv
        pUmGHK0i1OuxihbFfe9D62U4Szf9XTMZz718rk/Qmgsh5Bji3zCHCAiANYFLVGOJB8dmXm
        SEUazpoly748dLkDsrv7VBLJg1xg0FRvew/TjVm3/hCqe6HunkldM2z6J/GGZVNXUg/PYi
        ezNBtxksqvhA30P3/EHpq+7XWMdq0EDO0mWBCyvZYDPjFhDb7Intz5kA9BHT/PpvTUkN4t
        FGeHktoUyLKekNgCtnsn3r36cH6PFJ8orSembemIvX5GlLw6NZ57xiVLY3x7sw==
MIME-Version: 1.0
Date:   Fri, 02 Dec 2022 16:13:11 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mtd: spi-nor: Extend SFDP 4byte address
 instruction lookup table with new octal modes as per JEDEC JESD216F
In-Reply-To: <20221202135539.271936-2-nathan.morrison@timesys.com>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-2-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <80cc15aa905f151ecb28500fefdd0817@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-12-02 14:55, schrieb Nathan Barrett-Morrison:
> This adds the new bit fields for
> reading: 1S-1S-8S, 1S-8S-8S, 1D-8D-8D
> programming: 1S-1S-8S, 1S-8S-8S
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

Reviewed-by: Michael Walle <michael@walle.cc>
