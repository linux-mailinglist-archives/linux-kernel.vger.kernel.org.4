Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960A4602610
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJRHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJRHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:45:40 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77201263D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:45:37 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C68741D2C;
        Tue, 18 Oct 2022 09:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1666079134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwuNwWcyNAFSlRAr+eqDH3/oNtts/gH6iawPwlibttI=;
        b=PdoxgIbf8iBcEgq/aSEK/uDPeL9g9X9zPXxrlIfMP0FtQ3EpuSGYy9U7Javotb0Fucc4/F
        85Lwz4NrbUhuG9ZTl53sYz1ZzxfQYC+TeD3ghHeDB0CfaopN4JDejM8p0+9UOzL7lvpk69
        1278m/oT8ro0G/qj3rVwYw1fsTGQeMB256DZ08SonSut37BLEEXk7o8VAW85gth4m2E1kj
        6VGD58hSW73kCRkYTTB7vvwA86lq6ZaXjt5EvvrT7JsFGI1ZGy7L1INYTKf8pXIw7T9q+9
        gNGDtDeEhR15SJbidCgTIs90HU7v1kQk+ARBf8+u+48meIgf8SHekE9x4r+WLQ==
MIME-Version: 1.0
Date:   Tue, 18 Oct 2022 09:45:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Eliav Farber <farbere@amazon.com>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        talel@amazon.com, jonnyc@amazon.com, hhhawa@amazon.com,
        hanochu@amazon.com, itamark@amazon.com, shellykz@amazon.com,
        amitlavi@amazon.com, dkl@amazon.com
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Enable locking for n25q256ax1
In-Reply-To: <20221018072254.21606-1-farbere@amazon.com>
References: <20221018072254.21606-1-farbere@amazon.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bb7040f60b86b1f028fc6a40f6221ca6@walle.cc>
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

Am 2022-10-18 09:22, schrieb Eliav Farber:
> n25q256ax1 [1] uses the 4 bit Block Protection scheme and supports
> Top/Bottom protection via the BP and TB bits of the Status Register.
> BP3 is located in bit 6 of the Status Register.
> Tested on n25q256ax1.
> 
> [1] 
> https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_256mb_3v.pdf
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Looks good. But could you please dump the SFDP tables as
described in [1].

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
