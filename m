Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28270FBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjEXQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEXQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:37:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39980E9;
        Wed, 24 May 2023 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=DAOLtkgl++ZaUIbUqvEG8vYlbrCs6LpYkEDUBJQWXys=; b=F11jg424/ylaN67WRXdL2jIGoM
        0eBJyChaR9MjAvDP97H2duDxmjYzk9CIwdnWHXXMMSxQFjhkJXMN9egYpH4Vb4c/6yuam9TSVE1vM
        9lqFsb7zX4IZE08nbKHvY7gZ96nNx352U3nCe3FYqM6kfmZx0qCYcOFoliyHlWgm3Ieo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q1qvm-00DoMd-Gz; Wed, 24 May 2023 18:01:42 +0200
Date:   Wed, 24 May 2023 18:01:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        y2kenny@gmail.com
Subject: Re: [PATCH] Remove hardcoded static string length
Message-ID: <c0fda91b-1e98-420f-a18a-16bbed25e98d@lunn.ch>
References: <20230523223944.691076-1-Kenny.Ho@amd.com>
 <01936d68-85d3-4d20-9beb-27ff9f62d826@lunn.ch>
 <CAB9dFdt4-cBFhEqsTXk9suE+Bw-xcpM0n3Q6rFmBaa+8A5uMWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB9dFdt4-cBFhEqsTXk9suE+Bw-xcpM0n3Q6rFmBaa+8A5uMWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think there is an RFC describing RX, but the closest thing to
> a spec (https://web.mit.edu/kolya/afs/rx/rx-spec) states:
> 
> "If a server receives a packet with a type value of 13, and the
> client-initiated flag set, it should respond with a 65-byte payload
> containing a string that identifies the version of AFS software it is
> running."
> 
> So while it may not actually cause any issues (the few things that
> look at the data just truncate past 65), it's probably best to keep
> the response at a fixed 65 bytes.

Thanks for the link and the quote.

So the compiler warning/error needs to be fixed a different want.

    Andrew

---
pw-bot: cr
