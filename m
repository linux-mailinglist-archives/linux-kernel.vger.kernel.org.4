Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE06E1DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDNINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:13:35 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07AE26AB;
        Fri, 14 Apr 2023 01:13:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 694CB5C00DA;
        Fri, 14 Apr 2023 04:13:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Apr 2023 04:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1681460014; x=1681546414; bh=4Wi2CluXC7r+jFUFmQorm3+f7t6iVagk1FK
        ncLw60ZI=; b=ml+a4hYE+yv46BqK7tykFk9blxiIW8vzqBJ2COKYjwOef+fs5tj
        WxPA707BOwPnRYoOFNSWyfGZ7CI0oXtqUBa/m0kby4Qt2+pXLKiqimSO7bLrHya2
        /M8GBLH6nl1wYf325J/wwLBRSLLRDXxAQfEUDCCTmzr+zGjgMb2ycmlvWYMRvvlz
        tinVJ1dPet9mbPq3c5jA+NjCPkSBD4MUEQIRJWed5CS0hZXSeytbtFUzPZcjpqe+
        sSjbkdAuLUz3qoZtJzkOXS9b3x7t4X/X533s/X0DxbDw7O0w/KArV0mtEb/5x994
        sca9iRLO9fLGqify1U+9Z9XCZntBdDMazeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681460014; x=1681546414; bh=4Wi2CluXC7r+jFUFmQorm3+f7t6iVagk1FK
        ncLw60ZI=; b=a9Z4eVzehB62rdfB1MCH0X73h1Trzf+IeTy6LQXViMjA1OKoQMy
        7swZbgRltSfvt71Y1ghoDKg5sQc549e0EJ0c9XMCMeG7I57oI7tzpaslvYuQ8Z8T
        gx0gAVlnleoBFVvnOSe+zmIGnvLvHkExghT+gpojI9UW8I3GPNjt1QTa87750G5M
        Civ9T8yH7H4UM9k/20e4VS1cCHdZ9WZDRkIsnAOmVlNlzu+40qJ0dTVrn88kJq4x
        MfUno4jx07vxpz7AgXMBNAFuZEIZZvMfDhvrfEOFE/4idH180GyRKEGuph+LwXzY
        aBqKZPkQVDmEHAcf598GR4bgXvBdSmqdHmw==
X-ME-Sender: <xms:LQs5ZL99ewiFqL0M4u9GQmmzBLYhDcxKPkrKIMPUANJ3lkBJOvU4Mg>
    <xme:LQs5ZHtAmGXS3h7yaiobzu0HiJz8_R4RN9e7jY8s_-3JKTZd5jO4xN--kih7fc6gr
    so-8Q0-erZcjXWxpOA>
X-ME-Received: <xmr:LQs5ZJBOhh7P20dUJU20Ag8OCnEp4jnWGriZmbVl4RGn1XZFNWnI4LNsSCQoFVlSuYZD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefhffelvdfg
    udeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:LQs5ZHc_aDvHYgVEMzR2dkeFAVAYs72FIXYzGR4-LrGc0SPOf-G1Dg>
    <xmx:LQs5ZAO0X-QVLQgBZoArx9BbGaNMiNuvEDflpQXXUI8Mbjmi9stE1g>
    <xmx:LQs5ZJnzJEb4WRWxO_RIDQC1hgfADku9wTS7I5XCe104eqBuqJ6WCQ>
    <xmx:Lgs5ZFrT1B8j8_SFcLQlU1Jd1UALokR3BSsa7S1TZ019uxt7qTk1fA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 04:13:32 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH] Mips: Fix _CONST64_(x) as unsigned
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230411063144.3119-1-zhangqing@loongson.cn>
Date:   Fri, 14 Apr 2023 09:13:21 +0100
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A77E6D2-2BFD-4728-B33F-4EEFD0BB07BD@flygoat.com>
References: <20230411063144.3119-1-zhangqing@loongson.cn>
To:     Qing Zhang <zhangqing@loongson.cn>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8811=E6=97=A5 07:31=EF=BC=8CQing Zhang =
<zhangqing@loongson.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Addresses should all be of unsigned type to avoid unnecessary =
conversions.

It=E2=80=99s defined as signed for a reason. To keep consistent with =
32-bit address, which
Is sign-extended on 64bit systems.

Thanks
Jiaxun

>=20
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
> arch/mips/include/asm/addrspace.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/addrspace.h =
b/arch/mips/include/asm/addrspace.h
> index 59a48c60a065..75d36115a25e 100644
> --- a/arch/mips/include/asm/addrspace.h
> +++ b/arch/mips/include/asm/addrspace.h
> @@ -25,9 +25,9 @@
> #define _ATYPE32_ int
> #define _ATYPE64_ __s64
> #ifdef CONFIG_64BIT
> -#define _CONST64_(x) x ## L
> +#define _CONST64_(x) x ## UL
> #else
> -#define _CONST64_(x) x ## LL
> +#define _CONST64_(x) x ## ULL
> #endif
> #endif
>=20
> --=20
> 2.20.1
>=20

