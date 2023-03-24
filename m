Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C6B6C7AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCXJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:17:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50055184;
        Fri, 24 Mar 2023 02:17:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D91FE5C00D0;
        Fri, 24 Mar 2023 05:17:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 24 Mar 2023 05:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679649472; x=1679735872; bh=TXn9bh8NNQiaq9RCNIuEb1mA2gEV5NsgDpg
        JpUdv/CY=; b=UgsRLR9CZYS9v7HxbOhO1Ht7dpegLxuTjK3G0tMgwmMzlAbJw/y
        U9HlpavWJLBaeTE4VEdafvz57R0rK7HQLUol36Qnwp60zAakk00EMhB65LEt84tA
        U43B1xJQJ7knz5Sz95Cl8pSrmjn2ISQYeYCskrbZEnIAxZKESLkyGsl7e2amr03c
        jqQz/0DTEVpdG7TUR7w9wfNYuUPIxYq9WIDjY2oVuhG9XqCjr4gSL/qP2E5hLXw6
        7KrL0Z8EQs2SxUyR1RRalFNhqwMXACbkDO8YWr3cfceVYglRMukqd0oyCRSdMKFd
        rERfEvUu+7bBOo7kH347K8JHKDdAAH86rQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679649472; x=1679735872; bh=TXn9bh8NNQiaq9RCNIuEb1mA2gEV5NsgDpg
        JpUdv/CY=; b=bOkAriQ7SnMVdc9qlRXrg5zjYuHLUnhkL6Unzsl8BtPHLmS3GXe
        J6cE/oQ9wv8dIarPz0lMPZ5XmKxcd8+GI1QK7tguZGdNGzM2+DEE4xnVTQFTXYFo
        y8lK+wmchkkV6NOzQngQq9SLF4fxFrFESKJvgSJd2GLXjX86jlAhQs9VC65mX3HW
        5sTD9UaWye41qO4s5Q8HZOJOmcqA/qumqDU0Mh9SqhrxsG9M57fKYu5nwH6BxOen
        BvlBpRQPlK+whAqHIzJXDYbZwwmdRDvo8ledWUeo1oXZMDtjw4z1rwfDrHR9IZAX
        6ABMlrnc+AjRMD4Kz0Sj27qYvKPA00lTNeQ==
X-ME-Sender: <xms:v2odZP0DKBmYhJwawl6AQqFJbRYwbeSdSF6WdW1t_xW_kf6YDCA1ZA>
    <xme:v2odZOEc0QRgUxZYSV48BYhgnDEkQtvTB3g3UCU3TrW7CzFs7D0iyHpcD0VJnkx-c
    kIWyrRPumnVUWbgVOc>
X-ME-Received: <xmr:v2odZP7Jx6EtWVylFcEP02YbQr1V9F0NqX4lUk6bZIUs6RuqAHlihHcQnV_dwQVA7-uH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wGodZE2hliBxevB73UB7FDxctXUd7Mw7JuXZPD87jbsd4EFvk9gKCA>
    <xmx:wGodZCGgTeqiAZ5Lm-8-REfVc_xlmMESyx8WazmcKLOxI3WVQvdjcA>
    <xmx:wGodZF9wPT7NC7kNhDO8E_rpjgU5KuY5looZwimGRHo1r153OEF9dw>
    <xmx:wGodZK98UJgeF9dxp_Q9540JaqZEFReCb9Xx_acBTbK_3ql_xaXMLw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 05:17:50 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v3 0/4] Use dma_default_coherent for devicetree default
 coherency
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230323213930.GA7730@lst.de>
Date:   Fri, 24 Mar 2023 09:17:38 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB41D3AF-20F6-42F3-9168-C0D6E716431A@flygoat.com>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com>
 <20230323072944.GA18524@lst.de>
 <60D7FE31-D708-4495-949F-3F64DDC11377@flygoat.com>
 <20230323213930.GA7730@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B43=E6=9C=8823=E6=97=A5 21:39=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Mar 23, 2023 at 09:07:31PM +0000, Jiaxun Yang wrote:
>>=20
>>=20
>>> 2023=E5=B9=B43=E6=9C=8823=E6=97=A5 07:29=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> The series looks fine to me.  How should we merge it?
>>=20
>> Perhaps go through dma-mapping tree?
>=20
> Is patch a 6.3 candidate or should all of it go into 6.4?

Please leave it for 6.4, as corresponding MIPS arch part will be a part =
of 6.4.

Thanks
Jiaxun=
