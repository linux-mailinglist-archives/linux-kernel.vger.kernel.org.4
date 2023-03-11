Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7A6B5A46
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 11:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCKKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 05:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKKD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 05:03:26 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48865DBD0;
        Sat, 11 Mar 2023 02:03:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8FE05320034E;
        Sat, 11 Mar 2023 05:03:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 11 Mar 2023 05:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678529004; x=1678615404; bh=Vq
        ji9kNwgOAY0G705adR/Zk+/mY3GWNulE6EVZ2CAoc=; b=tIGlWWcrRhILFwLCnw
        m7hFJOABAAUDJ6pEifjKmKLpHF8z0vouxpr1NwzCNVdq0NQqIeU2iQXjWe/FS3Iw
        0m+I6saZ9JaxGO+yiobEBw8wAek+0KQktaqKKO984449VSOqBuPJVVb5OSGvfb50
        p+LBV/agNhnCBYGoMWDbB4TpDp0xJDKYKEElpL8q6dy1lLESSrTnMb+JaFTawCN1
        00UzCCeZO43OFvdWr4uIyeXD/BtQDxL6N/26nDTMyXxsKqEr5jCVdChI7YUvwI7v
        AgGLVfSsXh0nFyIb6+tA8O4vpLwcYrhGT71g4up1YdhpJxEwk4z+UeHwHd0iBcgs
        l4CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678529004; x=1678615404; bh=Vqji9kNwgOAY0
        G705adR/Zk+/mY3GWNulE6EVZ2CAoc=; b=DXe9rSHu2zKjsAau8gKg8VA1LMjLx
        tsjpd7fpUSAH6IRLv11zX6MYy2ElLq1/oexS52wemfDCV+2Em731ukrpT1Farkev
        4O4cBxfFdQK79+jwynSw00G1uPgjmZgQjq8hJ1Vc2MIHh/GomHCLDm2pYZ/VMAdt
        7E9AcPU3D7vq1lDb7cVCWtu8YzzAIM81RdbYUD/q83+Fz/6gWs/awo0ZQHKyhxDE
        w6hMvTJRDK00gMpL1MXYdpclW7LqjIQzEweokp0w1/9oVfn5MSqsmExrO3FZcnET
        /nhudEZmrUlFVUR5CeenU8nVKDRBV53JunJjkM3mf7Ip89wQOOU/M1jIg==
X-ME-Sender: <xms:7FEMZEn8D7HEScdefA3WSnwBYOJ94P72DvhTfkCFYj4CWtXtPvi5vg>
    <xme:7FEMZD0duukg20-LxT-rkOdBZFlymTVSl-4hKqqA1qcD_0SxuMb-0SgTxBheGplk_
    Oe2zEW7OzJmo8N8UpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduledgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7FEMZCqZH4wtPfiOHr71F7zsP3IF5ILrcCJVygZ8UQMykiSThrnkhw>
    <xmx:7FEMZAlfq_A5WxYmGBsmKhc376IKNpVrTTO3LQXQpwI1itY9QdOWFQ>
    <xmx:7FEMZC1R6RbnsUXSRtwumowsHcRhtleIssIzlzJIkMXgHwwU2kaUrA>
    <xmx:7FEMZH_iweSEgcOAQepfqZPYQRe7ONu3add7b-PrFFUdlBQZJrXTWg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01CCEB60086; Sat, 11 Mar 2023 05:03:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <aab2c897-94ca-4434-95bf-a9338e85c68b@app.fastmail.com>
In-Reply-To: <20230310144713.1543544-1-robh@kernel.org>
References: <20230310144713.1543544-1-robh@kernel.org>
Date:   Sat, 11 Mar 2023 11:03:03 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rob Herring" <robh@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/sram: Use of_property_read_bool() for boolean properties
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023, at 15:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
