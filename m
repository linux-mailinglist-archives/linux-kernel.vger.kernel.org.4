Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F8723366
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjFEW4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjFEW4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:56:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C2DC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:56:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CEC9D5C06DD;
        Mon,  5 Jun 2023 18:56:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Jun 2023 18:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686005794; x=1686092194; bh=a7
        KMYicZEUIE6uw7owk+wAQbBZMSOwnOCGbW7LMEHdQ=; b=ZRckXazygVE2iBj1KT
        C43WeNABbbX96WzodVN7/uF2MN9F+dl7AUHe52F5I2Z6wcxZhfGtenmkJdsGzmRs
        gUfs4cDXQhxljZUnS57fg6KvxKCRKrwiC2+MJdgC1bhXaVlbZfr+aCBGIex4mDnN
        g35pvDoN+LQcwNaGpdUv0agon1xNpExoah1SQSwxyviuaGyXY00vFKPitR6kWDaV
        gPT9IXpeJDDgp7HTefb3Q85U0gRYCIjqFy+k8df44zcS3efmMxEieNTuBE3niawi
        r0t+lbjQf39EzRb71ak+hrIp+7ETQ64pSYSLIzlG/gWJLL9AenugiPDBNn/RTIL8
        w4Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686005794; x=1686092194; bh=a7KMYicZEUIE6
        uw7owk+wAQbBZMSOwnOCGbW7LMEHdQ=; b=QFIi8G/idAhkoxhnvL5yqUFlhtIe3
        y/LzMNRdN2nvMlVTYBbTW1SsSRmVP84klSrYVzXEIOoOvSWYF2zCQlsts6HTpLhK
        77nLsHBuAi0SNJsq0fcYnHKFlY08oAmQCq79L55tgYerA/NvGcM3QTOm4ZSe5Kjf
        L7RGtv49HNH3bda3aYipQVuvFiBk6miK4iz4KkgHkh30V1MgFHTpCoHkIDRaujLu
        VfiR6Bqw2Y6kyrsnRvMy8JrzW/AZq/oGYr+zHY+jM059PpEqnbcfmtgn6Ds+e9ZT
        vCQHW7f+0MerTCBlib1iQgP/7Tz15wXt7jTEBfiFdT5ccEkQR/3QTsquA==
X-ME-Sender: <xms:Imh-ZM8k44EA8AL2ltq2KV76wMIkO3Ug1CdB3kgmPIBkgdDJP5NhUg>
    <xme:Imh-ZEvCkhk6lxc2s2JaB0BZzTA4hnRuyijui0k4w-WWxA-ADbtqeOIdYb_NYTRwp
    F2dnDEjnz00QBKIQcI>
X-ME-Received: <xmr:Imh-ZCB0kNyYXzl958VMp2bxVi0hl2IFAErYR_WRyKN1AZRqF-bi8fGKyml_zGT6e1LdUZhjx3jhBMssztzmlYU_WmzPBfbh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnheplefhueegvd
    ejgfejgfdukeefudetvddtuddtueeivedttdegteejkedvfeegfefhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Imh-ZMedOcTYIjjW2IKL19v1hyc5rlJSkcgDNJEHDYK6Yh38MYoZJQ>
    <xmx:Imh-ZBO8AJIszCjvq1idlBuMSyBtn_DX1ixK9UTQddZt8NyO8_lVwg>
    <xmx:Imh-ZGnCsy_Cep0rsUs29hAj2BGJXprxfFdFbfk0gOXkRDC0tudxZQ>
    <xmx:Imh-ZDX1q_eh9HGx7eYL5Mi_CI65jEE45cclaa1JJU09QWf__-P-Bw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 18:56:33 -0400 (EDT)
Date:   Tue, 6 Jun 2023 07:56:31 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] firewire: ohci: adoption of device managed resource
Message-ID: <20230605225631.GB178739@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230604054451.161076-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604054451.161076-1-o-takashi@sakamocchi.jp>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 02:44:42PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> Linux FireWire subsystem includes a driver (firewire-ohci) for 1394 OHCI
> controller. The code of driver is mostly written at the time when device
> managed resource (devres) was not widely used. Nowadays the usage of
> devres is standard when writing drivers. The series is an adoption of
> devres for firewire-ohci.
> 
> I note that MSI-related operation is left as is. The hardware vendors
> forms their products of extension card with 1394 OHCI controller
> connected to PCIe bus by several ways. If chip of 1394 OHCI controller has
> PCIe interface (e.g. VIA VT6315, LSI FW643), it is just connected to PCIe
> bus. If the chip has PCI interface only, it is connected to PCIe bus via
> PCI/PCIe bridge chip (e.g. VIA VT6307 + asmedia ASM1083). There is some
> chip of 1394 OHCI controller integrated with the bus bridge (e.g. TI
> XIO2213, XIO2221). The MSI-related operation should cover the above
> forms as well as module option, while it is still unclear that the
> operation from pci device driver to the bus bridge.
> 
> Takashi Sakamoto (9):
>   firewire: ohci: use devres for memory object of ohci structure
>   firewire: ohci: use devres for PCI-related resources
>   firewire: ohci: use devres for MMIO region mapping
>   firewire: ohci: use devres for misc DMA buffer
>   firewire: ohci: use devres for requested IRQ
>   firewire: ohci: use devres for list of isochronous contexts
>   firewire: ohci: use devres for IT, IR, AT/receive, and AT/request
>     contexts
>   firewire: ohci: use devres for content of configuration ROM
>   firewire: ohci: release buffer for AR req/resp contexts when managed
>     resource is released
> 
>  drivers/firewire/ohci.c | 174 +++++++++++++++-------------------------
>  1 file changed, 63 insertions(+), 111 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto
