Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6574A1C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjGFQFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:05:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3295DC;
        Thu,  6 Jul 2023 09:05:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-783698a37beso33511039f.0;
        Thu, 06 Jul 2023 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688659506; x=1691251506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTwkYSqtsqBHs66NETbnHT5nEfsCUcOLAL0N30buT0Q=;
        b=Jo9h4FlyCvzQZ0jWs1i0uvFOIN5SotGmaH5DqJNFnELGu1TPjEPh03ovcbUoJqfk2d
         +GsIAODlxVmIIbUjU6+JyNSS3Bc1iwpl1fSMyAQq2jExpvGhGxHOjAO1z7ZnJ59SF+LM
         Ey4oI7hLLDiGOM7Tsdpo58lqIIDt6mWAxdrYYhZwSOg8irt4youjs7wlLF/q/Bgz9+vP
         p6q6ru1kRMSQ+3uoJXSwFVAXrL5Cokrdbuqbxonz1pefI2QH+e+31oxr/plOLpb5PMsw
         pzUYzTjYYh9sYyxZVeB/fPEDkFlaVa5G+nAAKTSyeYPg6OLwhn4bTuuBNOYqaIai4aWc
         mUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688659506; x=1691251506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTwkYSqtsqBHs66NETbnHT5nEfsCUcOLAL0N30buT0Q=;
        b=g6CeUUMpyUu91UMXT/eAjL/PvZATE/66SpVnuEaaRuMw0KoSmESlfaOolfULJqY45g
         sFmNXmjxgE2QolAsNOCIJbXygqVxKLTRWNA9RYYFpAhBW5dH0s9fWZ1cfTyb7yD0aUsB
         pKFe2QfZnzn8XCdbHNPJT3Czm3leO4dyo/XB/nRfiZ6aYQ67EvlBp+DFATCnqVfnsOYC
         TXUqxLhs+n9Woq1z7IAlhFkSUkkAEBc96TuGVRSieZBjj2Hp0iPIrPrvqEDfE4+fdxXz
         uQ1/bxg3pZqmA1gDC45gjMYInsdyoZZUY4NQlGAGYmqDfk7CQElgZZL1gY7NwG8+KwVT
         Yjfg==
X-Gm-Message-State: ABy/qLYwDvuHGgfu9gfT7dZ7K7YdqMUEsjrACXMyq3qub6FYBX+0pK1P
        Ilse/ovp9EuAGyUcRmiklT9bSF1LcdEktyfDqMk=
X-Google-Smtp-Source: APBJJlGAv+oHpyM+F0rVCKJV/FH9dXLruJYc6nI3WCrra0tJEp/YbmbSTCCl4hetEFobsQ2i/9san8dTlSll2GVxz84=
X-Received: by 2002:a5e:c648:0:b0:786:445e:1c0e with SMTP id
 s8-20020a5ec648000000b00786445e1c0emr4030638ioo.20.1688659505925; Thu, 06 Jul
 2023 09:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230706111700.14305-1-dzm91@hust.edu.cn> <87cz15s2gv.fsf@toke.dk>
In-Reply-To: <87cz15s2gv.fsf@toke.dk>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 6 Jul 2023 18:04:54 +0200
Message-ID: <CAOiHx=kccbUFGsWMA_31UPW6p=k1qa+HyL5OGyzv50W2Mc111w@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: ath9k: fix printk specifier
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 at 13:39, Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk=
> wrote:
>
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
> > Smatch reports:
> >
> > ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
> > ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
> >
> > Fix it by modifying %lx to %p in printk.
> >
> > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> Third time is the charm! :)
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

But do we *want* to replace %lx with %p? Because this now causes a
change in behavior, as the kernel will omit the pointer's address,
while before it printed the actual memory address. Using %px would
have kept the original behavior.

So if the change is desired, it should be noted in the commit message.

best Regards,
Jonas
