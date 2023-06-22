Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC2739515
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFVCCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVCB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:01:59 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6811819F;
        Wed, 21 Jun 2023 19:01:58 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-780ce0cb634so3602239f.1;
        Wed, 21 Jun 2023 19:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399317; x=1689991317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlYlUUAHO+mbBbqIGkPmduwoBnKgJb9GdmGL9Z2MEeI=;
        b=gILJEhEoLqDkO1s3yWtDaXUyPbUPR7P+wnqqvRQo25ZPCfGzHDkzJPxiDE9Ajsqd5W
         Th6yCtERkGDH+bA16LaXHt0Wk68JH3WFvdXE7oz1G9sTowlpSTXsgwB8C1f96/aTx+XI
         eNtbvfClwV3Uq1RG/UJH2wBvFeh5t8FY7XjX1FzwzR6b4oPodaMqBWLQcCpCgxE6O2MF
         kI1YZh8ykZiZqw8d3UFR66nWLfEW1iaF7S67Nne3CTJdcJV9wt/ZYVKMMEWWh/CAag9i
         jI4/zCEBnpKiSoiZIlxcSYFHop18k7M1zd4Tvk89t+KID3HN8uGzAOueRl9EhjXuWYyC
         9QBA==
X-Gm-Message-State: AC+VfDylg2Jy4cHKgEGPz4HeEbUJY/mNEm3kJesX3sfSzgeAYRAMhIlp
        x0XmcYrfeUhspVJUWK7qAwFoUgP1ZQ==
X-Google-Smtp-Source: ACHHUZ7Z4wxdkN7Z68bLWE/7h+8zRmTcMc+lkhJ3+yvlPDbMh6WA6vM292fs0NbWzFfqlhQ/J7/kXg==
X-Received: by 2002:a05:6602:19:b0:774:7a6d:8753 with SMTP id b25-20020a056602001900b007747a6d8753mr18012680ioa.9.1687399317624;
        Wed, 21 Jun 2023 19:01:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f15-20020a6bdd0f000000b0077a1b6f73b9sm1752972ioc.41.2023.06.21.19.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:01:56 -0700 (PDT)
Received: (nullmailer pid 59336 invoked by uid 1000);
        Thu, 22 Jun 2023 02:01:55 -0000
Date:   Wed, 21 Jun 2023 20:01:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     jaswinder.singh@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, ryosuke.saito@linaro.org
Subject: Re: [PATCHv3] dt-bindings: arm: socionext: add Synquacer platforms
Message-ID: <168739931347.59220.2647323260418738541.robh@kernel.org>
References: <20230620170725.13794-1-jaswinder.singh@linaro.org>
 <20230621153658.60646-1-jaswinder.singh@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621153658.60646-1-jaswinder.singh@linaro.org>
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


On Wed, 21 Jun 2023 10:36:58 -0500, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> Specify bindings for the platform and boards based on that.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
> 
>  * Revert back to using the brand name Synquacer instead of sc2a11b
> 
>  .../bindings/arm/socionext/synquacer.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
> 

Applied, thanks!

