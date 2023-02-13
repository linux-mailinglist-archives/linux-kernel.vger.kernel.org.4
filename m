Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C5694483
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjBMLaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjBML36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:29:58 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA435A1;
        Mon, 13 Feb 2023 03:29:57 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d2so11590957pjd.5;
        Mon, 13 Feb 2023 03:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMRBalgZt1NhHh8/Xj4aw6RZFRl8clPnr6APpPegkDM=;
        b=b6nIXh4NtKTVI7klAL8x/JZYRUQ9nCmCP3D/V3sGKRlJI5Vrxj9NWj+0WtcqtsozCK
         PB6SrNhDvcEfWMrW/+Z0pO9A3Enik17aM5yPyvVp2hSv3FEm86PhRTOXhgAiVd2MFd/5
         KH/pGJLqFxcS2CWs1BPuUNcwmm3Qifct73kfwMDtpJlYCgYRh7a7GXTAfoWw1kcd8r+B
         lEq35qAG8wsXgi+QNO4FgPTDy6Y/oUzzH0bjghJds60o88NyalrjVpfsj941lDPGzj7F
         p2sq4KXu001+jZWqOa9ZjGCZsDa1sq1uC9t3G1o6e6Ft9iClX2X2ozJ5enyDqd+CyGQ8
         ci0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMRBalgZt1NhHh8/Xj4aw6RZFRl8clPnr6APpPegkDM=;
        b=7IpwrpYJsEYrj2njZpDccdx3NPed/5rlHMK5IHGR5WxkBb5aq/v1A7QTVGfByAKaMA
         /GP6AkZQlKkw+jpgConEnn9nU7oLFe+dCSGHVUHXA8xcNgjxKRSMsu9jpKG3wIwR8ruB
         ZyfFbH6faK8kIZ3svNmj7Vccqi0ZRms6NS2e7Yn669nOBS/xBAXC8QOfL+TRGsX9xY4O
         t1afdcGtAx1wcxIlX6Dh4yJ8TSTYrQ0Tyn48vV184XkQVHBTJArgun0IizNzGx7a3ybF
         YVKsjzGjSW+1UD27TQUNte+8rwXcSlH3SYAmpUim5MaCdluzlDIvWFRykMMSfyf/YDWv
         BAuQ==
X-Gm-Message-State: AO0yUKVtO2HyPtwW6EL8g9VcW/VRNXJHUJcuxA5vGX0tE4Syna12SQNz
        M/kb2i5G3KrX4x+PXyGnlMU=
X-Google-Smtp-Source: AK7set99jyM6Gb47HIlRmf7V9ovJaH9x+Thw2GqdneoMwhS/APNGfF70ujPMMWpzvr1jMvle1JCtmQ==
X-Received: by 2002:a17:903:3015:b0:19a:8316:6b51 with SMTP id o21-20020a170903301500b0019a83166b51mr6026012pla.4.1676287796620;
        Mon, 13 Feb 2023 03:29:56 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903120300b00186c3afb49esm7956540plh.209.2023.02.13.03.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 03:29:56 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:29:48 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT36523
 bindings
Message-ID: <Y+ofLDV1nsQ/WUJs@Gentoo>
References: <20230210161925.32343-1-lujianhua000@gmail.com>
 <6cffa875-d8cc-a4fe-e18d-2e24c28a49d8@linaro.org>
 <Y+oZOXyE8/a+vreS@Gentoo>
 <ad5dd369-842f-7301-e57d-d0445f0a5268@linaro.org>
 <Y+oc+kEDoiMsebWF@Gentoo>
 <4055b041-c012-3be6-0aef-085ec389aabd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4055b041-c012-3be6-0aef-085ec389aabd@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:23:04PM +0100, Krzysztof Kozlowski wrote:
> On 13/02/2023 12:20, Jianhua Lu wrote:
> > On Mon, Feb 13, 2023 at 12:08:27PM +0100, Krzysztof Kozlowski wrote:
> >> On 13/02/2023 12:04, Jianhua Lu wrote:
> >>> On Mon, Feb 13, 2023 at 11:45:23AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 10/02/2023 17:19, Jianhua Lu wrote:
> >>>>> Novatek NT36523 is a display driver IC that can drive DSI panel. It
> >>>>> is also present in the csot and boe video mode panels. It is found
> >>>>> in Xiaomi Mi Pad 5 series.
> >>>>>
> >>>>> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> >>>>> ---
> >>>>>  .../display/panel/novatek,nt36523.yaml        | 101 ++++++++++++++++++
> >>>>>  1 file changed, 101 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..a7098d0ce7e1
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
> >>>>> @@ -0,0 +1,101 @@
> >>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36523.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: Novatek NT36523 based DSI display Panels
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - Jianhua Lu <lujianhua000@gmail.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  The nt36523 IC from Novatek is a generic DSI Panel IC used to drive dsi
> >>>>> +  panels.
> >>>>> +  Right now, only support cost and boe LCD display panels with the
> >>>>
> >>>> boe? both?
> >>> Boe Technology Group Co., Ltd
> >>
> >> Then what is "cost"? If both are names, then they start with capital
> >> letters or how the company officially spells itself.
> > both are company name, I will search offical name for it.
> 
> "cost" is company name? Then why do you call binding with different one?
"cost" is a typo error, real name is "csot".
> 
> >>
> >>>>
> >>>>> +  resolution of 1600x2560. It is a video mode DSI panel.
> >>>>
> >>>> The binding or hardware supports only 1600x2560? The how it can be
> >>>> "right now"? It's defined, isn't it?
> >>> Yes
> >>
> >> What yes? How it can be "right now"? It implies it will change, so how
> >> hardware can change?
> > sorry, my wrong. This binding only support 1600x2560.
> 
> How binding can support only 1600x2560? How does it exactly work for
> binding?
the driver of this binding support 1600x2560 and panels are 1600x2560.
> 
> 
> Best regards,
> Krzysztof
> 
