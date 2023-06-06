Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F24724ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbjFFV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjFFV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6CB10F2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4D0636E1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A584C433EF;
        Tue,  6 Jun 2023 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686086948;
        bh=k5dh5UqC/q7zNRQQgS95fX7gkoUieGfOD7x/ugEKKhM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eIkkDuie0nqk9UmDo1LBJ+f+bKAv58jJdfhRWxjSgF+akX4V38UmQ/9kFOoQGpCK6
         clLxnDZHLQKPJzL13Mae0xSjVA0fkwl2I8m5rx7m+K2yarDesBaDPnotDoFZjx5atI
         XCOEzUIgDU103Mdr7dCB796LLJXjgOgUuEm5TDdpOD1ibgy0o5OI6cVdXP0QqQ/m2X
         JGdh/QmiDD8f9moxqZaAOW+hBqRZuWVmqwJ7PA3jCnpSGPwaLO+VlLJo8uZvRhv6WC
         v6SpM36Qob7NPst5ZhjS/uSGM9tk5x49uj1fwqJTifCNme3p66xu7kmc5RlMWyaNxe
         25bRZNqf7es/w==
Date:   Tue, 6 Jun 2023 14:29:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Patrick Thompson <ptf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
Message-ID: <20230606142907.456eec7e@kernel.org>
In-Reply-To: <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com>
References: <20230606140041.3244713-1-ptf@google.com>
        <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
        <7aa7af7f-7d27-02bf-bfa8-3551d5551d61@gmail.com>
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

On Tue, 6 Jun 2023 17:11:27 +0200 Heiner Kallweit wrote:
> Thanks for the report and the patch. I just asked a contact in Realtek
> whether more chip versions may be affected. Then the patch should be
> extended accordingly. Let's wait few days for a response.
> 
> I think we should make this a fix. Add the following as Fixes tag
> and annotate the patch as "net" (see netdev FAQ).
> 
> 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")

Perhaps it's best if you repost with the Fixes tag included once
Realtek responded. 
