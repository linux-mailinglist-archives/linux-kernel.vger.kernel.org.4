Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05086726DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjFGUoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjFGUok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:44:40 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A0269A;
        Wed,  7 Jun 2023 13:44:24 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-33b9a56e261so7707895ab.0;
        Wed, 07 Jun 2023 13:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686170635; x=1688762635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIJj+RIryKrqEnTfrnBmC9GgMPZG3FLKuNsXROM4OMM=;
        b=TBfN4HWSwe+HX6H3optamkgA1fV4eLieFGbiPnZuJ/St0PRgjPpyTmxa9At9S+O0L3
         vTvzk0057jkz/FMbnzkB7jUrdWt1GjIrstcNhIzjeYevn44ArqWFuviDQWrVg2i3q1s8
         AtRP81MZw5EAOwujCeJJSzCspLyFB8UaK+g6V96tAXCmL5GmBtIj2Kh0e3vu+erWPiqQ
         hSLkPXasrFdcvDUxslKhXZ76TrAZqqYU0zIpJcl8eiC5z5Zc9PPBi9lAiJmK6h4jChXD
         v/Fp2602TUsSI9izlFOYTNpOzuesNXHkjU1Hm/bvlPzGVCvg9WYOlCHgTMiTOjj8vgwI
         tNyQ==
X-Gm-Message-State: AC+VfDx6AksdWqEOfobFqGmZuL09XsjvwdPZvvqp/39vurABv6pV0HUq
        +QEwxc8O81TBH+VBwx7jnA==
X-Google-Smtp-Source: ACHHUZ7RjquUYmIYHP3bF6+3teSYZ+l4qrU3YZYTuT6fvCYrT3KCXiOEQABgjKo0X9Wsx+UrQe1FRA==
X-Received: by 2002:a92:c14a:0:b0:338:b887:b674 with SMTP id b10-20020a92c14a000000b00338b887b674mr6729837ilh.2.1686170634754;
        Wed, 07 Jun 2023 13:43:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m26-20020a02c89a000000b00420bf02fc47sm873569jao.28.2023.06.07.13.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:43:54 -0700 (PDT)
Received: (nullmailer pid 3988267 invoked by uid 1000);
        Wed, 07 Jun 2023 20:43:51 -0000
Date:   Wed, 7 Jun 2023 14:43:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 convert to yaml
Message-ID: <20230607204351.GA3984668-robh@kernel.org>
References: <20230524123528.439082-1-claudiu.beznea@microchip.com>
 <20230524123528.439082-4-claudiu.beznea@microchip.com>
 <20230524-blizzard-hunting-4da815e634e2@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524-blizzard-hunting-4da815e634e2@spud>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:19:08PM +0100, Conor Dooley wrote:
> On Wed, May 24, 2023 at 03:35:27PM +0300, Claudiu Beznea wrote:
> > Convert Atmel SAMA5D2 shutdown controller to YAML. SAMA7G5 SHDWC DT node
> > (available in arch/arm/boot/dts/sama7g5.dtsi) has syscon along with its
> > compatible. There is no usage of this syscon in the current code but it
> > may be necessary in future as some registers of SHDWC are accessed in
> > different drivers (at91-sama5d2_shdwc.c and arch/arm/mach-at91/pm.c).
> > Thus update the YAML with it to make DT checkers happy.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Modulo the license thing that I mentioned on v1,

Should be fine given it's an Microchip employee changing a Microchip 
binding.

Rob
