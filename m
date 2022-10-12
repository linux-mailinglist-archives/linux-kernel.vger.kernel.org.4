Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D6D5FC772
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJLOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJLOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:34:36 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9A2BA;
        Wed, 12 Oct 2022 07:34:35 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id bk15so26497355wrb.13;
        Wed, 12 Oct 2022 07:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tor9Al5zKFy4H384gqWBoxXv/hFxksivsNXjuDpRGaw=;
        b=LsbsHdymJCHIUtf60MxaFEX1GSTr4ush2srZ/CG9mouefD1Nf+tTZQTX0aNsy7FeqY
         XtqhwA1xqSGsW275W/C8v8Tg8SwMa1oBvz4sspcAD06ec/HcbHeUfCLvDBe7zyGeI8Mf
         9oRWM2jYZf6FuLuld2k1khEj0sPdCvZvHoVOOo1DWfyGSe/9Sd+tjCKzTPpgQlep1weH
         sxVGzpbSs6v+9s9xfxowxwJ3XfRjgBm7RAPj1nOw4J4V06d+mREK8Q3EVaNjmBBs1Sw/
         uKRU62EDduTOcrJYHvd7dF9jfMUMSe9NVL2ImHiS7qsG7bRHQ11JgpruoTYQYHsbrsv3
         Ebrg==
X-Gm-Message-State: ACrzQf0zueQ8ADethoUhXArzYKEuhbkfnuy/lb98YZKfjJ1A1UmfzBvP
        raWjbeWXzEvoRLohATwJEiW9EYUJ+Os8WiR5ZKw=
X-Google-Smtp-Source: AMsMyM5q7nOEeGxpb90r8BpgH/goefH7ZF9xFGoX3X6IYwsHHjbU0d+LCLtmUkdkv+x2O6are+Nhuj0nkQQUrEbM4n4=
X-Received: by 2002:a05:6000:801:b0:230:45ad:fba6 with SMTP id
 bt1-20020a056000080100b0023045adfba6mr11248444wrb.514.1665585274073; Wed, 12
 Oct 2022 07:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221012142733.32420-1-quic_youghand@quicinc.com>
In-Reply-To: <20221012142733.32420-1-quic_youghand@quicinc.com>
From:   Adrian Chadd <adrian@freebsd.org>
Date:   Wed, 12 Oct 2022 07:34:22 -0700
Message-ID: <CAJ-VmomqwxD4wnuz3GJDaXUV71s_4aexY+3xYcDhXSKgo-9Zng@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: ath10k: Delay the unmapping of the buffer
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Surely this should be a firmware fix/patch?



-adrian
