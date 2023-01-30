Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555E0681DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjA3WMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjA3WMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:12:01 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C83B0DB;
        Mon, 30 Jan 2023 14:11:58 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id i11-20020a056820012b00b00517518d79f6so638957ood.10;
        Mon, 30 Jan 2023 14:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWJ05yhc/QoYhGwjtBStJIcXLe5TjSNLXFeusdsihHg=;
        b=PolgQlT2OFSmEkWhXl1LMQ9Dr9C5/9hW04sjACVQKiX4a/Kd+KGIUtjNoycqiaICqg
         6G9W47J5lMVvUhwIxvTgTpcIOaAFdtlHhBe6gZbcQk9o5SzsoYZAp/DG1eeJ6uhsa8VO
         +mKylTM2duNUY0kT3sGsk4V6Tv8aPeosBVWRGvA59Ac1jeEFU6TAmoHwtzAtVSzIwTGM
         pFG9SeBViG5uoXtnRYmEDwrvSZKW8zN7mn1Ji2cKy3aOWaNj/hxPsKc57E2zJMZJ5vep
         k2oYg0TS8daNgRc7QuSmI+djG65YSjxMs+GWpMcBlM9ru2hAKfctB8El4J27/Dst8vz2
         vsuQ==
X-Gm-Message-State: AO0yUKWDUVigRJHOWGlnBGLX/qHBDM/RVX9juNK2/Tg/zquEPF0cIngE
        NjWGB19DfzKpAzqZVqxVj1LbYhjb2g==
X-Google-Smtp-Source: AK7set/YAH3TEUhitOrmZxOxRKiEb2e6U2zBS7JTANOg3qFnJ89fkAqhM0gR0HuIkDCGafJlzcSxRw==
X-Received: by 2002:a4a:c884:0:b0:517:7b89:b8d3 with SMTP id t4-20020a4ac884000000b005177b89b8d3mr2657984ooq.6.1675116717033;
        Mon, 30 Jan 2023 14:11:57 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o22-20020a4ae596000000b004f269f9b8f3sm5441483oov.25.2023.01.30.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:11:56 -0800 (PST)
Received: (nullmailer pid 3618211 invoked by uid 1000);
        Mon, 30 Jan 2023 22:11:55 -0000
Date:   Mon, 30 Jan 2023 16:11:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, list@opendingux.net,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: rtc: Add #clock-cells property
Message-ID: <167511671553.3618148.6225023459111985094.robh@kernel.org>
References: <20230129120442.22858-1-paul@crapouillou.net>
 <20230129120442.22858-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129120442.22858-2-paul@crapouillou.net>
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


On Sun, 29 Jan 2023 12:04:39 +0000, Paul Cercueil wrote:
> The RTC in the JZ4770 is compatible with the JZ4760, but has an extra
> register that permits to configure the behaviour of the CLK32K pin. The
> same goes for the RTC in the JZ4780.
> 
> With this change, the RTC node is now also a clock provider on these
> SoCs, so a #clock-cells property is added.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> ---
>  v2: - add constraint on which SoCs can have the #clock-cells property
>      - add JZ4780 example which has a #clock-cells
>  v3: Don't break ABI anymore.
> ---
>  .../devicetree/bindings/rtc/ingenic,rtc.yaml  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
