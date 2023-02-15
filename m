Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC9697C28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjBOMrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjBOMrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:47:03 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E682536446;
        Wed, 15 Feb 2023 04:46:59 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 60F315C00C9;
        Wed, 15 Feb 2023 07:46:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Feb 2023 07:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676465217; x=1676551617; bh=oF+nuJUlGq
        sGD2Bd/Tzxg3RSEzUS++9nuxOl/FiQWe4=; b=qfidbLrLN3TDh1LZOQ2Gwl3B2r
        9OZtKILiUwziX3/ACgoOCrK3lSoFWwj5HXsKLeduWfKgE73UDQiL2Vi2xoTG7DdY
        KCB19b4YCn7WfSvWXEgjqtB6Jgk78rcCxlcuQs88OuFPGJSPT0kQ0jgzeQTzfMCY
        mV5PXAeWuxjbGU8qAg5efh1wLWn1hJNefIYZ0/W78cnYMMkjO3e08qqhgPVnAxHI
        daxply72SYoS6FHJdlFwTIvJ/SUyjqJwYKLWC6vqWIF+nJxa/eZoOI4Zi0d7xdv8
        KFokIk8S/yAU/LxTTCiqsL0nZHmvlOgRIrutUtOPy3dZN9jpZDF9Fb5/F+8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676465217; x=1676551617; bh=oF+nuJUlGqsGD2Bd/Tzxg3RSEzUS
        ++9nuxOl/FiQWe4=; b=MdfZou+mEa3P2OMT6/tgNT7PBDPe0bv04M9ZtPHnaD5L
        e9B9HvP0vueq2CEM04J2wmFFvhF1eJCYM5GROSpQ3l7LiGYjPXr4uUcwx4Piy1up
        hwrOZxMUh6WAJ/DayqX3y+M0/1nsV3+pqEL/ZzNsvAqP2O0FRQnEd8myy+grKhHF
        spzgKiTJncafS7zGyEt6oqtW8AaC6PTyCFX8DVfWYJ2rw8TqRiqEAyNfCiyBn6O3
        CJneo5zBtnhjcQTzl/eapHVv9G7i21R0c0MBMEU+xnQNri0iA1a4PDwQgF1Xs6Bx
        m3Spw88Q9c+YAAZcibmgBiKRgkFe9QgqWjWAm7Yweg==
X-ME-Sender: <xms:QNTsY2O75uas4Ue2tq9U_VZ1HzSwwDMCPe7nZeY93LwpvSBQYGcvUQ>
    <xme:QNTsY0_X0n1eL0eZKQC8eJ7OdZ8cYMAYMuzIFoNqjKE-Rc2v5E3V3MpkNetq789nh
    LWp0gu3RK2eIFvtFhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QNTsY9T-avZzH2T9X5EmngfUKI4dz0E55TTTJpEXNJKFBICTmI-ZiQ>
    <xmx:QNTsY2tk1BTFV3-aytHejDvkgtJN6xwAWgQnebEq6jaNJdjylI0Esg>
    <xmx:QNTsY-enjknIQCYq_zlk-LDfVZwlohw--q_c6o8gXdi2vV-NEk9PqQ>
    <xmx:QdTsY1xE55an06N4LlDL6g_84JxFs-m0Sv8nGbxoEttsQKmJJEuDpw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BC9E0B60086; Wed, 15 Feb 2023 07:46:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <51900fc5-1a5c-4414-a85b-061a0cd58c63@app.fastmail.com>
In-Reply-To: <CAMj1kXGYcLLaJQfYjcjvAnFbb+MAWQF-2BzeUGJTqBu4V=ejNw@mail.gmail.com>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <20230215100008.2565237-3-ardb@kernel.org>
 <ea12dd12-db17-44a8-8c29-6b0a129f355d@app.fastmail.com>
 <62e7ab37-1148-4cf1-8d6a-3da440fa623f@app.fastmail.com>
 <CAMj1kXGYcLLaJQfYjcjvAnFbb+MAWQF-2BzeUGJTqBu4V=ejNw@mail.gmail.com>
Date:   Wed, 15 Feb 2023 13:46:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ard Biesheuvel" <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "Jonathan Corbet" <corbet@lwn.net>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] kernel: Drop IA64 support from sig_fault handlers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023, at 12:22, Ard Biesheuvel wrote:
> On Wed, 15 Feb 2023 at 12:15, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> CONFIG_IA64
>> CONFIG_IA64_PAGE_SIZE_64KB
>> CONFIG_IA64_SGI_UV
>> CONFIG_IA64_DEBUG_CMPXCHG
>> CONFIG_MSPEC
>
> These are all gone from the code after applying this series.

Ok, got it. I missed that the first patch also removes
bits outside of arch/ia64.

     Arnd
