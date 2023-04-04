Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D126D58DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjDDGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDDGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:41:32 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81E213E;
        Mon,  3 Apr 2023 23:41:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cu4so22824065qvb.3;
        Mon, 03 Apr 2023 23:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680590489;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ubSVjV5n/ZIFvg/nNFW2MiE4DLKAencx+/xiP1BInN0=;
        b=USDERrwHUZuutcRX32G+qzk8YfgOtrnjS0qBgDxjY16GMh9iBjsGNmQ4nXJnQhcWA1
         8iHsVewMmf0hv4hmYZEaK0tqT+LuyfGWZH4YSjaSkN2QEZpEPdK9l1lZhWSAZAS++IH2
         K/165+HCA3Et3+TmGGrZQkUd+AGVLzmtN7CoCyHQQ/PCYrSbdgDedPtyuFUuFdOuR/8p
         PigIeyYfUr3TRzmDNnSRC45XqOXx+VpNLZpTNSQk2VFsSfMf3E3V0IeUinItqKhAVgJd
         7jLxVOK1zwKeytOhaRN8Yrm1ZIhPFL0lQKYaaHpo4MOEeqhIjq5+0K5DzHVvwUZaccsB
         lSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680590489;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubSVjV5n/ZIFvg/nNFW2MiE4DLKAencx+/xiP1BInN0=;
        b=la1WSQUc75vbybQvstWTjlGTJ8J96wskDG+ZKLbccpUGQLF4LQhz33vcwhowexsu1o
         HmIshmRMsNBK2U1/75MNlhJ05yW+2HZAOhobOLF4Qzi8CcPrt3TLrevW6ouj3OeUclDN
         ftB3dsUvR8br1rLTaV6lwt1hwaTwd6ljmLGjBEen3w0oQa9Hw+aPywckYwvdVGvNXvnZ
         5pCFkwVK4H6mBktKHmkm64uf2h3fpp6Tqgql5hN67k/e5E/J9IYtYIJViGPvdDhzrTz+
         4MQcBmluXLebUGZnMxqMTpGlcMJqv2SzanHXKaRiJFIJSPaP5YFOtd20Nvg4+10ktf2S
         SnjQ==
X-Gm-Message-State: AAQBX9czUaHOkW91yFsNOf6lFLxb8OX7/3+7JiDofoPFIHRv5wb2/GKI
        kD0Bymti5yn+syeFcydrC57bf/G+UwDKoNIf
X-Google-Smtp-Source: AKy350bryRRjBBRDpcU/ZB/mnA683R9FBdLUjpkheKLNwnYAkWdhOgxkyPEa7Ya3WsrrZKNzmznwtA==
X-Received: by 2002:ad4:5c43:0:b0:5af:d59:885a with SMTP id a3-20020ad45c43000000b005af0d59885amr2960027qva.3.1680590488739;
        Mon, 03 Apr 2023 23:41:28 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id a18-20020ad441d2000000b005dd8b9345bdsm3191552qvq.85.2023.04.03.23.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 23:41:28 -0700 (PDT)
Message-ID: <ee03cecef9139720a9818aa434dd34ae433d8e9d.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: set varaiable max5522_channels
 storage-class-specifier to static
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Tom Rix <trix@redhat.com>, jic23@kernel.org, lars@metafoo.de,
        angelo.dureghello@timesys.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Apr 2023 08:43:32 +0200
In-Reply-To: <20230404013828.1914523-1-trix@redhat.com>
References: <20230404013828.1914523-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-03 at 21:38 -0400, Tom Rix wrote:
> smatch reports
> drivers/iio/dac/max5522.c:55:28: warning: symbol
> =C2=A0 'max5522_channels' was not declared. Should it be static?
>=20
> This variable is only used in one file so it should be static.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


