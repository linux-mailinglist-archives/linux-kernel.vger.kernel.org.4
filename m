Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A496C1A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjCTPsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjCTPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:47:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C0AC662
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:39:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so48314148edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679326798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjfBd8LURFBkQCdmjFasI4BK9MyPMfZVc7ZkAGHyr88=;
        b=cuC3vyLjdxS4aJOpnFsyjzb1G4OFCfk1JCOE0a/2IgM+a2rkfQ79ipGDHj14qaNG5Q
         tRhYTA9pP5eDgwpb8xSUm32EA3fQPjAN7V1MG7UU+SXOksLA2TZYnhSjKV4dnn46RNyy
         Yd5PtN23/77DR8v3yNA8UR6rX8B5hg6F84Zu/XDk9ii893U3PH943WfW+zatpgn0PQcR
         WaFNBvP29dYRAFIxjANDty+1HtEP/NpYMM4T4mMQSdU625fZjVSvzRsusK/VCRYj9E04
         5+wZwnI4QQp2hCajwTfBZlk+9lC0nRvqzdV96GnI16QXvfbTmMYICejnUHJaZnslGlHe
         a4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjfBd8LURFBkQCdmjFasI4BK9MyPMfZVc7ZkAGHyr88=;
        b=hg8CWopV+mZtYDhxBtGNjyCZS77170ZNxj5Xm5+0MprWUMAjfKVqcvjxG8VhnTpQqE
         RIxygxU2E5rKCZV8U3/JPxmncR+06yaAQTvtJvPVaPxp2sgcO1xEZg8k3S7yl6uv2wo2
         mRaejJP9u8eKWr9dVnDiTzl1O0fzB11/hr/zpcZJVHIjDb6Fazh5tcT/QiaN/kdQ611t
         1j44gmnZY49V6pg9uzw6tzRYXhas5EpQYFHibw0uAOWVI2e9ga83/rDutgLFT2VqPZVl
         xxVr+VqBBhbYoYuKYj9BrIVDLW5v36YQI8YlJh2C6lIHZVxKFxJUaiIWR1SyfZdh53/V
         ZfQg==
X-Gm-Message-State: AO0yUKUfRDVU/KYpSHq0zJ9f9Yqr7JHQlOdb/fPmqZzG/zr8pFBT2u2f
        Jt+LQxROnY3tC/v9bmKuVRGKmKdUd3geMi27RI0=
X-Google-Smtp-Source: AK7set/cQBOAzSg9oecwjRF7YkwtVtmfSxm23V2lUrmLZDrszp1xZ1Wb1UUB49bxl+AyY283GL+7LtnaTaMovp6OuMQ=
X-Received: by 2002:a17:906:95c6:b0:92f:41e4:e48b with SMTP id
 n6-20020a17090695c600b0092f41e4e48bmr3950471ejy.6.1679326797634; Mon, 20 Mar
 2023 08:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <d846047f-b714-3fd1-d8c6-9f774902fb9f@gmail.com> <6dbdf458-9f46-613e-de58-b4a56a6cdd9f@gmail.com>
In-Reply-To: <6dbdf458-9f46-613e-de58-b4a56a6cdd9f@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 Mar 2023 16:39:46 +0100
Message-ID: <CAFBinCBHLEAJo8r8kKU-Tou0esM0J=dnh-RO5heO+O9w0jRS5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] base: soc: populate machine name in
 soc_device_register if empty
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 1:37=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
[...]
> +static void soc_device_get_machine(struct soc_device_attribute *soc_dev_=
attr)
> +{
> +       struct device_node *np;
> +
> +       if (soc_dev_attr->machine)
> +               return;
> +
> +       np =3D of_find_node_by_path("/");
> +       of_property_read_string(np, "model", &soc_dev_attr->machine);
> +       of_node_put(np);
At first I thought there's a problem with non-OF machines here.
But if CONFIG_OF is disabled the code above is a no-op because we're
not checking any error/return codes.

So this gets my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
