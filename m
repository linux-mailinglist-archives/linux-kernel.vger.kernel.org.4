Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB306FEB2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjEKF0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjEKF0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:26:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8C4213
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:26:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba1911d60f5so12022812276.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683782796; x=1686374796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7yTENVyOqFjUfzaGJwWt+oOgBMebhIk0NqAg6/+aCg=;
        b=E3fqH+C1TZNntj8XWs7Ld78+jxI7qMTtnccB5OVdHIipQZe02qJRykfjXf3ciqoyQd
         iwuNgbfoH9bDnGMTiXO+5Xulm42HNjAjIftdKiHXRqH1kWCBGImuAb45Kx0wlV+gC5ea
         jGHjsEU/2l00dJ600ly9uY08OnOCrTdWTIFxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683782796; x=1686374796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7yTENVyOqFjUfzaGJwWt+oOgBMebhIk0NqAg6/+aCg=;
        b=iMxBCMLRAV1OjkRQ9alDdtAqzcW7wgEKP7U98cWNfAdREMlBy9DQHClSWkP3HvALm5
         ateC5DR77wCjLUXr+zmg+WJjl62CNQLnwq6KnOItK8xqIegxRLh13ecAZSh14NaBTWgd
         UP7ND/qqDen+uFQRqesjpqSyHvANZNDDmC9HuIhSem9DPUxq3JwkBPX0RRpyq5EooLGe
         zOROWy4hHbFTbmasCNt4OoLZmlpxh9uiuarPf973HP++EmSnpawhrD52PVPKPO9w8gfz
         ytCJ/N8AhVP7m+o7oWsgnWsbT0MKeAedsrZlV6I02Dzfb4Fxh7izrFvhz44q42qbC8va
         ZQ5g==
X-Gm-Message-State: AC+VfDyNNJbDz9XJcor7WMIDNhlgf6xmg1TUhU6y/ZD9MZO4yXwxLd5b
        Kp5nefahomGMPJJDIisPRO78KqU/E5/kvNXxEx2SLQ==
X-Google-Smtp-Source: ACHHUZ4ntDzdE8uBKO3utIIAtwq/ZLfBZlZzrpxFAD3yE0ohaVJvDEWtv7oPkHqvfIZt+Fa2i56UMm+7j+o9FilwBs8=
X-Received: by 2002:a25:d187:0:b0:b9e:917c:c8ba with SMTP id
 i129-20020a25d187000000b00b9e917cc8bamr20142971ybg.10.1683782795792; Wed, 10
 May 2023 22:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop> <20230510171238.2189921-6-paulmck@kernel.org>
In-Reply-To: <20230510171238.2189921-6-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 22:26:24 -0700
Message-ID: <CAEXW_YRRMfbfXJwCA89hD_VCpbxR8AoEvv9xzrX=W_4Ffi-g2A@mail.gmail.com>
Subject: Re: [PATCH rcu 6/6] torture: Remove duplicated argument -enable-kvm
 for ppc64
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
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

On Wed, May 10, 2023 at 10:13=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> The qemu argument -enable-kvm is duplicated because the qemu_args bash
> variable in kvm-test-1-run.sh has already provides it.  This commit

drop the has.

 - Joel

> therefore removes the ppc64-specific copy in functions.sh.
>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/=
testing/selftests/rcutorture/bin/functions.sh
> index b52d5069563c..48b9147e8c91 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -250,7 +250,7 @@ identify_qemu_args () {
>                 echo -machine virt,gic-version=3Dhost -cpu host
>                 ;;
>         qemu-system-ppc64)
> -               echo -enable-kvm -M pseries -nodefaults
> +               echo -M pseries -nodefaults
>                 echo -device spapr-vscsi
>                 if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_QE=
MU_MAC"
>                 then
> --
> 2.40.1
>
