Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32A6F3FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjEBJN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjEBJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:13:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1D046A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:13:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so3473372a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1683018801; x=1685610801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je+stwVyVzohIMwhwEUkHHYxPgxc8l0tiX0YAlYbwa8=;
        b=S9eTIKXHQFsHNG2DDigtg+A94Kft9D3iwx2hQnQh1GTzcwuOJIuPqfp6zsZkV+8LJN
         CVVvFBpb2/PB9rA69X5DaXk/+n90Lx6RWnBmzRw84LnRGdw//09aCBRXMsLTfetNbfsL
         XoTBydUOfyeEqFfakYu//jz60rwxx9brShtYk2/jofkOCLTKMJRiY+e9bnn/Tz1OMP0K
         XEQgY4Gqt26+1h72oZbQ/mpxDmyyqaJJ00a6NfoxDO/4wySJjwO/q1oOH4LwehV3V3RH
         9lyo8rVCfZIfVN1I19H/Ey8MF14edZj2hMcOj775hKHhBLAfRR5mQDMwfwJuEm4+vKgt
         plMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683018801; x=1685610801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je+stwVyVzohIMwhwEUkHHYxPgxc8l0tiX0YAlYbwa8=;
        b=jO1HUPPqylCPIo06hz/C+kuWwuKRS2AeEny36YZ9QYtf09YMKCMLkkXN6iiT+eRjEv
         lGWT0DbYsOtKkodkvN52de4mGzwG/z0JHjiTQXHpCGsRiHjq2+UMuugwpnFt5WXyIHNI
         Lp6D1lR2OCfn+q8a8cPHIE9E2VE4gImwx1/TDGX7nfoXUfk+8Erzp0nGeV2AxgjhJEAt
         MoUgTdCcDHogj9ZQjO8+UY122vyQErlyoiWMOyCQc25Vc2ysVrXUeBI0Xhf+Rvv0IEAY
         TYBOwhOu0USmjDqn2Ns/266YQbHwBhWBaqhzDy7Cj+5RxWYK1eb7CZOT23D3zwQA+GUF
         KYNA==
X-Gm-Message-State: AC+VfDzPW+qZ5wUvBfkvKGDA3DBxKjVU5s+GeR1kvgYKaUNoVrI+6TNz
        G43gGqYmUmyiohIIvEf99cNpXw/LqAmeAiGdtsHkaA==
X-Google-Smtp-Source: ACHHUZ5WzBNZvaHyJuQvxWvMJR3VHsNMHmkanBSzQ4QC8DfeJ+IWvHxYq1XJGkTwEG1UfMd183WkrJATar7m2pKDMzg=
X-Received: by 2002:a05:6402:441:b0:506:983f:1f61 with SMTP id
 p1-20020a056402044100b00506983f1f61mr7514391edw.3.1683018801471; Tue, 02 May
 2023 02:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <87ednz7roh.fsf@all.your.base.are.belong.to.us> <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
 <CAAeLtUADqnwrgBjhDd+iNfwhMU6YBiMUZzeopVMAh0Jq19W9JA@mail.gmail.com> <87jzxrnp01.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87jzxrnp01.fsf@all.your.base.are.belong.to.us>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Tue, 2 May 2023 11:13:10 +0200
Message-ID: <CAAeLtUCqyARVaY2YtVXWc_cucMOCbQ2RAd2y35pun_MMagEN_w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kito Cheng <kito.cheng@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Greentime Hu <greentime.hu@sifive.com>, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 09:58, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrote=
:
>
> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
>
> > It is a pity that the current interface was designed without involving
> > RVI (and that I had to ask my team to put together a patch set for
> > further discussion, given that none of the other major vendors in RVI
> > stepped forward).  I guarantee that plenty of reviewers would have
> > highlighted that a central registry (even if it is just a kernel
> > header) should be avoided.
>
> Are you claiming that the hwprobe work was not done in the open, but
> secretly merged? That is not only incorrect, but rude to upstream RISC-V
> Linux developers. I suggest you review how you interact with upstream
> kernel work.

Please don't put words into my mouth...

I was merely pointing out that there was no engagement by the RVI
member companies (in regard to this mechanism) within RVI, which would
have prevented Jessica's issue.
This would have also helped to address the concerns on vendor-defined
extensions.

Also who do you refer to when you say "how _you_ interact"?  If it is
RVI that you refer to: it doesn't interact with upstream work
directly, as it doesn't own any engineering resources.
RVI provides a forum for member companies to come to an
understanding/design and then have the member companies perform the
work and take it upstream.

> Why didn't RVI get involved in the review of the series? The expectation
> cannot be that all open source projects go to RVI, but rather the other
> way around.

That is exactly the point I was making and which you seem to miss: RVI
does not own any engineering resources and depends solely on its
member companies to project into open source projects.

> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
> probing"). Your team was very much involved in the review.

I am aware, as I had reviewed and commented on these are well.
And my only request (was and) is that we need to figure out a way to
efficiently deal with vendor-defined extensions.

Cheers,
Philipp.
