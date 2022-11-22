Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB1634832
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiKVUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKVUaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:30:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5EC1B1E7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B5B618CB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB42C433C1;
        Tue, 22 Nov 2022 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669149017;
        bh=QKE/smYGsWm9pQOWeYiOJVcdI3DnsY0aJruAkVwD8GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dW6safaK4x8GDATEnLzKTDqecExDT1JMQUbyFIyjFsGH/KwBQbz8X9097TRj+kPt3
         lhK3en11nExrzLCrJuN53d14DhYgLIjOeDUeB4RM0G3q5paUsQS4KwovKVkYKuXS6Y
         5zkev4VE+o3eD4QKCs+wvsEaluBcBwQef5SVGZIfQX+BnUsFCkzRnQrj00x7nK+TqI
         N9GtaUSsH6DSA/EUkOI8nNAuWghRWdFJJYTpyKkhylO0CRQ9INX+Q0RLdRU4cVobGi
         D3902bJbiUkNcpbBe7pqzX+LxWu8tsXwqx3WmVtflA/cCboKE7iaLSUCAyL8zxg4NS
         Oi5isFoc6uyjg==
Date:   Tue, 22 Nov 2022 12:30:15 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Coco Li <lixiaoyan@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] IPv6/GRO: generic helper to remove
 temporary HBH/jumbo header in driver
Message-ID: <20221122123015.65ec4f5c@kernel.org>
In-Reply-To: <20221122193239.3159985-1-lixiaoyan@google.com>
References: <20221122193239.3159985-1-lixiaoyan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 11:32:38 -0800 Coco Li wrote:
> IPv6/TCP and GRO stacks can build big TCP packets with an added
> temporary Hop By Hop header.
> 
> Is GSO is not involved, then the temporary header needs to be removed in
> the driver. This patch provides a generic helper for drivers that need
> to modify their headers in place.

you need to cc: netdev
