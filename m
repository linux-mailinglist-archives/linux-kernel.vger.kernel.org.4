Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977EC71FB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjFBIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjFBIB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:01:26 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1550113E;
        Fri,  2 Jun 2023 01:01:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A2AA35C00B4;
        Fri,  2 Jun 2023 04:01:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 02 Jun 2023 04:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1685692881; x=1685779281; bh=sWfQnJ/iZV7sAf4tTECV2wsOw+AdKyD745o
        PJjxva1k=; b=hM8cP3H9EXvqWK9Zrjm21pKUbHEC63OpWQXfdjBYWQz66yGGnX9
        3pIyt8J8dRks12JSKu1QT3ptIhHIZp8CP/CW8bH2+M64XGtoDskNVxw3na8OJI60
        u+yxtn4Sj1n8eK0kbRA7l2h3TspFJm/97jE0Z6plo+ssCq6v8amIFRGjQwTMjbNM
        nutvFWqr1Wg/3xrSzf0KYFcFynd1XKnCt+65+k+uKV+l1f/sD3OnzEDFnsDldQPb
        8n0OqorQ+2K074ZrmTNXo8VZsr34JT3fTJSXYEr9SgC+BuSkYlicqMoQrO/MA8w9
        yqjipgIxBbsNlq7bpvI1Q8KIIty8HyXQifA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685692881; x=1685779281; bh=sWfQnJ/iZV7sAf4tTECV2wsOw+AdKyD745o
        PJjxva1k=; b=oMW/7Y5BB+VpjnDC69MxYGQTWmu6rBlfJg/DfvmZZTfLjaclLAN
        TlJE2UANcJ82YQrzuxu5CXr9YrVD8zBr7hiXp8twe8SF3co8CYE45xgCLW2WO42j
        KtE74EVsHTZbEVeifWrcYW4Gu+iEgLz38K4TW6k8ePzkr+RPp7TgdPq+FBI5uTEb
        2oPkKFP8Waic2/q6pmZ0Wt45jOULw1+Z97RqxPbHcn4vqQffezTnwnVWN1Ad3S2K
        C6SytxBR23SHtdkyDmZ0qfWRVzIQpQt3UIgcsV78Jj7U+waiTPh8ZmBLN3EhVc4w
        vPB6Dzip8jfOxytQ+4go9PjKyfwUXDzrvnA==
X-ME-Sender: <xms:0KF5ZGYD7Obg99kD4yUv1HdH52ZS49Jk7KRyqMp95LpSJPVLAYkdtA>
    <xme:0KF5ZJYyiTsH4NgKhd1hCyPnMWLy62v6d1iN8Vp8UPbdPxyOxvcy8f5O4n9sACoXP
    foPEOGKa2u1fQ>
X-ME-Received: <xmr:0KF5ZA-mhUoj8orZNcq5JpHtst2TJiTxgPrUbADLIyYw9Uva0INODqXLfLa1L_9DpnKWN1C-cMXp5fSu6M3W0ZTf8jDrVayDcR4D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ekffeifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:0aF5ZIqa0Cpb30nqWmABCH2K6RX8i_m4cl_8-G1bgsjVcElkpHMeuA>
    <xmx:0aF5ZBqNJQXobbRojFJ8zCXpuIAEgyyxjf67LquolffuotsOeOPeWg>
    <xmx:0aF5ZGQMoQ7ReujZONx6YHsGTD0AkRUbZbF8DmgJFiQh6C8Ot51fKg>
    <xmx:0aF5ZPjqwVhacTdz3nA6lFUOZUmLHctikw_MkH9unQfo1w6ZHT-_7g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 04:01:20 -0400 (EDT)
Date:   Fri, 2 Jun 2023 09:01:19 +0100
From:   Greg KH <greg@kroah.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the char-misc tree
Message-ID: <2023060207-blouse-footwear-c804@gregkh>
References: <20230602132654.4497f896@canb.auug.org.au>
 <CACRpkdYua8NfFYYDCpDoggu3P34DQu=QdYR+2UuqO1uL2rdkmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYua8NfFYYDCpDoggu3P34DQu=QdYR+2UuqO1uL2rdkmg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 09:54:57AM +0200, Linus Walleij wrote:
> On Fri, Jun 2, 2023 at 5:27 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > The following commits are also in the arm-soc tree as different
> > commits (but the same patches):
> >
> >   b866e7e7f995 ("misc: sram: Generate unique names for subpools")
> >   ca3222ac4477 ("dt-bindings: sram: Add compatible for ST-Ericsson U8500 eSRAM")
> >
> > These are commits
> >
> >   21e5a2d10c8f ("misc: sram: Generate unique names for subpools")
> >   38bd22dac71e ("dt-bindings: sram: Add compatible for ST-Ericsson U8500 eSRAM")
> >
> > in the arm-soc tree.
> 
> Hm hehe I was a bit confused, one misc maintainer (Arnd) merged the patches
> to the SoC tree, and another misc maintainer (Greg) merged them to the
> actual misc tree.
> 
> My misunderstanding that this was handled through SoC like drivers/soc.
> 
> Arnd can you drop this from the SoC tree?

No need to drop them, we can keep them both, no harm :)
