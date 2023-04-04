Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC76D6EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjDDVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjDDVRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:17:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9D5599;
        Tue,  4 Apr 2023 14:17:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so136091038edd.5;
        Tue, 04 Apr 2023 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680643031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vB8C/rkfKSiKVTM11U1zRHBbWNH+nLc5httEWsxhlqs=;
        b=c+svavxJzJiDnanNxas0i37W0Wi3ItSv75f77BColKvnVsaij56RGWuarKjybsdY90
         c54uFR0fCl+BgN7t8hK7AMaBcwP9BWoOaRexZ69XxqUL9SMonxIGVpoEU96iYw785yK/
         JosttHftu7m+AgCTVNeH48tS54HhWxGIONtep8kkmbDYMsraR2ICNZLmApYislh3PUll
         gKLhX3drqADr3+sEv1WQ6dI67x/wZI8N6kCr4F107zOrMzlkfezL8xwMD9WVqzcv/Oki
         BwHCzkYFsaa5hQdJtVzxKeWFTCUuJhmZ7rD+OqO8ZEdFtaxIi3i4DHHDHczcxuLjEvOv
         KBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680643031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vB8C/rkfKSiKVTM11U1zRHBbWNH+nLc5httEWsxhlqs=;
        b=d/ImaHeH0XT02VegHvjsN9LDxsyo5BGNk2JEZ+I7Io59kupWdMT1zdC5vVDv3ljepr
         7NknqE2QlkidFNwLotqYkYJTJYi7UfMV16r7WdeGpF+Nbx4ICzx3o+8K1VdMLD/WYOdQ
         M0n5TsAtiLRo+ugoZPnrQTRKF9Lt6uDQfurngqFJvB/AsxrEoe6fVdmn7K9sS7emb8Dt
         Hb+BXF1cm1IN2Ta6NmyFRW+EoPVz1PvZjqwSgC0cROJLeuStJBkuFvJ8O38CSaXj3+aT
         jnC1GuUEnOHKJLWVH3PPi0jO6jQeQyN9dBqgru9n6j+gfUIcfZ6Ov44qb6LE6fQcuwwE
         0lEw==
X-Gm-Message-State: AAQBX9f3KtFQ9vfdZ0r9FJVw1x+lxmOEjYh++1/F9OYvhIp7yQXFkYya
        HEjSvyA6A6fmkWbJVYkkyGloTZs/YXORMaWNIjSn0WJ4yIA=
X-Google-Smtp-Source: AKy350aIqmZisXJIuv3J8wKQg2znly2zjp4bcIZKIIKVGI7jtw6pB/aDQVQxVQWyQt5jRB+KnOnc6Z0ic3xeASo5O8k=
X-Received: by 2002:a50:9e2b:0:b0:4fc:fc86:5f76 with SMTP id
 z40-20020a509e2b000000b004fcfc865f76mr450020ede.6.1680643031003; Tue, 04 Apr
 2023 14:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com>
 <20230327072641.3591802-1-geert@linux-m68k.org> <eb55ca34-ca71-ed19-dae2-6e5e87c170@linux-m68k.org>
In-Reply-To: <eb55ca34-ca71-ed19-dae2-6e5e87c170@linux-m68k.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 4 Apr 2023 22:16:35 +0100
Message-ID: <CADVatmNHYar6tR3r9q42vZR5fsqZeeDb8LEmmBcrrOwhA7HpmQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.3-rc4
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 at 08:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, 27 Mar 2023, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.3-rc4[1] to v6.3-rc3[3], the summaries are:
> >  - build errors: +9/-1
>
>    + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45
>
> sh4-gcc11/sh-allmodconfig
> seen before
>
>    + error: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>    + error: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>    + error: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>    + error: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>    + error: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>    + error: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>    + error: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>    + error: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>
> sparc64-gcc11/sparc-allmodconfig
> seen before

Tried sparc64 allmodconfig with gcc-11 and did not see the parport
errors with 6ab608fe852b ("Merge tag 'for-6.3-rc4-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux").
Is it still being seen?

-- 
Regards
Sudip
