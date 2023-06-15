Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1E731EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbjFORM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjFORMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:12:44 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF0D199
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:12:42 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1a98a7fde3fso1477662fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686849161; x=1689441161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7t8tAjtALMCxF4db4hi1Na7h70msD6c1rOODixaixs=;
        b=jNqIYIKjaHjZGxMm6sINXlkUWOIHlJv67UcaVrw15ZUbyxe0n2u5Y4JHeH3FviTlR/
         pCh+K0a0f4XdDI2cqcOJ6lNIsg7OjMKICFPnIZrHuPwfcGHwywIiEHeGMFuCog6E6VVz
         K6AyyNUE5jlhz5/QZco3+c/NKidFQfZuZLFOAt+RWhouuFhndh9Hg1e9krU3RvKgRMkz
         mWee2eKcY/DTIVRhURZWmTAWs8cHAlgeComVUetYhxZCBHytBECwVOvwL/84LQrXwHLw
         PPWOu6qSRyXYjJIV9QujArTRi0eTu030+MZB4DlrOCuWLf5JOD6nhH0shqaMMHiciJ0F
         5czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686849161; x=1689441161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7t8tAjtALMCxF4db4hi1Na7h70msD6c1rOODixaixs=;
        b=Xoy/N0CHOYOvQRXpUhUk/6iCjm2RboOeHiDXqFhEQFofXPNLXtEei4FWRV2T+h0udK
         P2Ia7OaxlK6oBQA1LwtH0BboFy+VdnINrEFkZqkzdz4dSAMySQP9TKmFcOCiAceo/QRq
         X3SL4rK84bVTywlMILsgJm6kqzWotQHPeXQaUVd2VDcMAL+PGYMBVqWnpDxwoZzzRpXG
         6uvx4Px6DB0vBcN/WyX3DEoN4oV2tdXffu8bG21FKbVv20RV0Q5jlM/J0DYA2gbu3PVp
         SD9scwc/vhR55i5FXf0f9WCvyEjA//XZAkNpuW7SIk13y37Iqq9g1HFqa/V34Yh0l9Ef
         69Iw==
X-Gm-Message-State: AC+VfDyYkzLIlgwaBx//bfPeuAo+jrYsjdS6UF9jex9wLRitv9TVjvFS
        Mz71JsN3F8kphCC9okf4DBznWCmLeQB4l+yhq9A=
X-Google-Smtp-Source: ACHHUZ6CXnT0WPxl4FYp/k4qqBNQvCCWTxuAf5kTrU+0rjax35sGjlU7IXpnGAs+b68DIsoVnpxYAHJfYkEVz1vWONM=
X-Received: by 2002:a05:6870:e506:b0:1a2:7a03:4fe2 with SMTP id
 y6-20020a056870e50600b001a27a034fe2mr12726386oag.35.1686849161335; Thu, 15
 Jun 2023 10:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230614034936.876-1-machel@vivo.com> <5844e20e-843d-f65e-107a-8fd4cff48e32@gnuweeb.org>
In-Reply-To: <5844e20e-843d-f65e-107a-8fd4cff48e32@gnuweeb.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Jun 2023 13:12:29 -0400
Message-ID: <CADnq5_O-HmDpTbNnEAvtrFzFRHiBoDD+wfJM2kJ0rzT2PPb7+w@mail.gmail.com>
Subject: Re: [PATCH] amd/display/dc:remove repeating expression
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Wang Ming <machel@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        opensource.kernel@vivo.com, Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied.  Thanks!

Alex

On Wed, Jun 14, 2023 at 1:36=E2=80=AFAM Ammar Faizi <ammarfaizi2@gnuweeb.or=
g> wrote:
>
> On 6/14/23 10:49 AM, Wang Ming wrote:
> > Identify issues that arise by using the tests/doubletest.cocci
> > semantic patch.Need to remove duplicate expression in if statement.
> >
> > Signed-off-by: Wang Ming <machel@vivo.com>
>
> Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>
> --
> Ammar Faizi
