Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732C1661A2D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjAHVsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAHVsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:48:51 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6F86144;
        Sun,  8 Jan 2023 13:48:50 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id qb7so5012143qvb.5;
        Sun, 08 Jan 2023 13:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doqDUNC8qP8MatRZPOWaIbEXI6pyG66qGtlsOqIvLa4=;
        b=7pcCLb59mbvz7vvLnmzSw6LLvd6rNkTfsmGbVkZKj4FQbA3xXZbDiNiO0m3C/AJHnT
         uhmyGoyLpQxR8cD4g4RNbxck3twd8e25y9NwKYu9DgTiSw9F4RCHZKtlavwDxhyXMLNh
         cLjL6nOeGRB4rHupcpxQFgXfXhBxiaiv55XC4p9pIeudjLBuXHwOvKR9DR0ZY5d1qiXa
         yXo6fB4TRdmBfHiX9RUNj0IF8naSjgIWuMrsw2e8DHrUv8qHAk0ZqXulaqZ83XyYhe7q
         sVj7/3pqOKbN822BhtzN47vRX1ekQrA5YoP5JQdBGKgbAOEgNyVvLk4XtKlRPLEWsa1Z
         Yrsw==
X-Gm-Message-State: AFqh2koQIBuYBbCW+CkTk4phP0jbsxlL38wMhFHU4Ru20RuIvLgPIeOJ
        863gU1IuGwU5/hXePP0wXZPiRkGjMA==
X-Google-Smtp-Source: AMrXdXuJK76yoUULVOufb3h+H7dZYcnVxyHRRL8gez4abYicxWTNDCrS40HwAyq8xawVU3SX6+vCZw==
X-Received: by 2002:a05:6214:3302:b0:531:bde2:365a with SMTP id mo2-20020a056214330200b00531bde2365amr41642578qvb.7.1673214530049;
        Sun, 08 Jan 2023 13:48:50 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80a5:9b51:39ae:24d1:33f3:811e])
        by smtp.gmail.com with ESMTPSA id w29-20020a05620a0e9d00b006fcab4da037sm4277502qkm.39.2023.01.08.13.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:48:49 -0800 (PST)
Received: (nullmailer pid 325297 invoked by uid 1000);
        Sun, 08 Jan 2023 21:48:46 -0000
Date:   Sun, 8 Jan 2023 15:48:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, palmer@dabbelt.com,
        devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-riscv@lists.infradead.org, Alex Shi <alexs@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: move cpu-capacity to a shared
 loation
Message-ID: <167321452534.325217.3239534782123890748.robh@kernel.org>
References: <20230104180513.1379453-1-conor@kernel.org>
 <20230104180513.1379453-2-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104180513.1379453-2-conor@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 18:05:13 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> RISC-V uses the same generic topology code as arm64 & while there
> currently exists no binding for cpu-capacity on RISC-V, the code paths
> can be hit if the property is present.
> 
> Move the documentation of cpu-capacity to a shared location, ahead of
> defining a binding for capacity-dmips-mhz on RISC-V. Update some
> references to this document in the process.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I wasn't sure what to do with reference [1], but since the property will
> be the same on RISC-V, I left it as is.
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml               | 2 +-
>  .../devicetree/bindings/{arm => cpu}/cpu-capacity.txt         | 4 ++--
>  Documentation/scheduler/sched-capacity.rst                    | 2 +-
>  Documentation/translations/zh_CN/scheduler/sched-capacity.rst | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => cpu}/cpu-capacity.txt (98%)
> 

Acked-by: Rob Herring <robh@kernel.org>
