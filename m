Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC56D63E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjDDNva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjDDNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:51:25 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF94217;
        Tue,  4 Apr 2023 06:51:23 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id k14-20020a9d700e000000b0069faa923e7eso17341650otj.10;
        Tue, 04 Apr 2023 06:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH0qV0hRMQiU3rBtrwZNkoVLWYzrXYIYrbxPgs77oBQ=;
        b=imOZ1mp3KwVEXvqEaQeSv+1+2lp0C5JGyTg3US7GOpPUpVdgdoXZ5hrD/KzlwIb82O
         WgW2LvF0hJ0UVh/DYkpf8HSl3uteDVIgMJ6TWPcQf/fkUHqet814lkwuEOpVhMreci2+
         Db785DTMVRhSm/wbppbi/88eiJoKKXRTHKcZWH/dhsrDKea66mjsjtuRzix0TW3YzHvY
         rdOsnoGFlJolURcLoGp+OYrQoalh88FstLh2K9qRHs6RDb6pzBpaKbBLcYDEIw21wgui
         nAh+PfsadtHSEgFMEhOtx8H/JEr7rTYQdv6PTgyCw2fM7B/SKYPKTg7HQd6PR77D40R2
         UbOw==
X-Gm-Message-State: AAQBX9f5ijNKih/Ax/K0Lmla93nRCRu0ejvKWbtdrwgRoxWNG3+OkPh8
        Q8EJoTKaOl6pkDmTMaVT/w==
X-Google-Smtp-Source: AKy350ajbMepIhxILlKEJFxTug5uTHyx6XXjORZb9ow9pjepVuAtHVSMuR07D+VBVbYsbxkOyajiUw==
X-Received: by 2002:a9d:1289:0:b0:68d:3fc8:7c11 with SMTP id g9-20020a9d1289000000b0068d3fc87c11mr11026951otg.12.1680616282479;
        Tue, 04 Apr 2023 06:51:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020a056830134400b00697be532609sm4480817otq.73.2023.04.04.06.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:51:22 -0700 (PDT)
Received: (nullmailer pid 3793289 invoked by uid 1000);
        Tue, 04 Apr 2023 13:51:21 -0000
Date:   Tue, 4 Apr 2023 08:51:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] dt-bindings: input: pwm-beeper: convert to dt schema
Message-ID: <20230404135121.GA3787069-robh@kernel.org>
References: <20230403090640.3237060-1-peng.fan@oss.nxp.com>
 <9dc60868-b3f2-e30f-f4fe-d2fbd551d948@linaro.org>
 <DU0PR04MB9417000982CDDF5B75E309F488939@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9422ab57-8512-0177-76fa-76347626f941@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9422ab57-8512-0177-76fa-76347626f941@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:17:45AM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2023 08:44, Peng Fan wrote:
> 
> 
> >>
> >>> +
> >>> +  beeper-hz:
> >>> +    description: bell frequency in Hz
> >>> +    minimum: 1
> >>> +    maximum: 4
> >>
> >> default is 1000, so how constraints can be lower than default? Also - missing
> >> default.
> > [Peng Fan] 
> > I am not sure what maximum value should be set. Previously I set 256, Rob
> > questioned it.
> 
> Yep, because 256 is power of 2, so really does not look correct. It is
> still lower than default, right?

It's Hertz and an audible (to humans) range! At most that's 60 - 
10000Hz. I imagine any beeper h/w is capable of much narrower range than 
that, but don't know what's typical. 

Rob
