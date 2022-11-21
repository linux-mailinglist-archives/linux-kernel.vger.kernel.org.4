Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D749632DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiKUUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiKUUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:16:47 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D222554C7;
        Mon, 21 Nov 2022 12:16:46 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id s18so14901576ybe.10;
        Mon, 21 Nov 2022 12:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FVW9aBegDfMkBk8Q9elRswZpSQ3tb+rLUL186gLs0vo=;
        b=AqMgwrPBZmYckEL/wU9NJIjLGljzKV/sGjZ0/Ze72+Ff5PkKAJTflPWYYFuWA4idRX
         TKXlouoyu72TggdKNiT57oGAlRoH7qUS8u5JJY7tU/QOdpK9jUKZyYuDWodSmDAtO42J
         We2LGqDEvPv5TzdcgysoDqEoXR0xT1b4NvtPftcDwEFhyNjh9NxfjCWI+nazRoVvPVwa
         Vqsm1yspCV58jt8/Rcbv22gZVNst/k/ILH48LKRi/XRIeMXgdP2Wh9prgJWMLc18Fm4m
         RZf2CQQAglBI8rPctMrhAyKUoFtU4qBV7ZQ6Qheg39nXxr1E/rWv4tE/w6knwKfUp45z
         I5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVW9aBegDfMkBk8Q9elRswZpSQ3tb+rLUL186gLs0vo=;
        b=j6vbvZOxRy0RcWKlcGNSf9ICPBZuvvnYyavGS5o88Iy16m0ZmBqphMJozwcEb9qKq9
         TAJ0+49wroORofo6wDeYecwvQen3DU7kEAWHbODCVyPtyht3CWabDTFGTMaCOoXjHPP7
         dxqZHQU/32eMGt06KY5E/C98ufwwr4QiJapwM5HgDP0oBd0JdjDM/TVodJbrD5+DiSve
         Z2ASIEwBzXmO5CY+rC/3+2UEC37YenKoQeIbc9XKUQP49TURTl2tvIILClkHIyxmPIAA
         +bLalnJ06ChGKRWkYIhi6SZuE0K2WbuUUQms8QwBvz4MBIg8ubwdlZXYiVjHunqu3cYb
         cXDA==
X-Gm-Message-State: ANoB5pkGJxBRNlGxv0jIB3IJJ4XLfyNiO+MJm6HsF9hQa9N8JVEMsFda
        t8p0W2j/6W63N23cT91JNKfC7Iiu255QRuGMW84=
X-Google-Smtp-Source: AA0mqf64cnB3FZteXYIBUnwZxvYaaNspP8j6ltMPLR+6WC6swRVhwwfrd9TtTWMjTr4uSzvmzPXDkS6Ge5hyN1qNKxI=
X-Received: by 2002:a25:dbd3:0:b0:6cb:8949:fdbb with SMTP id
 g202-20020a25dbd3000000b006cb8949fdbbmr19004489ybf.328.1669061805428; Mon, 21
 Nov 2022 12:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20221121181626.149558-1-carlos.bilbao@amd.com> <20221121181626.149558-2-carlos.bilbao@amd.com>
In-Reply-To: <20221121181626.149558-2-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 21 Nov 2022 21:16:34 +0100
Message-ID: <CANiq72nxGJeqVJCKYFA6-vQeT8-SZsD7brOwwJPtj7uig+YreA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: Update maintainer of kernel-docs.rst
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, jm@goyeneche.es
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

On Mon, Nov 21, 2022 at 7:16 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> +and written by Juan-Mariano de Goyenche

Typo: Goyeneche

> +INDEX OF FURTHER KERNEL DOCUMENTATION
> +M:      Carlos Bilbao <carlos.bilbao@amd.com>
> +S:      Maintained
> +F:      Documentation/process/kernel-docs.rst

These should be tabs.

With those changes, it looks good to me! It would be ideal if
Juan-Mariano ack'd the patch here too.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
