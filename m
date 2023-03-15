Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724956BBE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCOUxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:53:27 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE9C15C8D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:53:26 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-544787916d9so64407857b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678913605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hWRPtmPWJsX5vHSHgpi/4LQ9h4RWSVRNNwHg6FwZfU=;
        b=Ru3/4Tejeyllb5kurJRnPZuuL9vp9zEJG6qpjJMLqqQ9XiOGflk6gcGMiN96PeQcl2
         ZLEi5QSh+EEJRCtoRdOF1MjvWdam98R70ihe3ybnCB5H+tZJQA/pcPfLJpuWOSd2QpM1
         048bbuKOAl3pYOzwL6WSAGTzKDAl3x57qdlShymsNUFayNfIJnb7Y6D2kSqwqIMcX6GT
         wNy/ceVQpunCXrba19iyIy/Ktp3nO0kiidk0ITr1W3zbPW1zXslOcJRF0X64Xeh0QFqq
         b7vwEJc7tUhNgE7liZIGrm3vSQ3JC6B6c3ReP8CfJBAIOti6TMQd3r2+q2PJzWYfcP0a
         wmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hWRPtmPWJsX5vHSHgpi/4LQ9h4RWSVRNNwHg6FwZfU=;
        b=oaZhCkUjWHoHNaoTgpfV6rsr5Da34fbHACk+Y5rvU8uYvkW541Ufhq+F22XV7D4YgI
         d/P/5tNT0ARWL2yxcUfoltMHYnzVQbL9bmOhDNZs+6qVco/2SRTl7K+jSCWiK+fgA8kQ
         1CmdxOxaWsdh3Q3e5EA7BTGUpN1L8FkO1KTbc64pTY9oaN2YSTCbih9T46mZEPq3LOo1
         pjBDlasmdMuCArEvG0TouK9G+vJwk83OSQPN7efel9H8Zs+Bw+CD10Lv656HZwFIuLfv
         0Z1ncH7uR37ERmCfzVanBTBwK1tDNQ6k/3myY3sMGpnoAnIh4i4mpaZzQ+yuGSGYqTvC
         EBqw==
X-Gm-Message-State: AO0yUKXgW1paxHJtZ3p95KgETTZHj3SiqZmVGaOMoLsRr8rstWWwuwdy
        wg/xqihIEQN0h2RDnBkmtPMuX/1IPZuLNo1Rwng=
X-Google-Smtp-Source: AK7set98AUY/yzBaT4SHare2LVolluHFPhss78ErFBn/LA40sTFR4NqTBw4waabH51ZuzMsd1IleGs/ICXsRSjy7ucc=
X-Received: by 2002:a0d:dd11:0:b0:53d:2dcf:890d with SMTP id
 g17-20020a0ddd11000000b0053d2dcf890dmr902936ywe.4.1678913605580; Wed, 15 Mar
 2023 13:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <2d8ace62-c087-884b-3d4a-d29291697d9c@nerdbynature.de>
In-Reply-To: <2d8ace62-c087-884b-3d4a-d29291697d9c@nerdbynature.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 15 Mar 2023 21:53:14 +0100
Message-ID: <CANiq72nmk4YFiBx5v8wnvVH9aSqe6NvJpeeRy1S196evgJAaJg@mail.gmail.com>
Subject: Re: rust: Minor formatting fix on available Rust version.
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Wed, Mar 15, 2023 at 9:45=E2=80=AFPM Christian Kujau <lists@nerdbynature=
.de> wrote:
>
> In Fedora (and possibly other distributions too) rustc is versioned as:
>
> $ rustc --version
> rustc 1.67.1 (d5a82bbd2 2023-02-07) (Fedora 1.67.1-1.fc37)
>
> This makes "make rustavailable" report the version twice:

Thanks for the patch! This one is getting fixed (along with a few
other improvements) in another patch series that is currently in
progress.

Cheers,
Miguel
