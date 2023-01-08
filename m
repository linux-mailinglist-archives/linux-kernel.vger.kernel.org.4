Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E95661A30
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbjAHVtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjAHVtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:49:14 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC73BF6E;
        Sun,  8 Jan 2023 13:49:11 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id q10so4989067qvt.10;
        Sun, 08 Jan 2023 13:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXCsyxif2yL7a8wGYb819nDDXeZSm3UGb9NtadKhdBI=;
        b=jBkuAZzhgfun4o7LKuEyJ0mc7uaiRrDq6Y/xAw/J0IPRsIRTI8F5lLBpNt4LHGA90c
         9ugJJudukmNfVkECTHtYr5KCZF6Se4Ah7WpanQjULc++aOsAItuQrf885jTSlWXOICnD
         j8eUMqcIwyvD7ix+5uwnJ4r56uN12/Bx3PMeZMu4/j64wi4MTHGGlSBy3b15UGwz6iIH
         bY0KUNL3z+cxPg8R6FiIWnQfo0gbIS/8u3Znvwz2MvlEV2IWkyy6/LeJVoCnc8CQpPmD
         1SsFLJcewXcKTtCFLDd3Eyfu2/jFuNIZ5SPZ6pW7NY9hwDlblEALFuIcJf/Ix9sPIjX6
         ojNQ==
X-Gm-Message-State: AFqh2kpAMu9kHGSaWOFmlgqc+3LDtSrU1PJsnnj0Ah1XVKSQRJ5oD4ev
        55RP991P4+bujmZJVnwuug==
X-Google-Smtp-Source: AMrXdXsGVlFem7qt1wF5RhNU3PoZj1JztlOL5eeskVLDXOJLHgkObcBFo0c3IKdwZWrKRJQfw4H2fw==
X-Received: by 2002:ad4:4152:0:b0:532:2d6c:5deb with SMTP id z18-20020ad44152000000b005322d6c5debmr3471180qvp.27.1673214550599;
        Sun, 08 Jan 2023 13:49:10 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a448a00b006faa2c0100bsm4294554qkp.110.2023.01.08.13.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:49:10 -0800 (PST)
Received: (nullmailer pid 325792 invoked by uid 1000);
        Sun, 08 Jan 2023 21:49:07 -0000
Date:   Sun, 8 Jan 2023 15:49:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Alex Shi <alexs@kernel.org>, devicetree@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        palmer@dabbelt.com, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: riscv: add a capacity-dmips-mhz cpu
 property
Message-ID: <167321454620.325726.1419996484202189237.robh@kernel.org>
References: <20230104180513.1379453-1-conor@kernel.org>
 <20230104180513.1379453-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104180513.1379453-3-conor@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 18:05:14 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Since commit 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
> RISC-V has used the generic arch topology code, which provides for
> disparate CPU capacities. We never defined a binding to acquire this
> information from the DT though, so document the one already used by the
> generic arch topology code: "capacity-dmips-mhz".
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
