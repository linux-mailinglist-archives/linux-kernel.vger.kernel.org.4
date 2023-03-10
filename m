Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D046B5498
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCJWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCJWjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:39:05 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3DB12B7DF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:39:03 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536c02eea4dso125741157b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy1fGIL2bpoDt3NLA0Y/Pd+S2vU/897Q5DSocMtRARg=;
        b=OUSRD4Q6LAbVnpah9wnrAMnccjh6wCex45l1qPZ+Ir7Wxjpr8hPNxIjwbD/oDDZKpA
         Z3IbVI+s+1BHghIdCman7gLgpDHoHNPVGwlLKDlUaT+vS5+h3T3C+LcBFxEpewIJXDa5
         tlrPFJ9idj45ssWlFzdTQ+lSdQuX1/80vqn84LxiNmlPd/RKj/2elt1Ox674BzN+7607
         h9rE5X/SCMRTswjHlT/017+/zkZdKze+1MYZ3KDExjdNNzeKfFer/5i/BX+3tKjDP5ny
         c//uYh6hDzSipLxFsQEBqlifGkPQNfI4YtAi01tqCxKGx4PSPzhxHGLLevqqbqBuEiWs
         frtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy1fGIL2bpoDt3NLA0Y/Pd+S2vU/897Q5DSocMtRARg=;
        b=T6jH0cVGwXsMObM6rPQQon6u6rOdXKM+cdznpCnJCU6dBD6B5NijnMSFuw+1kZkCgR
         PoASmvKDXHJV/KdV/G6DyxN2ZbTd9T1bgJ4uPRhsVttoE6uLf/VcKYhAyDs2u9pBJ6wY
         OPVBSbp/B1ORMMNMd4kCeYvQBt4r/YIVbCHeJC4PkeJpakT5BbOMysKawm0yR5cm7ZZH
         ZVRwEn8nT1QeYPwygHzqkLrVfrGaAAqUoxglKCUB70/0KbP2504MYCjUWQyYnoBNB8HC
         zL6PXlYkx2g8hTQC7DjMHejt8bujbEBbthECVPVST6cIjVIUL5ft82C8YibU42IRsv9N
         yhKw==
X-Gm-Message-State: AO0yUKVB1c9Br40daTHcEfmtO93T3s/KqDXcBspFVt26PliLxSY1yIBd
        bdOmghj9mBs+uDkrBPMAhmOiGTo7qGOOLACIiLOBIg==
X-Google-Smtp-Source: AK7set9GSqXjAMs5/5vdSSS4bpRTDuTGgYofIyyJ3iCHBzSDnSF+Jf2SlfUdi/I9iKS/kGdJUgniqkrHAUGGWDgCg6I=
X-Received: by 2002:a81:ac51:0:b0:540:b6c9:66cd with SMTP id
 z17-20020a81ac51000000b00540b6c966cdmr882596ywj.10.1678487942014; Fri, 10 Mar
 2023 14:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20220928122539.15116-1-pali@kernel.org> <CACRpkda-WcnRdwYNi0oeZsvX9xO+ECBF15rd41+Pr+MWmrZuBg@mail.gmail.com>
 <ZAs3SgNsYb31x4UU@lpieralisi>
In-Reply-To: <ZAs3SgNsYb31x4UU@lpieralisi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 23:38:50 +0100
Message-ID: <CACRpkdZN=Rid894wruY14b+yFt3su8ejJbKbEH57ynoDxce8qQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 2:57=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
> On Tue, Oct 04, 2022 at 09:56:18AM +0200, Linus Walleij wrote:
> > On Wed, Sep 28, 2022 at 2:25 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> >
> > > Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() mac=
ro for
> > > accessing PCI config space.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> >
> > I have no way to evaluate this change in my head, once the kernel test =
robot is
> > happy I can test the patch on IXP4xx.
>
> If you can manage to test it I can go ahead and merge it.

I managed to test it with a oneliner to add the right include on top
of v6.3-rc1.

Yours,
Linus Walleij
