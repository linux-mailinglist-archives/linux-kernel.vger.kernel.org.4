Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6BE61A225
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKDU2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKDU2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:28:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E38011A10
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:28:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3E7BA320094B;
        Fri,  4 Nov 2022 16:28:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 16:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667593716; x=1667680116; bh=LGoKu0vw3K
        c8FrTfeG4Q9KAQSpeuhm0MFrj18uxk2Y0=; b=T3BN4RHFAmVSZZx2X5ZdDhkE3P
        qsEfuFbsGQIHL5OcIMvW9bM6DUKtOzjkYN28UfpdqKjU6/QPU3kFfbAqvxQE6DRT
        QijYI667m4QhH4eiuUFTr4Rspn4F264RVOd/4eDn2zGBFI1duMfat/lzXFc+mBFm
        aGz6gq15S83V+EbkmMIUaxPJX/44wmn+m+xGb7c3L09tSayLaqIvBxmAEi35qWLD
        pkC0f15bau7rcAImfMi1kNXV+shmKcMaRTCdRFHa4IhJ6vgKgwFi8FMd5knsoHP/
        TiYRjKBhNx3DpMH3zCRYYg6cqc95WoH4SgbNNMcJ+sK02rV3Fc4uRXn5TUwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667593716; x=1667680116; bh=LGoKu0vw3Kc8FrTfeG4Q9KAQSpeu
        hm0MFrj18uxk2Y0=; b=dA6MN3HOnNGr2laM0fDmdDcW0wwjN+r0FuAhVFVcAwvn
        d11BQz8cuIirjgRcilwZdncvaVoA40UR+XjjHw/eKGCnnlgQzZ7K8DZRROmlKwMS
        pP582ipiKX9+jGb1B3NTBSoBu7phgIXt2qsazWhcBIS5T3cbZMGp9zOb76Q+X9UI
        RG2vo5MIup6fU6RViC+EcQ0wsyYuXdT5bMaXWGf5i5Sko3CCbUAAmKEi91vnWerF
        zAAFcuExL73w/onTYbA6T65WwzdrbLGEijx5LEX6B7kehDEx1sVimSjcNN4JddsR
        YiPx2ZupC4ebI+ertnyT24qPAJNLTVcd5nkE3VVVYA==
X-ME-Sender: <xms:83VlY9uuBOYgNEziBa-dQlKxY5ZE7gmz2JLdoVgj1Lm_lunYwUT5aw>
    <xme:83VlY2dR8YjIdkaplK6qe-giIW9Hmj1BgJpqF85wtTjStMtoZCPOdE-MvS1M4_BoV
    XF47QCIEA5kpD14oFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleffheffveevkeegffefffdviefgffeghffhudevteevfefgtedujeefuefg
    gfejnecuffhomhgrihhnpehlihhnuhigrdhorhhgrdhukhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:83VlYwyLNnIwPzpcoUWMJHy-DThdmO1SHP5A4e37bAPU19POJ70dkw>
    <xmx:83VlY0NoGX45jnYSj84icHWl1GjUU0WvKNM5YmjaZ2HgM3poW6q2MA>
    <xmx:83VlY99ahfiZTxDjDgCg_y7X2g0kcD5fsXIlvpjaIKYWqZ1DPB93jQ>
    <xmx:9HVlY9yAN3dGffzVeN-Cp2i_OOgeXx2tmtmQ2NvgxATd_4Iq-qlpPA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D4114B603ED; Fri,  4 Nov 2022 16:28:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <8a40c9da-041e-4d3d-90e4-22dbb93eb9ab@app.fastmail.com>
In-Reply-To: <64e16669-8bcc-a05e-0eb1-9ae644431d95@benettiengineering.com>
References: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
 <64e16669-8bcc-a05e-0eb1-9ae644431d95@benettiengineering.com>
Date:   Fri, 04 Nov 2022 21:28:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: mm: fix no-MMU ZERO_PAGE() implementation
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

On Fri, Nov 4, 2022, at 21:07, Giulio Benetti wrote:
> Hello Arnd, Russell, All,
>
> is this patch ok or has it some changes to do?

Looks ok to me, please add it to Russell's patch
tracker at:
https://www.arm.linux.org.uk/developer/patches/

The patch description could be improved a little ("Link:"
tag for the URL, avoiding the wikitext  markup, etc), but
it's more important to actually get the bug fixed.

     Arnd
