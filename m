Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4B6A5B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjB1O5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjB1O5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:57:50 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30952739;
        Tue, 28 Feb 2023 06:57:11 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id y184so8214957oiy.8;
        Tue, 28 Feb 2023 06:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz13ePRsdvAV4VQWspwggO2nF1bgHhH78z9EfhScQfo=;
        b=lnP+NndMpGpAhx7DMET71uWKGYM1i7x3E0wj0FVqna7Vskmuuz33avnFDC+Y8Vw8mn
         jSCABvcZLaJIwJypF6Q5/J4p+Ao/dsDaxFSYWsVymlLxQtEvy83+n0WcQdurZyyED1He
         xXOuNkux0f9XnYjTm26wjrpQjjB4e4GNjf0TUPoyRmxW2yf4Gy1s1qHZHopaAbtQUDtM
         NXobWJLy0ReEwGMP1Xy51mymdpHXEe3JXviy/fPVPzO32U0OizYQPjVtiKAf03qEDbj5
         P47Gz4Htn5MOhYRFoFPAeNRcRNIwvdRRZQgyRZQrkHkkWJtWCnyC4qfLqnFtTDWdZX38
         BeiQ==
X-Gm-Message-State: AO0yUKV/S3bhGgKOUMsLycMx3846WoKMvqX9sJRHcu1oyzQzJCExwk3H
        Mz+XN8Y3UE2QC7SXSSN7vA==
X-Google-Smtp-Source: AK7set94DR+xwEQYa8X8GkWyWk88A0B84qdhXg17GydthqLk+zGWGRTBG3KHBfgVM1ahYSFwmLQceQ==
X-Received: by 2002:a54:470e:0:b0:383:ee1d:f4b2 with SMTP id k14-20020a54470e000000b00383ee1df4b2mr1658344oik.15.1677596230861;
        Tue, 28 Feb 2023 06:57:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bk15-20020a0568081a0f00b003845000eca7sm635702oib.1.2023.02.28.06.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 06:57:10 -0800 (PST)
Received: (nullmailer pid 3232983 invoked by uid 1000);
        Tue, 28 Feb 2023 14:57:09 -0000
Date:   Tue, 28 Feb 2023 08:57:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/7] dt-bindings: Add RISC-V misaligned access
 performance
Message-ID: <20230228145709.GA3198794-robh@kernel.org>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-5-evan@rivosinc.com>
 <Y/01c7sZ9ri5i8ao@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/01c7sZ9ri5i8ao@spud>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:57:55PM +0000, Conor Dooley wrote:
> Hey Evan,
> 
> On Tue, Feb 21, 2023 at 11:08:55AM -0800, Evan Green wrote:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> > 
> > This key allows device trees to specify the performance of misaligned
> > accesses to main memory regions from each CPU in the system.
> 
> Could you fold some of Palmer's explanation for why this must be in the
> devicetree? Think this is where he explained it:
> https://lore.kernel.org/all/mhng-8736b349-e27a-4372-81ca-3a25d2ec1e94@palmer-ri-x1c9/

I still don't think this belongs in DT and replied on the above thread.

Rob
