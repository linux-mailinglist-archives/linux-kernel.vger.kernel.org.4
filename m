Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074806E891B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 06:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjDTE24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 00:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjDTE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 00:28:53 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13640C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 21:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1681964932;
        bh=qjJvhRPJtTB9s4JlA/d32awcwTdfGFqpmvhyPup6Wc8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PX8JwbhZLO8D/l7LmC2fOX9ytOGvUVJ9EOfaiI/asRKpWeIcsq52EOOtOcjL4xGX3
         Cm7vIEg1QTGA+PCU/mGiwKCKnSfberDERsRTbGMR3lIh1UFoBgiWKJ/JN1yNwOV9bg
         ve/iK0dphdPBJg66mXWEqNhRuzNBiP+FK9GWJat8=
Received: from [IPv6:240e:358:116f:3d00:dc73:854d:832e:2] (unknown [IPv6:240e:358:116f:3d00:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id DCE7C663E6;
        Thu, 20 Apr 2023 00:28:48 -0400 (EDT)
Message-ID: <4c8bd175b3749631ebd3ab1b70693b3f7e748c69.camel@xry111.site>
Subject: Re: [PATCH 1/2] LoongArch: Add pad structure members for explicit
 alignment
From:   Xi Ruoyao <xry111@xry111.site>
To:     Qing Zhang <zhangqing@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Apr 2023 12:28:43 +0800
In-Reply-To: <51051bd7e42378cdf465494389ab76a30ca3acf2.camel@xry111.site>
References: <20230418091348.9239-1-zhangqing@loongson.cn>
         <a7fa32c3af68083855e7690f67824d060d5c6135.camel@xry111.site>
         <899085c1-7a74-8bab-1429-1b6e9e4c2c30@xen0n.name>
         <48bc7236-638d-9086-daaf-62eacea80dd2@xen0n.name>
         <111c1e81-dfae-4388-9fc6-a3f247641398@loongson.cn>
         <51051bd7e42378cdf465494389ab76a30ca3acf2.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-20 at 12:24 +0800, Xi Ruoyao wrote:
> undefined behavior.=C2=A0 `printf(PRIu16 "\n", ptr->dbg_info);` is an
> undefined behavior if ptr->dbg_info is a int16_t, because the standard
                                           ^^^^^^^ uint64_t

:(

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
