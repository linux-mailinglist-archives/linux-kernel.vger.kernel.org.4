Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7286D1CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjCaJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCaJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:48:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42B20331
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:47:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x3so87263111edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680256027;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqGpnxzWplzffE6Th9lsSK73X294LhiCIk+YQ6eCW7g=;
        b=qHAPLJcQgNA3lXe+/G8cSRt+pLL+rIMnefFO4TB5+4y3aupxPG6wuVnqp8ovBKFSVE
         DU/nAph7ZX4X1gmpFj0iDjI4xTFGL/y20FSeeA2Xj8vnZa0o5aU1zjgt7NEJnjZAg1E2
         tbVeoE4dWuuKA6ALPta762/Sx7pLMdqQCWoxEx/oiFkczasqRbrfqKyuN8vWGmYhGLGn
         VO3DxmtclVbP/I8iVhQYXDB1ePFlC6aJWJYosAU8Hk7C54QqrOLSQYLL0jrMbSwYutM9
         /Prtnrj9NB+wdw3hGfyIHh6lmHasYvg0aIas1jmCunksusl+FoovjH/Y7q2GKtg7Ottk
         6U6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256027;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqGpnxzWplzffE6Th9lsSK73X294LhiCIk+YQ6eCW7g=;
        b=JD29/gwqYsxRP67odu2q96YNhTQ+1WLd/+SmK+128c7tXaGEZ45BOX9+IN9Tg0udGd
         WDhANw59oyFmYDCGZ6v0UDy5bkAzJIY/DSpUB/fyH+h/O7ASh+BJKVQ7+gpaHDVmLm9M
         JH6s78Szn3pw1n/ZoYO9hZ+KnSiJpBSjRFEUMIVz1jMqtcj1rto1VvzNvpj/Zzo2opNN
         LCNAZJ7TgTCseVI/fCQNzFECfi7YX8p9Me5ZcOqySOwg5ARIgg4FBG0SDAgC2K+8dsYm
         FjcQCg/c+1w39CyOOpWFYTo2i4VldRBA2kUia91EGdEPfyB5Z+JlsDKuvlkT8jlRBGd1
         vS/g==
X-Gm-Message-State: AAQBX9c6h580XUx2ba6EV1MTyDH0rJClj/qO22cVe4N/QH2fACc6gxws
        AEgg1T7egIAXVB71P/HU6/lNlt2RynIo1oUv34E=
X-Google-Smtp-Source: AKy350ZctqnY7YXp9BjKd26KtcaeLLk2YEhxFz2aCSIKky1UWIBAUlYh3pDdyu2fE6oN9qmjs20SKl3re6YnfjrjS70=
X-Received: by 2002:a17:907:720e:b0:947:46e0:9e51 with SMTP id
 dr14-20020a170907720e00b0094746e09e51mr2778570ejc.11.1680256027298; Fri, 31
 Mar 2023 02:47:07 -0700 (PDT)
MIME-Version: 1.0
Sender: dijevab@gmail.com
Received: by 2002:a17:907:2d09:b0:929:487d:f552 with HTTP; Fri, 31 Mar 2023
 02:47:06 -0700 (PDT)
From:   Mrs Aisha Al-Qaddafi <mrsaishag16@gmail.com>
Date:   Fri, 31 Mar 2023 09:47:06 +0000
X-Google-Sender-Auth: Y8udftG3rLO3gQd7OlpuTx3kKUc
Message-ID: <CAMkvHsvhU9aEGUWbSvZuHNYpL9xaqj3EFkEB18nMmg8oO1K6Kg@mail.gmail.com>
Subject: Can I trust you My beloved One, I need your assistance.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the name of Allah the Merciful,Peace be upon you and God's mercy
and blessings be upon you
Please bear with me. I am writing this letter to you with tears and
sorrow from my heart.
I am sending this message to you from where i am now, Aisha Ghaddafi
is my name, I am presently living here,i am a Widow and single Mother
with three Children, the only biological Daughter of late Libyan
President (Late Colonel Muammar Ghaddafi) and presently I am under
political asylum protection by the government of this country.

I have funds worth $27.500.000.00 US Dollars "Twenty Seven Million
Five Hundred Thousand United State Dollars" which I want to entrust to
you for investment project assistance in your country.

Kindly reply urgently for more details.
Yours Truly
Aisha
