Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB86B69E73D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBUSQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBUSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:16:20 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F958303C0;
        Tue, 21 Feb 2023 10:16:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 883A73200583;
        Tue, 21 Feb 2023 13:16:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 21 Feb 2023 13:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677003364; x=
        1677089764; bh=PWhQBSMVu5KO9I1pjFrMlWxr95gEQWCuCEkhO0i7Pj8=; b=W
        vhaJyeREx3qhPmQ57x06QaQcSEJIePk7CC8TQ0zNCoL7/z9+rER9OtZqUNgt0qFg
        ae1VRs5Tt26IK2jdKRm4qCLfuQTiKtv1mmyGsW9dDsvXhX9E9M53au6us03hlzTE
        Y0INbzFqJ5fgG/OripkdmsOuIgtu5JlYAZgpzyIgMatCNo4MUPZ8jXCqeVFrNtTA
        oIGiENiwuz3mJ4JrNmyXcPlRY/eIwGm3cSSRbIqnx5knlsA+xd4FIFJjsk/v9OWk
        ZRo/sQrUs5zb4nQLnTULWO3y0yv1RU/9q4skRIxa4dJ+uCXcEOyST+QArNpDDOfp
        APPV3K10YnemVD9tR3KgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677003364; x=
        1677089764; bh=PWhQBSMVu5KO9I1pjFrMlWxr95gEQWCuCEkhO0i7Pj8=; b=W
        VuBiv/6/SG05/hERpvME8PBkQKO1KFO8KcpmNMy8UGX3qtvA44pF8d19s3ZzhsyP
        FCsV9iq91c5iYCvI9r/LpwHhuIy/t9/QjOc7UgOHfmg7Gh+NwTlUVzJR9d8QNM1S
        ISkjNqZBkXlwTxdq9q3yXfea7NPbVrYe3vW6JglLb54IFTcibOqqxKQFfdGofWyu
        BTBgCVMeiIfX3hh6ZVTIlNiQp7NEFGPAHTDJvfOwrljGhPUDF6Qrp4r268PDS+Og
        P6AeCwdKJzD0rlWvnlwJGVxYwCzj8JFkOgDDnT6dRd7HbhPYC++IhLjdGNUF2LOB
        5QpRyEkudF35OfAOFrWbg==
X-ME-Sender: <xms:Ywr1Y8RGAKBMLjwk0mu11hSNQwYZ87lh5wQJepoYi4bPFAVQ49Byow>
    <xme:Ywr1Y5xVWNxoVdavI5vAIBGkNGs1O9po4WcQSsH7ARiVPesTRjIyop68MjevTTWDO
    uAlVb66XnsVlXqDKdc>
X-ME-Received: <xmr:Ywr1Y53ztllrWakiqY12lKASHyGzL5I3oIVVna-LIr5izIOk_zWgW1fz2zgLlkVqeYAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Ywr1YwA0ZJHy7yLpeVmnXSoNgU_tiR6b7BLED_iseegdMzXiOA39Kw>
    <xmx:Ywr1Y1jopRraqHOFjy7UECXAfJ8JvZby0TmgVGBx45mQ3n3Le4-aWA>
    <xmx:Ywr1Y8qZaWkTXliwjZncDEf15PToRzy5cv2SxJobnp4gm1FjFGX-2w>
    <xmx:ZAr1Y8NU7l_wRJ9UrOAYhZCmIW34ogQZ4a-S5J7kXHE6eYiXmqbkCg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 13:16:02 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH 0/7] MIPS DMA coherence fixes
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230221175423.GA15247@lst.de>
Date:   Tue, 21 Feb 2023 18:15:51 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8AC22A0-E883-4D9B-A629-5A3721B976C5@flygoat.com>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
 <20230221175423.GA15247@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B42=E6=9C=8821=E6=97=A5 17:54=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Can you explain the motivation here?  Also why riscv patches are at
> the end of a mips f=D1=96xes series?

Ah sorry for any confusion.

So the main purpose of this patch is to fix MIPS=E2=80=99s broken =
per-device coherency.
To be more precise, we want to be able to control the default coherency =
for all devices probed from
devicetree in early boot code.

To achieve that I decided to reuse dma_default_coherent to set default =
coherency for devicetree.
And all later patches are severing for this purpose.

Thanks
- Jiaxun=
