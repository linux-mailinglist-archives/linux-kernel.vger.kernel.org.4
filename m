Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1D26DD92D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjDKLQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDKLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:15:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE43C25;
        Tue, 11 Apr 2023 04:15:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 82E7D5C01E1;
        Tue, 11 Apr 2023 07:15:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 11 Apr 2023 07:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1681211742; x=1681298142; bh=rNxd2zGmgkAmADZ+JZbkF3uw4Ve/3YJzCvs
        xLSYPEwg=; b=BMW5j8L6xNOfYHv84A9/6RVR0mcIpsBIDHdaZ2DFEq9NRyIyOfO
        VAe3gVhDcPS/n+SHKf3n7LVX+I0Fmlcabjo4xe3x2XgWHJSf3gXZWKhlEqSwrSCH
        2pk55diKRZo04FctPe5d/UFRH58vDq+DXVuR6sQGpjJsyeyOPMX619XqwOaeelpI
        Vtz0g/TZ/0xzVMEXr7Kp0/scypvsU1ttVFtIPlim+6fNb2O6g45GzZHKcU2MySlv
        9NDFptmm79w3kmcZG0iOyu1ZCOJ+K9sVT+B9r0k7nudEjSQ6+AcEbZwYwtAF5/VR
        mFG3YMdJb3pEA/j9OfagNg8v37GOo3CDmHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681211742; x=1681298142; bh=rNxd2zGmgkAmADZ+JZbkF3uw4Ve/3YJzCvs
        xLSYPEwg=; b=g2DYhg5Z1dLc7RiFbdAXqGwt+YLpWHNVw7S9N5GvyNFliKw23+8
        BEJL/xLH4/kNm346JAm1EhrLXvQaK0mcoDDy6RtTEhmy8hpLtbvHiv3+DILXVUU3
        +e5FQL/JBIlRaNV8H7tYdirsPOXgGaG4WtIuqWBOTiMXPZAqYDsFQkCB0ApWXMoD
        DRZlc0fFDCOZDfDCn0plXsc7yv2+SfiLESPfwAdRaTwcoXtjXo3+NVDzkUc5TySZ
        RgOgCEEwyZLH0qdHeXckUl+4yS5EuKY3XV6LMzTFU0oHi+CvUJpws0grh759kOzH
        EielPD16WZopvmfp8SYukKRdQmO0A/zEkqQ==
X-ME-Sender: <xms:XkE1ZJ74szy2ZTNzomXRE5miE8h4zlbnlRA-jvJMeFc35vrUd3HcpA>
    <xme:XkE1ZG7rnAchmTkyeFzcQ5InrZuELxm2bWZ7JtsIuwV5KkdSkkV4ivAgzorclT_eF
    X97IpfhUaGLTBx-xPQ>
X-ME-Received: <xmr:XkE1ZAdqHZ5SqSeiLLVrQOmbSzp3nwd7oDZVDZIJxoKIwcaop9BkREWDGUj5-UprFa9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepgeejffefgfefudehfefftefhffdvteeuveeifeetiefffeeg
    keehvdeggfejheejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    jhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:XkE1ZCLbH9UDFN40q7boLNbSUTVoOoOeabJ5fFQ-uMWZ4EbknxECMQ>
    <xmx:XkE1ZNKdDBnflIrOITnXM4mW7QmkW2TUiHfsex7t8ulzOvLlKlrZag>
    <xmx:XkE1ZLx6qBqo-DVz0Y7s3m6qwY6s9PhoWY1DG9d8kh0xTOETw4ZOCg>
    <xmx:XkE1ZEXTygqIePEwsfYScnY2dyKfuNoHa13e2bafccQYG3oR41AyFA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:15:41 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 0/7] MIPS: LLVM build fixes
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
Date:   Tue, 11 Apr 2023 12:15:30 +0100
Cc:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, and@gmx.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D934EAE-574B-46B0-AC91-E71A96C10E8E@flygoat.com>
References: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8811=E6=97=A5 12:12=EF=BC=8CJiaxun Yang =
<jiaxun.yang@flygoat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi all,
>=20
> This series fixes some build errors when building with LLVM.
> Some of them was discorved by inspecting the tree.
>=20
> Tested with LLVM + LLVM_IAS=3D{0, 1} and GCC against:
>=20
> allnoconfig, allmodconfig, 32r2_defconfig, 32r2el_defconfig, =
64r2_defconfig,
> 64r2el_defconfig, micro32r2el_defconfig, 32r6el_defconfig, =
64r6el_defconfig,
> loongson3_defconfig, lemote2f_defconfig, ip22_defconfig, =
cavium_octeon_defconfig,
> malta_defconfig
>=20
> With other patchsets [1] [2] [3] I sent before, on my CI [4], with =
tree [5].
>=20
> allmodconfig is still failing but it's not related to MIPS.

Oops, not intended to resend that.
Please ignore this thread.
Sorry for the noise.

Thanks
- Jiaxun

>=20
> [1]: =
https://patchwork.kernel.org/project/linux-mips/patch/20230407102721.14814=
-2-jiaxun.yang@flygoat.com/
> [2]: =
https://patchwork.kernel.org/project/linux-mips/patch/20230408115936.6631-=
1-jiaxun.yang@flygoat.com/
> [3]: =
https://patchwork.kernel.org/project/linux-mips/patch/20230407102721.14814=
-2-jiaxun.yang@flygoat.com/
> [4]: =
https://github.com/FlyGoat/kernel-action-ci/actions/runs/4649898964/jobs/8=
228560848
> [5]: =
https://github.com/FlyGoat/kernel-action-ci/tree/71d3f53e9c44cebf62cfa4ed7=
ec3b0ce6452555f

