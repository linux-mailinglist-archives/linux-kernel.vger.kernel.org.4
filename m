Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904671880C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjEaRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjEaRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:06:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA01E41;
        Wed, 31 May 2023 10:05:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bad010e1e50so8643036276.1;
        Wed, 31 May 2023 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552742; x=1688144742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLI3C77UUH8a7vo/UtwCwZu01ZTIS8d3sU+aRADHIYU=;
        b=G4nllCdJCOjAFj8ZxauXRVVq7uw3y0OzOdsiezqKZ5DfFZNlEkLII7Hc7TJdeKh15W
         eLLTQmortFLT8AesUuBvWfjQ4B8Ene6kWHDmTjfJ3PgG53lkEywPKBTOSQ7nEvVYc5N9
         hqBGIrLP/kl+rwSgNz22YgWGan8dh0MG1T6q4N7Cuw8D59P6pTH0cIeQsCLSZE3vnVv0
         sVM65wKdQI4y/thZgJoRv5TOWcSalI0Rmj+V7cdo0Ma/nr4etRXgjHTyt/TpOwjOXfyV
         8XXrYhdlCvsQjWwrjIUpYSgrI+Djq9ea9+qe20Iq2aAfVOG25FogpBOjRa2bsnVtj8XC
         C5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552742; x=1688144742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLI3C77UUH8a7vo/UtwCwZu01ZTIS8d3sU+aRADHIYU=;
        b=K3JLsrEmrLsf6uEoiXSZOtfxw+SOL1FtsR2IjoPqEA7mrffFuSmCm4fOR+TH4l04kA
         ODYQFVChUX4j14ePUoQ2JI+a0Kgvs0Pu9k1kfbWyurxTaLeAc6MFNdUcXjpuagE1SNK9
         24+lzBRHnhbl6j3+bnvJYUQCjqQjWoZ//gFtnH5nczw19qq23mQ8mh3EHo0qNYHPmo25
         GkWNoeVbop9cc6oOO+7Qddq/UqP0PimntFbW0FZOnpuskWxYyh+Rc5DH3Dr4AJEUPD7L
         lLu/KvMIJE7j1j28KPbds1/IEOz/toWS1Sl8v6xQttefwISScdd2GrHq6NXY+SDeUnhn
         ib3g==
X-Gm-Message-State: AC+VfDyipWPVtPI4O9zV1HGPShPEldtqAJ3WCcprfCTR4wTKA92ZJgCl
        etoOD/Ni2YNWa0JOW+PMpkY+Yn9jb6+N0BtqTQo=
X-Google-Smtp-Source: ACHHUZ7T5FWtaCksEYIGCfBxBoHHCSoylR97os4Rjz45cR+S5pJnqL6TG4nigKhZP13Jl/iqOnTvmluSNUoNaVjYCL4=
X-Received: by 2002:a25:242:0:b0:bad:c64:4e0d with SMTP id 63-20020a250242000000b00bad0c644e0dmr6780393ybc.35.1685552742397;
 Wed, 31 May 2023 10:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230306220959.240235-1-ojeda@kernel.org>
In-Reply-To: <20230306220959.240235-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:05:31 +0200
Message-ID: <CANiq72kun_ZLRBB_h3-Dtby3G0brDV+xWb-mda=3QC_oRyzMfQ@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: point directly to the standalone installers
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Mon, Mar 6, 2023 at 11:10=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The Quick Start guide points to the Rust programming language front
> page when it mentions the possibility of using the standalone
> installers instead of `rustup`.
>
> This was done to have a hopefully stable link, but it is not too
> helpful: readers need to figure out how to reach the standalone
> installers from there.
>
> Thus point directly to the page (and anchor) with the table that
> contains the standalone installers (plus signing key etc.).
>
> If the link breaks in the future, we can always update it as
> needed. And anyway having the full link includes the domain and
> gives more information about where the old docs were in such
> a broken link case, which may help.
>
> Link: https://lore.kernel.org/linux-doc/CANiq72=3DgpzQyh1ExGbBWWNdgH-mTAT=
dG5F600jKD1=3DNLLCn7wg@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` (with Andreas' suggestion applied) -- thanks everyon=
e!

Cheers,
Miguel
