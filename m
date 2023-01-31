Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B4682594
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjAaHcs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Jan 2023 02:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaHcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:32:46 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61D42B0B7;
        Mon, 30 Jan 2023 23:32:45 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 12BF024E1E2;
        Tue, 31 Jan 2023 15:32:41 +0800 (CST)
Received: from EXMBX167.cuchost.com (172.16.6.77) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 31 Jan
 2023 15:32:40 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX167.cuchost.com
 (172.16.6.77) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 31 Jan
 2023 15:32:40 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Tue, 31 Jan 2023 15:32:40 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: repair file entry for STARFIVE TRNG DRIVER
Thread-Topic: [PATCH] MAINTAINERS: repair file entry for STARFIVE TRNG DRIVER
Thread-Index: AQHZNH029ca3Y+nofU6pYdo9/RGqe664ImLA
Date:   Tue, 31 Jan 2023 07:32:40 +0000
Message-ID: <b994277b5be24b8eba14d69228ca1208@EXMBX168.cuchost.com>
References: <20230130073109.32025-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230130073109.32025-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Commit c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
> adds the STARFIVE TRNG DRIVER section to MAINTAINERS, but refers to the
> non-existing file drivers/char/hw_random/starfive-trng.c rather than to the
> actually added file drivers/char/hw_random/jh7110-trng.c in this commit.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file entry in STARFIVE TRNG DRIVER.

Acked-by: Jia Jie Ho <jiajie.ho@starfivetech.com>

Thanks,
Jia Jie
