Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB7652A78
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiLUAaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLUAaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:30:13 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022C1DDEF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:30:12 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id d2-20020a4ab202000000b004ae3035538bso1582582ooo.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQyrHAs8avSuw2RzVe3kkAfZLtEeJGUdPG7123X/iSk=;
        b=l3JvZYGLdF+uess97IA9FSkL79RRbmXrTgKp+5Mt+GbAQTntR7npqsNfXwRCQc8hNB
         wtdKg24Kp61fw0JKy1VrtZRbF1aXUKRkThke/R/AVqI2dfkrK56aWL0qDDI/HVJiu1O6
         zYhYjwvyy8bojIWAadkyMUJ6odkHLfHEs+ZKc2jFZV2Yksv1+ya5vrKfCjC13HVquzft
         scDgYLLuYZynEUJ+kpCIVf0qr+mcQ37x4Kmr2FIikYQxAiR0sXtxlOSItaQhPH962L6R
         jx7oq3l66QnBRwmO+9sKEVaeZayJowQOPFDhIrBDI30kl7f6omrAVhXmdrsO1dGVr6Eg
         bA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQyrHAs8avSuw2RzVe3kkAfZLtEeJGUdPG7123X/iSk=;
        b=h7wsoEzXMQONIucyw/oxXoq68kGc1MUeka2hybL53Q8xBsnmcP5HWNjQZntt8Ue/V2
         ZnzWt1lQNNZ/oDjDznBEoLINvERwQpngJ5M3Op0RvvGlrdZlWRZX3MC80451nXtwuaiT
         o+GE+w2zpD34AA/EM2QK8tVVdLeBlSwUYqWh5HlIrclTDi2Kl5N2wr6E89Absz3M2shH
         OMWaxAM0T6AEneJQNO+2RURpQfMYo/08O2y3n0lucK+Ezios6IDSNUgYQEvLTJj/2l+r
         Y7k8pF33gY27LFYw76Ohd1i14+xr4N+4WI84yke4ZaaOLjQegGxYTYOp37NatoFRFn1A
         q+TA==
X-Gm-Message-State: AFqh2koz3cDkul0ZdGtAEplRvvIeN+7CyHZA4HtxFFzHzNKMnWWYnhmm
        ZNMvR81LJ4ouqqEMk8f6YAjjlxqFGFg=
X-Google-Smtp-Source: AMrXdXt9Rl2/cCrsNu/PcY3Hk6ryOG7w5t3xnEyQKPcLXaAekU9sfvLVc1muMLqcmajx0gmlo9U5NA==
X-Received: by 2002:a4a:97b1:0:b0:49f:dba7:5e65 with SMTP id w46-20020a4a97b1000000b0049fdba75e65mr62577ooi.3.1671582611479;
        Tue, 20 Dec 2022 16:30:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15-20020a4acb0f000000b004a065c72a05sm5637777ooq.2.2022.12.20.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:30:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Dec 2022 16:30:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based
 on SFDP
Message-ID: <20221221003009.GA280250@roeck-us.net>
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 20, 2022 at 07:48:07PM +0100, Sudip Mukherjee wrote:
> The datasheet of is25wp256 says it supports SFDP. Get rid of the static
> initialization of the flash parameters and init them when parsing SFDP.
> 
> Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
> SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
> After this patch, it parses the SFDP information and still uses the
> same opcodes.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>

With this patch in place, qemu emulations with is25wp256 fail to
instantiate the flash. Specifically, this affects the qemu sifive_u
emulation. The resulting error message is:

spi-nor spi0.0: BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP when declaring the flash
spi-nor: probe of spi0.0 failed with error -22

qemu command line:

qemu-system-riscv64 -M sifive_u -m 512M \
     -no-reboot -kernel arch/riscv/boot/Image -snapshot \
     -drive file=flash.8Vtb7,format=raw,if=mtd -bios default \
     -append "root=/dev/mtdblock0 mtdparts=spi0.0:- console=ttySIF0,115200 earlycon" \
     -nographic -monitor none

Reverting this patch fixes the problem.

Guenter

---
# bad: [1e4fa020d574768445fca2d9bbfe473ec8bbd224] Merge tag 'mtd/for-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
# good: [a594533df0f6ca391da003f43d53b336a2d23ffa] Merge tag 'drm-next-2022-12-13' of git://anongit.freedesktop.org/drm/drm
git bisect start '1e4fa020d574' 'a594533df0f6'
# good: [2399401feee27c639addc5b7e6ba519d3ca341bf] mtd: maps: pxa2xx-flash: fix memory leak in probe
git bisect good 2399401feee27c639addc5b7e6ba519d3ca341bf
# good: [bcc0c61e6134066f4629845691a514ea33465653] mtd: spi-nor: micron-st: Enable locking for mt25qu256a
git bisect good bcc0c61e6134066f4629845691a514ea33465653
# good: [a50ae8c98e5766a4fcb78e76f13cc658b784eac1] mtd: nand: drop EXPORT_SYMBOL_GPL for nanddev_erase()
git bisect good a50ae8c98e5766a4fcb78e76f13cc658b784eac1
# good: [6408cc05a50aaf88074a5a31d065e5af87a456f5] mtd: rawnand: Drop obsolete dependencies on COMPILE_TEST
git bisect good 6408cc05a50aaf88074a5a31d065e5af87a456f5
# bad: [1799cd8540b67b88514c82f5fae1c75b986bcbd8] mtd: spi-nor: add SFDP fixups for Quad Page Program
git bisect bad 1799cd8540b67b88514c82f5fae1c75b986bcbd8
# bad: [a30f53d8bc0f9b55b4e8eea0e17b68cfd1f07f34] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
git bisect bad a30f53d8bc0f9b55b4e8eea0e17b68cfd1f07f34
# good: [ef434f08b0562069cf431873a052692357d325a1] mtd: spi-nor: winbond: add support for W25Q512NW-IQ
git bisect good ef434f08b0562069cf431873a052692357d325a1
# first bad commit: [a30f53d8bc0f9b55b4e8eea0e17b68cfd1f07f34] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
