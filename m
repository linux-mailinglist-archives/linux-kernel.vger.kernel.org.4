Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CCC652580
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiLTRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLTRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:23:03 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470551869E;
        Tue, 20 Dec 2022 09:23:02 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1445ca00781so16198893fac.1;
        Tue, 20 Dec 2022 09:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m759R3NNJtMIrV9Yundq41ukEnmCHJ740TTiiogoDM=;
        b=RrayoGatYQwyU7x2ZYod3NbCY+8W0zVMIIVtqpqtqCFDYHdZvvCLVwG6YPYCs6l6Lu
         S6d35DInK19D/uAfiBYHrJqyIq3jIM7OSb8aulUoLuCOfJ6ScFteDbr9enmU+9dOgsCS
         lNQIILp3pJnocS8A9iDLTeUVhOpUrJ7n9OIPaIWS9lVo/PbVA6oVsp2JotF0VVlru/jw
         gcoxDf+E+MimfyW+1vp+OHuAxXLRbwdLtTEYG9mkHCSSwbyuMlw/1IN0CDkIId0iVDvi
         8qElgAK+qgd14ni+SrsMULplOygQJ4SFfshWXRU9aXkISSFsBAZMfTzDN9slnneMw6bS
         RNYw==
X-Gm-Message-State: AFqh2kqfG+ms/ichTjAwkyNlUGNndDA9deQsgDwRx/r9NoeUbOuQPKnb
        ua7wzwqwzLMA0/yyjuOZcA==
X-Google-Smtp-Source: AMrXdXsO8yqVRg7avcaopThhKulTDE9MWTEUA6xsuEbVm364CmV8ytfwd7JYTHsN4QCxJtQ+X6Zyrg==
X-Received: by 2002:a05:6870:e08:b0:14c:6a72:dd31 with SMTP id mp8-20020a0568700e0800b0014c6a72dd31mr639642oab.18.1671556981556;
        Tue, 20 Dec 2022 09:23:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l44-20020a05687106ac00b0013bc95650c8sm6216885oao.54.2022.12.20.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:23:00 -0800 (PST)
Received: (nullmailer pid 774015 invoked by uid 1000);
        Tue, 20 Dec 2022 17:22:59 -0000
Date:   Tue, 20 Dec 2022 11:22:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: display: bridge: it66121: Add
 compatible string for IT6610
Message-ID: <20221220172259.GA768859-robh@kernel.org>
References: <20221214125821.12489-1-paul@crapouillou.net>
 <20221214125821.12489-2-paul@crapouillou.net>
 <CAG3jFytgK0noWteGvXTdSm9as9Q=qfhf_ep3Z8Wv2ofmLzGb=A@mail.gmail.com>
 <c78e92ae3cbea037abdd31ecd64e997c8dd1def2.camel@crapouillou.net>
 <bb2b5b72-42b3-3a6c-d865-9e338e34aba0@linaro.org>
 <d1f6d19d3218d9f1acc9b38e44af413f72f8a824.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1f6d19d3218d9f1acc9b38e44af413f72f8a824.camel@crapouillou.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 01:21:54PM +0100, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le vendredi 16 décembre 2022 à 12:21 +0100, Krzysztof Kozlowski a
> écrit :
> > On 16/12/2022 11:46, Paul Cercueil wrote:
> > 
> > > > >  properties:
> > > > >    compatible:
> > > > > -    const: ite,it66121
> > > > > +    enum:
> > > > > +      - ite,it66121
> > > > > +      - ite,it6610
> > 
> > These should be ordered alphabetically. What's with the tendency of
> > adding always to the end?
> 
> I'm too used to the "inverse christmas tree" sort :)

Come on, the DT standard is sideways christmas tree. ;)

Rob
