Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1624C733444
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345836AbjFPPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbjFPPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:07:31 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093A30FC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1686928046; x=1718464046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z71f+ItIcebrPU1PBYh087NSCRQNSUfJNNleQs3WmQg=;
  b=lMLgDRDi7szq+1hwIVCYkAklY28EYr0L1aRiT8OHqrBt2fv5Dtk94Eie
   kOwdr+IBdHEiwaF86rvX65j/9fA0e3vyyRHT3ieFduAiQCfey98EQHK4w
   hDAuopUgXH/DzJPVZRJFwNdWv3TqW0qxAOOvo49Nw52G29kZ6qCvmfUXy
   U=;
X-IronPort-AV: E=Sophos;i="6.00,247,1681171200"; 
   d="scan'208";a="10615424"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 15:07:23 +0000
Received: from EX19D007EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 66E48A0648;
        Fri, 16 Jun 2023 15:07:23 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 15:07:22 +0000
Received: from [192.168.31.171] (10.1.213.30) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 16 Jun
 2023 15:07:18 +0000
Message-ID: <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
Date:   Fri, 16 Jun 2023 17:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        <linux-kernel@vger.kernel.org>
CC:     <graf@amazon.de>, <mzxreary@0pointer.de>, <xmarcalx@amazon.co.uk>,
        "Amit Shah" <amit@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, <bchalios@amazon.es>
References: <20230531095119.11202-1-bchalios@amazon.es>
Content-Language: en-US
From:   Babis Chalios <bchalios@amazon.es>
In-Reply-To: <20230531095119.11202-1-bchalios@amazon.es>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.213.30]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Some time has passed since I sent this. Any comments/thoughts?

On 31/5/23 11:51, Babis Chalios wrote:
> This patch revisits the story of user space notification about VM
> events. It uses uevents to send a notification to user space that the
> VMGENID has changed, thus we are now in a new VM.
>
> Please note, that this is not a "you need to reseed your PRNGs" event,
> which was what the previous RFC [1] was trying to do. It is, explicitly,
> meant to be a "you are now running in a new VM" event for the user space
> to consume, so it can do things like regenerating its MAC addresses and
> refreshing DHCP. For these cases, we do not want to tie on the "you need
> to reseed your PRNGs" event, since these do not necessarily get emitted
> only when VMs get cloned.
>
> [1] https://lore.kernel.org/lkml/65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org/T/
>
> Babis Chalios (1):
>    vmgenid: emit uevent when VMGENID updates
>
>   drivers/virt/vmgenid.c | 2 ++
>   1 file changed, 2 insertions(+)
>

Cheers,
Babis
