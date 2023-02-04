Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA968AAE9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjBDPS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 10:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjBDPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 10:18:55 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC41B565
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:18:54 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-51ba4b1b9feso104767047b3.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HFJLgoi+tS77UonQPI72Lq3VMERqDs0LwQVfHpTSaC8=;
        b=Lc+ah9tSl3kTEScnQchIGDUxTYTo4GPkvSl19Db4TghEqMWIlo8y1Oc5wV0RWJ1esH
         7LKKxv8/fOQQRCynq7ticKpVXaEHBylviBEA/gf2A0BWDLqKQVnQL8KUKe6SCTXrrXGT
         JGcQ4FNd1BXLPdaNoay7txZyzIzuNUZF7d0vU69gIFego2hCgaFjhLJKFb9NKMxq7ana
         1s9444A8KybxrJrIcPDGJRYZAZbLlC8jGVcAEQvZknH0TM4S351fBBknu0HmTfDZQDas
         pWh4Q+yD+sJNG93/vZUBR5Nzp/cO4w2CkSEEYi1jHP4K+sHteu4gwXZCY2bhVpKe6Yxe
         PzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFJLgoi+tS77UonQPI72Lq3VMERqDs0LwQVfHpTSaC8=;
        b=gIygLsLub5E5MBXuQRX5jjbOiEala2/DiOTDxVlk1/0B66vPiCGrrvTX8wbwRqSw9H
         CrutXVtQrwp47E6B0E00OMEhz95Eyg1uxHZHxKffK005Xa6GrmACDC9po4J7eGP4aDF5
         /5R7hydWSucOSxrvfBXqfm5CXCq23t+EpoHYruoWIohANa8Kcnynq5KfbWfgwY3RkgLO
         7F2qmJ28uADLuPA8lTaOcLIwhNx2bknUlZFd5TOTACSTl/KaiNZ5Y47c/QcyHKYrJ4va
         Mr3tRkCHShE81qeIwP/20NJTLoJEX27dAPYt06HwIm6S0eYb+8Mx6K6+DFwWnz9V+k9B
         x8cw==
X-Gm-Message-State: AO0yUKXp0L9sA/0WcKWuPfyTLkDQIYoqfrsXqs3+R8WG0KoRfD3Gl44u
        +CdNcbwKPVfPy19uGrFTBaZDrjfKJ/NqnXjsL2tdkHoRV3pvMtGB
X-Google-Smtp-Source: AK7set9qkgZO+i3Vd2wQ0pqNOWhEnbhwhmYyBDVJ8lFw9SHjcAlhjlrxzO95LmyOPjLY7vWf1guULHUMWbxl1XBy1+8=
X-Received: by 2002:a81:8394:0:b0:526:5d5c:aa34 with SMTP id
 t142-20020a818394000000b005265d5caa34mr509202ywf.157.1675523933336; Sat, 04
 Feb 2023 07:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20230204135652.336495-1-guillaume.tucker@collabora.com>
In-Reply-To: <20230204135652.336495-1-guillaume.tucker@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Sat, 4 Feb 2023 07:18:42 -0800
Message-ID: <CABXOdTfMwx7OW_oNkkJ_rKT+EqohTa-xg4kfsHFx-Ep4uug6Qw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: use printf instead of echo -ne
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>,
        David Laight <David.Laight@aculab.com>, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023 at 5:56 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On some systems, the default echo command doesn't handle the -e option
> and the output looks like this (arm64 build):
>
> -ne Emit Tests for alsa
>
> -ne Emit Tests for amd-pstate
>
> -ne Emit Tests for arm64
>
> This is for example the case with the KernelCI Docker images
> e.g. kernelci/gcc-10:x86-kselftest-kernelci.  To avoid this issue, use
> printf which handles escape characters as a standard feature and is
> more widespread among modern shells.
>
> The output is now formatted as expected (x86 build this time):
>
> Emit Tests for alsa
> Emit Tests for amd-pstate
> Skipping non-existent dir: arm64
>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Notes:
>     v2: use printf insead of $(which echo)
>
>  tools/testing/selftests/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 41b649452560..06578963f4f1 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -236,8 +236,8 @@ ifdef INSTALL_PATH
>         @# included in the generated runlist.
>         for TARGET in $(TARGETS); do \
>                 BUILD_TARGET=$$BUILD/$$TARGET;  \
> -               [ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
> -               echo -ne "Emit Tests for $$TARGET\n"; \
> +               [ ! -d $(INSTALL_PATH)/$$TARGET ] && printf "Skipping non-existent dir: $$TARGET\n" && continue; \
> +               printf "Emit Tests for $$TARGET\n"; \
>                 $(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
>                         -C $$TARGET emit_tests >> $(TEST_LIST); \
>         done;
> --
> 2.30.2
>
>
