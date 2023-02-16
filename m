Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95EE6994F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBPMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:55:05 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C023B877;
        Thu, 16 Feb 2023 04:54:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B9865C0182;
        Thu, 16 Feb 2023 07:53:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 07:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676552020; x=1676638420; bh=DbrLQv3/pV
        tTQOZWpqNFqEWPdA+pKJ3lEDwvQXG6DB4=; b=oauL0G1TRIlgWSz7p8TU8eHziQ
        UmDyJnfH5478eg3C2PjAxRr2fBk8tvZ2aV8nQVdeXDG1OFRJpOjNnlO9RC8YbKJP
        6u1zBU2soFfeEQJO14Ukd4ELMdGyLuJvzsEB/cM8m/ipQPhZtmEk4KESmv9Mx80d
        +7CYqkOL1aRdBego+2AwNSxvwG8uOgDerQ/vKHnRkcRLzgHV8Z7V7CvoclxqWxg+
        l6WszlcPqwYonGkhmfTkxXKN+zOTqWDJ1ioOfnMvo0yxIM/bCEhHnQW5wz7g6vmx
        qLe2iiMtWJzRJX5db2PRKzbGVpVoTEcsCKrq6S/Qk2nSu7TafxzpMGJBl65w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676552020; x=1676638420; bh=DbrLQv3/pVtTQOZWpqNFqEWPdA+p
        KJ3lEDwvQXG6DB4=; b=t24p3UPWYZ+KCYTj7ighSAiKBdig04/acVYEucG1LfC4
        R+/g9buHJlnRHfHwUN6OzexDtYT3jkuzmFSDMOqGAUD22GEtjYS8jN9WQ69MugDM
        opv8xT4lHdUKFD+LooI2oT5ogfLpPO2fLFJu1XHPyGPhIfZoBxKMnDLm38rDTVoe
        N21pYlEAdqUrqCv6JQQzpS5Wfes/swSdZHYEAFCZqRpFmKJ0N6il6X77AAhXE/6y
        vgxa89YBjC2wZzlhiZOjc6AYdZMxhLvol7Yxo3a8mfOfwWeb9GW/MHqdxXYcGhfO
        wP33vY0sSgAwMiw5dLQsVwGReJBlmf+ToqipESJ4/g==
X-ME-Sender: <xms:UyfuYzeUUaSaPrhxbXMLkxkQ25baorED_7p5qH_4G8c5wmbdZGBPnw>
    <xme:UyfuY5Ohj94ZoNF7YDc5cFlQpVlkqSftk0-qX3mmGSwxlqGNR7NqRM4EhI7yAcHyo
    9WCHZIE-HRcYyGIa2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VCfuY8g1NjNg3i-wn1zXWb2CuyyCqKfEFShjryv9KODtVQM1Pfga2Q>
    <xmx:VCfuY08Cqsv_xgxN8dXnRWUk5PHaYPai3yvVlTNAhqW9-fzqMJo_Bg>
    <xmx:VCfuY_u5jVRuSzSbmO6g2OjCqoOhi2K_75ahNcF9c-hUH82q_iZFIw>
    <xmx:VCfuYwnBkonwkcWstLJk06CtE9ryeZY5nvSPL6sERp2A03-yLYtOkw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E4E50B60086; Thu, 16 Feb 2023 07:53:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
In-Reply-To: <20230216123419.461016-2-bhe@redhat.com>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
Date:   Thu, 16 Feb 2023 13:53:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "David Laight" <David.Laight@ACULAB.COM>,
        "Stafford Horne" <shorne@gmail.com>,
        "Brian Cain" <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v4 01/16] hexagon: mm: Convert to GENERIC_IOREMAP
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
> diff --git a/arch/hexagon/include/asm/io.h 
> b/arch/hexagon/include/asm/io.h
> index 46a099de85b7..dcd9cbbf5934 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void 
> __iomem *addr)
>  #define writew_relaxed __raw_writew
>  #define writel_relaxed __raw_writel
> 
> -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> -#define ioremap_uc(X, Y) ioremap((X), (Y))
> +/*
> + * I/O memory mapping functions.
> + */
> +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> +		       (__HEXAGON_C_DEV << 6))
> +
> +#define ioremap_uc(addr, size) ioremap((addr), (size))

I think we probably want to kill off ioremap_uc() here, and use
the generic version that just returns NULL.

I see that there are only two callers of {devm_,}ioremap_uc() left in the
tree, so maybe we can even take that final step and remove it from
the interface. Maybe we can revisit [1] as part of this series.

     Arnd

[1] https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/
