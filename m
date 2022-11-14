Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB22627D99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKNMVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiKNMVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:21:48 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AED23BED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:21:47 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id k67so11218531vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NQjGpKJwFRQldPMBS1RB9/2fjaTlWUG/ZVpaABszmJc=;
        b=P1f7QIuacrhH0W0S9PmNG41RFwe6iMnnxpQjvgBLQ/HAwp6q3DKo8XLjIhbAJJaCz5
         yv1wXH8hDKaHgMxl4SFJUFml8Ps6DrbptcfpPinJVytoM5cgZEtX1buD9yPCI+gEkhhu
         XyY5KqIrDRanfEWrQ84ThEWkIKKeSWaSIGT6rWr3cfgETe08juaZQIHyKhztMhnwwG/h
         4UMfN+LrfozjznQRE0etwAQUcny4/vXIncEJhoFoPk7xrrR39a0y1d3L94HUvquhggMV
         TmzICErbm1POBoqQts3rYCSkLlmsLKuC9f3YC2202YasmITLeV5dX/NapS1ItpCRnWul
         MK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQjGpKJwFRQldPMBS1RB9/2fjaTlWUG/ZVpaABszmJc=;
        b=Gy8Mx080IBE+E5/nt+hIcbVC3Z+w9n56/G+vuMYsnmhVP3rEplFuXE8XMatGEBwr2C
         chX7XjubpBIav1MjxR38O6IR7zVocPKkpwYB0wv8URYDGZrb8iYJlwV0UPsSW0IXTPoA
         JnoBdazRma2wYjoRQ5sVeUi0k9eEPUSxPHkbQid/xNcVjEOzm0/ADhD+dtmSEyfgfmTP
         EoDN9JsFHpLiBq1wUsXtFwXIN+0piZUwh40G59kXhxmrAB1UpgFWVAMOvqCZBR6yfuFs
         uEC4uz0VPxPdqdEJu9lXe+eWFBwyrZQYJGi3U9PfUETGjq/9Hs7ybuNPvj+uDzrpq1L6
         +0hw==
X-Gm-Message-State: ANoB5pkBOtVPxYRT1QBXtgQ9aNvHsBjWD9RVnpjPhd72mFe67jQs1Y4L
        iuvc1vVsEjgl5M+eDmeeKkBgRFATsOWQ3Ie3KX3W/UxTjCY=
X-Google-Smtp-Source: AA0mqf69sum61rEy9cOqRqF9p5n/5Fica+46LF0sBPSO5L3Z3yaJ+IpRZ4xX3zIAoF5RBikKxZGRbOcX5kxjKx0wNXA=
X-Received: by 2002:a67:6b03:0:b0:398:6504:9ece with SMTP id
 g3-20020a676b03000000b0039865049ecemr5734945vsc.16.1668428506317; Mon, 14 Nov
 2022 04:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20221114085659.847611-1-miquel.raynal@bootlin.com> <20221114085659.847611-3-miquel.raynal@bootlin.com>
In-Reply-To: <20221114085659.847611-3-miquel.raynal@bootlin.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Nov 2022 13:21:35 +0100
Message-ID: <CAMRc=MetoyeD3neFo1yg128NYgDEAfvji+1FqNEym6BEHpFtOw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: eeprom: Inherit from nvmem.yaml
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 9:57 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> EEPROMs can be nvmem providers. Let's make all EEPROM bindings
> reference nvmem.yaml as they should, so that nvmem cells and layout
> parsers can be safely described within the EEPROM nodes.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
