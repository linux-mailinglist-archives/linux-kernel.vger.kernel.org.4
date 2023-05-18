Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A9F707868
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjERDWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjERDWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:22:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA27D1732
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:22:50 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E4E5D3F4E3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684380167;
        bh=Gi4VEKOMa2h3a92P3bc7WeGm4ywxJ/65UScMzNMWt9g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qnuDyIoi3/7GulumttzUMARn+ALgFMvozZ4e3j7mhrKz0BDb+R98s/ctoAeQ+OOCV
         FcHccaFKtB/xOg13zHGK3dHUqdDFiR+hYOhB30NEXausW3axEazM3d0peePK1OgmtI
         X/pQBEbt1CzjYjZSOdqlbKl4FVZZA4WzekjrvD4NV5znum7d/xZImOJO750/bQOw56
         lFPgxiKLejfmSaVQnApbPqZC23EQAK16AYGHMqdbX3t+Fm8OWv94KI4LepnsGXfa3O
         q7EzglQdF3HC972pY9F9i2HAJ/7oJK3C9yeq+2SRutd17yvqKa2Xt+QFCjVlSbSvW6
         yWdRlAyzAyCiA==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-54f7473b53cso351874eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684380166; x=1686972166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi4VEKOMa2h3a92P3bc7WeGm4ywxJ/65UScMzNMWt9g=;
        b=WRvhQrP1linzpHcickqn4zdTseihVGfUmg2lbpazg/MN9h4+Il1jteFtGNBU8mySH5
         VEU9TIzztDzTIUYr5TmGo18J0+LvKe6QTRGyQvwnWshYhJxxrLfsImGEamg7UNyvJiC6
         UkBvQr4mD1oHpd5o1p4O3hnEu1mjAC1x/PqxsqhoYZc6pc5kV/z2e0K0Hl1bi33iaaZJ
         b8/i6VnGu2mIMpcAtOMLpB/mnCcnJoBZM7i2Xpzzj8lH6XkX7jSMFInkEMcQWNtlHbwd
         H6Lk4pnCC730DL3Fgbb/2Tw5RVwv+4Pa7DrJ1ANWLase+8wwV7sKkdxCf3J4zdaR7y8+
         JGFw==
X-Gm-Message-State: AC+VfDzhKe9uqyoCDOIwwXmlOcFOFGhRyxflx2SuEtDReYuWwcTGd2Uy
        QXkZrnMKgVC6+BVkVBx59pITzE+iRuCF2xg6DwgNw+4c3pa1g5DnD9SZUKwceQTWvsFAtw+JySc
        flrUkD4ByGDI7eEa+QXUL1y1WFJ4p1JeiVQdq/o1gNV8VkJD9m4viDUCc
X-Received: by 2002:a05:6870:a343:b0:17e:5166:e5ad with SMTP id y3-20020a056870a34300b0017e5166e5admr99275oak.44.1684380166735;
        Wed, 17 May 2023 20:22:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Di+BGi2T2Y8o48hf73VHtmqnUhbnSLeez5vG0gzZcxFpeZcJDMLOxz1YGfRxkX+0YNvwFmiA9PRUEr7Fdn9Q=
X-Received: by 2002:a05:6870:a343:b0:17e:5166:e5ad with SMTP id
 y3-20020a056870a34300b0017e5166e5admr99266oak.44.1684380166509; Wed, 17 May
 2023 20:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230517041119.202072-1-po-hsu.lin@canonical.com> <ZGRthdt5u88zs6xy@shredder>
In-Reply-To: <ZGRthdt5u88zs6xy@shredder>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 18 May 2023 11:22:35 +0800
Message-ID: <CAMy_GT9SYNzhDx6Eod8VXkDM+eKnn+5NjxvBvd5bORF9kBBu_g@mail.gmail.com>
Subject: Re: [PATCH] selftests: fib_tests: mute cleanup error message
To:     Ido Schimmel <idosch@idosch.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, dsahern@gmail.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 2:00=E2=80=AFPM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Wed, May 17, 2023 at 12:11:19PM +0800, Po-Hsu Lin wrote:
> > In the end of the test, there will be an error message induced by the
> > `ip netns del ns1` command in cleanup()
> >
> >   Tests passed: 201
> >   Tests failed:   0
> >   Cannot remove namespace file "/run/netns/ns1": No such file or direct=
ory
> >
> > Redirect the error message to /dev/null to mute it.
> >
> > Fixes: a0e11da78f48 ("fib_tests: Add tests for metrics on routes")
>
> I don't think this tag is correct. More likely that this is caused by
> commit b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit").
>
> You can even reproduce it with '-h':
>
> # ./fib_tests.sh -h
> usage: fib_tests.sh OPTS
> [...]
> Cannot remove namespace file "/var/run/netns/ns1": No such file or direct=
ory
>
> Reverting the commit I mentioned makes it go away.
>
> Also, please use "PATCH net" prefix:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#tl-=
dr

Thank you!
I will submit V2 for this.
