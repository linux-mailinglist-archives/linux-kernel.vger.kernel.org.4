Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10749631D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKUJyr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Nov 2022 04:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiKUJxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:53:49 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DBDF8A;
        Mon, 21 Nov 2022 01:53:36 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id e15so7676806qvo.4;
        Mon, 21 Nov 2022 01:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOcXUuHAGZimwc+RZm0Yt6j74cNusx2nIprjfIzx5YU=;
        b=FxrYTijCXNPlCdnTR/qhjNWueLjMV1bdjoszW+/RqXM7j5Pj231VKeB2WvZ1lHZwhc
         nbxvlp5oDDO0nvrc+ex5oKMkDjPf5xQ9YVJvtld+xMhTYTPCHcAJAgU2crKNmx99gFB2
         bo5YDUqRCm9a+b5qxTRvH/fzPO7Hf9zTpsDoXwXiAvg8B0PlO5u8Tepr//3AnTGIQwTJ
         CLsbpDfnByfDQSGZYpvS93T+S/zBn/0yTHlktxOft19oSV5pTxbRoAoELu1Iv30OJorS
         6s/RJRP+lK/KsTXxBxUyl+SCvG/7O4lw6zRBtckil+tXFxBk9psbjBdJ2hHpGTudVI7L
         1Edg==
X-Gm-Message-State: ANoB5pkbDigfef2TCIi0NDcKA4IB03g2CnPC8OuxrLOIBUiH1tHkUYf9
        WbuU2a1mmlZxFykp7gOSxintkcExDVop8A==
X-Google-Smtp-Source: AA0mqf6bc5uQ9A+jKCMsLY/XTTOD+1e5YYW4/scGfbmTnFMdo35Xfpbfpj7btWTnjskYySYCNLAj6g==
X-Received: by 2002:ad4:52e9:0:b0:4bb:728e:b232 with SMTP id p9-20020ad452e9000000b004bb728eb232mr4470319qvu.27.1669024415708;
        Mon, 21 Nov 2022 01:53:35 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a124f00b003a51e6b6c95sm6469986qtx.14.2022.11.21.01.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:53:35 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id y83so4847204yby.6;
        Mon, 21 Nov 2022 01:53:34 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr1436785ybq.89.1669024414398; Mon, 21 Nov
 2022 01:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-6-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-6-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:53:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvC3LoDY+qxxyDHGCi4ViMoxb=gKA+_8oob5yCoX7vNw@mail.gmail.com>
Message-ID: <CAMuHMdXvC3LoDY+qxxyDHGCi4ViMoxb=gKA+_8oob5yCoX7vNw@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] serial: liteuart: minor style fix in liteuart_init()
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:56 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
