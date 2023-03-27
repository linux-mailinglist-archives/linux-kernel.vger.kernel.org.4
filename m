Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB496C9C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjC0Hiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC0Hiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:38:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D4B4C25;
        Mon, 27 Mar 2023 00:38:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AAADA5C00A7;
        Mon, 27 Mar 2023 03:37:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 27 Mar 2023 03:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679902644; x=1679989044; bh=cf
        J6Opu466RXFLkT0nJoqwLZQybPK22CsCzCVAC39sg=; b=In6JGnaaZ84XLeMVLS
        JvmgSOMfABkgziiV5/dz4j8rSWLNKlbd93X+4SB4n9mMybrymA2rzyjhWeV77agb
        7OMdDkmbgruvaPU4FHMBj0NIKn/bSrzsEU0/HmTMzP2Jk+gJBv4VF3PwdSGD0WS4
        pfl0galLp1AoD7qmLdj7EHVaaTtcPtb7FSiK0xJ5bUffREsMiKpoYZK70wkn4g0B
        POTEY5YL+U7p25V+sLupfnQ8ndnGEl2RRF3N4/0Nj+BQZa+2rwDzy6D2OAaX+Pws
        Mj/fFwMqEBWUXz2TbonMuApHMdkOGfH9FEqVA0Svy80puEU22mvsDTfbLWS6qNT9
        IRLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679902644; x=1679989044; bh=cfJ6Opu466RXF
        LkT0nJoqwLZQybPK22CsCzCVAC39sg=; b=C+ORU60y8mOdRLGIj7Kdio2MpZzhe
        z5sUT8dvNewySiyM2yprU+6rLbDabWA2/sI15aXQTENO9eVFwrQQE63U7WhfVB9r
        +WoMCgmCpNnPjMt75WmoB9GYGIGD8bJBqB0Yujy85zOqvz5cYRdwMZGyK2OCyX51
        rg8vkoHgF4phN/j8+IMSzOERny9D2+GwfjgmdErLvTJc93Qul+puRcZ8GtS3rCiT
        4unQVl5j4t5VJAlpBKpsmtKun4gCNpq0me3Vfnrf+FzuNAfUKkxA+kIOeVErc5oD
        H1S/7oc4JeVatFy8xArBZZIy06x0J2t8519KnGiJCctdJCQj9vEgbWEtA==
X-ME-Sender: <xms:tEchZHJgP8KDo9vMu5j2UxKZkoIvrO7BEKXoeqnUmQqkGmWX0zw--w>
    <xme:tEchZLKYsLIm21s6IN0no1FDxfywzwPegbRKN4c8IPtscQ0wcQsG-P6tfOEivXRLr
    nqHvKMQqmAVNg>
X-ME-Received: <xmr:tEchZPtH2dXoBwAqT9vt44jTx8Udrg4HjJAUl6q6loi_t3rJvTZ_3jY3DN9D_fQAwfwPOyDOeFnfS71S7yqA1ZW9glNF5kioQlawMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    fgieduveduveeiheduteevvdfghfdthfejlefhtddtveegteeiheelffelfeenucffohhm
    rghinhepvghllhgvrhhmrghnrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:tEchZAaUdo6Mh1u9Ol7O1aowwmmVBtqIEut9e6Sf9xKOpBv6yl0efQ>
    <xmx:tEchZOYuRhf2c7Fx-yOWsa3JigyRn_XLWl-IDLn0T32EK2WJA8E5dg>
    <xmx:tEchZEA48yey3lpSrU6uGnL1-EMQ7hKuaZj-7113WeI3fTrJN8o5VQ>
    <xmx:tEchZEMlJvQTWarXd1kC5H5xMPPfa8IGRe0bJocgdUhGtq34lKqw9A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 03:37:23 -0400 (EDT)
Date:   Mon, 27 Mar 2023 09:37:21 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Josue David Hernandez Gutierrez 
        <josue.d.hernandez.gutierrez@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <ZCFHsSkxXAahISuK@kroah.com>
References: <20230327160232.6119b93f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327160232.6119b93f@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:02:32PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (s390 allmodconfig)
> failed like this:
> 
> drivers/usb/host/xhci-pci.c:91:13: error: 'xhci_msix_sync_irqs' defined but not used [-Werror=unused-function]
> 
> (reported here: http://kisskb.ellerman.id.au/kisskb/buildresult/14902506/)
> 
> Caused by commit
> 
>   9abe15d55dcc ("xhci: Move xhci MSI sync function to to xhci-pci")
> 
> The function is only called if CONFIG_PM is set, but defined
> unconditionally.

Ick.  Mathias, can you make up a patch for this?

thanks,

greg k-h
