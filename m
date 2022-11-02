Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB97616713
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKBQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBQHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:07:09 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C755D25EB4;
        Wed,  2 Nov 2022 09:07:08 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so3944012otl.3;
        Wed, 02 Nov 2022 09:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th6/ZO+U3Z/edcN2KgziGNJueIvFPLRfv4u6mt7jrck=;
        b=hF2sSnXEKF8hYLa+CdJJ2ibf1lzzfR8iWB1szCDsucs6i5WcCYPAT/FjuMBK7VqOue
         MhO1j6o9LPFRn6AFid31rQ4++XcT8of0wcBL2dusTUkZ/1qI/5RqW7bd+MTAQzQx1HwA
         FR5R9nW1bVoynQojMmI2cMqVf3VPk2qP+2NhWrnbSUtI9h9jJ/TLFUdwjsGpwJKHylZ1
         It3SEd/hWOkmqAdQFijmIg14pPfJ9m1WW003W4Hqw2Fho2PV/52Dn4dVCRGBaTh2tRNM
         rlrU/Jvva5enJx7syA5oUannLsW8NTngJEcfHqGtJy9okUcRyWm97wS6e2X847fjob6I
         9kaw==
X-Gm-Message-State: ACrzQf22/7GwoNPYmIe9/bqSpH6QPYevtJIZX3fQGTkqGo5n+YK33KWe
        kBMMNNKb7vN3I5lu2Hq3Is5fVAuHUQ==
X-Google-Smtp-Source: AMsMyM6xwEveyhcFQBvttzseNwCLpoSlmkHUq7T6+pg7ZTNvsWy4AVnWNkyGh5Hr2jjsAMZHehEz9g==
X-Received: by 2002:a9d:63d4:0:b0:66c:572d:e067 with SMTP id e20-20020a9d63d4000000b0066c572de067mr7949792otl.86.1667405228068;
        Wed, 02 Nov 2022 09:07:08 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s37-20020a05687024a500b00127d2005ea1sm6215390oaq.18.2022.11.02.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:07:07 -0700 (PDT)
Received: (nullmailer pid 3979089 invoked by uid 1000);
        Wed, 02 Nov 2022 16:07:09 -0000
Date:   Wed, 2 Nov 2022 11:07:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     joel@jms.id.au, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, colin.king@canonical.com,
        robh+dt@kernel.org, andrew@aj.id.au, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Remove the property
 "aspeed,trim-data-valid"
Message-ID: <166740522806.3978983.397017282901820216.robh@kernel.org>
References: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
 <20221031113208.19194-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031113208.19194-2-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 19:32:08 +0800, Billy Tsai wrote:
> The valid of the trimming data will use the otp default value as a
> criterion.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml    | 7 -------
>  1 file changed, 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
