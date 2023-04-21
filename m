Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12586EB21D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjDUTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjDUTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:10:17 -0400
X-Greylist: delayed 138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 12:10:16 PDT
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DB818C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:10:16 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682104214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9nptc7nFsnBkPk8XtEJlycB0Q788aB2D6UaBkyu74Y=;
        b=bdXprAp0tYcirhanYw8bQqri9ckfvXGij3zsRaW31Rp79TyHytNiP2LAxDLzMsdR5D3k2s
        /sAQyoNd2ertNgOwtYKlhN53Xmy7kKlJU8m3Bp2V1JtejQ3beDelYG2pLP9Oxelww9x+Id
        ipSUd4q1YPaHNRcS7BdzJqpbW97DvI0=
Date:   Fri, 21 Apr 2023 19:10:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <ba235aa677a561ceb2dc776414403dc0@linux.dev>
Subject: Re: [PATCH v9 0/6] Introduce 64b relocatable kernel
To:     "Palmer Dabbelt" <palmer@dabbelt.com>, alexghiti@rivosinc.com
Cc:     aou@eecs.berkeley.edu, linux-kbuild@vger.kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        bjorn@kernel.org, npiggin@gmail.com,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <mhng-bb70f74f-2b5b-4880-b7bf-975e67dc554e@palmer-ri-x1c9>
References: <mhng-bb70f74f-2b5b-4880-b7bf-975e67dc554e@palmer-ri-x1c9>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

April 21, 2023 2:59 PM, "Palmer Dabbelt" <palmer@dabbelt.com> wrote:=0A>>=
 riscv: Use PUD/P4D/PGD pages for the linear mapping=0A>> (https://patchw=
ork.kernel.org/project/linux-riscv/list/?series=3D733603)=0A>> base-commi=
t-tag: v6.3-rc1=0A> =0A> The QEMU CI has some way to say "this depends on=
 an un-merged patch set sent as $MESSAGE_ID", not=0A> sure if that's a b4=
-ism but it's a bit less confusing.=0A=0AI think it's patchwork-ism, actu=
ally. B4 will eventually learn to be able to include dependent series inf=
o and automatically retrieve/apply them in the proper order on "shazam", =
but it can't do that yet.=0A=0A-K
