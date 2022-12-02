Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB76E640926
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiLBPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiLBPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:16:09 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE6DC4CFF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:16:08 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 38FCF75;
        Fri,  2 Dec 2022 16:16:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669994166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTY7W9AuURAmXh1e0g3ooGoEB3zos3qaFWWlauQi6Sk=;
        b=lj49bsqNGPwxB+tpE/CmIgTPt1WMTGu+DAE2Whhh+c1UT+boygL5ngNT/tCBzvRS8dLn1N
        2xwfwBrRIA9i3+N2o5cTVc345hRoD4awRTHQVZC5DB8Lol/4nveXivLQT23Ni0qCEKsbYb
        zz/CGAaZN87Um4c84E9ytfNoIiswAf6DWe7guOtuiuD6POmP0mZpcZOjZCUcYvUaI0cSpT
        4wwV/nchbjS6/tgR9lGdtzza2y8trKeXYKGdMrCmHwmY7UQ5RfX/bw05IOa82cB1i2y3MS
        4kzYPyZLFaPvZPGy1+4Sr1nstV/+zRbQ3tsMYKaqkTrt2+CfRRTP0mMei8ExfA==
MIME-Version: 1.0
Date:   Fri, 02 Dec 2022 16:16:05 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: Add additional octal-mode page
 program flags to be checked during SFDP 4BAIT parsing
In-Reply-To: <20221202135539.271936-3-nathan.morrison@timesys.com>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-3-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <517a30b96e5b7c3305ad99d238125407@walle.cc>
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
> This adds some support for automatically searching a chip's SFDP table 
> for:
> 
> program commands: 1S-1S-8S, 1S-8S-8S
> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

Maybe a bit shorter subject and more text in the commit
message. But I don't care too much.

Reviewed-by: Michael Walle <michael@walle.cc>
