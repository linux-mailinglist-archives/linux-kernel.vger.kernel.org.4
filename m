Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E246FEBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjEKGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEKGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:19:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626463A82;
        Wed, 10 May 2023 23:19:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-528cdc9576cso5522141a12.0;
        Wed, 10 May 2023 23:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683785949; x=1686377949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBq6gNXlIkO1sr2zMtsa0llQb2ivWfUTIg0xFKyGA4g=;
        b=OLxj8WGjuHm4DwG7o+78ctgXx0M120hOz7qq6g+15EU+qTQfLPgmURTYSPkYOMBs1W
         nOOVlz/HZQJl0UYWeqZ1HyNZuNhKlA+N9pNT6vtweH9MkzjjcCPWBC7llZbdy1bc/fTi
         8AVEYlEwye7WXlXmW1fixatJ5PxFSbQ1xpL7naOpgVMGOREsxU+zftbZtjEvadIKA4Lf
         MUTZPWKBVyEq2mh+tK7lxlNvSaAhvaJOqoWCn+nBjq5PhNFz5pqKj0XTEar0uwJZGvPo
         ZFHz48EHUxU+oh3fGWz1yELSI7PhEzayM5nDgtEnQL5aiO/uxHeaAvtptTf1WgXI717M
         tMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683785949; x=1686377949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBq6gNXlIkO1sr2zMtsa0llQb2ivWfUTIg0xFKyGA4g=;
        b=XWFCqPeN8Gyi8LNeT7wWH1P4ohMqixPOD+2/uldbl6obv4hEJvoP0W/4utZPsHM/+o
         TCTJF8i22DQvQJdVP9Zch0bc4FSqLDPgFOMURyd4+K5I7jiNKZixVFWTaYwZvCaTS3jO
         UrwmkcSMnUp616dSE1yqy++2RTXmbfB+KgZoEFdNn17N7strqmXK6S0R3BmdqgopEG2K
         I+5EXz0W3LLIbs+isHj8VJZW9uDDpl6JwEGns1ER4uTE8NaLX7V2hoszzEntgZ50qKKg
         6PTlDmTEiIL8L9ybADYTqfmQQGqAfoE4hTihWwga7e+y81wPwU/TC/5xPSWF92lAbO0x
         hNrA==
X-Gm-Message-State: AC+VfDxY/tQeMQrh+z+LZ8hqVRKYfXEjYF63vmCFRx7v3Yw/zYPUuH9x
        FvSiVbz3ZRSzr43p6p2GzWPzizg9tFP3QAouSo8=
X-Google-Smtp-Source: ACHHUZ4UfBQg0I+Vec8VlNZggJE3FqRIIUr6q9DeTWErjMivgnSpTfpnJNg8lYpMYIqGfQGyOMsB/iYUAypo0YvKvtY=
X-Received: by 2002:a17:902:e88e:b0:1ac:451d:34b with SMTP id
 w14-20020a170902e88e00b001ac451d034bmr27571774plg.9.1683785948711; Wed, 10
 May 2023 23:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <20230510171238.2189921-6-paulmck@kernel.org> <CAEXW_YRRMfbfXJwCA89hD_VCpbxR8AoEvv9xzrX=W_4Ffi-g2A@mail.gmail.com>
In-Reply-To: <CAEXW_YRRMfbfXJwCA89hD_VCpbxR8AoEvv9xzrX=W_4Ffi-g2A@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 11 May 2023 14:18:57 +0800
Message-ID: <CAABZP2wGXaMUwu372HG-654z2RCvUayiR8tBpDg+SDgcyg+OtA@mail.gmail.com>
Subject: Re: [PATCH rcu 6/6] torture: Remove duplicated argument -enable-kvm
 for ppc64
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
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

On Thu, May 11, 2023 at 1:26=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Wed, May 10, 2023 at 10:13=E2=80=AFAM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> >
> > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > The qemu argument -enable-kvm is duplicated because the qemu_args bash
> > variable in kvm-test-1-run.sh has already provides it.  This commit
>
> drop the has.
Thank Joel for the fix ;-)
Should I resend the patch, or would Paul do me the favor instead ;-)

Thank you all
Zhouyi
>
>  - Joel
>
> > therefore removes the ppc64-specific copy in functions.sh.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tool=
s/testing/selftests/rcutorture/bin/functions.sh
> > index b52d5069563c..48b9147e8c91 100644
> > --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> > @@ -250,7 +250,7 @@ identify_qemu_args () {
> >                 echo -machine virt,gic-version=3Dhost -cpu host
> >                 ;;
> >         qemu-system-ppc64)
> > -               echo -enable-kvm -M pseries -nodefaults
> > +               echo -M pseries -nodefaults
> >                 echo -device spapr-vscsi
> >                 if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_=
QEMU_MAC"
> >                 then
> > --
> > 2.40.1
> >
