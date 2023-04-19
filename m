Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922EA6E740B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjDSHbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjDSHbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:31:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB046B4;
        Wed, 19 Apr 2023 00:31:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D22A65C00E9;
        Wed, 19 Apr 2023 03:31:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 19 Apr 2023 03:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681889473; x=1681975873; bh=Ec
        4Ecq7H4INlX/3HvS/3quM8Fg2PkdC80uzcjyfYOJI=; b=VCrvrExRrgs5WTxoZZ
        b6o/Wn2xY9uJ3qgnfSXPHzVACCJFSvPUT43RJKboctcCzfUNkn7ogvkr3elFgR/M
        27VCCKLYRMGJVjesdnqXOwG2mKT832b4mUV5B1yip1QgIGOXbSdVRlXfrVnZccOw
        fr2r14Q+bm9TIv7qW02iL3XQJ3n3UYsoeIDU8vmboqRUY2lsgR5loRzRYpsePbqd
        nge+onwZXU23O/r7jHcJLdPA7WLVY44GczoWuEV6ydDj1vYIGLQ37RhJKlR1vgBZ
        vMJoUaF5k0kQK2fmgPVfy30/qOO4HfoQs/MReHs5M0mSxznrdoHJaHC760rSVOQR
        QyYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681889473; x=1681975873; bh=Ec4Ecq7H4INlX
        /3HvS/3quM8Fg2PkdC80uzcjyfYOJI=; b=eDxpRvKP0y6qok6rzsgrcxDtk+GQR
        TeXy/o7hCOxk0uNMbc6fzVQStfx4nLMCkWQ0yg7XRBbSGOhaCDTfkYeHgzfFReRu
        YPteXgf/lUZQtJp9EZ01EfE4OMbg47vvuxNAYHJIjFxwKMgmanr8WXC2Kbj8qiXz
        mgK9LOvLf+eiMq/72zW+jwlZ3Ifn70I0+3RwgjHlG8vypIkUHIa8iJZ+2xPSyYO2
        cORgp4wXKBmhCWniyA2nbxGa8NE8SnzNvy5Pbqq02Bo6alUiUPpW04wILREz7vke
        bp2jt+PyCi1Rrf3JyscVvv/Iqwq3TamOEC7wPo/mjsSInowRzLSUmkkYQ==
X-ME-Sender: <xms:wZg_ZKK7RGecFL3GExmwiIm6Lbli87fWw2G6KWBniHgKX_jiYuh4aA>
    <xme:wZg_ZCKMJXYshqb4GuqM3Mz6NUxZ2Ymt6BpUnClRvB_VqAmSssPN9P3bCXQwWRQeT
    gOpxs4WOu1WYpLhRSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:wZg_ZKuOm6wxINAVt4yFGBHqv3B_xo0u20VVwglKwHTj1qxUyh2REQ>
    <xmx:wZg_ZPbM8FQbKIH_sk0XL6z_staU5GJAPYoj5BOzthGSM01yoyoF0Q>
    <xmx:wZg_ZBYNuAUN-42j8eiCykeAILB1jjTKPF8i8OPJWe0cYjwQgvMoFg>
    <xmx:wZg_ZHARBlYD2gjZbKDzIbN2uSn5eFYBnsjVQL5_7EhMfS0rs5FLKA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 698B9B60086; Wed, 19 Apr 2023 03:31:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <50844899-b047-42fd-807a-db7136e5e590@app.fastmail.com>
In-Reply-To: <f1456dd7-5dcf-d91a-459c-65efca4a3444@quicinc.com>
References: <cover.1681829664.git.quic_schowdhu@quicinc.com>
 <e4f41fa61d9dd66f68bbd7650c6fbf96810c3569.1681829664.git.quic_schowdhu@quicinc.com>
 <2023041833-alienate-trash-f4da@gregkh>
 <f1456dd7-5dcf-d91a-459c-65efca4a3444@quicinc.com>
Date:   Wed, 19 Apr 2023 09:30:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, "Alex Elder" <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V22 2/3] misc: dcc: Add driver support for Data Capture and Compare
 unit(DCC)
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023, at 09:00, Souradeep Chowdhury wrote:
> On 4/18/2023 9:15 PM, Greg Kroah-Hartman wrote:
>> 
>>> The following is the justification of using debugfs interface over the
>>> other alternatives like sysfs/ioctls
>>>
>>> i) As can be seen from the debugfs attribute descriptions, some of the
>>> debugfs attribute files here contains multiple arguments which needs to
>>> be accepted from the user. This goes against the design style of sysfs.
>>>
>>> ii) The user input patterns have been made simple and convenient in this
>>> case with the use of debugfs interface as user doesn't need to shuffle
>>> between different files to execute one instruction as was the case on
>>> using other alternatives.
>> 
>> Why do you have debugfs and also a misc device?  How are they related?
>> Why both?  Why not just one?  What userspace tools are going to use
>> either of these interfaces and where are they published to show how this
>> all was tested?
>
> DCC has two fundamental steps of usage:-
>
> 1.Configuring the register addresses on the dcc_sram which is done by 
> user through the debugfs interface. For example:-
>
> echo R 0x10c004 > /sys/kernel/debug/dcc/../3/config
>
> Here we are configuring the register addresses for list 3, the 'R'
> indicates a read operation, so this register value will be read
> in case of a software trigger or kernel panic/watchdog bite and
> dumped into the dcc_sram.

Can you describe why the register location needs to be
runtime configurable? I would have expected this type of setting
to be part of the devicetree, which already describes other
parts that interact with sram devices.

How does a user ensure that the address they configure does
not overlap with some other use of the sram?

    Arnd
