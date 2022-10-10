Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53665FA14C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJJPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C2A5B040
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7BD560F7E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73B2C433D6;
        Mon, 10 Oct 2022 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665416511;
        bh=OVOTUrIilndF1mR/lcqxq5K3gXDsoBCDf10VgMvS05c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HlnJ6PAkTmb//6BpFhLmM/8I9T9k0/r26yDs+E8k1ahLJXR8HgaveZWDrb7R/P1Ry
         B1LvEIFr7JhV1tkv8vHULD3EpwW3xNpQm9t1ZbOdCqqKd8BBP8iToWhDYif360Aj8l
         xUMbtKkWXM7NbGwKs3auUjkok3mi4XQ8SaGMgT1HeebdvGSmk4N0bUo003WG8Vpja7
         /Q9IOiTLoVIPI+/4chbv3BgulvkDODHkablz03RZdV6X0uSUJtdgqi+GWcVltdcvgs
         uQC9CV6sp8xlQJXGpe4McSCp+NwXHxJj356HYrBHURmaIDygL39pRRGGzga16IUo6F
         pdxFmU9Sjxu/A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Make port I/O string accessors actually work
In-Reply-To: <alpine.DEB.2.21.2209231211350.29493@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2209220223080.29493@angie.orcam.me.uk>
 <c4ee195a-cf1f-44f6-b3b6-241d04e01fb9@www.fastmail.com>
 <alpine.DEB.2.21.2209231211350.29493@angie.orcam.me.uk>
Date:   Mon, 10 Oct 2022 17:41:47 +0200
Message-ID: <878rlnk7no.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" <macro@orcam.me.uk> writes:

> On Fri, 23 Sep 2022, Arnd Bergmann wrote:
>
[...]
>  Thanks for your review!
>

Chasing stale threads! ;-)

Arnd, would you be OK adding your Reviewed-by tag to the patch?


Cheers,
Bj=C3=B6rn

