Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE366731F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjFORrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjFORri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:47:38 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531B271F;
        Thu, 15 Jun 2023 10:47:37 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-341daf315b3so3351895ab.0;
        Thu, 15 Jun 2023 10:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686851256; x=1689443256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXUuU+bjTRUlDh30kMbjfqbr6PEXiONI6qJ0Ou76ZMM=;
        b=ivI9K1pCDx3ZmP6A2tDdOlCO0QkZ6cCBssYlh5zUxGAdGyVujhljei8dw6NfcAygAS
         Z1XN34SC81j9NNIYqFhr4/opcAEBBT9Jh4bF6AktF6an9OtFCdOjlD8mx98fkH4PZ0Xp
         h6ZZ7KJ2WCPlY+0V/f2RW90V+E5kGfl8YbE/LfKHREej3nKD9znR35v9POeJGd8kMvxJ
         AsxXfHvkI70SYoWCv3niS5ZG4H8md1HfZrd6Wqcc5w0lcmXuGTfZCeyCHv1f+bUlIEob
         MiHV4aZYHhzuFPOOD0i+0aYJt9Q0Tu+EfNJ+fYVKlLleHRVlgf/yh/VQdDxcvuyyr0ca
         IwfQ==
X-Gm-Message-State: AC+VfDweQ4rH7AFeI6pCIo37KKv8bViCy7rsLhkIRDyPIJqL01F2HXna
        8pUrxy+2pTDTnyc/mQJezA==
X-Google-Smtp-Source: ACHHUZ4rcf0f5VD09/y2OdnlU6rJyVmdPxbV3gdxcOg2VFvtQm13Yr7CRD75ZN4ywJL3AJeDxmxjbA==
X-Received: by 2002:a92:ce08:0:b0:340:5928:e048 with SMTP id b8-20020a92ce08000000b003405928e048mr171435ilo.11.1686851256291;
        Thu, 15 Jun 2023 10:47:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o8-20020a92d388000000b00341c0710169sm609236ilo.46.2023.06.15.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:47:35 -0700 (PDT)
Received: (nullmailer pid 1252912 invoked by uid 1000);
        Thu, 15 Jun 2023 17:47:34 -0000
Date:   Thu, 15 Jun 2023 11:47:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     palmer@dabbelt.com, Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] dt-bindings: riscv: cpus: switch to
 unevaluatedProperties: false
Message-ID: <20230615174734.GA1240678-robh@kernel.org>
References: <20230610-snaking-version-81ae5abb7573@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610-snaking-version-81ae5abb7573@spud>
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

On Sat, Jun 10, 2023 at 06:24:47PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Do the various bits needed to drop the additionalProperties: true that
> we currently have in riscv/cpu.yaml, to permit actually enforcing what
> people put in cpus nodes.

Arm needs pretty much all the same properties. I started on adding them 
to cpu.yaml a while back. Let me finish that up.

> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> 
> Conor Dooley (6):
>   dt-bindings: riscv: cpus: add a ref the common cpu schema
>   dt-bindings: riscv: cpus: allow clocks property

I just have 'clocks: true', so if you want to keep this setting it to 1 
clock that's fine. But I imagine that it's just a matter of time until 
someone wants more clocks.

>   dt-bindings: riscv: cpus: add a ref to thermal-cooling-cells
>   dt-bindings: riscv: cpus: permit operating-points-v2
>   dt-bindings: riscv: cpus: document cpu-supply
>   dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
> 
>  .../devicetree/bindings/riscv/cpus.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> -- 
> 2.39.2
> 
