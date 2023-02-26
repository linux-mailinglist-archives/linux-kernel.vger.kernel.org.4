Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE96A3393
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBZTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZTR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:17:58 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6515F6E9D;
        Sun, 26 Feb 2023 11:17:57 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id s8so2875160ilv.10;
        Sun, 26 Feb 2023 11:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq1ivKD6RivZCMPyh5AoByorkVQ4XKKDpGw+zbHBm8c=;
        b=YeulEnZFqVOeS1/m3SVCyZFLXJiziFBL0Cpm6LJi59RpEvt9Ppk5OncmioVH/yPYTl
         NLWyhTRmKxNLtMJ0Yt1jp9RCl69+IIeCnR1Y409SCJXvH+oLx7IAewV61GPd0FfqTF3D
         S7IE5V3H67CqIvnAXvRchuly/NwCkTPHlI+m5645ezt08wpUPNtL0td4jPjwSCRKwQ7u
         RJIV6wKfmZGNSj8ZKV1dW2UlIhdPgynIsmtMEbrlChduMrIwy7FyAOlOGP7d8UmwWj4b
         JptIHx6hOY0fb17JSeJm0wXw1VECOi1DgIUJ9pvUPyvomu4g4vbpyr/v+x5R8XigYvlR
         RW/A==
X-Gm-Message-State: AO0yUKUtTkxHymfSwK0FCznvmVGqp2/D6C7phsBkAbd9uRIFrT5xJw2u
        nRl7eR3N7SQWL7ynG2ghFw==
X-Google-Smtp-Source: AK7set9Hu4Sy+NQhvjCSJqK0tY1a0Hk6P5CLj7F5TClDXfRfHpsboyEPsry+SsYb4Kjo0zofxpn/UA==
X-Received: by 2002:a05:6e02:214f:b0:316:fcbe:397c with SMTP id d15-20020a056e02214f00b00316fcbe397cmr10307752ilv.27.1677439076618;
        Sun, 26 Feb 2023 11:17:56 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b003a58ae912aasm1558577jan.28.2023.02.26.11.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:17:56 -0800 (PST)
Received: (nullmailer pid 163984 invoked by uid 1000);
        Sun, 26 Feb 2023 19:17:52 -0000
Date:   Sun, 26 Feb 2023 13:17:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mips: loongson: Add Loongson-1 based
 boards
Message-ID: <167743907191.163906.16111583186738971743.robh@kernel.org>
References: <20230221110142.2121482-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221110142.2121482-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2023 19:01:42 +0800, Keguang Zhang wrote:
> Add two Loongson-1 based boards: LSGZ 1B and Smartloong 1C.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V2 -> V3: Amend the vendor prefix
> V1 -> V2: Add the according vendor prefix
>           Change the board string to enum
>           Modify the board description
> ---
>  .../devicetree/bindings/mips/loongson/devices.yaml   | 12 ++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml         |  2 ++
>  2 files changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

