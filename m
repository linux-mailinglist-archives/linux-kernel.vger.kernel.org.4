Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1D643C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFFVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiLFFVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:21:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E764220CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:21:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n20so3647546ejh.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 21:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QB/Kh9ow3EUM5SHFp0aGSD+yTCIfG6WneTyXhljDwcU=;
        b=cLb6Cd+FzxmMBo5l6sociKfYtZBGwkTeAZ1XrvpVf7CMlG3syQ0X5HAVGBpM/xW0HG
         8JbUrfELxWbFR+Y7h/H54vmpQDTH3IkY9NYNtfOqmnlAZ3aqQNYPs+2LUvFfb30FUSxF
         +6CvDfn1nhW7noPzavmuJOda0RUYnCpovwhf77GKWi0PTToy6wQMFY8v0ap5ZMrcaSbE
         guG2bUZGW70sDtvW9wIi50u++lH3Nd+plbblxDGTpyyxjduDC7oufuu/edbAJa3/HlhU
         bie3Bv/LDaMEZZiVsO7lLSkdTbvBy4d1S4Ny1MsyZEhuQ+gb3vxyokWba+BgFW+619Cn
         HMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QB/Kh9ow3EUM5SHFp0aGSD+yTCIfG6WneTyXhljDwcU=;
        b=W6soCp1DEFAGNMq2DEBMV4br3CJq1Jata+RlI9ZnZ0HzTlkZ4f25QsF19jaXI9otRt
         rsOvx9zFXfDYFvRmKncyuzwiDDTuuZUtYjEhR6vvQXBPUC3PAqVRdhGyl4dPWcb8Xdhm
         SMVysdTzkkpMgGRc2Rzo5AXka22Ub0u2AKxqgf+lspTIX2yb6a5RUNqkbjYwtRhw+j2b
         eWV57MA9LuMNuwxaWYzKqZBNHxgW3qv6QDbPvQytzd6S0e/g6657bI/CPqwyQew9WxnX
         +Sseiqkww21swIzlS2uTmVhq9DNOZwmzea+wyGLu0KvIt5XEWSp6xteY5O4qUB2QOMG3
         Y5CQ==
X-Gm-Message-State: ANoB5pntcXUwc5/hBWGP20yDWG8ibprLvpvNJ9riWKi7UVhYahP9TFaD
        G58K33nJOIuZlgBXuwOStEDNvaBEw63KMwRwXXpfI620PRA=
X-Google-Smtp-Source: AA0mqf4TyFxEgOnjRjEYTXVnB10F/m6ypQcEjXlB4nOlh5ErlgqLlPdUUnEvoJSgnum/XZpK3qSEeoZEDfAGI7DubAw=
X-Received: by 2002:a17:906:2594:b0:7c0:8d06:33f8 with SMTP id
 m20-20020a170906259400b007c08d0633f8mr25750948ejb.150.1670304064581; Mon, 05
 Dec 2022 21:21:04 -0800 (PST)
MIME-Version: 1.0
References: <CAEYL+X_X7OsP3BQ3poK4n+DWEOxAais6d9At9nz2TzLFV2HinA@mail.gmail.com>
 <1716b73b-77f4-da8e-801f-7521872697bb@infradead.org> <CAEYL+X8KAg58c32LXL8ksfxnDvPPLwJwBRxMFdu6wB7HU+kXBQ@mail.gmail.com>
 <5c01fe50-a975-f866-87d1-0343ad2ae520@infradead.org>
In-Reply-To: <5c01fe50-a975-f866-87d1-0343ad2ae520@infradead.org>
From:   Zopolis0 <creatorsmithmdt@gmail.com>
Date:   Tue, 6 Dec 2022 16:20:55 +1100
Message-ID: <CAEYL+X8SuUvaEG-ouGdCUBpe5DS0j0rPw7XedtcCocn1ZJFX2A@mail.gmail.com>
Subject: Re: PATCH [1/2] gamecube/wii: graphic quantization registers driver (GQR)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
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

> Other (better) options are to use an email account/interface
> that does not corrupt whitespace OR use 'git send-email' (which
> does not require that you be using 'git').

Git send-email doesn't work with gmail anymore, and I've never had any
whitespace troubles with gmail inline patches in the past.
