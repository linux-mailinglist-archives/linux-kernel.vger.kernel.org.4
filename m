Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0A62BAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiKPLGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiKPLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:05:44 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F734C254
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:52:20 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g127so20487502ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoRuKDvRtfqyxGXCloGQzrbnsQ9lUzIfiyzXfdm3sb0=;
        b=EQyRpq6xCb5QSFzpsfric99YN0ZsQ9Us/A8yUiBkDqeQa69Af3/Ws27dLusUvjCwVj
         lbPyWiX1rvCAeMXcEEj4sEH6wrFNffdMYIdk2jECYf+YzbvKgO3U5Jnfk0GDyPsAE+5j
         tbjbxhTXMGVfynN1opiPyTSjpthCHKwA/QuuA+i+y7BR/F+kOX6qc9UAlhTF+ciu709T
         15Z+YPwKtf1oMMZoKOyoc/VYzbsqssNVw/cvMQ3LpYu4n+DJB1E/BAgqD2ULpPPlbmGG
         QCWzrdyTxoLggYsxp/93kgxKxabb6kmRrlGn1qUBhr+tEAMLVzJfHZ72sCrNvgEkW5kR
         kdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoRuKDvRtfqyxGXCloGQzrbnsQ9lUzIfiyzXfdm3sb0=;
        b=Z7uhTZ2H6B8ybgj0ar+yp8HwL/gb5hFMu/iUjEs1UwU8We7Na7mON/S3hwx3adgDAQ
         Tm7x2wjjXgvrpLe+cM2CL7fRHoTLDzaCZr7nJE08zifUMPE+u2yNWaEEx1tuekGeTJwc
         KSDhTAshUl9h1ZN5+p1hC7T2Hx5d9YodfnOxDhPPe8dxkWgNKoh3oYYGJ0grPX0EE2fI
         LmRIW2pHcuHllwYNlMDEcMlUqAYxdtFY8e9QHRwcFReOnztUlO70pDkMhkQjf0gRBbQM
         ktdeqypwIr0we0tkn5bX4rB4++xOOQDnka3O3SEAs0VkL85AyyzyepGCnGcg+jTH1UEZ
         MgSA==
X-Gm-Message-State: ANoB5pm+ZGf9go3iT6WVjvANmdH+75Vuf2ZeF+LPx1KotCCiBaeD9FUs
        Ry/UGvU6dbB6+xZi46emyEAosvM5JCwa8tUEpDDYxQ==
X-Google-Smtp-Source: AA0mqf670K8oXK4BKY3rGd4/pry5UiYhbONNHWXWMaIp6wf/HClXcTpOxNUWLRinurA/uSVisGW1IKI3bgfLq1d+9gU=
X-Received: by 2002:a25:828a:0:b0:6cf:cfa9:94e9 with SMTP id
 r10-20020a25828a000000b006cfcfa994e9mr21818067ybk.35.1668595939679; Wed, 16
 Nov 2022 02:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20221108181144.433087-1-nfrayer@baylibre.com> <20221108181144.433087-5-nfrayer@baylibre.com>
 <575fa0c61cb55845c4d3a646d0b1f48d782588a0.camel@redhat.com>
In-Reply-To: <575fa0c61cb55845c4d3a646d0b1f48d782588a0.camel@redhat.com>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Wed, 16 Nov 2022 11:52:08 +0100
Message-ID: <CANyCTtRCY3_DUDbwHUt39toeUtUJDMQmV4Q9bxz+enyJkY5OWg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] net: ethernet: ti: davinci_mdio: Deferring probe
 when soc_device_match() returns NULL
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peter.ujfalusi@gmail.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        grygorii.strashko@ti.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, khilman@baylibre.com, glaroque@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 10 nov. 2022 =C3=A0 12:21, Paolo Abeni <pabeni@redhat.com> a =C3=A9=
crit :
>
> Hello,
>
> On Tue, 2022-11-08 at 19:11 +0100, Nicolas Frayer wrote:
> > When the k3 socinfo driver is built as a module, there is a possibility
> > that it will probe after the davinci mdio driver. By deferring the mdio
> > probe we allow the k3 socinfo to probe and register the
> > soc_device_attribute structure needed by the mdio driver.
> >
> > Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
>
> I guess this one will go via the arm tree, right?
>
> I'm dropping it from the netdev PW.
>
> Thanks,
>
> Paolo
>
Hello Paolo,

I will resend this series as individual patches, so can you please
apply this mdio patch individually as it's independent from the others ?

Thanks,

Nicolas
