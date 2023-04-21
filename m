Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB626EA660
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjDUI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjDUI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:56:55 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF18A5FF;
        Fri, 21 Apr 2023 01:56:51 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef54bcded4so8334576d6.1;
        Fri, 21 Apr 2023 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682067410; x=1684659410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXhEILP7MIbeRegT9QhmF9Jbqb5hykNTAv4rFurPXOo=;
        b=Fp8vNPjFC8gwk56JdwhvgixReiu7sHBr42H+rxicYairhgzRr3XxufHNn7LTllmLrt
         RKK06lWxyEnQ+t4dyN/w7hmLHXOlTu9Gjtv756fVWta6JCA/ZlyXTHUmgAAYqHyGgKmv
         3zHMcbPt3oMdV3MBEPQF/QV5bKiFdeFpTDDWMby3I/5s2QifWhDAO6daaHS8I6t1RAOm
         FuVWAMsnNpGCk56hFN2RSJLAKZqqzA1Qv89wKOWIamIs3xeW5IUjSObzD4jGAoQKLOGT
         0nvnJHCNvQUlYxrSRc8GGC5EnKJClwi6np86K7bapdH+2eeVOupkNA5vkORorIqojpxb
         5v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067410; x=1684659410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXhEILP7MIbeRegT9QhmF9Jbqb5hykNTAv4rFurPXOo=;
        b=DXIlYhzY3/42ToofeCf1Qons0P9cLsO8njvlbiJN6ZkgEkFSgavvDbJ0Arb9QIJbqo
         C/EVgXzlVZi1XuluaBDm68jIBq2MHFfcuTijTF/4wIpGRRg5nBKA7VlFkEWWwqCN8wIT
         vYz3dz36CIJ76ii5A+peOopFR0R7OUP87ceLvM4P+VTROTFESM7MgbeDHNqLHj4TrqEt
         wAubQnHd7TNJbDSGHA7JT7V3Csuguun1UW/u3E7avnusPq6lME+5ptf4ANmGy5XDZV1F
         MEa7lHMfW/n+aMmNJXWoiHFL0eXu9vhCk3unqP1lKljINcryqYxqj/Ymb2LJMQ5IP8ny
         WiMQ==
X-Gm-Message-State: AAQBX9doalvnHDxWs2+qiJxwUk9PBWRU4u+I4yivLY5e74b2ObiG+gYH
        qzH3aEujibTZR1Bdd8pZvp0rcKeVy+sHk6qU
X-Google-Smtp-Source: AKy350Zruw6CuMXgd+e3OySpeenWD9EnXJSTyoiWBbyds2AXwDQko5XgQ00OnjewRfm41mpvH+Pfqw==
X-Received: by 2002:a05:6214:124c:b0:5cd:1adc:30e2 with SMTP id r12-20020a056214124c00b005cd1adc30e2mr7170251qvv.11.1682067410196;
        Fri, 21 Apr 2023 01:56:50 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id q15-20020a0cf5cf000000b00603551afd50sm481424qvm.39.2023.04.21.01.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 01:56:49 -0700 (PDT)
Message-ID: <b60c56780c76272d55ea58a4a7aab7450b97c6af.camel@gmail.com>
Subject: Re: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Masahiro Honda <honda@mechatrax.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Apr 2023 10:58:57 +0200
In-Reply-To: <20230420102316.757-1-honda@mechatrax.com>
References: <20230420102316.757-1-honda@mechatrax.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-04-20 at 19:23 +0900, Masahiro Honda wrote:
> The Sigma-Delta ADCs supported by this driver can use SDO as an interrupt
> line to indicate the completion of a conversion. However, some devices
> cannot properly detect the completion of a conversion by an interrupt.
> This is for the reason mentioned in the following commit.
>=20
> commit e9849777d0e2 ("genirq: Add flag to force mask in
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_irq[_nosync]=
()")
>=20
> A read operation is performed by an extra interrupt before the completion
> of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UNLAZY
> flag.
>=20
> Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> ---

LGTM:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com

