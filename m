Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD56D20E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjCaMt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCaMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:49:21 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D421A84;
        Fri, 31 Mar 2023 05:48:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9453058267B;
        Fri, 31 Mar 2023 08:48:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 08:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680266936; x=1680274136; bh=1wl0PaNqVV1tf/UjJBVG7Hr1Nf6zuThoMUu
        qGEpn1MA=; b=BLukJoG1DbMb6R2AbqA/+7JjbZ7Oc/VY/GccCFivK2SLSyJIUDy
        eDvuj6KlJ9yQrHhbcVFZFc/7GfKYkkIJnc004z0WtfxhzT8F0Dryc/fj4uAQEHP5
        0uQBdRp2Y9CzikgGULwwka03ZtEYN+vA0NR1UYoJiMuMTtA+TbmqSw1RKb6bHBwu
        kgWKCmrmDScSe7b7EAcsyIEqiEeMn1uQFjhnq/BazbUn1vodHcRar+Z8amV+f2ZZ
        4SEu3kvSxhj8jR9TWpWv6H7rDT3W+eYIj1h32pDouk8U16vHi7UxgZYWiVlTR8pm
        cvHgSREjUd2DJv11jgWTdKV0doKNHN4KAQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680266936; x=1680274136; bh=1wl0PaNqVV1tf/UjJBVG7Hr1Nf6zuThoMUu
        qGEpn1MA=; b=QTw4z9BqGCp34jRTQ9lJ0Te2z7DjXCcjR1cRFuymA6teq1Ue47T
        RfmowyRx6v1MwMbGt3ApYDk7qwSROS25JV78fgnvrSJIUz/j3GedCAWFmvE8DLl3
        HoMeyCJb5WbZ+f8j44/HhL12AZyMqN3xRjT/IDdrxGjXOHILLMDS4nNm1QNzKgnt
        FLCEk9P9FtfqKPKXWuMbSuG7oHcgCKFsVXQhQDt+sRTlprJiPAhFBhU6avHf2Ete
        uaofk0N4pXe1j7VHba5yYeMGTXuCjt30lCiXSGhI7m4EIcITbbYAAY9vnjAdi0d+
        SAs1yBNQ6aJg2m3zpufn0UV2fnpNcc/oKsQ==
X-ME-Sender: <xms:ttYmZMk-K2WF_uQihYdEaE-WxRbKWanSV4_1kq4F_OoJAiQRztqr8Q>
    <xme:ttYmZL1tFGUNnFuZ3XoKvNtYojk3J4bwbaadBIOeVDI0Ukgz-8ewFG032ufxZ-SbD
    1b0xoms1quNu7guG_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ttYmZKrf5muOZ7qbqVpPjnkqBNMSMOU4gybMeyJ3rUMZTBnAWuP7Zg>
    <xmx:ttYmZIlj2z9EhXlgVWbMqhx-qYV5mMM2GAMIKkxak63PHlTsdJDm_Q>
    <xmx:ttYmZK07ZhhFcRRDILM_35s-tNIWEGc_cMzAk1ijnOb4EPEMJyMkfQ>
    <xmx:uNYmZAU6_XmPJuSgqvZ3Fo60bA3Va1J04nlnSMvYEI__B3v7Fjseqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B8952B6008D; Fri, 31 Mar 2023 08:48:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <f3637818-7528-4564-a208-6e587efd7128@app.fastmail.com>
In-Reply-To: <CACRpkdZdnTX4-jnnXZveXxwOg76yH4Zyoa-ZSGeC7KzOnn+6Lg@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-18-arnd@kernel.org>
 <CACRpkdZdnTX4-jnnXZveXxwOg76yH4Zyoa-ZSGeC7KzOnn+6Lg@mail.gmail.com>
Date:   Fri, 31 Mar 2023 14:48:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
        "Brian Cain" <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Stafford Horne" <shorne@gmail.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 17/21] ARM: dma-mapping: use arch_sync_dma_for_{device,cpu}()
 internally
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023, at 11:10, Linus Walleij wrote:
> On Mon, Mar 27, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The arm specific iommu code in dma-mapping.c uses the page+offset bas=
ed
>> __dma_page_cpu_to_dev()/__dma_page_dev_to_cpu() helpers in place of t=
he
>> phys_addr_t based arch_sync_dma_for_device()/arch_sync_dma_for_cpu()
>> wrappers around the.
>
> Broken sentence?

I've changed s/the/them/ now, at least I think that's what I meant to
write in the first place.

>> In order to be able to move the latter part set of functions into
>> common code, change the iommu implementation to use them directly
>> and remove the internal ones as a separate interface.
>>
>> As page+offset and phys_address are equivalent, but are used in
>> different parts of the code here, this allows removing some of
>> the conversion but adds them elsewhere.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks good to me, took me some time to verify and understand
> the open-coded version of PFN_UP() and this refactoring alone
> makes the patch highly valuable.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

    ARnd
