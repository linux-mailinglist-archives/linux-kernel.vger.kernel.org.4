Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCFF685CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjBAB5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjBAB5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:57:30 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D4F4FC37;
        Tue, 31 Jan 2023 17:57:29 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so1795655otj.3;
        Tue, 31 Jan 2023 17:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il4+q0bbik14msabTB8Ry4Vk2QXt2ITErIdFitMsV9E=;
        b=xA5cWOLfoysw++yTmbLHElxltqMKRNXExejKHB4jLSjqA5NCKiQefwFVdqwMx+Bf/6
         nZnUvPRPLL26AWsvenjh+OloXYEIwOx/TsofQgvIBZdBVuweORb2rE2C6EI6hqnGNZ47
         hmlIK2GnPONoLvGTKBR35w4ZzDONMCUnK2YkywaFCVivUt2aS90ByS6xGwpI3YE277OZ
         AEZnmOdhfVRSV+ftNB8wFkqiBt66+AUKmVG1z1OqRhAYGKVlHRMXF2F0tRxTD6r9lIID
         z98T7S1Oe4Xqe7F6rDgcspOMfzN0LDVOIxaCnDZ4dS6Wo0JhdpqKJLrb7mp58VUJo1Ew
         a01w==
X-Gm-Message-State: AO0yUKXSvp8hv3n9D0O1VOHomvwjjasyPqng/5SUu0C9x3ifxj79xpoR
        oW3hn58ZIQ1jZNI1oP7kQSEWDEBw7g==
X-Google-Smtp-Source: AK7set+IUHvbSgpk5ghxTTGIPErQseQOTf9hnsChty4qdkANK1UYGB+c/W5c5LR16o6gYwKXs2OtCA==
X-Received: by 2002:a05:6830:6209:b0:68b:ccb5:c6d1 with SMTP id cd9-20020a056830620900b0068bccb5c6d1mr582252otb.22.1675216648701;
        Tue, 31 Jan 2023 17:57:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g22-20020a9d6496000000b00684bede5359sm7406195otl.42.2023.01.31.17.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 17:57:28 -0800 (PST)
Received: (nullmailer pid 2311344 invoked by uid 1000);
        Wed, 01 Feb 2023 01:57:27 -0000
Date:   Tue, 31 Jan 2023 19:57:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: pincfg-node: Introduce an
 overridable way to set bias on pins
Message-ID: <20230201015727.GA2298086-robh@kernel.org>
References: <20230130165435.2347569-1-konrad.dybcio@linaro.org>
 <CACRpkdZjAyLUg3V7ZTzeMfUOTrndLrRX_gTFdO+amSmZkzB72Q@mail.gmail.com>
 <f3f70ac2-d097-b6ee-22d3-92fcfdd7c53f@linaro.org>
 <CACRpkdbD+vtiFnPHoSR9fpV5zwtdNo923frROR7Nb1nkAMP4wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbD+vtiFnPHoSR9fpV5zwtdNo923frROR7Nb1nkAMP4wQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 02:21:38PM +0100, Linus Walleij wrote:
> On Tue, Jan 31, 2023 at 12:50 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> 
> > > +#define DRIVE_STRENGTH                 9
> > > +#define DRIVE_STRENGTH_UA              10
> > >
> > > drive-strength = <8>; // 8mA drive strength
> > >
> > > bias-type = <DRIVE_STRENGTH>;
> > >
> > > OK where do I put my 8 mA now?
> > >
> > If you look at the 2/2 patch, this property only reads BIAS_
> > values, which can't coexist anyway.
> 
> Well the DT bindings have to be consistent and clear on their
> own, no matter how Linux implements it.
> 
> But I'm sure you can make YAML verification such that it is
> impossible to use both schemes at the same time, and it's not
> like I don't understand what you're getting at.

We already don't enforce mutually exclusive combinations. Perhaps 
someone wants to fix that first?

> What I need as input is mainly the DT bindings people opinion
> on introducing another orthogonal way of doing something
> that is already possible to do another way, just more convenient.
> Because that is essentially what is happening here.

It's really a 3rd way we're adding because the existing properties have 
2 forms which IMO is worse than 2 disjoint ways of doing it. And since 
this new way can't represent some cases, I don't think it is an 
improvement. 

Rob
