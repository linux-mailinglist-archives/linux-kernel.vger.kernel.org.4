Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C415A6DCE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDKAFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDKAFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:05:54 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0296F1BE7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:05:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4B2183200495;
        Mon, 10 Apr 2023 20:05:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Apr 2023 20:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1681171549; x=
        1681257949; bh=Cz6BsumEIt+mTcwd5ko3MSJ+L+18kKloKqkmGXShAw4=; b=Z
        KVwQL/vfz5ieR9j/izxkEZuH3iBT5NzmSIYZCDvSa5KsYJXt7jFzooJd5cptarWY
        j23yx18RAZdBr66th9uyIcYTrnxy9Pie8xzqUwwa/Q7B7fmIqHZaZr5tEI1sDUMN
        swIggmG4Cj0vJyur7Biitay3gwgY4C9WtvF2MseOMHXSuSaR8k2Mvn5H06UtNMZN
        kAB3rbWJm0bt08uwFN8Ch58oDavC41vHcbaiPR1BsZD3DR+F+QK06XlP3j1em6Zn
        wedcbXM4OhYXZVG374zryyBZkI5qOVQQAsaLG8+oV15aCnW8MrPMyedoVyuB3hWg
        +hgQZ7Cr138221DcfedEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1681171549; x=1681257949; bh=Cz6BsumEIt+mT
        cwd5ko3MSJ+L+18kKloKqkmGXShAw4=; b=t10OaKqdX6CE7EYILpyGFrg+jFqRc
        9/GQceecu2zXzkbqq5XJrcYTZy8jLlIbLYdkLu1sGpG9zvLW29bTvk6Z6+LxzwjY
        +A9CGeYoS9Thu+TAr+wrLawHZ92eZBhDwiOUDThfmk4xNen4XBSsVv6Fn9Juzz6E
        iIHTKK3e2fCxtrwUiQasQnbAdYbuGN2dX8U7lL3/Kd+HUofqpKZH4kQpxHkr3Mz3
        u1981wH/4IqgBz1qqO7DMAXVetko97ZAmxSxJT3QOKKRZiciSWKJGhWhDkICSwXY
        0rHUU+Z+hKctgke9FxzpJ35Zn6nmgtTxXINXlNh6dY1K5kIM0V8I5lwHw==
X-ME-Sender: <xms:XKQ0ZHynqOwhXI-9cOGEcCTBhadDdCtYDREVwdqXJVF2a18p76sb-A>
    <xme:XKQ0ZPTTjoB0VJWBK_vt28-8zrBwwaIh28q5VrZyQePuYzuVVxmbKZibL_HoIffNd
    6_7ZuFnh7rFCjEJg5I>
X-ME-Received: <xmr:XKQ0ZBXPjQO_juPEWRgAhrpOFdQLNco81VMM1OWZ8Cm_qbgezk-zqCYqIHK2Wv0qar6Wyx7sqaNmijtT439DsCUmLbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:XaQ0ZBh2rU2kPL1ikh3tEzHAhaEKY2MMTyr-prD0_860N3JUbRrxIQ>
    <xmx:XaQ0ZJCcWNWofTis3-SZVAVhUUYDSFKtQbp1hebE8nVtmf-zJkknJg>
    <xmx:XaQ0ZKKlCim2dDa_PfIZXduzkTQflcjpTUnfGpMhzpFfHgBS4WtP9g>
    <xmx:XaQ0ZINdUVsdsRYmKh1RIufPfp743WXjGNEEbCE8NMrcv7vi4GSDxQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 20:05:47 -0400 (EDT)
Date:   Tue, 11 Apr 2023 09:05:43 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] firewire: init_ohci1394_dma: use correct function
 names in comments
Message-ID: <20230411000543.GA254125@workstation>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230410011306.26268-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410011306.26268-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 06:13:06PM -0700, Randy Dunlap wrote:
> Prevent kernel-doc complaints by using the correct function names in
> kernel-doc comments:
> 
> drivers/firewire/init_ohci1394_dma.c:258: warning: expecting prototype for debug_init_ohci1394_dma(). Prototype was for init_ohci1394_dma_on_all_controllers() instead
> drivers/firewire/init_ohci1394_dma.c:289: warning: expecting prototype for setup_init_ohci1394_early(). Prototype was for setup_ohci1394_dma() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Cc: linux1394-devel@lists.sourceforge.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
> v2: rebase/resend, add note to Andrew
> v3: add Takashi-san
> 
>  drivers/firewire/init_ohci1394_dma.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thank you to remind it to me.

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
 
By the way, I got enough access permission to linux1394.git repository
and I'm preparing it for maintenance work (not done yet).

* https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/

After finishing the preparation (e.g. joining to linux-next integration),
I'll apply your patch and tell it to you, within the week.

> diff -- a/drivers/firewire/init_ohci1394_dma.c b/drivers/firewire/init_ohci1394_dma.c
> --- a/drivers/firewire/init_ohci1394_dma.c
> +++ b/drivers/firewire/init_ohci1394_dma.c
> @@ -251,7 +251,7 @@ static inline void __init init_ohci1394_
>  }
>  
>  /**
> - * debug_init_ohci1394_dma - scan for OHCI1394 controllers and init DMA on them
> + * init_ohci1394_dma_on_all_controllers - scan for OHCI1394 controllers and init DMA on them
>   * Scans the whole PCI space for OHCI1394 controllers and inits DMA on them
>   */
>  void __init init_ohci1394_dma_on_all_controllers(void)
> @@ -283,7 +283,7 @@ void __init init_ohci1394_dma_on_all_con
>  }
>  
>  /**
> - * setup_init_ohci1394_early - enables early OHCI1394 DMA initialization
> + * setup_ohci1394_dma - enables early OHCI1394 DMA initialization
>   */
>  static int __init setup_ohci1394_dma(char *opt)
>  {

Kind regards

Takashi Sakamoto
