Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F937658B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiL2KQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiL2KNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:13:43 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA77B7DE;
        Thu, 29 Dec 2022 02:08:15 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-417b63464c6so254824447b3.8;
        Thu, 29 Dec 2022 02:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kCPue5bVnBCl6KyFMLbRIdht8VKhagIgElJcX4EzXBE=;
        b=LnbtTop9Vh8oiQR1mcwCJGeIGtusMpaxi8axneDslxRT/LofjDcIn57aOX5EnSaA88
         0slS8G/gGY81Aam1jW4/2SNEmIH8dZtu8HaHa6X9kDME+emdOCHi9C3mm2X3Qrzw6M10
         O/TCRYAdG74OSPerCIpFYS3x9V/zGFctGln8IrpZYqvluCauuxI+cPOuuyhiq1pTr8ee
         CPWxRMOROPaYR5elaKw2c/Viu9n59OKyrO5AVthOoNA9U+eBvyex26dq4I0/q/eJdgq2
         YXLh1qZxYp/+D6J/Rkzu7SCnub6Oj3Aql5mRh+TLk56lV/0PtcvPqKbBUvAGVgJRYUuQ
         Qsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCPue5bVnBCl6KyFMLbRIdht8VKhagIgElJcX4EzXBE=;
        b=uOD3gb4Vl0rI41yXIrr1Gv1uHIUjI+t0aX46YUldgRQKWZAFQ8pk93oNI2lzn1atmw
         jUEcvnm9u29qiJY4A0Ye472JML9uKFFe8BzAlUBipU4mBoO6wt4GcEkKi+lS+Neqlv07
         1gw7lg0nTNYWTUQ+82rbbS06+BC7v5cZipxhj6a0aywpRZqeWr6bv0ajtIb8ysS5EQE5
         kqygT5oRgx5v85A+7G0jWan1ptboL6FCYuuaX5TJNqjGMnoEaHce74cmPB+nlPK97DQY
         x1MAoUwkuhhOL3OY2cI2SUHb76m7wNuxud24AYq35AB6bIrStKfIw47LWVQfuhN5cjNt
         kfLg==
X-Gm-Message-State: AFqh2kq1DaqkWTDVAtZ7RKsmxYima7luJGVNEE+HmHV1ueKrquz4NWz3
        IN8x3sKQ9/qVdPRudEcsJAXgLy6lDTN6NkE1a4A=
X-Google-Smtp-Source: AMrXdXvdRJSJJyCj0d1bwOfSiOSmpSIdqVwL1LI+Ddec21OKinEcvfqAVEhWXgciIR22wNES0Um8cZnD1pQn+Z7bwTY=
X-Received: by 2002:a0d:fc83:0:b0:3ed:90d2:2ab8 with SMTP id
 m125-20020a0dfc83000000b003ed90d22ab8mr2562641ywf.67.1672308494481; Thu, 29
 Dec 2022 02:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20221229080813.908450-1-masahiroy@kernel.org>
In-Reply-To: <20221229080813.908450-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 29 Dec 2022 11:08:03 +0100
Message-ID: <CANiq72n1uvzwWZ2pcn6yxQDMMYjaB5BpW1aVv149=n1HHnA=SA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: sort single-targets alphabetically again
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 9:08 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> -single-targets := %.a %.i %.rsi %.ko %.lds %.ll %.lst %.mod %.o %.s %.symtypes %/
> +single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.rsi %.o %.s %.symtypes %/

My bad, sorry. I added the `.rsi` near the `.i` due to the similarity
in purpose.

But it should go after `.o`, right? With that change:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
