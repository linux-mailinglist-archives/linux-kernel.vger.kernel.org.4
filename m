Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB3715B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjE3KMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjE3KMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:12:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD89C9;
        Tue, 30 May 2023 03:12:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 282333200936;
        Tue, 30 May 2023 06:11:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 May 2023 06:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685441518; x=1685527918; bh=mVNqPo87NfFEfgNxvaqd7ERnmadSPr41Xby
        9dmRRviQ=; b=WahCs54HMDt401Ld0E16WracTP9F/x+baO6ofMS5tGaj+3Hywm4
        cW0re7j5mxF5cP8YpQ/G/tCvNR4lgavlq3Xd2nyS+QbKsCY4Yir8vogIk7apYTBB
        hh52Jrz6DTtLHqPqwATufKztPVmnNnAfYYg6pwrv9hZNJLvX/l/YLxvFs3psNqnZ
        xPU06/JhOL9Z7mRqZB1LVfo9MADIVVz/J3DSnVSQ5CYjzbQpdxz/bpfJ0H9ChTUk
        vZ5G2KeaHNr/N5jXxUSkFZHTE17nxOHc4LyHz3JJSW2pDO0yfhXB64mcUXlW1TSK
        aMWZgcD31+noDdx2ihvCUCoKv1zQ0hJRr5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685441518; x=1685527918; bh=mVNqPo87NfFEfgNxvaqd7ERnmadSPr41Xby
        9dmRRviQ=; b=cJj4QZ4QGbHzwaVmBkPFBbvq6vPVD6Sx7TidDy0hISxBZFcxyL9
        5r6FYJCqwtFWqlntPXRuq6CEtbnpSvKPHddeWITzhvMEMghs+wdSS2yLpTo6DM70
        dR3WNQmrpytSlz6WDtPqcRuum602y1OkImiA0BKViT02Lj5DeoRuw6p6SGb87pv+
        W8U+S5M7VSFxmsLm8xR5VDFIwcjhUBpM8zl/1RJRuUy3r9I6H+MDKBC6Klm2v8r6
        HhkvTFQTYtk0IxdXatKUeBaJecf0Rs1h7IlbuIOAeHwZ19PEK0TQLvd4odrrDuKX
        cO6mwLg1MZEMCu6po9lN2qsq3MkGA2Ladag==
X-ME-Sender: <xms:7st1ZECVGYbvZW1Hyfej2-hWMCe3WTxnj1Cs16e52SMjArOiAadOJQ>
    <xme:7st1ZGgo8nNQQzWg4sa9RPvi39-xNPNRJL0aqrKfQR1fdKBo_NJeP3-Bqka4lUSGk
    KHR7H91vGhGjJ1SZoU>
X-ME-Received: <xmr:7st1ZHn8qFWsxoKOJF27FB7ymqptM4B4NVpPiwx6RbUFDjCqn2V0_f2o3mMztA4whQaZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:7st1ZKyhNz6n57HCsH3NsjhO4YjN-uywK1lRAamyeGQN260yDK_kVQ>
    <xmx:7st1ZJQixOe9kRo97a3rAj1j3gwnCzOByQ20BSBnwAIoVijixr_ZBw>
    <xmx:7st1ZFZN6p5DxQYHD8E3uH0hpPzDoLeqfRpWVmpa8bkqQEKlue_NtQ>
    <xmx:7st1ZLfHUn9cukjL_qt4_kSXtx4QUw6-3Mp78yp_E6nk6FenVvfU2Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:11:57 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
Date:   Tue, 30 May 2023 11:11:46 +0100
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <684C1A48-C743-4045-AF12-B0846FCE8EBE@flygoat.com>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
 <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B45=E6=9C=8830=E6=97=A5 09:03=EF=BC=8CMaciej W. Rozycki =
<macro@orcam.me.uk> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 29 May 2023, Jiaxun Yang wrote:
>=20
>> M5150 and P5600 are two MIPS32R5 kernels, however as MIPS32R5 is
>> backward compatible with MIPS32R2 there is no reason to forbid
>> M5150 and P5600 on MIPS32R2 kernel.
>=20
> What problem are you trying to solve?  The CONFIG_SYS_HAS_CPU_* =
settings=20
> denote overall platform's support for the given CPU and have nothing =
to do=20
> with what architecture level a given kernel has been configured for.  =
You=20
> do need to get the settings right for your platform, just as you do in=20=

> 2/2, but this 1/2 part looks wrong to me.

Well the universal target is to allow R2 generic kernel to run on R5 =
CPUs.
As R5 is backward compatible we can just have one universal kernel =
binary.

Allowing P5600 and M5150 to run on R2 kernel does not bring much =
overhead.
In fact only several bytes are added to kernel binary.

(Actually although M5150 is advertising as R5 it=E2=80=99s technically =
R2 because it does
not implement some features mandatory for R5.)

Thanks
- Jiaxun

>=20
> NB CPU_4KEC is double-listed as R1 and R2 because early revisions of =
the=20
> 4KEc core were actually R1 before switching to R2, so this CPU can =
report=20
> either revision.
>=20
> I don't know why CPU_XBURST is also listed as both R1 and R2, the =
history=20
> looks convoluted with no explanation.  Paul, is the CPU also =
dual-revision=20
> or is it just a bug and it is supposed to be listed under one ISA =
revision
> only, presumably R2?
>=20
>  Maciej

