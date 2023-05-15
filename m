Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2670229D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjEODup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjEODuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:50:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C953211B;
        Sun, 14 May 2023 20:50:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 141A6320091B;
        Sun, 14 May 2023 23:50:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 May 2023 23:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684122635; x=1684209035; bh=cD
        iTADJk9/eFkCuGM818u4eT+ONxEvgZ3Tzb5liRKbE=; b=kv2bGbhrc5ZerLhKT2
        /0JSelCFVqeFyb2LkNIpFcn5adqAXXRVja7uLiH6MAM/o1jTlEiC7CJX6FmQK0yS
        baFtwVMOK3zjpUWa+zESTdqs4EcS1Rq2fgYhf0xca24nWtEaMkegv6EibJbyMjL3
        Fkdpc87UimLBXDeZpbVug5gB2HJstVL+Qyi2/u3mIUd/mVCRcKntTb7BAhiWB9gy
        zwI2bgZkaaclza+SMgRvv49fxnBNe9DvKIjH7bMXzyoxFr7MbTrwVhLC8/z/5keE
        wZAU6ZeErS0TpOiGh3CI2yqLy9t3DiP99I2nDlp82CgCpho9iKZGyWGnTQWWU79d
        h0tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684122635; x=1684209035; bh=cDiTADJk9/eFk
        CuGM818u4eT+ONxEvgZ3Tzb5liRKbE=; b=qWgF4nfvcJpQrp5HRU/worKL9nyrk
        66QgMf8nI31YJn+Wd0qrc0Fi/mReZnQelH/GZ/ObTXTiBfyGS/Eucb/p+h1eO+5h
        HeN8X6udQpR9A4C6IlBR+Rv+9lNlaBTj+HBEHVZ1siHvBqeB1kvl+rtzn959dmhF
        rH7Im0CAZYVcHRcshidQKQFVM9jb8de6EPAPfVdnxNcBOe4eF4j4SBWZrb8DOij5
        D8mIlrAiGAwO/rPabtPIAgoRciqbS4iJ2n8pdnNHqDisHEZIQ0NiNy618h7dPz75
        BJ5ryWS4cn46ldP/I0ysU1fH2TCyroytGdQu41HoYTXF41pF/d+MoKo3g==
X-ME-Sender: <xms:C6xhZGlhNdcyd75LGto4ZhZFe6VvOc36ViLBFZsZ4wxdi4yGzh9glQ>
    <xme:C6xhZN3rALobzQHqbdBdskiKlFvf4F9sDcCWijchHjqrPEABRq_ci8sYme6ZTeC0B
    0Jve7hm6W79cg>
X-ME-Received: <xmr:C6xhZEpTaRNHXqw-IA0HM-XDBRScI67QBZ5vnl8g9Sua47cSpMsL1VFRnMf2ijyL6nGq_3iCvYr6l64m5mr4-Lwn4ZFKsHT5KhK_cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehiedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:C6xhZKleyB3uvRBxxLPIE-UukFsOYkvbeazJC-9BJsqmHd3MeV8zMw>
    <xmx:C6xhZE3oa8E-SBDmd5P8oXhHV-pgCVLCPRC6Yo4eeGipKT5yczpdig>
    <xmx:C6xhZBuzibvIRVoUwYujX-Bc98SIJf_1nc60Dv-yXAP5gYYnExwE6A>
    <xmx:C6xhZFKim3UmeJ4AoKdvopk6g9dTIedreN2cPIvtmrCc4pRf5EIkfw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 May 2023 23:50:34 -0400 (EDT)
Date:   Mon, 15 May 2023 05:50:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2023051509-confess-rinse-6fa5@gregkh>
References: <20230515123524.74e7bda3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515123524.74e7bda3@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:35:24PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/dwc3/gadget.c
> 
> between commit:
> 
>   c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
> 
> from the usb.current tree and commit:
> 
>   813f44d57e19 ("usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens")
> 
> from the usb tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks for the 2 merge fixups, I'll apply them to my tree when the usb
fixes get merged by Linus.

greg k-h
