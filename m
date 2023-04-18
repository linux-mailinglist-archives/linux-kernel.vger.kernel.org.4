Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ECB6E592C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDRGNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDRGNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:13:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3D30E4;
        Mon, 17 Apr 2023 23:13:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EEC65C00E7;
        Tue, 18 Apr 2023 02:13:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 18 Apr 2023 02:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681798407; x=1681884807; bh=vV
        QVLPH2v1chK7qtJeJorbitAX0W4SVoNNo6OCYXC4s=; b=P8p0bnQGiKs6wqOa/y
        wztbmeR0RMbxFN2ebNm5L6Gj7FMoR7pUsRDseNGt5mLiAH6lpPRFFHzDPmpH9uPJ
        gYlE2Td3MDS2lmeMb5Xcr9+Vx0bDV0myGaxTsg3U3xaUcfeOXNmSaVBhYj9vw/aT
        +2V2V/aV9LcIm+RXn/haUGXvAAIFPPFa3H78M/CaQV83qPxtQNA3U/MeY+YrLR7h
        XShVUukKNWy/WdxmRYMNisuDveWdGyD1cb/MmbDIhKqe7zZxnXhP/P2kja/6sk4T
        xAG7rC1MFsIDAJsot3Ba7wOmYIZbbhMCdRZlTq/BHjzOuQ1+SYLcFMP0+lyd8Q4W
        8L7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681798407; x=1681884807; bh=vVQVLPH2v1chK
        7qtJeJorbitAX0W4SVoNNo6OCYXC4s=; b=gHwbOtyV3nWJEhxLwIbQ3Vfx8560z
        O6qH5q9eSRFY0Qy3t4zwLFuT6x8RCcwMeuUsvyYHgm7JlCDSmK6twLgZppMrBC9l
        jH0ZIXksFCGnoB4xuiehH+e0icmbKmgVbiTRZWzlFS1YGK4bVl6rgAUQuLMuxXVH
        8EqokWjQ15vmEeLWg3p4AmUvh4iDxys/bTx9DiEdrJ89NhmJBkcQqWb2abdGwGkA
        65styWvwNtr1+vcVO5DAO+xyKPtwK1MwlCtQKufVQ6iPzZtbZQpel2mttJa6J34c
        FmjPgDw+GgR9YKD3vWQ08Qc6Im45aLSJZuox5uwow53ocr5O1HI/t5GgA==
X-ME-Sender: <xms:BjU-ZHOe8SxV6t3r0WXeFa_nIehSTb6OQfLVe5jD2kQrdv9kRXIR9g>
    <xme:BjU-ZB_lNUuEBlqN-cGni-lHFm6twG1Ah39ivIgtA2Hxhq5p4gcxXdNe7T3BLFvOc
    pvzR2-fe1TIyD3gWBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeljedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BjU-ZGTAwIMpcWg02_zVyUX_pLRanaHrLmmh68PYGw6r_348tK--lQ>
    <xmx:BjU-ZLsu_54U_WOGGkx6gDhuuJMo1cYRJOryaql1zQZ6_k3zqtqreQ>
    <xmx:BjU-ZPerSnFQquTW_btxT4LOx7oDZAgAncWYWgtY_cdkkCqHmsbOdA>
    <xmx:BzU-ZN0o_MDM2nwEugn_xuQiscp9X8WG7TYdPEupvULiZIVk-ckC9A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D4E16B60086; Tue, 18 Apr 2023 02:13:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <e4d7ceaa-ec0a-4ab0-9ad5-f0ecf9d263a9@app.fastmail.com>
In-Reply-To: <20230418032031.GA4703@pendragon.ideasonboard.com>
References: <20230417223738.1811110-1-arnd@kernel.org>
 <20230418032031.GA4703@pendragon.ideasonboard.com>
Date:   Tue, 18 Apr 2023 08:13:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Christian Hemp" <c.hemp@phytec.de>,
        "Dong Aisheng" <aisheng.dong@nxp.com>,
        "Stefan Riedmueller" <s.riedmueller@phytec.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Jacopo Mondi" <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: nxp: imx8-isi: fix buiding on 32-bit
Content-Type: text/plain
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

On Tue, Apr 18, 2023, at 05:20, Laurent Pinchart wrote:
> On Tue, Apr 18, 2023 at 12:37:27AM +0200, Arnd Bergmann wrote:
>> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:55:24: error: right shift count >= width of type [-Werror=shift-count-overflow]
>> 
>> But this is best avoided by using the lower_32_bits()/upper_32_bits()
>> helpers.
>
> I've submitted a patch yesterday that uses #ifdef, but I like this one
> better. One could argue that it leads to dead code on 32-bit platforms,
> but the ISI is only present in 64-bit SoCs, so that's not an issue.

I think there are actually some people using 32-bit kernels on imx8,
but they tend to do it for the wrong reasons, and I'm not worried
about wasting a few bytes in those setups.

My first draft kept an IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) inside
each of the three if(), but I dropped that for readability.

>>  	if (buf_id == MXC_ISI_BUF1) {
>> -		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_Y, dma_addrs[0]);
>> -		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_U, dma_addrs[1]);
>> -		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_V, dma_addrs[2]);
>> -#if CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +		mxc_isi_write(pipe, CHNL_OUT_BUF1_ADDR_Y,
>> +			lower_32_bits(dma_addrs[0]));
>
> Could you please align this with the ( ? I can also do so in my tree,
> but I expect Mauro to pick this patch directly from the list, so a v2
> would make it easier. You can then add my
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ok, I sent that out now, but now I see I forgot to add your
Reviewed-by.

     Arnd
