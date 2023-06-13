Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B461872E868
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbjFMQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243075AbjFMQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:21:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364421BCD;
        Tue, 13 Jun 2023 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=97aImOeixrL2gdg6gSWQ4e9JZgBEAU+a5A8NTT/u71s=; b=oRfaLgMMtbIMqJPVc/hkEPNr26
        L3rOOHyJPIe+koLJf49PpjS5Bzl2gO84UoC0tWhCX+A9jko0G85jTtSdgy9R+Afk6+nIPckMuK7Rg
        7LXM4/NPDTHR/2fhvZ7Rw91UiDQgQISdFdjrP1aF6vDsjyjgKWjaTKURGkQS9UN+fA7jbjb2ojrOq
        470LpKlqYcU/YUdw1/h+qAWu2K6SZW7sRDsiu2zLYxenjGQxYGj4hBzWKtq+lTnaZEAbeTgGGN3tb
        ilPN1ro5uHz1Yztm/n1O0vfHerOIEp61rGsDLKcF85vXh8JTGHxTAawpTPX9lcr87IspYoa47KrwT
        i3cWQVjg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q96ls-008a5f-1x;
        Tue, 13 Jun 2023 16:21:28 +0000
Message-ID: <8f9f8d38-d9c7-9f1b-feb0-103d76902d14@infradead.org>
Date:   Tue, 13 Jun 2023 09:21:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 13
 (drivers/net/ethernet/freescale/fs_enet/mii-fec.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20230613165903.5cc10e58@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230613165903.5cc10e58@canb.auug.org.au>
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



On 6/12/23 23:59, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230609:
> 

on PPC32:

../drivers/net/ethernet/freescale/fs_enet/mii-fec.c: In function 'fs_enet_mdio_probe':
../drivers/net/ethernet/freescale/fs_enet/mii-fec.c:130:50: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
  130 |         snprintf(new_bus->id, MII_BUS_ID_SIZE, "%x", res.start);
      |                                                 ~^   ~~~~~~~~~
      |                                                  |      |
      |                                                  |      resource_size_t {aka long long unsigned int}
      |                                                  unsigned int
      |                                                 %llx


-- 
~Randy
