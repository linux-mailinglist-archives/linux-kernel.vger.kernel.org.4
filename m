Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DE8629217
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiKOHCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiKOHCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:02:04 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C87672
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:02:04 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D1D0B320095A;
        Tue, 15 Nov 2022 02:02:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 15 Nov 2022 02:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668495722; x=
        1668582122; bh=qSXY6b1OFdbBMx6N9E7tR9znaN9W9UBLf9DFV6qUxEw=; b=p
        DeRwsTYNYh3kzMcLmSxrYk2fEF6GoeWpdfg4HF8JTysNkCvJXCcf4FM/jOFoVl6s
        RBsY52MIQ9JkOe0JaBe9PxTm7g2k2RmI/3n0kw3yHvEPOAPphFxIrIi4xCJDORu3
        ACMa6iS/ViBf+Gwba15YmII2bDvAhkt0iMbo3Q9VZNiiu7wnjmzmSQrtDI4SBnrs
        MVJokccUF5JtMbQ7kRFvzOUKqhFx+3UM2DtigFuXSSD0Y65Tow4FnIXbmMIgTbVV
        e9Ygr05HbHiUHGUktroyTkq4csop0GxdRwFKYDxbo0JduEcsUd6fp8l4xFxTmpPa
        rRH8MmqVC/ZqKqm5Sdvjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668495722; x=
        1668582122; bh=qSXY6b1OFdbBMx6N9E7tR9znaN9W9UBLf9DFV6qUxEw=; b=v
        4xtmZnS1TwlqYHpQLXo5W70khni1rCadRxMZzxiRFoe/8YTdI2pE/geiw32uPEgL
        9bH+/bBay0ZqhUryWHO+1P3iqRvu8k+m2DF6mtQvWUAkHv5b5ns5NavvxuoMH2Ba
        i+XKnbYTpqBdfIXMDQvKwRk5SRQJuCDKyKRNwhDcgtEg2bPcP1/Kr4MZnBj6qZGv
        MFtt/BtTyE0GrZ9pp25VK+wGCyGDHbbGd4C0S0naJzOatIeV7gk31pFxwde1WEjQ
        f0xcnlyQfZa7pzrpOssJI0shDuBtipB5ZVbJ2UMo5aYnAmu5+/e8C0JoJ/TKvcwV
        Vt/gE4mxyFOS/+dx3rrQw==
X-ME-Sender: <xms:ajlzY6GfwWNCReozB_AifeEXPXIYqv5BTxpJhF8cpYmoDnUDEGB04Q>
    <xme:ajlzY7W5PX2iUpNxmSIo-F1gBf4qX___8KEKrpJGUGGBTb3ZsXY3ce5LTRY_YSGDk
    tx4dk-F1o-oxr4iww>
X-ME-Received: <xmr:ajlzY0IIXeiNmKBr44Sy-RvXHay6QffhW_u5N0Z3-Mm7036Ee-Ej1-ZWTj_NsFzHKiR5ptzonYRmZXzjJ9HPGP7T_fWujfY0wWwFN84BxiVH8WNAZIRQeDtMow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeefgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleel
    fedtteejhedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ajlzY0E8w6LRgYibTM-hKn54m7aZFTfUOR42OqUNsmKu-KYxWvF2ww>
    <xmx:ajlzYwXSctvlGDSfDau6s7_fwGfA32JUB_-BYHNWSqOrfzDjt0nwzw>
    <xmx:ajlzY3OGFgzi3JIuhjaDBLa_rhoP39dDbShnHcVvWPoTpLU3P6Yz8A>
    <xmx:ajlzY_Mbd4mG3S2tw4cfoxMvQfmTQ6X2ieB0EEHG5y2pUeO-XLQphA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 02:02:01 -0500 (EST)
Message-ID: <ac450a01-5771-be91-fda4-9b3084c9bff3@sholland.org>
Date:   Tue, 15 Nov 2022 01:02:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/1] regulator: axp20x: Add support for AXP1530 variant
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
References: <20221114162459.1802174-1-martin.botka@somainline.org>
 <202211150623.9oWDx9Ec-lkp@intel.com> <X11DLR.YBCMARW947UJ2@somainline.org>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <X11DLR.YBCMARW947UJ2@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 11/14/22 16:56, Martin Botka wrote:
> Patch depends on the MFD driver which introduces also the regulator
> definitions.

Then you need to either send them together as a series, or wait until
the MFD portion lands in linux-next.

Regards,
Samuel

