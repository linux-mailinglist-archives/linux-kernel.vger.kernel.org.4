Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C3744576
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 02:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGAAJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 20:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGAAJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 20:09:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035783C29;
        Fri, 30 Jun 2023 17:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=frNBpN5Ah3HHFVhq8vAbyVzkXEJ+bYa1e3oBl0nbpV8=; b=Rjm4s0jhP5lIXdHShrT46FIvjH
        s2XBFAkiha/owQok0aH8tLh8hgGUOr6FpmeOEEtxxvpHpFvaEfrHONpnjcI9vpplPd64Cf5H5Jnly
        4pdxaQpQTy8MXt+ogOlpSXZkegcNUv+HXs4Ix/a5X9Pu3omWw1WGIdGAkFbqxg2UDb4g0iYwh7k6C
        wldq9b6brR27zlSiUe9hQCOoSmRuiSWlVpPHBb2Pvajybllk1QuHStiVcnp3X9gX7nwEe5I5rJ9xJ
        KYOmumRWUZpcwL8Dgm9k0+NdcC2kPeOBI5jfItR6ohMpUAr+Z7BFADgVLaWrGCjUMLgkaKleeX8IO
        c1XJm8SQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFOBH-004oqX-18;
        Sat, 01 Jul 2023 00:09:39 +0000
Message-ID: <2e729756-4468-9e3a-2664-9b1b4b4ca060@infradead.org>
Date:   Fri, 30 Jun 2023 17:09:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: linux-next: Tree for Jun 30 (drivers/bluetooth/btmtk.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Jing Cai <jing.cai@mediatek.com>,
        Chris Lu <chris.lu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
References: <20230630131756.6dee658e@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230630131756.6dee658e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/23 20:17, Stephen Rothwell wrote:
> Hi all,
> 
> Please do *not* add any v6.6 related stuff to your linux-next included
> branches until after v6.5-rc1 has been released.
> 
> This release is broken for 32 bit sparc builds.
> 
> Changes since 20230629:
> 

When CONFIG_DEV_COREDUMP is not set,
gcc 12.2.0 (crosstools from kernel.org) complains:

../drivers/bluetooth/btmtk.c: In function 'btmtk_process_coredump':
../drivers/bluetooth/btmtk.c:386:44: error: 'struct hci_dev' has no member named 'dump'
  386 |                 schedule_delayed_work(&hdev->dump.dump_timeout,
      |                  

I see this on arm64, ppc64, riscv32, i386, x86_64


PS: please add a MAINTAINERS entry for btmtk.c.

-- 
~Randy
