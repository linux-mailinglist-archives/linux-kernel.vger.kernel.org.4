Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B6656E53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiL0T20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiL0T2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:28:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E3A2A0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:28:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id t2so14068854ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F3yGec1v/pAZdlsdz4KptKUFtToX+P4HKect6tvS0bM=;
        b=eZBHoAftWthVp/W6i1eY7oWJRD71Y9IPWPP49BSMuDdLH48aPJpqXUHhnHjcQ3vxWA
         ZElU5SN+QVdH4rtn71R3XmF1NZb/hHZiRp4vSIr57NzmfzKvfF2CpsWiOmID82+AKp6Y
         WoFCh9ct+g0Kcltcu1FrAU32Xw5daqNdSiPPaPVWMqdfsM5TWGAuWgvIEOl4KvauhwWS
         VBWOYYOLzHxRJd+P24Npz/HegJMC3wwrVJR3mkGFj1Zc1ovw21WVJ5h5BEBd0orRN8S5
         JZdt7pjgX64uGwkPxT0pUtDPeh4DIwUJB+37rVEhy4erYpHB99SzJTCDyNADiLzEMlX6
         kzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3yGec1v/pAZdlsdz4KptKUFtToX+P4HKect6tvS0bM=;
        b=EvmAnODUtmoy4grWVQ7/qmRdyv8CILEdd2MHWkCoL+46F+CGUaiqwHvaD8zeezuGEL
         Xa5jgu+TD9wZ2ajC/0YPcSTNVZODDwjeWj2TA59zpBH3zMP1ycM75Nim4EAN7Mj1E+nn
         1p0/BF7udP5ZW5J2CUMnZErlPcQfs2l/krcI9YdHvTMNZ/NCcvBeiPqcu7yDH02pepI+
         ARTqyuuH7azyFNqvdLpq8ON8ZFMdHS1h34hLPbVfshX99SNovrM2Kb2t8yAzscMUN3O9
         QbB2aYBfnGNyRcetz0VcvUDrxTv/eHxlNDrXEpsNLiwhgvihxlZjDx7yB053lLVKB+oC
         skUg==
X-Gm-Message-State: AFqh2koN+OC50muU0weJJpeYDdRGT4V2NWAmCOb1WOIzXOSupDDcILU1
        e0oEt2bc3dxkgotMPXDXcdulB7yYEOyRN0qEhlPZaQ==
X-Google-Smtp-Source: AMrXdXsOvBld3xBN5qjRM49UlgQSR/vTb5qkj6SsVg9Om1xjMhqlnlFj5FBPS6mSldhVyUhf3qbUFTbJ4PIqwLf2jHQ=
X-Received: by 2002:a17:902:7089:b0:189:9cfd:be76 with SMTP id
 z9-20020a170902708900b001899cfdbe76mr1390560plk.21.1672169301016; Tue, 27 Dec
 2022 11:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20221227110335.2923359-1-javierm@redhat.com> <20221227110335.2923359-2-javierm@redhat.com>
 <CAMty3ZAaHKJ21D8mE=HU3D3KOGAiZ7vfmW_Hgc-E5JO5S+tMNA@mail.gmail.com>
In-Reply-To: <CAMty3ZAaHKJ21D8mE=HU3D3KOGAiZ7vfmW_Hgc-E5JO5S+tMNA@mail.gmail.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Tue, 27 Dec 2022 20:28:09 +0100
Message-ID: <CABxcv=kwtk21UbOwaV4tq=BpPsrYmnTrzuhybjbknipqk5R-fA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: Add Himax HX8394 panel controller
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        devicetree@vger.kernel.org, Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Neal Gompa <ngompa13@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Martijn Braam <martijn@brixit.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
        Peter Robinson <pbrobinson@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jagan,

On Tue, Dec 27, 2022 at 7:16 PM Jagan Teki <jagan@amarulasolutions.com> wrote:

[...]

> > +allOf:
> > +  - $ref: panel-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      # HannStar HSD060BHW4 5.99" 720x1440 TFT LCD panel
> > +      - hannstar,hsd060bhw4
>
> Parent controller can have a compatible where the associated panels
> will be enum list.
>

I'm not sure to follow what you meant. Could you please elaborate?

Best regards,
Javier
