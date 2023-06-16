Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A78733735
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbjFPRMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjFPRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AFDC5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7879D62E3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 17:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAB6C433C0;
        Fri, 16 Jun 2023 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686935550;
        bh=KlTwkwXblCNvivnAXZAG0KbO1kr/0iJApC9exLWjwQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XxMhIBTtbYbQNwDNDxZAKj3cIkAcPSZgQbghzI/y5G4TmoEbnnlNBKIXRO/4nC9Pz
         lnlbV90YTs29wq7WR2g/xZfivFt0zKTLoPbLAlRwlbxgwUdRhxglqu3qjwlSDvWVYa
         1m3zrPA60CALcQc8R/OriSte+FhSaVTQoBZhHpqta3Ls8XfM4o9fpzSHMDzFOhHkIS
         ZlHmkMFPGB71aljLZTp5UvwdBm8c1HtU8TxO8xlaunuGtgVUVLXrXTCxu4pTRWwCql
         ba9OnDVWuYMg51I2bvAyob67ucv7Wywg2o3YBpgYOT69qT1V2jqm0nRl2C5p77UKU3
         JHW8XFRJKZzwQ==
Date:   Fri, 16 Jun 2023 10:12:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Veerasenareddy Burru <vburru@marvell.com>
Cc:     Sathesh B Edara <sedara@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] MAINTAINERS: update email addresses of
 octeon_ep driver maintainers
Message-ID: <20230616101229.1e7339f0@kernel.org>
In-Reply-To: <BYAPR18MB2423D248B84D85F3C1A48159CC58A@BYAPR18MB2423.namprd18.prod.outlook.com>
References: <20230615121057.135003-1-sedara@marvell.com>
        <20230615101311.34f5199e@kernel.org>
        <BYAPR18MB2423D248B84D85F3C1A48159CC58A@BYAPR18MB2423.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 05:04:24 +0000 Veerasenareddy Burru wrote:
> > What does it mean to be a maintainer to you?  
> 
> Sathesh will also be maintaining and submitting the changes for
> octeon_ep drivers, going forward.
>
> Is the right way for this is, add Sathesh to MAINTAINERS list along
> with his first patch/patchset submission ?

The patch is perfectly fine. Please see my question as half survey half
commitment device. I don't think we have a crisp enough understanding
of responsibilities of "corporate" maintainers. It always worries me
when I see someone who never (AFAICT) sent an email to the list before
get nominated as a maintainer.

So I'd like to hear from Sathesh, clearly stated, what responsibilities
and SLAs he's taking on. Once we gather input of this nature from a
handful of maintainers maybe we can distill a guide in
Documentation/process/...
