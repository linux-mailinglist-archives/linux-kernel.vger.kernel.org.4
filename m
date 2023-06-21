Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3698E73831D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjFULTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjFULTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:19:14 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306F4E57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1687346306;
        bh=Zr1EsiFqQQrgEXNsiy7QsP3O4tH+/+f4e9VPHaDXlec=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ObMpenS8QgIlZfjBkRE0dpK/IKJh3t85RRXiRxE2O2rTrcMjt2iGt9iySVM+z7v41
         mMrrcshMNjchAbT0/I3k/IdSZdwepGQt3FU3Gc5tHa5nlaMKMKAiDFTX2EdQUKBs3s
         vPBhRhRMGTHpXlW4KBhSI9lSe1BdLBmiVND/kJEY=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0028366341;
        Wed, 21 Jun 2023 07:18:25 -0400 (EDT)
Message-ID: <a155ebb791d3aefce5db32658e3c519a1cfac1f6.camel@xry111.site>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
From:   Xi Ruoyao <xry111@xry111.site>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 21 Jun 2023 19:18:24 +0800
In-Reply-To: <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
         <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 13:13 +0200, Borislav Petkov wrote:
> On Wed, Jun 21, 2023 at 06:57:40PM +0800, Xi Ruoyao wrote:
> > I intend to implement the same logic for Glibc.=C2=A0 I can understand =
"3DNow
> > implies PREFETCHW", but is there a bibliographical reference about "LM
> > implies PREFETCHW" so I can convince the Glibc maintainers for the
> > change?
>=20
> https://www.amd.com/system/files/TechDocs/24594.pdf

Thanks very much!


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
