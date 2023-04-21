Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9716EA451
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDUHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDUHHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:07:32 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BBC7DBC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:07:29 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7721f36a69bso434502241.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682060848; x=1684652848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSYmFIBvo/39//HYsPHxDg04iiAQgWsffOlw6b/gJqc=;
        b=MSuKI7etY84g7qPA6Ywqcgqm89D6KVhjjgiAsSocKkQSQSFdYhnYHtJ0dMfO2sswY8
         yEAldvBimU9hLPOTZALoxeIWDfKszFJN4t2z3OSHPX4c5z4jD27y4UDG8XdekTUjEKGV
         9GzeLmCMTLHjYQ7YtEL8aA0Jtb4dAX8Do+TPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682060848; x=1684652848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSYmFIBvo/39//HYsPHxDg04iiAQgWsffOlw6b/gJqc=;
        b=LStYa7a9gB8IOv/RNVtnZiTFhJcWkjaZEJVkOv60nKPm6BLbWh78XklutmM6sDvJBw
         1D3UAnczgv1pxEXO2//FTSRzjCDSCtOuqedjvuEzoG8qV2EYnySVNKZxmfnp5I7GneVd
         0CNyjt3/KQuS1OsB7RC9nvuu6XHmcpEHlj+qX6HHPg5A8MD6/X2dF5B/SmcDQZOYUXQy
         32RdNZi8z+5phAgCAaMmNzNMJ7/o8ZeFpNdMlsdhAAmE3awo76WCvJxaILlDOb9fyAus
         3gw14C9jEK+W5BqqsqdrgmH1ShcTFpPjEkhhQJ3pxE724gNPbWTdr33bEYxD+Jhc4TWD
         YdtA==
X-Gm-Message-State: AAQBX9dKZE8MwWcp7fnb30yhi6MvzLJLejh394CT06Nfdcxzn57MXoTf
        Peaw/1Wn01uAzNj/lkyf7ixjQEn2n56qhileDwrhwA==
X-Google-Smtp-Source: AKy350acAl/SE2HRNGSc35n0Xobw7Q6eRphLA9qWh3FvDA1yrtZsodgQn6llJUsD9hRFeXzrI4cIXFlpeq/s5aOrZfI=
X-Received: by 2002:a67:b10b:0:b0:42c:79a7:f2ed with SMTP id
 w11-20020a67b10b000000b0042c79a7f2edmr2164074vsl.34.1682060848155; Fri, 21
 Apr 2023 00:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com> <20230420094433.42794-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230420094433.42794-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 21 Apr 2023 15:07:17 +0800
Message-ID: <CAGXv+5Fiqpzn-M2yEGSETCyReGJRnTk45wrOyNBi9k=qymOW1Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: mediatek: cherry: Enable PCI-Express
 ports for WiFi
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On the Cherry platform, a MT7621 WiFi+Bluetooth combo is connected
> over PCI-Express (for WiFi) and USB (for BT): enable the PCIe ports
> to enable enumerating this chip.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
