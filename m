Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5698C639010
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiKYStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:49:16 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9411EC5B;
        Fri, 25 Nov 2022 10:49:13 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7EDDF5C00AC;
        Fri, 25 Nov 2022 13:49:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 13:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669402150; x=
        1669488550; bh=lGBLZWw4I2IVEe7ioPYHs0ee4vEFUgD9+nW1n+RmPgk=; b=G
        w+QGLTLVvemFW/nXuipobMMHYB//cFx3yZejaTLWzL2a36xdVO85aPXyky4FMg//
        sDuV2BVseU7w6m7dK0CYtkMjtu5OlsRMoM+Eyc0P9j97a/3nuZAXHvsCpooefpXp
        BiPCbuCX5oJh+yQMejb77bbsFAGFr0O39G0ihKCK6jP4gLLjxC0D2ahU/Ixz5Zae
        EyGUzILyFOavr7Xx9eL2XUk+jrK21AM1dwGaea9paWoFcFlUhCE7Bgp/ZirmzR8o
        Hu8mT7z+WxLDya9ShoQdUrFjX49EZ5jGTaITu6oQ0oAB+7BMAc/DPn2mm307IOuj
        iiorbpmTWdDRBXQgOcWfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669402150; x=
        1669488550; bh=lGBLZWw4I2IVEe7ioPYHs0ee4vEFUgD9+nW1n+RmPgk=; b=s
        iP+d+1Cr9xX7hOx+9Nc+jE4O6lyv8hSRtb0gW2577XvBoyRR3eqjhq/oHZ7gkdL+
        2+MpPZaV6x3LIQKZC0dumsU+N+6XzzJDQ+Ik90TlLWQf7XXKb+LrR0vuV6djCqz6
        cCnR8UI/3OgJYpL+N4bE/lOc+FsWHYUgrbtG5vwooKrJzqzHAdGCiZJua644ebWn
        I4RwD0pTUmypO0J+T+n6+V+iiIy2n89NThL8VkEbdxIWAQB6WOSAqMnJpy81mUgp
        94qbnaJEYhv2b21GAB6XZ3IqJHDzmr8RxrUMIapCbAV+yW4iyNS+A+Ue9Z0jyxHH
        mY2z9wPABwamp7g+z7yoQ==
X-ME-Sender: <xms:JQ6BY4iv4RHmiA62fny5yI9YDI9TCsMDw_rYpsq613baazuFDo3TSA>
    <xme:JQ6BYxAJImrvGcnnvCBuSdUYANgJ7ZQCjHg69Qnt_4wz3VfKTy3o-cWUOPsnZEkbr
    9og8GdHmNJFU2qFRw>
X-ME-Received: <xmr:JQ6BYwGUwvadsg3zElasU1qN12IWedU9XyMga9Z79VVbWbCPLqXYrraBRdUPHSpB9OOFoN7zfEEl4VeX7ONvY8pQMdVTXIrmc1Gois8tTb83Ud4w1H_vv1xHog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegieekueefvddvueetiedviefftdfgtdefjefgteeffeegfffg
    vdffheejvdeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:JQ6BY5RWoXXEr60Vwh2k712uxx4d3ja3R-gyIL-v2nbXaeH-gD-5mg>
    <xmx:JQ6BY1yZLm5nZ93cdF7ABIVVJGLxVu7VxkVq8Z46B1VhUiuHeQQbfg>
    <xmx:JQ6BY36QVnGO8gGm8cPyaMLEcwOm0GuJPpzvwwOnmsXD7e-Ro3jmJA>
    <xmx:Jg6BY7rMqmoHaIqQt1SqANX6uylPyxd0Lj-MBa1nq1PVbP6ia9dWLA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 13:49:07 -0500 (EST)
Message-ID: <3b5e52c5-7a1c-8bdd-b076-0c5e13463274@sholland.org>
Date:   Fri, 25 Nov 2022 12:49:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <3689906.Lt9SDvczpP@diego>
 <CA+V-a8uQh=q8ksTe8ttHkJThcoYtggSU-AXUqPGYnam0CiqZWw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 5/7] riscv: mm: dma-noncoherent: Pass direction and
 operation to ALT_CMO_OP()
In-Reply-To: <CA+V-a8uQh=q8ksTe8ttHkJThcoYtggSU-AXUqPGYnam0CiqZWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 13:18, Lad, Prabhakar wrote:
> Hi Heiko,
> 
> Thank you for the review.
> 
> On Thu, Nov 24, 2022 at 6:29 PM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Am Donnerstag, 24. November 2022, 18:22:05 CET schrieb Prabhakar:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Pass direction and operation to ALT_CMO_OP() macro.
>>>
>>> This is in preparation for adding errata for the Andes CPU core.
>>
>> can you provide more explanation why that is necessary please?
>> I guess you want to use different cache operations for some cases?
>>
> Yes basically to call different cache operations based on the dir and
> operations (and also this allows to export just one function to handle
> the errata). I'll update the commit message in the next version.

This makes things less efficient, because it requires more instructions
and registers inside the alternative section, and your function
duplicates the logic from arch_sync_dma_for_device(). The alternative is
already passed the operation (clean/flush/invalidate) as a token, so you
can construct the function name with token pasting.

Regards,
Samuel

