Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB626C0885
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 02:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCTBbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 21:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCTBal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 21:30:41 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 154FB1556A;
        Sun, 19 Mar 2023 18:23:19 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(2727:0:AUTH_RELAY)
        (envelope-from <prvs=1442F5243D=cy_huang@richtek.com>); Mon, 20 Mar 2023 09:14:30 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(14131:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Mon, 20 Mar 2023 09:00:51 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 09:00:50 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 20 Mar 2023 09:00:50 +0800
Date:   Mon, 20 Mar 2023 09:00:50 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Lee Jones <lee@kernel.org>, Alice Chen <alice_chen@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the leds-lj tree
Message-ID: <20230320010050.GA23894@linuxcarl2.richtek.com>
References: <20230320114816.2abe5751@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230320114816.2abe5751@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:48:16AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the leds-lj tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/leds/rgb/leds-mt6370-rgb.c: In function 'mt6370_check_vendor_info':
> drivers/leds/rgb/leds-mt6370-rgb.c:889:15: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>   889 |         vid = FIELD_GET(MT6370_VENDOR_ID_MASK, devinfo);
>       |               ^~~~~~~~~
> 
> Caused by commit
> 
>   55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
> 
> I have used the leds-lj tree from next-20230317 for today.
>
Already sent the patch.
https://lore.kernel.org/lkml/1679067760-19098-1-git-send-email-cy_huang@richtek.com/ 

Wait for reviewing.
> -- 
> Cheers,
> Stephen Rothwell


