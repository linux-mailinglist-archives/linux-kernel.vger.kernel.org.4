Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7B370791D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEREbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjEREbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:31:09 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E1E2D7F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:31:08 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B3993F1A6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684384265;
        bh=b+oOfiP1rI5QINs0SG6MekNu1r25dIcI5YYFcjqrpGc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=S4RL4KzpyXdE/DSFJg9V8J6/7CywtcHHDo+lcWF+fcawTTLCUf5DA5YtWAdvmVQ06
         r+CphA3mCWOPaRpIkLSX6On53zDJN4DyUQ4jrWhYlkk2XAB0LOFtPXWNa0FljSGCMA
         BNVssdqc5Rf9wXAjQGatamouU7f+WGU53laIqOCRQL+YiN4AIQPWyPQQBMKBdafyer
         f+dMuadB+627k5zkcD9njYNvEAeX8PytMptBBE9ssF8B9kGQhfuAc/EU3/7jHfI8yx
         U1t89v8itI/tq/4hAIz3vVgrE+18WwgjRjfvh8UI+cFryLpomeQQytzsxitv7glT5G
         BqYLubtLRopZA==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-54f618e51f7so385183eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684384263; x=1686976263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+oOfiP1rI5QINs0SG6MekNu1r25dIcI5YYFcjqrpGc=;
        b=dr8I6jh4ZjZ12xvA/ZPhBllnp666UMX6WQA2wpM6BRk3aUFwyHxTf4fOB7Yex5vqq2
         OIA6wbDuXnLELTr/LudfvW5nQyMlIQGnEXwpom4xAsAA+855CH3VCTe5s7teh+zRzoRg
         wWq2T6o5oDsNDfbJZk4tvhUvIbBBIqUQLJJU42ZBGREQN9WhSPk92b8jAN6/FVIqBQyh
         xofOIFTWgjENFOUwA0tg/d8oBzsxKzhJZctYA8VUMdtSf+ct6dAMyWSuI0UewCT/2SzL
         5/GS/gS+v6p9bf/ya3reUFQ7civdxVO9yD1p16TbKcP5aX5dK2f7/77GRz5VEk713Hng
         QO8g==
X-Gm-Message-State: AC+VfDxVNHbC0klKwdEJvLCzJ/TUo0wvQ8S7oZ5Tw5kk/0RX455rl/hd
        a0/TdlKDO2n5MqdtZpgkC0h4IuzcGu7zuILZRf/wO6H2MXb+Y2wNs6/+qM9e+/vqK5Kx6r/F8Aa
        NceZ+D7TUSGQC3Zxy7kn/Bj+5F68BXmkh5MtBXpji1BvyR3J9sYNRV5VK
X-Received: by 2002:a05:6870:a601:b0:184:4:3038 with SMTP id e1-20020a056870a60100b0018400043038mr231864oam.24.1684384263699;
        Wed, 17 May 2023 21:31:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76PMNB8QPvld50lcowqrluKsvulCwftjic0oglH6fL5bPQQ73mDIlJeqbsIloQRTGLw96BKHvZrepMbqaaQgI=
X-Received: by 2002:a05:6870:a601:b0:184:4:3038 with SMTP id
 e1-20020a056870a60100b0018400043038mr231851oam.24.1684384263434; Wed, 17 May
 2023 21:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230518033310.19893-1-po-hsu.lin@canonical.com> <20230517205130.0b44e3d0@kernel.org>
In-Reply-To: <20230517205130.0b44e3d0@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 18 May 2023 12:30:49 +0800
Message-ID: <CAMy_GT8=eiF5GaoUungL6d7w4Lp7s=NOE_YpBf4GEFpqrHG++Q@mail.gmail.com>
Subject: Re: [PATCHv2 net] selftests: fib_tests: mute cleanup error message
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        roxana.nicolescu@canonical.com, shuah@kernel.org,
        pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 11:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 18 May 2023 11:33:10 +0800 Po-Hsu Lin wrote:
> > In the end of the test, there will be an error message induced by the
> > `ip netns del ns1` command in cleanup()
> >
> >   Tests passed: 201
> >   Tests failed:   0
> >   Cannot remove namespace file "/run/netns/ns1": No such file or direct=
ory
> >
> > This can even be reproduced with just `./fib_tests.sh -h` as we're
> > calling cleanup() on exit.
> >
> > Redirect the error message to /dev/null to mute it.
> >
> > V2: Update commit message and fixes tag.
> >
> > Fixes: b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit")
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> missing cc netdev
Sorry my bad, wrong copy-paste, will improve the workflow to make sure
this won't happen again.
V3 is on its way
