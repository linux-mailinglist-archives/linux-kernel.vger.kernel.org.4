Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7A642471
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiLEIWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLEIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:22:43 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C12E1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:22:39 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 955D111ED;
        Mon,  5 Dec 2022 09:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670228557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cawzhIrCiAJrKU4rgqns2i/i9FlaNB5jAb1CiiwigTg=;
        b=dzGyMcFnsKv8tBH5RiAV8tn5dQq9ToCaVQiu/j+CK7ZUbklX+1dlFKI4CEpn6wEv+bUbmw
        22B3R6+qUNjuBBoQrwZ5M7GOaHbJxCx7eAYUtWsY/c68ZJXSU2orOuS2bOfDytKv4N41DQ
        ZqV5dJ1NMLV/52q7b1CXc07ASRBVFbPg4MwZMRCKN7wELq9H7cKUCisxfpOmOQ6ApdMd4D
        YI/z8TKCaUJq04TB+QJ3yqSgrHRV3CPaDXie33pTQ+JMoc+0cWG9GdiQzr43gPgsSC0RXP
        aGm5rBO+wpCGtokA1KvNVNhC14iU3fU9n9/GfyvGMDDDXGi33JpSUJlfpKV1Vw==
MIME-Version: 1.0
Date:   Mon, 05 Dec 2022 09:22:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Victor Lim <victorswlim@gmail.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        vikhyat.goyal@amd.com, amit.kumar-mahapatra@amd.com,
        alejandro.carmona@amd.com, Victor Lim <vlim@gigadevice.com>
Subject: Re: [PATCH] Linux: SPI: add Gigadevice part #
In-Reply-To: <20221204080000.4100-1-vlim@gigadevice.com>
References: <20221204080000.4100-1-vlim@gigadevice.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <dee37d18f8de5af7d07388031fc08571@walle.cc>
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

Hi,

Am 2022-12-04 09:00, schrieb Victor Lim:
> Edited gigadevice.c

Please have a look at
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-michael
