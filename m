Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E573A8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFVS7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjFVS7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:59:01 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACBE186
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:59:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 421455C01A0;
        Thu, 22 Jun 2023 14:58:59 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Thu, 22 Jun 2023 14:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687460339; x=1687546739; bh=2ATLxKVF7C47OWMyNOiJ4IVAUvlLTr2PQjO
        03XrYwtQ=; b=jhMw2Ska+eZgeHO3+++5OD0l49PGliWvSy8fP31gex+XeJFNm+/
        ctTOnjSUriBk3YanRaQE4vhhOiMaQdFLSZVbq6SKL891lWcfNQvVp0IficXkD3ur
        Qr6LsBzKtp72CXlpdy1mkANu2ZFlt/FRdMWOq/qOzyZN6S02AXxe6vrbu7xsBeXh
        0sofux24YHFG/IrWZxftgMTr44BZ9fIoiTNqUlkzNvzwgD4RiUrbSFsjoOBWBGcz
        y1xEFprOPhayp9Hg4sRIAIW8VPF+Ry87kroPV6PDMWmIsOEUQyZ4nxZQQSBFKiUR
        Fi6/pNoGYD4QjTHF6OEnemBdtdUrlkky7/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687460339; x=1687546739; bh=2ATLxKVF7C47OWMyNOiJ4IVAUvlLTr2PQjO
        03XrYwtQ=; b=L2YsXMW+IEJEFtXPrtZcD1ui9pto5WQBzlhgdWm7aqGkV5DMr+L
        Ykb6/YBCH9g7WyK+vV3S3GmFMJesJA/yFMv1L5u+ewK//AT1uz434o1d54nEPdRy
        IgF4LBIOh8PP6mfURQ0dDVUA6qWHzQavq+1vtzDExzZpq7Hy+rcw1fVztuJamrwW
        wTPIDkR26/gHpqifTBS3/s+yka9npE++AlBZQdTwXHZEcVkID/qZIkfM7qIZkmM6
        cOTY0N2LRVHH8C7mAuQukgibPfTOlmWrJBtArfWg3rtZ2JbDBxYGel6PBtGoXqQq
        ouAW4Q9n0RFG7sazqT+FNMpjm0a0d4iK9VA==
X-ME-Sender: <xms:8pmUZHz-TsAhn36bFy8ivSrmfn8ofkBe4VxPTV3Otp9F3eobfVGJEg>
    <xme:8pmUZPTei0QfRD1CbHGWAmjHp1aReIB8qFPZ7_NnDlXVJ8Z6tvP8Lcki49529Wn2-
    ytkw9iJz99myc2pvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ufhtvghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomh
    eqnecuggftrfgrthhtvghrnhepgedvvdegveekteduhedvkeehveekhfeuveffkeethedv
    udekgeffhfeigeefveeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:8pmUZBV-LfLOyF46PVDBM9kaEZreix_cZKnto2GkDqOrz_HlA-VsPA>
    <xmx:8pmUZBj55LIctWugk_DYCmUum2agcBcJZc0hVb9c8R_1dr1PWGPjzQ>
    <xmx:8pmUZJBjrZFREGFhGDb3EsykrMNvVjWHHhAXFyl_caBsactX_m2_WA>
    <xmx:85mUZM6eDv-dO7ZEgdECxzMGeEMeyjXGo1Xf8ZbAA0LjwCZM8Vyu3Q>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A8371700093; Thu, 22 Jun 2023 14:58:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <23381fc8-c297-46ed-9e11-a2643e18e4c9@app.fastmail.com>
In-Reply-To: <1941316.PYKUYFuaPT@diego>
References: <20230228215435.3366914-1-heiko@sntech.de>
 <20230228215435.3366914-3-heiko@sntech.de>
 <75071be8-272d-45e7-989f-5d717f313fe2@app.fastmail.com>
 <1941316.PYKUYFuaPT@diego>
Date:   Thu, 22 Jun 2023 14:58:37 -0400
From:   "Stefan O'Rear" <sorear@fastmail.com>
To:     "Heiko Stuebner" <heiko@sntech.de>,
        "Palmer Dabbelt" <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] RISC-V: add T-Head vector errata handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 1:39 PM, Heiko St=C3=BCbner wrote:
> Am Dienstag, 13. Juni 2023, 08:35:53 CEST schrieb Stefan O'Rear:
>> vxrm and vxsat are part of fcsr in 0.7.1, so they should already have=
 been
>> handled by __fstate_save and __fstate_restore, and this code is likel=
y to
>> misbehave (saving the new process's vxrm/vxsat in the old process's s=
ave area
>> because float state is swapped before vector state in __switch_to).
>
> I'm not sure I follow your description but may be overlooking or have
> misunderstood something.
>
> Somehow I way to often have trouble resolving CSR addresses, but accor=
ding
> to openSBI, FCSR has the location of 0x3
> (#define CSR_FCSR 0x003 in include/sbi/riscv_encoding.h)
>
> where CSR_VXSAT and CSR_VXRM are at 0x9 and 0xa respectively.
> (#define CSR_VXSAT 0x9 and  #define CSR_VXRM 0xa)
>
>
> And looking at __fstate_save + __fstate_restore the only CSRs accessed=
 seem
> to be CSR_STATUS and FCSR itself.
>
> I definitly won't claim to be right, but don't see the issue yet.
>
>
> Thanks for a hint
> Heiko

Are you aware of "3.7. Vector Fixed-Point Fields in fcsr" in
riscv-v-spec-0.7.1.pdf?

-s
