Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8907C6FE356
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjEJRkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjEJRjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:39:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788AB468E;
        Wed, 10 May 2023 10:39:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so10520425e9.0;
        Wed, 10 May 2023 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683740383; x=1686332383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KqxPzDXgXdJ+A/E42EU+WNg4JndxRLg1TSWxQty68Dw=;
        b=Va5ePUCsUNIPz0ClUeX/F4iuYUSLsuIcytSFzpqYA1xqPz/cuBBP+udw6cGfExC1jb
         s1dlw85OBNBXY78WqAco608YLMCywZ6xzpa4r+79M89ACwvNrkXVYlrY2kM8HvVpf/ZK
         r4bLnAinTjjc/DMmdd8q2xTICQV3CuFOuqUkra7mPn9WllyZTXPhjVpRzWF2DtutWKYi
         4Sq66nW+gcHHogulxQnMCY09Q/XX/4sBcEzrgzpOX2s+VZAlqIeJCFqIw+zNhCmPgFgo
         +2xm+12Xv6uMXyUPnUszpwn/HZzLdjxZOWp3P2skwZ+nWbU71fcHO3JEPVl0qZu42AdI
         SvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683740383; x=1686332383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqxPzDXgXdJ+A/E42EU+WNg4JndxRLg1TSWxQty68Dw=;
        b=Y5VcAC/7TeBVMShFmQdJsNuVwVCIaKIZNdrLNZpsz9jhO1vvo127ma0SG0XOT0KbB5
         n7B/hqkNW71V8ThEhNkHCxyIAY75WYOcgvEL3XQwkyeb0qofJyLEh8+9gHH6huH+Af8+
         PkBaUpexPvLoQJ0guXTVBYW4SVBWkZmWyNcE0+BUY+WVvI5eytSVJ1Ha60ytQ2RrXl9T
         BgQlUPdUoklrmgtRBYGkiiiTtYYlFtICRfZPkL9tl7mN28fPdWEuTShP2UEyFPQRkA+v
         ZHrIvlUPJZ7Gn9O3Fdg8P96U1p9EAVr8RQYSW+ihBUfQ9DwTCQyQAq6lq8uEV9LRmF4o
         DOAQ==
X-Gm-Message-State: AC+VfDzxUzLqFl/+GwZzLHvaI0jng8XdfxWA+LObD0UZpOx5TXcvyBdE
        /Na7f+STz1VN4x1ZmCi3B7s=
X-Google-Smtp-Source: ACHHUZ4nRspDgDYA0xiP8LjY0SQAypftYEtCae8akp2CgHsYDiy/co1nMyb1nNjWf3ZBb/BpPkeNCQ==
X-Received: by 2002:a05:600c:2904:b0:3f4:2c21:b52c with SMTP id i4-20020a05600c290400b003f42c21b52cmr4692823wmd.39.1683740382828;
        Wed, 10 May 2023 10:39:42 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:7251:37be:dc31:d566? ([2a02:168:6806:0:7251:37be:dc31:d566])
        by smtp.gmail.com with ESMTPSA id l11-20020adfe58b000000b002f22c44e974sm17941316wrm.102.2023.05.10.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 10:39:42 -0700 (PDT)
Message-ID: <0d3c3938dbd255e21f40884408076fd24222211a.camel@gmail.com>
Subject: Re: [PATCH v1] usb: xhci: plat: remove error log for failure to get
 usb-phy
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 10 May 2023 19:39:41 +0200
In-Reply-To: <20230510075129.28047-1-stanley_chang@realtek.com>
References: <20230510075129.28047-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-10 at 15:51 +0800, Stanley Chang wrote:
> Remove this log to avoid non-error conditions.
> If CONFIG_USB_PHY is disabled, the following error message appears:
> [=C2=A0=C2=A0=C2=A0 0.231609] xhci-hcd f10f0000.usb3: xhci_plat_probe get=
 usb3phy fail (ret=3D-6)
> [=C2=A0=C2=A0=C2=A0 0.239716] xhci-hcd f10f8000.usb3: xhci_plat_probe get=
 usb3phy fail (ret=3D-6)
> In this case, devm_usb_get_phy_by_phandle is declared static inline
> and returns -ENXIO.
>=20
> It is easy to pinpoint the failure to get the usb-phy using the debug
> log in drivers/usb/phy/phy.c. Therefore, it can be removed.
>=20
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>

Thanks, the false positives are now gone for those without CONFIG_USB_PHY.

Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>

