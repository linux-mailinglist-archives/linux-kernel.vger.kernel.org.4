Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC851716122
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjE3NJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjE3NJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:09:23 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF0109;
        Tue, 30 May 2023 06:09:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9E7D4320016F;
        Tue, 30 May 2023 09:09:11 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 30 May 2023 09:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1685452150; x=1685538550; bh=lV
        YHeJu8wkJLFHZkEE7erujnPC094FVsR7kmXRaB43o=; b=niZaQrSKzNEnAKJTP0
        vwW/ik2IICWDNzj/z/OJfaNwLOCeyAb8m9ghk1J9XdvADUm3G+FKlleeAN6VBxai
        Tgx10yt/JQtsDcLj1etZMb2aCOaXdhbzvSPJXifk8X3SmoeOUPPhPFPgLQ2Gi/oE
        EPWFsDNNjzGd6qZ4IrznCgA0RdbaV+zzeoTIBQcCvTh3ONbwsveGFAc1YiVHHs6X
        Jk93a0XAOOsddQiicQieFbSN99q+Jhn9wLusSTHe5VpMHWkJzLVpkERXkpLDNO1g
        PN0XIN4QSdrSWKgtNSSk2N0Wbq97TB7aUWOve7estMunwriDNiLxs43S737ICWTf
        211g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685452150; x=1685538550; bh=lVYHeJu8wkJLF
        HZkEE7erujnPC094FVsR7kmXRaB43o=; b=dPbnKSbE0Le7+/Y7Q84IITbZ1vvt3
        olyLdAjT8sOCq9RdhIsKceFUzcEIa00qJ5Wa1lRIwyl+bEG9aSEnyqO51X9ehpBb
        CJp4chNwd5T74LCVmK0H4xkVulM7SL/axzsKdCm+bBSfwWCxUj0NroeYUQNvBRWf
        asM9MvmwDUrJwWcIeEoimmnnlHLOsExIttSAuQYq/BykRkqPLzqoyWNh9eqhtU7a
        WoA1laXrRwfQVG/h+C4xFTT5Lhvw8YBqCDWB/nL2FvJdxEbExw0raa5QhDJrFaZG
        qXbyn2NsOOnyZLBLTFOFxj2IMIv2MSthmiMAX87Mtn9pSOzy+nwAq/18w==
X-ME-Sender: <xms:dfV1ZE7W-_VZmiveduY60UyK-vCqnGaNtlcacOE5g3O2tsq9V1782g>
    <xme:dfV1ZF5vonqH95TR4MLc08Izn8F_c1UARdgVeRatnWGl7ozOUQ3BCUIXpwkJLyPJA
    C4qcJ5Y2BeApb1CSqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:dfV1ZDc3QE0K4A0GpKiifUSqXsLWa-orB7w2dC76RBxFqk5v7n5qZg>
    <xmx:dfV1ZJJYinO10E49AoIgqBd_oPk2cIyRlHAg62fFq_M5dUjagKhpbA>
    <xmx:dfV1ZIKmVvxPZ31JZvg2xiVvmxcIioeTuPMnyo0WhBBi9K1LCw7TGQ>
    <xmx:dvV1ZCgkSWinXcZbieGPEDzZTzHsYu-iYiDXSQYb1w3DkNC9w33nTQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0C15C60093; Tue, 30 May 2023 09:09:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <b9b98752-da3d-4cac-b010-fb13c90bb2f5@app.fastmail.com>
In-Reply-To: <2ca9ef5d-2a24-c6b7-06fc-5b9919a2aaee@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
 <2ca9ef5d-2a24-c6b7-06fc-5b9919a2aaee@redhat.com>
Date:   Tue, 30 May 2023 09:08:49 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] platform/x86: think-lmi: Enable opcode support on BIOS
 settings
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

On Tue, May 30, 2023, at 6:54 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 5/26/23 19:16, Mark Pearson wrote:
>> Whilst reviewing some documentation from the FW team on using WMI on
>> Lenovo system I noticed that we weren't using Opcode support when
>> changing BIOS settings in the thinkLMI driver.
>> 
>> We should be doing this to ensure we're future proof as the old
>> non-opcode mechanism has been deprecated.
>> 
>> Tested on X1 Carbon G10 and G11.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Thank you for this new version. Please prepare a v4 addressing Ilpo's
> review remarks.

Will do

>
> About the aligning function arguments on the next line to the '('
> of the function call start at the previous line, checkpatch also
> checks for this.
>
> It is always a good idea to run checkpatch before submitting patches.

I always do - and checkpatch isn't complaining about the alignment here.

Mark
