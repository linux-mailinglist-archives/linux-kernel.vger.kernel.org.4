Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98467B8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbjAYRga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjAYRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:36:28 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD335B597;
        Wed, 25 Jan 2023 09:36:24 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 874105C00D8;
        Wed, 25 Jan 2023 12:36:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 25 Jan 2023 12:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674668181; x=
        1674754581; bh=VpaKyOeeNsoB1s68TYe0vuAy9Pw1dIF/erA8n8pEvvE=; b=Y
        qZcgC2AgtBLb9D1dcphAx3AxU9wKSEkdcFlR/gNp4L1ITi4V8xBdJPPgTxWXZHK7
        Ops9LuZvrdpueF0NbFtp1B+1PIF0tF6R5FPTsXPwqeSO6g/JqqQo8vNeYlqVLDHV
        gRBQc96akQ5N+Sa4w9t/EZXcbXwmYOYwdWnqNW0MchhTrhgLL9YB+a/G/TwUOmei
        Lugq9FI35jkUURre/Qnqv7jAsm64y1uKFkwDU6bOuaGAGlV9A3/ZUQ7wDyP/CAML
        IgNmVncixYEPJLfatd3xOIFJfRPzxGtLMxcjxlCEhtw3DKlAmxE0VYl0im9Kw2ot
        KTfTVjlfcfjXTXVYh1s9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674668181; x=
        1674754581; bh=VpaKyOeeNsoB1s68TYe0vuAy9Pw1dIF/erA8n8pEvvE=; b=c
        2nRGqU1DVQrYh+bkKCPX1uGLrkfqY28YU8CFtkwrq/7iFo6eznR4VRZgrBQJuq47
        TW4W4L9tLmOniudVYBy81Zmptd0nwRo8Z+NkHWKShWBtYLSAUYGRkFjzZr0FXMd4
        VN6uyKz0JypxeItYePeN32u/7gmDFm5olAcE3enqlgvujJVwUD9VJbW6huinwfGP
        /YpUI5IWv82xQILJN3xnoW9L68pfrM1VMDo9aM+gurHVmLm/Bi5ZXwyt88/YVhae
        KMgTX+Vh6CfCjB9oZt2gV6b0LMlyBFhTszEI+680YO+8Epl2zfNOCu6ioGQA+BCe
        0c23ygxvWHbJdLcMtbgXA==
X-ME-Sender: <xms:lWjRY4PU9BNhdnZLVqH22Ckv-yKve6IfxbRmrLPkOYr16Fa4aEb21A>
    <xme:lWjRY-9J5kBvbPRctsp4en3lpDlNi5i6UgOsugOF636GCW4EWiBQ_CyQnGPA9AEXk
    6LtNz7S7lrhzA>
X-ME-Received: <xmr:lWjRY_SMLuo8pFPTRCD7BmswoLQUC-F-62Cqy-mI7lhDB-_vrz6sgdDsWMzjb3TFWKI1hsWaGlgWgHYa0_3fXelwjQIdctmecp0smA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ehheduudeugeegjefgheeuudffheevueekgfekueefledtjeetieeutdekkeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:lWjRYwuoSFbxuuRkK-b6nA4sV6EaIVGQ_DsoH8DuD2_gsSD6olht3w>
    <xmx:lWjRYwczUbQxtK94G4zKyJmM66da4QAHhwq9_DB4XxGkVjyyyT49eA>
    <xmx:lWjRY02gxVddiAPl66716QFvmdEgVipbhNyVtzYnWi6eCCiQ0WlCOw>
    <xmx:lWjRY4RgnBGRwKwj_QMTbaUt5rUCa7rK1ZwRWPm74zkchuomIA7ilw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 12:36:20 -0500 (EST)
Date:   Wed, 25 Jan 2023 18:36:17 +0100
From:   Greg KH <greg@kroah.com>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: add doc to struct usb_composite_dev
Message-ID: <Y9Fokec99g+c31P2@kroah.com>
References: <Y86cy1AM4w5ju5A4@kroah.com>
 <Y9FmWVF+J08V4RbP@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9FmWVF+J08V4RbP@jo-einhundert>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:26:49PM +0100, Jó Ágila Bitsch wrote:
> Added documentation to the new struct members:
> * bcd_webusb_version
> * b_webusb_vendor_code
> * landing_page
> * use_webusb
> to avoid warnings in the build of htmldocs
> 
> Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>

What commit id does this fix?

And it was reported by Stephen, so can you provide a reported-by tag
too?

thanks,
greg k-h
