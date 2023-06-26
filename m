Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11CC73EB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjFZTZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFZTZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504BE74;
        Mon, 26 Jun 2023 12:25:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0235F60F53;
        Mon, 26 Jun 2023 19:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66FFC433C8;
        Mon, 26 Jun 2023 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687807505;
        bh=cDD1qB0KwNErBzlvhgUdes1QzQxQ8D0lxjKAw3s3g8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VQTx68U5LYH1cXZNGFAHyNfyEvxgt2/lIqgPR/k9FAn/4puR3n1I0M4Sh0SCTU7/Z
         K8xdeAIgiEUxZtwUrJH0Xny4cGPB2w8H3Ei/Krq2xLw6YL+8/JemDZ7Cx1IIKrKgHc
         EYICtRjj2LfjNd8lpfhF6vnErrrhuSV4m2tjRkLpL/toZZ4fTO7xRmGBDxPEWeztvC
         4WYSN1AUrtl45moqORBOqkLCIcPnGIUzYFo54loZ6B+DF/uH0cYGFkJHKrlMVjX6tH
         n+aGanNN8XDPizHrZX11WOfwejypQAY7mHCN7NWcaNSXaY7gm5WkiieifXfCxD04XJ
         bgRh/5dHTvL3A==
Date:   Mon, 26 Jun 2023 12:25:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] libceph: Partially revert changes to support
 MSG_SPLICE_PAGES
Message-ID: <20230626122504.064844fb@kernel.org>
In-Reply-To: <CAOi1vP9-5eE6fjJ8rjvMCqGx7y94FHBDi2iNdZQfjPL=pugNWg@mail.gmail.com>
References: <3101881.1687801973@warthog.procyon.org.uk>
        <CAOi1vP9-5eE6fjJ8rjvMCqGx7y94FHBDi2iNdZQfjPL=pugNWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 21:11:49 +0200 Ilya Dryomov wrote:
> This patch appears to be mangled.

In what way?
