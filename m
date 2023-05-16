Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334F5705140
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjEPOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjEPOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:52:08 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25F244AD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:52:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7576deacbd6so608606385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684248725; x=1686840725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6zHo6bWXc/84vWZVuKR/6I8EjwUwKr00I4It6PliM0=;
        b=WGthoJEw+t7ttdWbkPOLshmqOtTY3VzK2cL7/uzCVD+xXSxhHJ0Wn8mg9/DbEYAuo4
         1G5k5vbe7N1/rsFV25W3nT90pCbpL8svBESkaWNRXxqzgsLIB0qfV1R7A4WTz1hOvohE
         GWxNfh6MybmQ+gXds1pETj6pJZ6uBiITKJckEyH8TiKkAcLihvS+Yd9DesDQ/MpeXJEq
         OD/YTIcO1PYVqwqzaYCb1588uNl427U+8W65u3tqv/WIzHc4Fnc9TNCQgI38JWYn+ULD
         2c35iO23WgwkJNm/dnnz1qu8U8f8+LVXI54DUs6dc+pZ6jir8+GvB5VPJ8ukqJfiy8S6
         Z7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684248725; x=1686840725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6zHo6bWXc/84vWZVuKR/6I8EjwUwKr00I4It6PliM0=;
        b=OtZgPBArfoStylnlOqj49miQGypz0dGzrOR9fyy/buCNhH+EPoQw0/L/EZXM1E76hC
         QsM5wg1o5nSq1OO+tfc4oOucj7sXqMrMxNlStNuYFdlB09nZSMcqsmeuQY5axATcssCC
         T/uL4hCC5OE2M+vGTF+MiZZQvRuYWSnY0urAWTwZKrWPt9hA2fS+W5X2IBAKVt2O2upE
         NafkhYu7OPAAZ5lv8mhysJ/9pZugvPDRNyNO1q3yR+jFv2GzkDyv4qkjCpn0ksAe9N9j
         I2qNtP+9mzQ8LAMqPPiF4JoIeb+anPwy/soTpOgN5JotL5h829kGLdGCBA1CVPD4VUOa
         Nm2Q==
X-Gm-Message-State: AC+VfDwGY7Y4Q3v6+9fHwYpYzstoIfSSWtd0aIV31NhHujCoJggFyUPN
        mAuoMC5tCk7ONExmqV720Xux3C4qzA7bcHBZR96MDw==
X-Google-Smtp-Source: ACHHUZ40oD9cViZWTRMJZNhLFQIwCH35iwip2jSEtirhaBtc647aaHYUYXLxnKF7BFi2Nsd1eN7GBPk3bIOFB2Tbx8M=
X-Received: by 2002:a05:6214:1c4b:b0:56e:bfda:a14f with SMTP id
 if11-20020a0562141c4b00b0056ebfdaa14fmr71315780qvb.9.1684248724907; Tue, 16
 May 2023 07:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-22-masahiroy@kernel.org>
 <93s3n008-7oon-30rq-5219-5r244919r38q@syhkavp.arg> <CABCJKuf91O4OtBQ62CRuCYHWrENdvjnzHdyH135qCt24rX4Lsg@mail.gmail.com>
 <CAK7LNAT_MakkY3hMaCJE=iFFc27tM-Xjw1fC_SQX8WycQRmouw@mail.gmail.com>
In-Reply-To: <CAK7LNAT_MakkY3hMaCJE=iFFc27tM-Xjw1fC_SQX8WycQRmouw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 May 2023 07:51:29 -0700
Message-ID: <CABCJKueexnq=hE2L3uFQt5WeS2_mFckK9NHagFfU-peTnwMNeA@mail.gmail.com>
Subject: Re: [PATCH v5 21/21] kbuild: implement CONFIG_TRIM_UNUSED_KSYMS
 without recursion
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 7:16=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Tue, May 16, 2023 at 7:54=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> > A while ago there
> > was a suggestion of adding an option to LLD that allows one to pass a
> > list of symbols to preserve in relocatable LTO links, which would
> > allow us to better optimize vmlinux.o. However, I haven't had a chance
> > to look into this deeper than this proof of concept:
> >
> > https://reviews.llvm.org/D142163
>
>
> Interesting.
>
> But, scripts/generate_initcall_order.pl is still needed, right?
>
> --lto-export-symbol-list is a list of symbols,
> but it does not specify the correct order?

Correct, the patch doesn't take the order of the list into account.

Sami
