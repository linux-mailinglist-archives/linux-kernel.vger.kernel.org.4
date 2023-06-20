Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA273720F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjFTQtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjFTQtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:49:02 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977A619F;
        Tue, 20 Jun 2023 09:49:01 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77ac2eb07a3so182186239f.2;
        Tue, 20 Jun 2023 09:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279741; x=1689871741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlSdhQ3eCYV+z1Kptfv3vGGIgHEt5bvqs3RHbJX+pe0=;
        b=Z2W8PeNwHzGC0GEmoo0hl9lZ/bovxLgUOhQcCa39X40/6YDrnv0MKZOAFHOIO+Ycn6
         klMgt/D35zp5eRSyGu0t/rnDi8pGrhUi0rnyx8ZadwyQ+57XzPBXGajA/Jc0wAvdJtai
         ohN3khDrdz5o0Y+WCmm/DxC0SX3cOe2bcpQY48pu2vbv2Tpz6OAk0mo+lylHsX79t9TY
         LhonkuIVAL5DwzWYglE/EzrJgXkGGdhhgymqgLH3YshO2RFsxdnxGK9DvfpTDqtCM2Iw
         zngR25NBHmo2bUGJOXripun0L1POJnz263OEENxv62A6UGX+m6qMYTPAui83zkmHaZQv
         TQvQ==
X-Gm-Message-State: AC+VfDy8YDIjTholXEdB3ySvQCdAnAtYwL5fIeR0UxJvsJR2HtJifCnV
        oP1nuj4hLThAQDt4WeganA==
X-Google-Smtp-Source: ACHHUZ5Oj0ipQS5YeJFc0dfgU05kiRIXolESi5d8MHZS7nV/rS8I4VVMxAxZWMRFY5ZK1rzNNHy4Rw==
X-Received: by 2002:a6b:7103:0:b0:774:934c:d178 with SMTP id q3-20020a6b7103000000b00774934cd178mr8559968iog.20.1687279740792;
        Tue, 20 Jun 2023 09:49:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c11-20020a02c9cb000000b00411bdcdc488sm693665jap.173.2023.06.20.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:49:00 -0700 (PDT)
Received: (nullmailer pid 3804095 invoked by uid 1000);
        Tue, 20 Jun 2023 16:48:58 -0000
Date:   Tue, 20 Jun 2023 10:48:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: riscv: cpus: switch to
 unevaluatedProperties: false
Message-ID: <168727973778.3804036.16013455064916997231.robh@kernel.org>
References: <20230615-creamer-emu-ade0fa0bdb68@spud>
 <20230615-viper-stoic-1ff8efd7d51d@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615-viper-stoic-1ff8efd7d51d@spud>
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


On Thu, 15 Jun 2023 23:50:15 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> To permit validation of cpu nodes, swap "additionalProperties: true"
> out for "unevaluatedProperties: false".
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

