Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FEE61D8FB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 10:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKEJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:06:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804932C64D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 02:06:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j130so8298725ybj.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=IMCLnsaFkkCeIk/XgqUJ0U+zjhe60rwF4P+9pbHKI87JGGthky+LEmiIWlaT/Ng61s
         bvdFLT6RRBEFWmTvccNreg7woFOP4G3F7AWWKs+Vtx789psQjrm6wWbzrWXJM3DopFGU
         sjkjLmaKuO6B3Vg3nmul18Luy2jCVqR5IKpyb3mCTU04Q1oIBC/8mdQvWFGDtAv1SvvH
         Sa4+Urh+BuPxXa1VcRYLI5gEXuVeqjbHuaxKoCbQNiGiOMm1UEmkEUylljiIJYkZinPH
         lf8kifJyUQ3vHCgxb6A/58Qf4FO6DDpxlrz9B9PuLgCn/RiTuRE7dfleO0zdmXYpffpb
         Y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=XQnBilddgwL7Efbs1uH8yqHlX2AOu6ivWk8gdz4hjmucqr7vxJvjAKQSbVBXI20pCU
         Sf8VzvNJjxSKUwvMR3gg07Dv+u2z2eyTSQU0DFwT6PqRzHfxYG2DXfKlx2BA4cT8MUsF
         XVgIWbMmSpAFVDI2l8qFDAiplk7laAdNHQYdvlDgJZwi7BFKbdX+n1Ef7Lg1ThcjJQO8
         IhzZPCVQNIXJBbRDFYSqDSL1uw914L7S2udhp2M1EAZmTGnsL/3V0jpkOeNToMiYxmfL
         58Wys2J5VoYss9skty7anYJD0sfpvym1kGqz7PpIXrIisu2Bqy6sVCh5lFMLaIRbrTYF
         nPow==
X-Gm-Message-State: ACrzQf2jejEsI5sYhTtxDHLvmY9PEEsPRaC0sCNHGCYSRe3IMMJz7/G7
        AIHd2aCN6QQ8q+gWTcqwVFhH2bRZsSS4N+cNx8U=
X-Google-Smtp-Source: AMsMyM5hMPgDq/hgfbHXo7V5t6kRZI+NZsIDLkIE6kmqMR4n0d+95w5pNQEada9gTl7OJTU2jCxXKAJczS6GM1BH8rA=
X-Received: by 2002:a25:d86:0:b0:6cb:84e9:e747 with SMTP id
 128-20020a250d86000000b006cb84e9e747mr38538814ybn.315.1667639199766; Sat, 05
 Nov 2022 02:06:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:8606:b0:3dd:4137:90cd with HTTP; Sat, 5 Nov 2022
 02:06:39 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <smasinde92@gmail.com>
Date:   Sat, 5 Nov 2022 12:06:39 +0300
Message-ID: <CAHYgA3rQSPzZrWYffkLAJjzCeTH471z14R14HFOTn=aJApSyOQ@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
