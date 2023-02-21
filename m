Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0D69E38A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjBUPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:34:59 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215252BF14;
        Tue, 21 Feb 2023 07:34:58 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bh20so4346836oib.9;
        Tue, 21 Feb 2023 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiAzRlCBTMrhlXByZpYWHKvdyN5bWbbQAdX6oQ5LG9A=;
        b=RqlOuM7j15Nnwn2zDE6ZSGqOHg6uR8PvU+b4Ad0VkteG3ss6rgYId6Xr8K34fcSPR/
         w1HskmNoEQ0wxudSAbareQSTXddjUCJzYIXjVMZXRMm1r84FgF26UzJWGhczHLpfPoeT
         2ZTaNI3fMmZArS18y0KdBabF6YXQMQ6UbAagaWS6LJh7xuKn2SMuQkvi6/25lgPorlEN
         spvJpylKLNtGeFftpxeItvAFUSf9wYDuF1UJymrTA8kJFHAMs5QoK5ahwvmlyjhOqrlV
         J7GOFnHZ8AXrlflCEjqZIjJwwzOX5kEbHtJ7vbbB/Yzz4qn1yB16PrMujbSI+GJgIab4
         MIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiAzRlCBTMrhlXByZpYWHKvdyN5bWbbQAdX6oQ5LG9A=;
        b=YWOcI8QFleXsgzjzLFls/G/WgBOQxn4kV5Sf9SILyQCzwkAHgJJ6rmtpsgfZyu3tVe
         lwwGNLyNlaW4+qTwAWHTsybYmNjUZz3/nc7D9Z2Z9O2S6lSLJ+11sTwjNL9FIfM2VOG1
         +OL5A3TSUODlOz+piYainpH/b+1JYWGtTUc0R9oYD2HWtGkdocjs2ZqwC85M3Xn9Tvao
         U7DSPXs95AX1G9saNz0hR4nqAEDxnA45zc0NzWlbjlDHZ0CcwBirAnXUmrgIQ0bUpoz/
         8si1NdSMMw8Rfw90ZXldciuVN6fspKxMCyGWfoFjEmJziu3xHGDcek7uKgkgExb2urfc
         tquw==
X-Gm-Message-State: AO0yUKXqebWKwsFyTd4WXyLp8S0PegYSZASsrdZTWn8ebyBpgz4a9x7z
        TLg+o6ltvvVDeiXO9Xwa9Fh0+14KHfm7F6hIQVQ=
X-Google-Smtp-Source: AK7set8Sa6IVPL4stqZq6btBAn5MGnS86003TfSj+k65uoA+SONlBEmUr3oJ6FBk+uT2MLmEBNhlbCHUg6AuU/oFV4w=
X-Received: by 2002:a05:6808:1296:b0:36e:f9d4:a488 with SMTP id
 a22-20020a056808129600b0036ef9d4a488mr1358657oiw.239.1676993697494; Tue, 21
 Feb 2023 07:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20230221092435.22069-1-arinc.unal@arinc9.com>
In-Reply-To: <20230221092435.22069-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Feb 2023 16:34:45 +0100
Message-ID: <CAMhs-H8OrH5U9L9AG3seCd_O_A92_JmxTHyaKpAgTXiQ73qhAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips: remove SYS_HAS_CPU_MIPS32_R1 from RALINK
To:     arinc9.unal@gmail.com
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:24 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> All MIPS processors on the Ralink SoCs implement the MIPS32 Release 2
> Architecture. Remove SYS_HAS_CPU_MIPS32_R1.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
