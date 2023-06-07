Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07D5726A60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjFGUHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFGUHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:07:06 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57421BD3;
        Wed,  7 Jun 2023 13:07:05 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-777b1b5ff50so167078139f.3;
        Wed, 07 Jun 2023 13:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686168425; x=1688760425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iogvmUnJd8dmsaSSNLjme6YVFLdDC5DcESiDlQNvEto=;
        b=Mjddjik+QwVGW45MyLRhJ93rkW2EOR2RfzJiRZe0keups80rEq7G/kzpsZhtLo+AUH
         scC+pH2HfwStUdSShSgAIjI4VKVXK1hGevkjVWk+yDTWNp5OQ9w5ZesabffXa+a/HcTH
         yqGq1zABLsVTRlDCRlZhShivselMeoGfCiHksN2sSPAWGMuh2JuhtQ8yddxMWn9IqUs/
         my5LS3j12fDEUB/XyzTrQv8bKJbFvufaw2dNZYYsX+wk7pUrhQuPfIGFVlnt9+xYe3Pt
         10mhft4ccr4e3sX33EGinc3PvihsU0Q+WMihoK7jExFwYqrHAu/f+Tr40ngjK+HS/nkF
         eO3w==
X-Gm-Message-State: AC+VfDz61C/gRctUCT/HKON8bVx0KFmNOdzDYn3Aau8Ct7XtQDX1Zv9V
        CLYNzoF7eOTFkyYQGhWw6A==
X-Google-Smtp-Source: ACHHUZ46JdCGj7zOlcTNqaPq40ycCIzsjr+132rAb0aIBqKMNfw1C0R9C7iRukbcfvmXUK7kyPj+eg==
X-Received: by 2002:a5e:834d:0:b0:778:82d1:39a3 with SMTP id y13-20020a5e834d000000b0077882d139a3mr7724530iom.13.1686168424958;
        Wed, 07 Jun 2023 13:07:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y11-20020a6bd80b000000b00777b3bfc406sm2218699iob.49.2023.06.07.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:07:04 -0700 (PDT)
Received: (nullmailer pid 3936319 invoked by uid 1000);
        Wed, 07 Jun 2023 20:07:01 -0000
Date:   Wed, 7 Jun 2023 14:07:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ayan Kumar Halder <ayan.kumar.halder@amd.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, mailingradian@gmail.com,
        j@jannau.net, geert+renesas@glider.be, conor.dooley@microchip.com,
        angelogioacchino.delregno@collabora.com, lpieralisi@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        me@iskren.info, matthias.bgg@gmail.com
Subject: Re: [PATCH] dt-bindings: arm: Add Cortex-R52 to the list of enum
Message-ID: <168616842047.3936246.5750632673120649061.robh@kernel.org>
References: <20230518152730.82954-1-ayan.kumar.halder@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518152730.82954-1-ayan.kumar.halder@amd.com>
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


On Thu, 18 May 2023 16:27:30 +0100, Ayan Kumar Halder wrote:
> As a pre-requisite for porting Xen on a Cortex-R52 based System-on-chip, we
> need to add "cortex-r52" to the list of enum.
> 
> Signed-off-by: Ayan Kumar Halder <ayan.kumar.halder@amd.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

