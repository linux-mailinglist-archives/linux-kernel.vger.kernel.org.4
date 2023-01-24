Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B663678FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjAXFLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAXFL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:11:29 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1D5B90;
        Mon, 23 Jan 2023 21:11:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2A836320093F;
        Tue, 24 Jan 2023 00:11:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Jan 2023 00:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1674537083; x=
        1674623483; bh=FL4EH6QJK+d1XgoAroJrgotEkmtGHshewgrLCi3uekw=; b=r
        jtn/0FU/v56BlVNeisMMSPzODrC9lG+vIBgyK8yUBQYEnvi+NSW1PhRiWEWejf9y
        DBMts3ZbhgxCteSsaNrAbsrx3Lxx1vD3+Q+vSVME2JDSjsD+dERvQV14dttsIhE5
        4I5s9vH/amlpFzbVz03tX1gG2G5xbR5L9HQvKRYvQcxrzMBcTJ7GpKwDD//B5JHO
        UxJ5bY8pXReNk+13UuaMxtYSW/rYhKkoMSLwiUz7iRz33r/ES8RC+0yN9XygSY2G
        Baj/nMmnRVz+01qT+5NfcTRwO03mb2MSrC3QWFpuPqvioEM9lZaZ5u7utsp7Tg2W
        fFFEwBKr0ikIxckS9/m3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674537083; x=
        1674623483; bh=FL4EH6QJK+d1XgoAroJrgotEkmtGHshewgrLCi3uekw=; b=i
        odecc03ocFIbjUEYEowrzdz0krD8bba7o8+vnGpbpBYspcuqu02fQJaKkjIBxFsk
        GsVLWdT74zXF/d2NvlNGi8BENIkVxR4a/d6FLEBRZhvhihCXPRp8Ky5GB7A4Ysd3
        St8gM1tL03X1icXX9xEHlLplIubOWGv0+1ouPYmJYR5X64YObQzcDrjK6ZMJEttU
        7tReJrl+url8zt6QsbTOsAmrMaev/MHJHKQpxejPR7P9oesjIkAycZpzxsfOQaS9
        MYsD39/531WjGI30fHjyJQL3oNj9aK+hy7Tq1KKGZ/wu7FD/81fCWnK486mDmSQC
        bp32Kj2BqLkYT3h3t+MXg==
X-ME-Sender: <xms:e2jPY1iz9LZz-HZ8fMgwNQ1I9lgPn4QkKZ_bdijKT87dl3oSxbBdaQ>
    <xme:e2jPY6CIZ6wKxGCD0qFydX-9PWjtGI5ROGEOOyf_eLVTFiQmh6RKGELOanG7IXLIf
    Liz6ZgeAvv0FA0aWA>
X-ME-Received: <xmr:e2jPY1FEtRewVLA-CseS80ahykYUqa7mNJt84yyMZIixWmKuBOPV3C6PSso7wHMqAlOsZtxWu7TlAp6yUWkGlQ8OC3LxJp-wge2d9Zv9fg_mGPRtoWEHuypYEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:e2jPY6RIHnG1EUqXaC3ACprutbwXrzsJkoSMFBvXOrE7FVFTVWkTcQ>
    <xmx:e2jPYywKnMpkbb1B4hxUMyrqWP98vX9ORFVTLs90GVRcQbr7vkzpnA>
    <xmx:e2jPYw55Cn94tS4s1iUFh1Eke49XtFb0udXx6Er5tEjsc0LeR1G5ug>
    <xmx:e2jPYzomzZAebvz0EzYzrvupHjTo-qOA650_P1omIPpLDP9FJqGp3g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jan 2023 00:11:22 -0500 (EST)
Message-ID: <9d61bda2-17ea-723d-7fee-e911061054bc@sholland.org>
Date:   Mon, 23 Jan 2023 23:11:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
References: <20221231164628.19688-1-samuel@sholland.org>
 <0c411b60-1d12-1c34-0f35-5e38d38e2786@xs4all.nl>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 0/4] Allwinner D1 video engine support
In-Reply-To: <0c411b60-1d12-1c34-0f35-5e38d38e2786@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 1/23/23 06:33, Hans Verkuil wrote:
> Hi Samuel,
> 
> What is the status of this series? It seems to be mostly OK, but I did see
> a few comments suggesting improvements.
> 
> Does this series depend on your PPU work? That was not clear.

The first three patches do not, but the actual DT node does, for
completeness.

> I do think there were enough small comments to warrant a v2, unless you disagree?

I agree, and plan to send a v2 with the binding/driver changes made
compatible-specific.

Regards,
Samuel

