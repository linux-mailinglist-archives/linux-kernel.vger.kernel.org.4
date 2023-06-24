Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6825073CA71
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 12:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjFXKWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjFXKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:22:38 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6437193;
        Sat, 24 Jun 2023 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1687602147; bh=ZPqsBRiD2qdKFt2nVlMfoA1SbLdu/T9qJmjOqN2CHAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JUArZ8ozT/rg2RDioIv2B1MhrjG1VXLBsgdHjvcOx+8AvHsqOUUS7CGmjkDzF4ALm
         vObAPSRGGRViTAOw6ayaQCRVA9W/6ts8+MN8zZpjUKyWzPbVDiSk/HUgP4HSieR0TL
         397Amj9J1D6evWKTrfJ92CclNM9oQ1rSzqcgsyhE=
Received: from localhost.localdomain ([240a:42d8:2400:8e2:3982:c8ab:f689:6a24])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 5932A218; Sat, 24 Jun 2023 18:22:19 +0800
X-QQ-mid: xmsmtpt1687602139tyiycog4l
Message-ID: <tencent_817CE182DEDA938E03B848314821098D4408@qq.com>
X-QQ-XMAILINFO: OEUhVsHQax4MuZAT+PUI+KMeFIffDAhIbn+ONyhtlPxiFnj+0X0WnygNB/pViY
         kyrMZZ4DxzsDvNpI7jzo7iSw1LWSaUR1k2k6MEEhdkKM/7dPOJKqB17AAnR8nPyRSCSiDq8GiCEe
         OkyS3oGCmwHGaiJdW3yPtT8EacU0GXoaXFmvXet7d0sPiTLNnelvZvXwxbECj1m5EXaulFOW9UYo
         +0UB+AaicFX4ZWf6qK8bDseSI0ipJURoi+kQl4xEQHT2QNpNS9vTOxWyg94e/bioZVGrF60T4kt/
         L7gbGJTN9CL+BauLT8MNDZvfHsunPxjUbeeF7sSALwE8vN6Oqe8gxhjNk1Cg5Zsv4Plany4JsYsf
         VN6BegI8k2/98eZ/qP3l/w2Ieq3MPVfYPkcBD/oGvj4CZtfi443W0v23y6oLJ0i5qWsBi1qzvOZS
         aAL8uw/TcmCboe7qDezeVsknQbE7AhJuW0OeplrCCWYmjZO548Y95lOA003uLyM981FzYOnUPWXJ
         JAAb6r0CGATCZ8NkQxJlWbpECWzPNfKszs5hhrzHIgiyxdvY4pPero+Uyybwf1ybWKOGkuuKus9t
         8u/6KFvDd9zOB3UEpFVU4MiMwUHJcyllspeX8RA2yHHjecqYmjvea9ArgjIlSc38R3dv87l1Be2u
         DOwpH0d9RbSo5XuoRWMqiPplz/F0o95bEn7EE5TWmxyFWsag8JoxDI2BaHTxUMNQ9X89qRfyo6A6
         pY7TdGGlYSjWRZFCYjETAqsAqI8dJfboMrtcIB6Vs/IQHALRmqUitn7PCAlWukm+GcDJJ3bSLgki
         fFSn1URidlLVVDLHoIA9/IRLC1T5lypbGYiwIvtaem706XZ+ucbbGjlYK2A7SLc/cwDfYA4+3wUx
         GyccTKi0O1uuYKwNy3eZULCw6RKNjO8g4hXPqmLC9tmQXBmji5GkFiAU63DNTEmeEc/MHidSc+A7
         88iESTzoZSBg7nn/tG3cwjWocoAQSDIP8Y40H/PgWTmYc5tKGnTusPWS1fAPb8Jwmp3aKhR0U=
X-QQ-XMRINFO: Mu10XATLq/IERfXGovp1cJndKWH8Kl+aSQ==
From:   Yangyu Chen <cyy@cyyself.name>
To:     evan@rivosinc.com
Cc:     ajones@ventanamicro.com, alexghiti@rivosinc.com,
        andy.chiu@sifive.com, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, conor.dooley@microchip.com,
        corbet@lwn.net, cyy@cyyself.name, greentime.hu@sifive.com,
        guoren@kernel.org, heiko.stuebner@vrull.eu, heiko@sntech.de,
        jeeheng.sia@starfivetech.com, jszhang@kernel.org,
        leyfoon.tan@starfivetech.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        lizhengyu3@huawei.com, masahiroy@kernel.org, palmer@dabbelt.com,
        palmer@rivosinc.com, paul.walmsley@sifive.com,
        rdunlap@infradead.org, samuel@sholland.org, shosie@rivosinc.com,
        sunilvl@ventanamicro.com, xianting.tian@linux.alibaba.com
Subject: Re: [PATCH 0/2] RISC-V: Probe for misaligned access speed
Date:   Sat, 24 Jun 2023 18:22:19 +0800
X-OQ-MSGID: <20230624102219.3049-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230623222016.3742145-1-evan@rivosinc.com>
References: <20230623222016.3742145-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for doing this. 

On 6/24/23 6:20 AM, Evan Green wrote:
> I don't have a machine where misaligned accesses are slow, but I'd be
> interested to see the results of booting this series if someone did.

I have tested your patches on a 100MHz BigCore rocket-chip with opensbi running on FPGA with 72bit(64bit+ECC) DDR3 1600MHz memory. As the rocket-chip did not support misaligned memory access, every misaligned memory access will trap and emulated by SBI.

Here is the result:

~ # cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdc
mmu             : sv39
uarch           : sifive,rocket0
mvendorid       : 0x0
marchid         : 0x1
mimpid          : 0x20181004

processor       : 1
hart            : 1
isa             : rv64imafdc
mmu             : sv39
uarch           : sifive,rocket0
mvendorid       : 0x0
marchid         : 0x1
mimpid          : 0x20181004

~ # dmesg | grep Unaligned
[    0.210140] cpu1: Unaligned word copy 0 MB/s, byte copy 38 MB/s, misaligned accesses are slow
[    0.410715] cpu0: Unaligned word copy 0 MB/s, byte copy 35 MB/s, misaligned accesses are slow

Thanks,
Yangyu Chen

