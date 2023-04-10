Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAABC6DC3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjDJG4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:56:35 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF710D3;
        Sun,  9 Apr 2023 23:56:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 92D413200933;
        Mon, 10 Apr 2023 02:56:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Apr 2023 02:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681109790; x=1681196190; bh=1a
        4eNuzIXQbnsDCN0p6R8u710BSDsS4pa5XNZlyjOIo=; b=QVCeo+kG3AyBw4iCEL
        FhOnl8qRVg8C8Rj0y2MlfeQRBRkx9YCA7jcAKeXhFOHbohkOAl8ZqpOpjXKpqBl4
        oE6ajA7gI+0cH8Y/vat82rFRErr/fQ6jQTIudDPrcKnYljO/PVXlbGA33gOFQUFt
        K4qCnU7Kh0a97GSxRLRpV8cJS51Z52hMKa7KoP1BPTrOo41Fn7Y3EmDF7qXbwN/b
        v4qXTeRXQvDaGnkOMXRfyw+OP6BizOgI9uy96R9UsZLU8K9FjW04X3xJwap8jEAZ
        nzftV+GbHxl+y7eNpDU+X1dSJzc88qvuqdpTT2kTGU2yALrUJhcaxmGLQ1rbwZR6
        faAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1681109790; x=1681196190; bh=1a4eNuzIXQbns
        DCN0p6R8u710BSDsS4pa5XNZlyjOIo=; b=ZYwWmEXOpNN0eyvsiBaw/xwuEL5Sb
        wJ+MjJA9c0s0pZxvNO1Ya5FpDchzfuVISHUF47kZC0BpudiehWLyOXs4zRfiTKPC
        9zyiHq7j3KfFPmNY9HNqwkj/ssJV0cPgOoyjwXlu22S9mJQawNvkC6fa6gGqowDd
        7CDmANzIJGfqpCInWlKrXbxNRMloJm3VVCtIvaoPFsPFvlT+kE9lLvlNsfom1vay
        oCTEXQQsjwL35+eZJcq2f30S7lk7vvsP906sQweH8zKH5f7DmmZkWZvYfQdV4DNw
        RCj7vjyP+4CMsueniDR8TjPM6B69XFh6T+z572H2r+FlgwACk1afq9BFA==
X-ME-Sender: <xms:HLMzZKqu7F5aJPIUMfORtsbO2VWvbsZaKE3dw6P6HcCCaqGzKF104w>
    <xme:HLMzZIo2YcixUSd1FcZacn3IjH9slvQjqy1Xr9G6tjn9Gg6aC-R6XrAQWeFWQqQrw
    7GgnL6L0DlJ3Q>
X-ME-Received: <xmr:HLMzZPOM_JJcpAEvQibNiBIYSSuFT2wyae7SlsrYQjyD33afbZJpqf3XS_zpy1VgRf4YhVSV6YAava2TSIulIp0XQPDHQ94Bf4LTNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:HLMzZJ7BEWvVEwirWdyt2jbK0ulf-1iBNDC4Pbrh7j0Woi2tE3TW8w>
    <xmx:HLMzZJ4ob0gZptY6A6lGxLicGzV2z1xfv98tSDc533xwdzt-laXAqw>
    <xmx:HLMzZJjbYKzTzrMxhfgYh-oJCIfdkqbTIk3NItU3HEAaZk5hktX-vQ>
    <xmx:HrMzZDuYBIFg5s5rZUgNtqTgDWgWIy3oZENZEI8C2wqdo6OzGGM3QA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 02:56:27 -0400 (EDT)
Date:   Mon, 10 Apr 2023 08:56:24 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2023041017-porcupine-corrode-e430@gregkh>
References: <20230331140150.597576b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331140150.597576b2@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 02:01:50PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/host/xhci-pci.c
> 
> between commit:
> 
>   8e77d3d59d7b ("Revert "usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS"")
> 
> from the usb.current tree and commit:
> 
>   130eac417085 ("xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/usb/host/xhci-pci.c
> index 6db07ca419c3,bbbb01282038..000000000000
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@@ -771,11 -967,10 +967,9 @@@ static struct pci_driver xhci_pci_drive
>   	/* suspend and resume implemented later */
>   
>   	.shutdown = 	usb_hcd_pci_shutdown,
> - #ifdef CONFIG_PM
>   	.driver = {
> - 		.pm = &usb_hcd_pci_pm_ops
> + 		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
>  -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   	},
> - #endif
>   };
>   
>   static int __init xhci_pci_init(void)

Now resolved in my tree, thanks.

greg k-h
