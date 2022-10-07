Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E265F7BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJGQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJGQnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:43:20 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0608F26B;
        Fri,  7 Oct 2022 09:43:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 72D7C3200413;
        Fri,  7 Oct 2022 12:43:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Oct 2022 12:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665160995; x=
        1665247395; bh=ztA8X0oCOrzYe4bRM5wcVboplj1CUUEIc1ilkn7aa30=; b=q
        FKLdf9EkUFedxcq0I8GMRLbiWqr6NZQZMGydORi7Kxsl3CqTUS/EjjN9Xh0NrbNK
        +NMDRdSZIVBmKoVd4EUhYiBPy8CFx2ArnKFSawz5/mNw/o7t0NZt8YdKzX1FPSZ9
        XoACLMW9kHSmBH7RBRqEbrTHLTERGlwxXMBFIwmsf5cMv/gF1wbLNdqXT3QCWXAA
        wcuhZtRxilf6WNmv2J4gDJAXPVZiGVW+Hb1EtlzVvrCVw29qO+944jLstNlWNdU4
        zT6J3Hy1k4S+DgDQHpG8NwdnurTBV9AbbCQSF3RrFBm8+HLIedUQEab+5RWc1JyV
        C6En08tpCZxwX0IPjvceg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665160995; x=
        1665247395; bh=ztA8X0oCOrzYe4bRM5wcVboplj1CUUEIc1ilkn7aa30=; b=V
        iORmYvI9BZfPe8CCIIT79BNszLMcZOEu8k5emi66xDB2mXe1SiUL4fYcl2u77Uq7
        KJQE8U0DHZu1AvhCVOxQGlnqA1S/1r6rsb6/jCuNrBRq2dtjpQBeLxt9NscAeFVG
        j/Wtfy2+QBYUgKmy8TEdiTHaVA3eF2+6moDmbi4HeTjRgRvCycStZPQURPYjsi2/
        3h1dm9GXa2J01SVcCTgCzHUuwnvXHY9cRN4Mqzt0CxwPOA2c9uQ+3z3DyfLycKpB
        z66utldH6N8O7jjbDH06go6fzVDezOiqGJeJHsG4tirJAlwr0X1nkwU2Kk8HKYRI
        H92LOs1gO80mq2FwQsQxw==
X-ME-Sender: <xms:IldAY9YcrY0GPBVpttivtE8OWGrjcFUA_8DE8DPS7_GMgysCU1CKnA>
    <xme:IldAY0an20vC3DnwkP8TrolukoPfVB7kRp8jXRBt_DB5K1MYk14Vwsh0QkMEpzmsF
    Ex-h0BvbJhsNQ>
X-ME-Received: <xmr:IldAY_90t4QK72yxDpO73zCWOwzs0Kob1MuCWr6CJsatrp0BFX15lZbgLj6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgf
    ekffeifeeiveekleetjedvtedvtdeludfgvdfhteejjeeiudeltdefffefvdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrh
    horghhrdgtohhm
X-ME-Proxy: <xmx:IldAY7pWMZe9_52OngMsdzKSb6if6T_pl161LvQf83vWI325963RZA>
    <xmx:IldAY4rNqC-iX4aLjjBuJbykJ27hF9qfqVKcag6QX-WsPQ4C0RNENg>
    <xmx:IldAYxQcqJuBw90WnjVswHFP4v2Dug9FMPZD7yVk3WEtx4-lJn5nKg>
    <xmx:I1dAY1jWZd4iSJIAVHZNkE4ex5dU43iro1I1qZLUW9I_c5O9B_Lq1g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Oct 2022 12:43:14 -0400 (EDT)
Date:   Fri, 7 Oct 2022 18:43:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-api@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH v5] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <Y0BXTP4ur6bxrpim@kroah.com>
References: <20221007141207.30635-1-jiaxun.yang@flygoat.com>
 <Y0A9L2KajswAEKsu@kroah.com>
 <b3886864-5c54-4524-8e30-b6701553b615@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3886864-5c54-4524-8e30-b6701553b615@app.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:37:34PM +0100, Jiaxun Yang wrote:
> 
> 
> 在2022年10月7日十月 下午3:52，Greg KH写道：
> [...]
> >> +
> >> +static int cpuregs_cpu_offline(unsigned int cpu)
> >> +{
> >> +	struct device *dev;
> >> +	struct cpureg *reg = per_cpu(cpuregs, cpu);
> >> +
> >> +	dev = get_cpu_device(cpu);
> >> +	if (!dev || !reg)
> >> +		return -ENODEV;
> >> +	if (reg->kobj.parent) {
> >
> > Why are you looking at the parent of a kobject?  Why not just always
> > remove the kobject if you have a reference to it now?  How does the
> > parent matter?
> 
> Another dummy copy from Arm64 code... kobject_put should be enough here?

Why would it not be enough?

