Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB54681883
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjA3SR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjA3SRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:17:55 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A192D7E;
        Mon, 30 Jan 2023 10:17:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E75265C0117;
        Mon, 30 Jan 2023 13:17:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 13:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675102670; x=1675189070; bh=9OsIGbEQni
        7gAWb33xW9zSfxbjrh3qiBjY82YoAPGIw=; b=iK3sQxbt48tiOwi9M0ZGgAvI69
        XmHFuxQ0CdzWdwgdT9OtFPyI4v5YVLHuUXI5XrFDOi70e1tNRQSB4WTneJhHEJO2
        ewTx7JIzDfXyy99nJ3TQp1nBWcOwSJFhUAtsJ09tDrBU+//2gx/Gj4vdwkcplUAo
        N3QssiK6W0dC3O87ciOh5Hf/7DTyVstTonI7qm3LvDv5ThovDttFdKHLNYPDLCnO
        GNOTliEAX/C4WgsncZ3IgWmyYchzoulAKzjB/9xcIEFMlNF6f2IdVmTdRumD4Wmr
        ARvbDpMBjsy2xxRVDZDLf45MEdO2SnMEimc2NV2vECugSHbb0PPWNnohCv2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675102670; x=1675189070; bh=9OsIGbEQni7gAWb33xW9zSfxbjrh
        3qiBjY82YoAPGIw=; b=nyOwxgilRxk1rTnVZtlwK6hdaxqgQBnWNbjfugG/bYjz
        jHEGlf4a0uc1qXKjXLWveuXzhcAM5I6yZi2D6gjjHQBWmV8o+0CtsXzwiNYpu8gG
        xFzJYfxLr/RGQxOzA1AZIdOrvCfXa82YFOHrXQ+WcEw4XS8zs1lyr0xAZl0O0Wqs
        3wk1fS3FoquxVHA78AO4huBaxADbi/7+3Z9ZSzUuJh1s5ZaTTiScaHxTd4BMsTjC
        gTWEpZ2AO66xYNcm/CpDjgH3jBlXqK1axocdx3yEy7QgarsNm2+eXZskHCIA9zXY
        ucwUe5dOoWItZS/5Bq+Ni9RzRx2Ooo5XuG6AvrAxGw==
X-ME-Sender: <xms:zgnYY97ltbgApZy_ZHNvu3VjhiiqUOLFPPFuXzDwGzcoQ6x0JMu7Nw>
    <xme:zgnYY65vlsZrnBQrFYbLnlp4v3_wv0bmO4lXJey0V4lx6PWEuCDyFoWUCUmaD2twA
    hft0gfspxdisumKTdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zgnYY0c5LIZ_5AJ_VN0h6LCuzgC8XKoYdl3qn4YE5FIjqPFHCC6mcQ>
    <xmx:zgnYY2KZoYBKPA5wCJLCzSkRr3xwhoDf57_hNfjm5AqJAoQ2gI1BbA>
    <xmx:zgnYYxIfOJOw8znJXFiI52vtPk_8hq-vnBfavOTkQgVpdtzT2pYviw>
    <xmx:zgnYY59-AGYy5PK12xUk65VnNIudNIW6Tmczs_Sf103KP51iYCc3sg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A14CB60086; Mon, 30 Jan 2023 13:17:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-106-gfe3ab13a96-fm-20230124.001-gfe3ab13a
Mime-Version: 1.0
Message-Id: <14e7d2ba-1a24-42a1-b19e-842e0fd8286e@app.fastmail.com>
In-Reply-To: <Y9f7/q3aS5nlY7nJ@smile.fi.intel.com>
References: <20230130131003.668888-1-arnd@kernel.org>
 <Y9f7/q3aS5nlY7nJ@smile.fi.intel.com>
Date:   Mon, 30 Jan 2023 19:17:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Hugues Fruchet" <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023, at 18:18, Andy Shevchenko wrote:
> On Mon, Jan 30, 2023 at 02:09:47PM +0100, Arnd Bergmann wrote:

>> +		ret = PTR_ERR_OR_ZERO(tsin->rst_gpio);
>>  		if (ret && ret != -EBUSY) {
>> -			dev_err(dev, "Can't request tsin%d reset gpio\n"
>> -				, fei->channel_data[index]->tsin_id);
>> +			dev_err_probe(dev, ret,
>> +				      "reset gpio for tsin%d not valid\n",
>> +				      tsin->tsin_id);
>>  			goto err_node_put;
>>  		}
>>  
>>  		if (!ret) {
>
> Can be 
>
> 	if (IS_ERR() && PTR_ERR() != -EBUSY) {
> 		ret = dev_err_probe(dev, PTR_ERR(), ...);
> 		...
> 	}
>
> 	if (!IS_ERR())
>
> (Up to you)

I prefer the version that only has one PTR_ERR(), but
either way is fine with me.

> But -EBUSY check seems strange to me. What was the motivation behind?
> (As far as I can read the code the possibility to get this if and only
>  if we have requested GPIO too early at initcall level. Would it be
>  ever a possibility to get it in real life?)

I noticed this part as being odd as well, no idea why the
code is like this. I just left the logic unchanged here.

      Arnd
