Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AFC73D26E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjFYQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFYQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:33:04 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D31A6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:32:42 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44358c019ddso125958137.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687710723; x=1690302723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaMClIyzbes8/ajhVEEaqDE5A6xT3CkloKD91himAvg=;
        b=SBsMMUgM/TDiklODo1eGbYP9dnl+XJ/qf/AsD+5vx03EWGC1PK0DEMH4/nADgLyEzO
         k6K8BlJDM0Yb4u/O0t5KTr8KhBnXRvPgGih9oZLlcK/YeUcTU88T5ikh+ZOjt8McMFoQ
         nMI1sQcnBLBO98hcKRRRgZlFLVWnCQrGrqM2Wgg28lXS9/1Pz9BiyDQ/Jonn4x/nDlRE
         TKOoXX12IdG76vdkeeds/Pm8enJQeYDvnzG19v/IIGl6U2M4s0EgGtBwGPC0ugdlFkrx
         jCCLHv+t/hA+nln3A9XHFZUk/aikvluSepFoSW9nkDYREnV+TcVzzWPo8WH2Sux5Pyaq
         EL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710723; x=1690302723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaMClIyzbes8/ajhVEEaqDE5A6xT3CkloKD91himAvg=;
        b=gzANl20010f8+pCBZ3P8JpOzKyZ6n87npPEEEuEwzlzlXI/kAigWYyTkjIUVkoUqH3
         aCZ/1/S54AeFL/7cEZ/rtOdcqLp6qmNiH8Ojg9QPefiqxwMVEBqA2mSAPq4cNTLv5gmg
         mdq+e/M6G5lanzTRvvr491yG2423WQWKxtDjSAUfsFHjO61fNa/0ZaiGKhN5OPz6Owvd
         yItZdSFGkSq0gu8WushlXlauqPaqI3Jr54WHJAYQWyIlE1m23ElofzFshfhGG9qsTXwm
         QsQTyYBwKYQ/eLHpM9nzByMSyp2tfyb9m/yOddXgi8KzSEWvzltCBqAhAeSj8dQCBLKH
         +txg==
X-Gm-Message-State: AC+VfDzZaDUsx7sBjmHLGN7wXDaOvjIzSU/ep5pUyqst2RjzsoWmEF1L
        FLm7iB5Xx97zPF9GWXzLpxAdahu7+Py9LGyx8tY=
X-Google-Smtp-Source: ACHHUZ53btt3b2NOfpPJbrKRlB4Vg9mJbf7rfNQwbcdLrmZ4jIh6JJCt9e9e7ivK+2NQ9usb8v4+SlMJnOcQnxRHzsQ=
X-Received: by 2002:a67:ce07:0:b0:440:d307:76f with SMTP id
 s7-20020a67ce07000000b00440d307076fmr7279107vsl.3.1687710723001; Sun, 25 Jun
 2023 09:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <F9C4E29E-C355-4B08-A2EC-2197A6EB7AFD@googlemail.com> <2023062527-bride-unsolved-3b56@gregkh>
In-Reply-To: <2023062527-bride-unsolved-3b56@gregkh>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Sun, 25 Jun 2023 18:31:52 +0200
Message-ID: <CAAUT3iObhY9VOQP9FqWRR-BmFRDmOJKFdcE--pzFdNgF6ma9NA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix some checkpatch issues
To:     "<gregkh@linuxfoundation.org>" <gregkh@linuxfoundation.org>
Cc:     eperi1024@gmail.com, hdegoede@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        philipp.g.hortmann@gmail.com, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
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

Am So., 25. Juni 2023 um 15:55 Uhr schrieb
<gregkh@linuxfoundation.org> <gregkh@linuxfoundation.org>:
>
> On Sun, Jun 25, 2023 at 03:33:59PM +0200, Franziska N=C3=A4pelt wrote:
> > Thanks for your feedback :)
> > Since not all the patches of my first patch series have been applied, I=
 thought I have to submit the whole series again. Submitting a series of 5 =
patches, where 3 have been already applied of course fails.
> > So does it mean, if 3 of 5 patches of a series have been applied and I =
want to submit a new version, I only submit patches for the remaining work =
and not all of them again?
>
> Yes, just submit the remaining ones.
>
> thanks,
>
> greg k-h

Done in v3. Thanks :)
https://lore.kernel.org/linux-staging/CAAUT3iM3k3iVx7UOQ-s9OJ=3DaVWarAp3rED=
NTzSfY-m3yJpGe4Q@mail.gmail.com/T/#t
