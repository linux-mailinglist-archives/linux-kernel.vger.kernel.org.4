Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA9605E22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJTKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:46:38 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66AD1C5E30
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:46:36 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1D88E1285;
        Thu, 20 Oct 2022 12:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666262794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyfpMJ7wvOKQzKJbA8gxhqaiUcCTequz7kYwWgzsxo4=;
        b=S8juV9ehFY1QtzfsNES16OBDCJDt6D8JuIVPz/Los2OyZjJ6w3Vjia8HTvNhkenO54ppQ3
        unFA6yGNnUmRezw+llCgvp6smheHSUdl+nLDaH/sj86RcbiqSsEZMzD2eIy8tN7mbXeIk/
        rEWjea8uO3QWs23LC7Oxzl3f9pzXOV512GMQEH8dcbHm6NY4EV7MmMCrEr3pbu3X1tRbg9
        zyPNP/obX07WdBHsRY4cKH4ZJpxA9GVSIXWnwqmoYx6tk/JL+2H54ovBwMfEH+I55genyJ
        Q2YoIew+XpV+wQ38hPNvT32jFOsu9aTsY6KekRcOm4EUF9UMJ+FWfU4cKphlkA==
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 12:46:33 +0200
From:   Michael Walle <michael@walle.cc>
To:     Eliav Farber <farbere@amazon.com>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, jonnyc@amazon.com, hhhawa@amazon.com,
        hanochu@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v3 1/1] mtd: spi-nor: micron-st: Enable locking for
 mt25qu256a
In-Reply-To: <20221020092058.33844-1-farbere@amazon.com>
References: <20221020092058.33844-1-farbere@amazon.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d91e3d91f085390d5dbe0c4415c9e37f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-20 11:20, schrieb Eliav Farber:
> mt25qu256a [1] uses the 4 bit Block Protection scheme and supports
> Top/Bottom protection via the BP and TB bits of the Status Register.
> BP3 is located in bit 6 of the Status Register.
> Tested on MT25QU256ABA8ESF-0SIT.
> 
> [1] 
> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Link: 
> https://lore.kernel.org/lkml/20221019071631.15191-1-farbere@amazon.com

Reviewed-by: Michael Walle <michael@walle.cc>

Thanks,
-michael
