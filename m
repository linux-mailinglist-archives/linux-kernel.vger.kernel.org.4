Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD51643E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiLFITu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLFIS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:18:58 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70803A456
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:17:45 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 43810126D;
        Tue,  6 Dec 2022 09:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670314663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s4cTi1vPx1lT99w7gcEu65YdC3MGfHB7p5R+XR4p4U=;
        b=ob1t0gLMJPazAqQkmbSP/tuTKYGDYWefM9gGUEn/GHS7a8PYoy2i43fb59b5fXrjAkEqKd
        rCvNnifxFIw1FBT+zdGarmWsYTyvmABtoDyMrHv/336fHzXMZjNx6Vb4XAAQavZ0hxH3WX
        6rON1ZlEQRBxKuqBXpjcSAuMIhNBUW/DNXU2/r0BnAmP3fZ1JKloN9Gy6ok5dRTche3660
        r6+1YyzWtz/Vym4bO8PpT+w+hl26qeGsxqLGG8mqmsccZY8y9rZfdUCuFK4Eja605QFk76
        8jEBIhuOoJNiwtZkPZFpd7NSTeVAPBrLaxZCqIK30FDjmymtUf9MY5whxEkGKQ==
MIME-Version: 1.0
Date:   Tue, 06 Dec 2022 09:17:43 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vlim <vlim@gigadevice.com>
Cc:     Victor Lim <victorswlim@gmail.com>, tudor.ambarus@microchip.com,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vikhyat.goyal@amd.com,
        amit.kumar-mahapatra@amd.com, alejandro.carmona@amd.com
Subject: Re: [PATCH] Linux: SPI: add Gigadevice part #
In-Reply-To: <TY0PR06MB5658B73E2F22472D0AF48BDBBB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
References: <20221204080000.4100-1-vlim@gigadevice.com>
 <dee37d18f8de5af7d07388031fc08571@walle.cc>
 <TY0PR06MB5658B73E2F22472D0AF48BDBBB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d147146428a078bd01ddbb5c1a9a65ce@walle.cc>
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

Am 2022-12-06 02:27, schrieb Vlim:
>  I will redo the patch following this doc.
>  At the meantime, can you point out a few mistakes that I am making so
> that I can correct it in the next submit.

I really don't know what you want to achieve with this patch. It
has a bunch of renames. So what is the intention of the renames?

-michael
