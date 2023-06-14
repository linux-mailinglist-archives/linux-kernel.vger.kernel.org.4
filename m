Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45ED72F7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjFNIZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbjFNIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:25:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000DCA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:25:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qgz4m6Htxz4x4G;
        Wed, 14 Jun 2023 18:25:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1686731112;
        bh=aotpfgQZbURhSACOUwxBHUxZhBJBP2q7hloZDWnKsCA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eplKTPzUs0h4/u1fJpvuOLadPBkktlMM+qOyAxkJpRnyie7ZBSajKrxsUtVtIaRWk
         iQ9NiRpPQjvmH9OlUQ+ELI0sd73B87HToXTPBBrdTP4CqYrc8HOVLnTdnNr8VPzddu
         GZbGLzGM44KlUbNRWZNw6z28Go5XsoDlEHjO0noS+d5nDVw32OME2an8MBJR3jlDsy
         0uDXamB1SzA5oTMJOZ43EeBPhcuNWtBmC8C2s0uuKs0pZ8TL7En1Vk/ftZIZSExNNu
         UjxLS5o2bYkPsrugUI990MYAZwMktwVXbdSADUzUzS2aZHFY47AQDY5xbTOLSI1aQf
         t7yyRf2BE7kQQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "wuyonggang001@208suo.com" <wuyonggang001@208suo.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/xmon: Fix comparing pointer
In-Reply-To: <975249b0-f69c-47a2-a084-64107e39e1f5@csgroup.eu>
References: <20230613033455.44992-1-zhanglibing@cdjrlc.com>
 <8adeeee071d085cac905d5752c2b7632@208suo.com>
 <9978fdbbd580fb60693607981c75ffdf@208suo.com>
 <975249b0-f69c-47a2-a084-64107e39e1f5@csgroup.eu>
Date:   Wed, 14 Jun 2023 18:25:10 +1000
Message-ID: <87r0qefo2h.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 14/06/2023 =C3=A0 07:48, wuyonggang001@208suo.com a =C3=A9crit=C2=A0:
>> [Vous ne recevez pas souvent de courriers de wuyonggang001@208suo.com.=20
>> D?couvrez pourquoi ceci est important ?=20
>> https://aka.ms/LearnAboutSenderIdentification ]
>>=20
>> Fix the following coccicheck warning:
>>=20
>> arch/powerpc/xmon/spu-dis.c:51:34-35: WARNING comparing pointer to 0
>
> Once again, why do you change the formating of the document ?

And regardless, this file is taken from binutils, so we don't want to
take pointless cleanup patches to it, because then it needlessly
diverges from the binutils source.

cheers
