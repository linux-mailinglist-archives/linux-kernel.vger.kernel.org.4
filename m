Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC228745CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGCNFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGCNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:05:39 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95BC7;
        Mon,  3 Jul 2023 06:05:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 106C65C0343;
        Mon,  3 Jul 2023 09:05:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 03 Jul 2023 09:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688389536; x=1688475936; bh=y6
        6qck3wmZRJ36t4o8onZHFSCsILya7sH1NGYC0a8vo=; b=U1UWfzyr96yEthJAxp
        9jPKIkpzj7cVeQWBUMLUO99svO7/eu/ifPPVeOJA+TN6TCk+Wo6UjcXv1xWsFUjH
        Qonsap4cwe6NcE/Ik1fwMC5QoaRQkkA8tIT++QUyn17Qe38wVSX5QJTgXRHDmvBn
        JSiGfYq6sODz9oErC5cuEP827NSRKQg43d46Xufw0ddys0ckN3YabiNK6hiunk5/
        pCKrGRqs77Fapz9+d5MELwDUgVYM6WLrMsEgumwxwtAOikt9cLq6jIbHzR8QDFT1
        TyXrPaDnZiOWea57+u/Z1U+rLB8ZD/aQkM6YAPV/JyRnhs1dBoNvYbZwsYzj5Etr
        dcDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688389536; x=1688475936; bh=y66qck3wmZRJ3
        6t4o8onZHFSCsILya7sH1NGYC0a8vo=; b=MZOm/iMfgkoulowADa1KxG+xLmFnq
        tIZsBD7uqqhD+tHakSyXlJ17KbX4WDBkCxpeeQulavhp+NAFUgN0Dp9m9IjaLPsw
        bbYdIdXCMwcHtpr6Us+w60sIJkFkLlC/b/M+gisr4DMvAWdUUGKYSGrXxjQ4gd+g
        eziQHCcWjxA2UYU1Fv5qtgn5PXetQ+psjISPwbUE5uxjfu1UaPGa3cwQgL3DR+Qu
        a3BK/QNNsNdFoD9qdBHJhqUALBaCP3lv2sB6FYw1zHJw1b8PYqCxkWp43WHjVNx7
        iSisDVVHoNojCvJ/MN4Wx/CAPXcbJl58HZufK3pNSXaVGGTFLHu95s1bw==
X-ME-Sender: <xms:n8eiZGtMqg_4S-0X5ri_ugKW6y5clECOkjR_ONuc9Zb14wKp7ZNJeA>
    <xme:n8eiZLfHxDDT4vogSewfjr5-Uf4nSnhvxU00jQsGETua-vmrM114roXqb1eBGw6l9
    YSeDZqQ59VGbzoZ8LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:n8eiZBzLS1XNAexzJn4uPJACKlPwPM_LL66_PYOi63c8-b_vouElYw>
    <xmx:n8eiZBMPdDT4cNJXs7joMXSnC1y-p8LC3Oy1G6JD7-Y6Z_ZEdApOEg>
    <xmx:n8eiZG9BvTaMd5JN4M9zd0Tun0MY94xNgGVTINZuk0_quqSjm2EyQg>
    <xmx:oMeiZNnDNcS-pKX978eUW4zYREMdgs3UcZUIxW98lhXTjLpyAoeysg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 60ACFB60086; Mon,  3 Jul 2023 09:05:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <8af6715a-8dc9-4cd4-9a83-acc27e539c54@app.fastmail.com>
In-Reply-To: <2023070309-outlook-predator-c3dc@gregkh>
References: <20230703123053.3117488-1-arnd@kernel.org>
 <2023070309-outlook-predator-c3dc@gregkh>
Date:   Mon, 03 Jul 2023 15:05:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Udipto Goswami" <quic_ugoswami@quicinc.com>,
        "John Keeping" <john@keeping.me.uk>,
        "Linyu Yuan" <quic_linyyuan@quicinc.com>,
        "Dan Carpenter" <error27@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: functionfs: avoid memcpy() field overflow warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023, at 14:45, Greg Kroah-Hartman wrote:
> On Mon, Jul 03, 2023 at 02:30:32PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> __ffs_func_bind_do_os_desc() copies both the CompatibleID and SubCompatibleID
>> fields of the usb_ext_compat_desc structure into an array, which triggers
>> a warning in the fortified memcpy():
>> 
>> In file included from drivers/usb/gadget/function/f_fs.c:17:
>> In file included from include/linux/string.h:254:
>> include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>>                         __read_overflow2_field(q_size_field, size);
>> 
>> Usually we can avoid this by using a struct_group() inside of the structure
>> definition, but this might cause problems in userspace since it is in a uapi
>> header.
>
> We use this in other uapi .h files, what is unique about these fields
> that makes it so that they can not be used?  Because it's not the last
> field?

It's probably ok, and I was overly cautious. I'll send a new version after
some more testing.

       Arnd
