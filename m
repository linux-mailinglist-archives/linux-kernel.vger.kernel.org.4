Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887A6FA008
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjEHGjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjEHGja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:39:30 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC1469D;
        Sun,  7 May 2023 23:39:28 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3EDA112EC;
        Mon,  8 May 2023 08:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1683527966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6M1Ih63w56e4EHUEuM6ZDRiovFqST9QgQFM0cgHYD4=;
        b=KmpVUxJXUkzB1QEi9Svp88PLsI4/Akj9QAn7dtiJsUXETU6UnFaiq6uX/BzVLZskBaTJsa
        4EqGjyFNekFEGiLVWzL8vRstkFCTh3e2ixO8qkoZofzLEwrqXPWJH6kQ7zSf78/m3BsICU
        Z9uDbt65auf7giMYCEeOMwaOdVnuLdkGDkdqfvJuGCkS9vQJ4H2Wtn79Q2eLei525ZEXn2
        +WaYhHMCyWeI07CV+t6CKgHb0i0TWan0t4axh0yl5rGBTQPjOBe3I60k4b7aHQYnWZy42p
        vB2+OHnyM1R6pe/jZW9tHZU7CBsGMEYjDjUawuqj7yli9xA2Q3Qy5/1V6Zu95g==
MIME-Version: 1.0
Date:   Mon, 08 May 2023 08:39:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v11 char-misc-next 1/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX OTP via NVMEM sysfs
In-Reply-To: <20230429120209.2232-2-vaibhaavram.tl@microchip.com>
References: <20230429120209.2232-1-vaibhaavram.tl@microchip.com>
 <20230429120209.2232-2-vaibhaavram.tl@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5445b9ad526aa1f4beaa47a3b0e7d83f@walle.cc>
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

Am 2023-04-29 14:02, schrieb Vaibhaav Ram T.L:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> industrial, and automotive applications. This switch integrates OTP
> and EEPROM to enable customization of the part in the field. This
> patch adds support to read and write into PCI1XXXX OTP via NVMEM sysfs.
> 
> Signed-off-by: Kumaravel Thiagarajan 
> <kumaravel.thiagarajan@microchip.com>
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Co-developed-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
> Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>

I just had a quick look for obvious errors, couldn't spot any. It's
not a extensive review, though.

-michael
