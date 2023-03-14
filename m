Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C36B99E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjCNPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCNPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:38:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F224A76BD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WABzYTnabi3s60fKuuL2P/MSD3EcLOo9sdyabvdUrXU=; b=BbLqcx3uLE7s7/9p2tLfzn9nEN
        5AePU0KEM3pctid1cGA0DBWojUU2rG50PKq+48M6HJhoBZvgOrnMB+688pzPDt4ztpTuDvpONFGHf
        s0slBvKCYSzXa4lfQINa+thaVfww4trWNNCidcVRtYKNNB9iBY+xu25QHYLIEGNvCxyPvM9niRJCm
        thx29RMt4hncZ4Zk92F7CqkNmHoSZ5Ag8tJQuTheWyVmMRzMfb9NqUPfSOufOTbz4KKLzbirVtAC1
        qAK7VkwZ4sttzv3TBEO9wB879khie0Fogon0TELBjmaoPHP8xjXCuSso8ntLooYkMsVf3Y+CAWU0U
        EtUsul+w==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc6hw-00AdKx-0Y;
        Tue, 14 Mar 2023 15:37:00 +0000
Message-ID: <b4e67355-efaf-e61c-03bf-e54b8790e4e1@infradead.org>
Date:   Tue, 14 Mar 2023 08:36:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] char: add driver for mps VR controller mp2891
Content-Language: en-US
To:     "Noah (Wensheng) Wang" <Noah.Wang@monolithicpower.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luke (Lijie) Jiang" <Luke.Jiang@monolithicpower.com>,
        pebble liang <pebble.liang@monolithicpower.com>,
        "Eva (Ting) Ma" <Eva.Ma@monolithicpower.com>
References: <08e7bd6ed16f4bde95b674db940783ec@monolithicpower.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <08e7bd6ed16f4bde95b674db940783ec@monolithicpower.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/23 02:18, Noah (Wensheng) Wang wrote:
> Hi Arnd, Grey:
> Thanks for the review.
> 
> This driver will be used by facebook. This driver provide a device node for userspace to get output voltage, input voltage, input current, input power, output power and temperature of mp2891 controller through I2C. This driver determine what kind of value the userspace wants through the mp2891_write interface and return the corresponding value when the interface mp2891_read is called.
> 
> Signed-off-by: Noah Wang <Noah.Wang@monolithicpower.com>
> ---
>  drivers/char/mp2891.c | 403 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 403 insertions(+)
>  create mode 100644 drivers/char/mp2891.c
>

No Kconfig or Makefile changes?


-- 
~Randy
