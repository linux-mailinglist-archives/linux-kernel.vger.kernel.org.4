Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45236E70B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDSBVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDSBVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:21:13 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C21E5FD1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:21:11 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-187ec6a5504so924714fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681867270; x=1684459270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwHPeuRPnETS7J1gGG+x8FJe/TP2H/54Upfy2bsQ9qw=;
        b=qq2zMdT2dkBvxZf0m8fww9/ALWu4OeFEX+uDAv2YwGNASL0eg/YzOh8s85GWnPVzln
         o+EwGoqAyRR9ipSoJQ5hAlW33xgRAP6YnLSDTxbVlSEe7r3IyTRkRIpd0822aIMCf8Rz
         LiwTvE5b7IfCFpGs2h/VXgYEHgL/xnpXOWqoZbXHw9Y8itcuj00EpOI3GdVBN34Nhh9v
         pJQrV2gJ+4sSwCu1onWIjc0toqILeYoTdEDVS7EGR7KlJP8/VSuZ2ZcMkvhjPsCo7z8k
         aktVKLgWOCEvKkSRnn/QWWMZvvulB/xfBWzh96vSPqpKVYYE1i2uEP5oUZET+Rhi/0Zl
         E4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681867270; x=1684459270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwHPeuRPnETS7J1gGG+x8FJe/TP2H/54Upfy2bsQ9qw=;
        b=D7oHIpiiC9cmyuT0fvWM0iwZHN5y2iiq4OttQAxUhhNGQidxqt3VbEIK+ubzTlUxII
         j4KG3fKGcthhd1TNRpLpX/j4AX4EwNXAe/kToIuYO+7NJLjj5aWH1VH08mEgtVViTaIX
         yqoIbEzSqAeG6tTLFhp0jx9sM7H+iW58os0mSt5yQsOvbYza4vWs/PnknTMEvfgyg4nO
         8Gwfr/s/VcSRpPsba0UwI8C9Cwp4bI/PTyo9a1k5wfbUvAd4UHnbqNuCB0UcpcEjl+BJ
         7FXPIGHxjI3H7e55NVtysOqHNUSm4E/Px6bOWAu6al3cuktpPTBQOQwDYMXF9T13cguQ
         bSVg==
X-Gm-Message-State: AAQBX9f0wfEV9MM2X89TGmclZqY42tM0u4rIxhVtxckjunNH/RArecDu
        A+XWlmGUp8Qm6zrusfveaYj5sWtKn9RsVGSWQO0VRw==
X-Google-Smtp-Source: AKy350Y0POSinYjDSsb1g3q8aHg7C+2SmuUrhTSPsQAVX/CabzpgHmjJ3DTtmxg/p69WSsYw3PLJbGp5L2j7kvFe/QQ=
X-Received: by 2002:a05:6870:910a:b0:187:ffb1:d3ee with SMTP id
 o10-20020a056870910a00b00187ffb1d3eemr1747416oae.0.1681867270455; Tue, 18 Apr
 2023 18:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230417160151.1617256-1-shmuel.h@siklu.com>
In-Reply-To: <20230417160151.1617256-1-shmuel.h@siklu.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 19 Apr 2023 03:20:59 +0200
Message-ID: <CAPv3WKey+AXGvXwYTWA5R4ZROB5v0afDZVXr4cbPwS7O_WFh+Q@mail.gmail.com>
Subject: Re: net: mvpp2: tai: add extts support
To:     Shmuel Hazan <shmuel.h@siklu.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        horatiu.vultur@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shmuel,

pon., 17 kwi 2023 o 18:03 Shmuel Hazan <shmuel.h@siklu.com> napisa=C5=82(a)=
:
>
> This patch series adds support for PTP event capture on the Aramda
> 80x0/70x0. This feature is mainly used by tools linux ts2phc(3) in order
> to synchronize a timestamping unit (like the mvpp2's TAI) and a system
> DPLL on the same PCB.
>
> The patch series includes 3 patches: the second one implements the
> actual extts function.
>
>

Thank you for the patches. For v3, could you please generate a cover
letter and properly number all the patches? Please also list the
changes between the revisions.

What setup/tooling is required to verify the changes?

Best regards,
Marcin
