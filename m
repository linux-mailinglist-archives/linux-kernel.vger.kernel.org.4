Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AEA6AFD72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCHDgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCHDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:36:37 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48EA614B;
        Tue,  7 Mar 2023 19:36:37 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536bbef1c5eso282577687b3.9;
        Tue, 07 Mar 2023 19:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678246596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBnC16V3DVRFG8Cx25Z1zKLSf9LWl69vSGngN5Vr3FQ=;
        b=cx6n34dK5vXQPXwCdkwXo3kfgSGrfhjM/SRm2cwr/AijaoqiGtJ9y2ht5cF7RPEXFR
         rY0B/LqRGjTi5vt6S986Gx5n/oO3hor4ILMtGkx24xL3N7SCxVUaPoANJUbmF5LIk1AK
         gpZFb2DGjo+WvHuRVLB72aZV/Q/U3cTdMvuC9LGgKVhjDB/wpDuVfJhU7R/SJQvihu6/
         pooDqJoLWTheTWkihT0Y/qtqW6vfM+JUm/IATk5GnsApHTg769XYMkoz2DVrYMoVqx1D
         w/fTDB6d3KUmoab20X3DcUu1hUiUH/FT91iWp2Oc9BN8z7EXyyrqB+Cw/7KYl/QfXIhw
         SGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678246596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBnC16V3DVRFG8Cx25Z1zKLSf9LWl69vSGngN5Vr3FQ=;
        b=CWkdNmE5ylmC3RNsrQmoHF5Z42LEnvuWBTtmX8TuyeIPII8HL1k1hcfnnSQH1M8Y+e
         hFll9WCZ7LDnawfoTbzqnG6Kf9WOo4NIttSEamNVhnuLl5lJXpRPiPxtzbPOy8VK5n/Y
         F0hQGL59F01vfhqVy67I+3Ti/JLnsAoOyy9rYsa9uA/d6BiOhD6pJLK1suggJDEOJtEy
         8MHZHicv7TfwtGHwmeMyYkW8GBKT3HG3/MR5LTgZ3sLtOoTrb7P0DW2TI7jM1TKGuIQY
         Pq06/NmUsnLSmy9olPL5J6aosmqEYD/PBdV7iNHcyzw5VUBP+gLIyt9EYHrsym1U5vQk
         oN+A==
X-Gm-Message-State: AO0yUKWvKSW+jB6KahMOLxqe7iXGg8k0sdo6zoPAckq7VCUh/xsHUdci
        Ka7hXbbpzm/ox7PuXLwDOWXM6IGTF51tNHsVLmn72QWAM/g=
X-Google-Smtp-Source: AK7set/z97qrdRU5Gsceap0mFRjtGxnmS4eQ5GpEo3x26lvH2ujczer+94shM10Dmck/wa8A9miTacTcR6m9nZcVAZo=
X-Received: by 2002:a81:b61a:0:b0:52e:c79a:cda with SMTP id
 u26-20020a81b61a000000b0052ec79a0cdamr10856119ywh.10.1678246596265; Tue, 07
 Mar 2023 19:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20230307130332.53029-1-daniel.almeida@collabora.com>
 <OBVROfBri9SuVdfyos-71URYovcNLhbDb_50cECWMwhycY2sHH90w28f0qlJ_q_dMuCnOD_4nQCVUnwOkgyCEH1298nsVLW0YFuuiIlLPow=@protonmail.com>
 <01010186bea3a046-f1f68507-2d3c-41c3-9066-44199e2ce071-000000@us-west-2.amazonses.com>
In-Reply-To: <01010186bea3a046-f1f68507-2d3c-41c3-9066-44199e2ce071-000000@us-west-2.amazonses.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 8 Mar 2023 04:36:25 +0100
Message-ID: <CANiq72m_ixnodZrDiZeYY1U3Wm8WJaWwCH=dVjKBKdmczbKrGA@mail.gmail.com>
Subject: Re: [PATCH] rust: virtio: add virtio support
To:     FUJITA Tomonori <tomo@exabit.dev>
Cc:     bjorn3_gh@protonmail.com, daniel.almeida@collabora.com,
        wedsonaf@gmail.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 1:34=E2=80=AFAM FUJITA Tomonori <tomo@exabit.dev> wr=
ote:
>
> C versions of virtio-console, virtio-rng, and virtio-net exists. Both
> C and Rust versions in mainline?
>
> Are there guidelines on pushing a Rust driver in mainline?

Although the website is not finished yet, please see
https://rust-for-linux.com/contributing#submitting-new-abstractions-and-mod=
ules.

Cheers,
Miguel
