Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7845F8CAD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJIRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJIRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:49:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD9ED46
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 10:49:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sc25so14635950ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZejLgz2KhY9qLr7ifuLCXoUfoCiZZhSwHm/qMEzGqc=;
        b=lJdQtW8Cft4FLGQkC30bXvrSKFFr1T9Otds+XTl7N/Hrg7APAuLUINc28ugYpC9xqb
         XKoS1UnYh63VInfYA3m/Ul6fr1pFicO+7BlQaVDYAlC6g5LeJ+jIAK/JhgJQP9T1QcGV
         z8PoWxIzH1lTqJiJcCj+ZzSORIRrONGS7LIV/REAfR0ozq9s2FrGQja7v6nCaGYcUDJF
         k7dtHbXF+VjIsfNHAB+wlnmVTE4IVXn5BaLrygrC64shw2cqQcysxNH+hd2By0zaJiNC
         WkPGkC23Uw1ovjOl+vkJJ/Hnrggh23ZZqWisd2RzNp5nOGc2MnRG3stAycDjCBfTGOcN
         0KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZejLgz2KhY9qLr7ifuLCXoUfoCiZZhSwHm/qMEzGqc=;
        b=pns/F0x5N+L/siU51stUGRq6W9f1SVrfEvhN5yDPsl0Vj/Eua/QtiIcT89NqsgFm0v
         D94fU4xyEQ22rT1sECzHyE+DkJWqRaY6B6XpXvzI/gjPeaBLYjy7jIqGYgJftkW+Ctm5
         WH8iOMAHywgCJn+AAd9PbOrr1URRvnT+J9SiJpjZxhGH38UJv0rLUStyM0khmfMxNn8x
         W8H4YuycKuPyCmRWRfAJOydGxrXB6Ral7cXQ1XUHP3PdsEddRlDGkflmuXpCtwFlZB4M
         XMV/GtmmSz+IK7nuOL+GsrXWdZVkOXGlhN7cVAWdB2YloX1Tzsf8PlIQrXIrkYTMQgAe
         6Low==
X-Gm-Message-State: ACrzQf3GRv3bci171yWVzgJDGchKB7Hsz+rTLUjWwJwEN/dfNUJxy/RG
        yiMqCJ/NHU8N+aob1I/qsUt5lklyTvs=
X-Google-Smtp-Source: AMsMyM69T9Sm1c3Oc3V3smOQxTUTnJHlN6nIA2lMu6COU5Ee5zNy51hO2/yOm9YfryUSNG+rypjMWw==
X-Received: by 2002:a17:907:2cea:b0:78d:4e84:778d with SMTP id hz10-20020a1709072cea00b0078d4e84778dmr11011773ejc.246.1665337780002;
        Sun, 09 Oct 2022 10:49:40 -0700 (PDT)
Received: from nam-dell ([131.155.245.44])
        by smtp.gmail.com with ESMTPSA id bo1-20020a170906d04100b0077b2b0563f4sm4248453ejb.173.2022.10.09.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 10:49:39 -0700 (PDT)
Date:   Sun, 9 Oct 2022 19:49:25 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Rui Li <me@lirui.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: remove necessary braces for single
 statement blocks
Message-ID: <20221009174925.GA17573@nam-dell>
References: <166532561205.8.1223417525390189864.67805880@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166532561205.8.1223417525390189864.67805880@lirui.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 10:26:31PM +0800, Rui Li wrote:
> This commit cleans up checkpatch warning as follows:
> braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  3 +--
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  9 +++------
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 12 ++++--------
>  3 files changed, 8 insertions(+), 16 deletions(-)

Greg expects a change log describing what has changed compared to the
last version. You should send a v3 with a changelog.

Additionally, did you mean "unnecessary" in the title?

Best regards,
Nam
