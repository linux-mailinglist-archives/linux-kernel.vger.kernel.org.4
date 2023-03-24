Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0146C85A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCXTJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCXTJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:09:40 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B81981;
        Fri, 24 Mar 2023 12:09:38 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so1379978oti.13;
        Fri, 24 Mar 2023 12:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679684978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDz1r5VhPNoU48BRrcseKzUPBMUtRwHQFTGhebuKT9E=;
        b=mBocgl+vwFkZcermyRD7VYee0y/a2Wi3fv7BgAaB9i1Ad4yOZY3NRXrrk4cBdy3Pno
         aSWp1tVROP89su3iy2PDYNM1MkxmsQRm7I6YYliaAxoH/jn5QHxby6/7VutHkuzNJa66
         KQ3djSv7pvrbaWUKn9TV4X7wZ5oK+iZ7LjHwKEYE51Jt6uptCCxRMcxJmBWvw6KzRX9a
         2dKXGbGji2I+lldpR9zzBP/5m3nfCmkEW3xokjMF7Xv5ChO1jtQqRvsXp+1yluDD0Ony
         8m8MTmpWWF0R7kAGpTTdFosun3+nFQrDfas/t3ibMeZtTPXMd+LnJ8uFE3SP5XjZplD7
         yDHQ==
X-Gm-Message-State: AO0yUKV1eZHj0FTiAdU5fkUloadG2F9P6fmBmP/tKvNtj0VB+LfwVnwM
        zFTiRCHWMxzNfLxF7ifUrw==
X-Google-Smtp-Source: AK7set+PcreFrKXbM4FiRb1Nlu/NrWcMeXMQQEJhgIqpVVn6tfHybXq5oC3TyVV2TyBym2hVGWmnGw==
X-Received: by 2002:a9d:6211:0:b0:6a0:4857:e119 with SMTP id g17-20020a9d6211000000b006a04857e119mr1708906otj.0.1679684977914;
        Fri, 24 Mar 2023 12:09:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s10-20020a9d758a000000b0069f509ad088sm5364132otk.65.2023.03.24.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:09:37 -0700 (PDT)
Received: (nullmailer pid 2276961 invoked by uid 1000);
        Fri, 24 Mar 2023 19:09:36 -0000
Date:   Fri, 24 Mar 2023 14:09:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: add loongson spi
Message-ID: <20230324190936.GA2273835-robh@kernel.org>
References: <20230324063317.14664-1-zhuyinbo@loongson.cn>
 <20230324063317.14664-2-zhuyinbo@loongson.cn>
 <1ebe139f-ed01-a073-c69f-a7db4b154fbf@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebe139f-ed01-a073-c69f-a7db4b154fbf@loongson.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:36:17PM +0800, zhuyinbo wrote:
> This patch need depend on
> https://lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/ .

It's best to remove that dependency if you want to merge both in the 
same cycle.

Rob
