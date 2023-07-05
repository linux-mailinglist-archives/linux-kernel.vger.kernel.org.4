Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D851748E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjGETxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjGETxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:53:13 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019541980;
        Wed,  5 Jul 2023 12:53:06 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-345f4a3ff76so23386565ab.2;
        Wed, 05 Jul 2023 12:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586785; x=1691178785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y45aTDzSTQD6CGxFP2My2e1zQpvSPUcKTCZkKn80Qfs=;
        b=TXyoDjYT9yNFoPb8q+zGCoBrErrzjBiNbDa/CzEsi9gIpFbZqRAxiSiP+3kduEINiT
         X71mD4J9w2R/qeN2KfOhwtawlq3wx8+9muHVwIpr8uvY4qetX7B8o0zzeuE6Y8zfAc4M
         qGuZi+uG2wfjobFMkcsKsN452+w99TCD7dcobw4DFQxq1yYIxaQxYlI2Yn6lirgc49dR
         tRKFUtLlc4RFCxijbOt47PLfRiR2exlqsQ5DhgtiuKn5bbq5CI+bUqqFAsqjoExYKfOu
         FgToHnOGVM/HTukQmuepbm1fzM8i7d4khNpMqlzZFOdb9y8gTxxIKJ0OWx4Q7RNknVqO
         CdBQ==
X-Gm-Message-State: ABy/qLYMqTdVSIrC5KNaJPK8ErY4noeeSTWtuuGRrZVXmSVk7Q1BHreL
        jMQcc91C+usARJqRHveUzTc4gxPKKw==
X-Google-Smtp-Source: APBJJlG849qoygO19N3NJ7tJkbVASz+SkcxxwDLkmdq5oiTtzbDaYXe0Djxd06jEC+Rq5kaeoS1mfg==
X-Received: by 2002:a92:c647:0:b0:346:46e:209c with SMTP id 7-20020a92c647000000b00346046e209cmr115663ill.22.1688586785208;
        Wed, 05 Jul 2023 12:53:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y24-20020a02c018000000b0042b4b1246cbsm1994291jai.148.2023.07.05.12.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:53:04 -0700 (PDT)
Received: (nullmailer pid 1732499 invoked by uid 1000);
        Wed, 05 Jul 2023 19:53:01 -0000
Date:   Wed, 5 Jul 2023 13:53:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: amlogic: convert
 amlogic,gxbb-clkc.txt to dt-schema
Message-ID: <168858678149.1732437.11783574032549132078.robh@kernel.org>
References: <20230705-b4-amlogic-bindings-convert-take2-v2-0-22be915ddc3b@linaro.org>
 <20230705-b4-amlogic-bindings-convert-take2-v2-1-22be915ddc3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705-b4-amlogic-bindings-convert-take2-v2-1-22be915ddc3b@linaro.org>
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


On Wed, 05 Jul 2023 13:41:51 +0200, Neil Armstrong wrote:
> Convert the Amlogic Clock Controller bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/amlogic,gxbb-clkc.txt           | 53 ----------------------
>  .../bindings/clock/amlogic,gxbb-clkc.yaml          | 37 +++++++++++++++
>  2 files changed, 37 insertions(+), 53 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

