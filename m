Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590966D50B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjDCShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjDCSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:36:59 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72498E6;
        Mon,  3 Apr 2023 11:36:45 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso31808019fac.12;
        Mon, 03 Apr 2023 11:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIk+N2IXSsJAoY2e0gzvK6ymWE6vQVlOd434dzmo7vc=;
        b=RP9znc0c4QdTb5NsoxvgwICtrzaZVENRRjsCE9XWiPw+oEO7/VxKvC70cnatz2Q8yc
         ohbuRrYVH63gJ1L9sZtWI0OxMGAHzq1hMvJ/+dsKXtbe5diBrPetaTTZ7A82OJuTK8/7
         D/Hb8wL+0o01lPTqKPsgwBGfT+VgKb/sNKfSn1xhHhRePn/AV/1m2ngnCJmh8h7hYXMO
         qurKMru9GbYfO2t0yq9rZ7vU+SpAKie3TvnoBvxLAfkiRNWoas7ECFX0O7RDPOQYhJDR
         pqBmMXcNqdPvatyn5Hra3+i+SK91of7S4LKpxXu4yjdFTbkquB9PBRr0OVwiptpQMIuw
         Dktw==
X-Gm-Message-State: AAQBX9c9cfgqHA5Aig/OsVKf+ijEwaAYKLax/qNtf8nQCkCW8LUmgk52
        fBE0NnQA3kwEW3gimBjJ0Q==
X-Google-Smtp-Source: AKy350ZUlFhjgnglIoYafXPoxlDOutQn4rOsAma6LUGjUwvFzwRX7OlCEgbyqHLMXYRz6fgk9hhxRA==
X-Received: by 2002:a05:6870:1707:b0:17e:3772:bdd7 with SMTP id h7-20020a056870170700b0017e3772bdd7mr90499oae.46.1680547004506;
        Mon, 03 Apr 2023 11:36:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id xf19-20020a056870cf1300b001724742cfcesm3759713oab.38.2023.04.03.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:36:44 -0700 (PDT)
Received: (nullmailer pid 1340936 invoked by uid 1000);
        Mon, 03 Apr 2023 18:36:43 -0000
Date:   Mon, 3 Apr 2023 13:36:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-oxnas@groups.io,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC v2 0/4] ARM: oxnas support removal
Message-ID: <20230403183643.GA1335487-robh@kernel.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 09:42:17AM +0200, Neil Armstrong wrote:
> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
> associated with a clear lack of maintainance, development and migration to
> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
> 
> In addition, the OX810 hasn't been booted for years and isn't even present
> in an ARM config file.
> 
> For the OX820, lack of USB and SATA support makes the platform not usable
> in the current Linux support and relies on off-tree drivers hacked from the
> vendor (defunct for years) sources.
> 
> The last users are in the OpenWRT distribution, and today's removal means
> support will still be in stable 6.1 LTS kernel until end of 2026.
> 
> If someone wants to take over the development even with lack of SMP, I'll
> be happy to hand off maintainance.
> 
> The plan is to apply the first 4 patches first, then the drivers
> followed by bindings. Finally the MAINTAINANCE entry can be removed.
> 
> I'm not sure about the process of bindings removal, but perhaps the bindings
> should be marked as deprecated first then removed later on ?

Nah, just remove them. Like the code, we can always bring them back if 
needed.

Rob
