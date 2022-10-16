Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71C6003FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJPWs7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 16 Oct 2022 18:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJPWs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:48:57 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D52E9D5;
        Sun, 16 Oct 2022 15:48:55 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id x66so1218528vsb.3;
        Sun, 16 Oct 2022 15:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JllJBalxx1s2X21K4hX9EpNGlj2qfI/v5wckJkk095Y=;
        b=2LT4OrHkEiXFCKCmhMP7PPaLnk0u+m/1prDcubn60+NzBbf45o6NYcMetqlBGh08sZ
         njYHumi/E5sK/rH5ezNm91QwJqp4UlQhEmAtbICI1Zwj76SGbX8bgIZ5XPol3qpB58R5
         IvUqIfF8XaDyyVriAv55FRagN40YB3DGOTXE2UEWjCha/lKFRhXudDI3kEmwHdN5DMh/
         ArYC9bPkIbTqYgbRd2A3yH0OxMo9Em+7q4u0ROoPB7o9kwaXAyUjW0HWk8afE+znBJWk
         lgGIYrjJfvxarjk6o6OSEmZyXHo+LQUcLWBHzLAKsP+nfudxw4Pw2w19d7kf+sWfPygB
         +D6w==
X-Gm-Message-State: ACrzQf1VTct/YwrTITYVwUeY8f7scJdrPz8ouG65PSiNaVWM8ueMaheB
        QWbsbmVQeFr90pjZrFT2A1b6kNyOaVShQsiMg/k=
X-Google-Smtp-Source: AMsMyM6dkMvQGci5X0iP3nd0muN8UkPBFNnSLNEezutijjpDIUoP4Vs7jqO/YfkihLvZ4Djixza7HiI7AJdWay1VHwM=
X-Received: by 2002:a67:e09d:0:b0:3a6:f21f:3d42 with SMTP id
 f29-20020a67e09d000000b003a6f21f3d42mr3114944vsl.45.1665960534542; Sun, 16
 Oct 2022 15:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214639.31074-1-palmer@rivosinc.com>
In-Reply-To: <20221013214639.31074-1-palmer@rivosinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Mon, 17 Oct 2022 00:48:43 +0200
Message-ID: <CAAdtpL5eFu9Vh4Xnkm5CPGb_h5HTe7M+WiG46t3d5gFu6b9ZEQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for broadcom
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     william.zhang@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        rjui@broadcom.com, sbranden@broadcom.com, rafal@milecki.pl,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 11:50 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
