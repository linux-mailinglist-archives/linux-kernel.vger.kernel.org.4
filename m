Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED8D63B42C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiK1V0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiK1V0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:26:01 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D60F2F3AE;
        Mon, 28 Nov 2022 13:25:56 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-142612a5454so14691078fac.2;
        Mon, 28 Nov 2022 13:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz69QcYFaerb1+zGHIv1bNvj06x8btPa1WRfWZWVAz4=;
        b=LJyUMIrKhjJ+UPnVJagH8+VDKO/ans2MiJFVaWF1OaM1JyV03uRjvrLOnUEDUPOpHu
         IjUjVWyhVDKXWyEvYHUXADHhVFprDHejGgtWqr1sHzTD963AOjM0oblAwGUWXYkdPKAZ
         CtGRs4twppa/tKsaYaECTz7F8m0WvRIvDU2xwUKhqpW4+IpKluBvManFQof4mP+fq7Wk
         RmLZu/G9uiBA7z47da6dwTQXWtz8TzdwyqhtsPIXNbQxClOJ8UDfVHeA/2eKXXk05pTJ
         AXll24pmxPoS1pYVyqyiXdZ8mdrIL8w08kDgI+hudT1/9Tw5zQcnSciD0pOnzJH1MYRC
         jWnQ==
X-Gm-Message-State: ANoB5pmznRsIoWAtr3R8GnvuZksglo/lx5MtjNf/P/I2+LFgs9F3MOMX
        41O/jBwmeINgVw8i4mlaS/klb3ib/g==
X-Google-Smtp-Source: AA0mqf7tx7gcOABjWcfxZZ8clBbQ/yafLtuYqgvCvucnSFE9E0wBx/5QWnneRzWcLHzkki/vOpNYPw==
X-Received: by 2002:a05:6870:a907:b0:143:8729:26a1 with SMTP id eq7-20020a056870a90700b00143872926a1mr7600209oab.272.1669670755293;
        Mon, 28 Nov 2022 13:25:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y18-20020a9d6352000000b0066b9a6bf3bcsm5142916otk.12.2022.11.28.13.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 13:25:54 -0800 (PST)
Received: (nullmailer pid 1509925 invoked by uid 1000);
        Mon, 28 Nov 2022 21:25:53 -0000
Date:   Mon, 28 Nov 2022 15:25:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND] dt-bindings: leds: sgm3140: Document ocp8110
 compatible
Message-ID: <166967073713.1509515.11919154666220950426.robh@kernel.org>
References: <20220505185344.10067-1-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505185344.10067-1-git@apitzsch.eu>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 May 2022 20:53:44 +0200, André Apitzsch wrote:
> Add devicetree binding for Orient Chip OCP8110 charge pump used for
> camera flash LEDs.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> This patch was originally submitted as part of a series [1]. But only 1/3
> and 3/3 made it into torvalds/linux.git
> So this is a resubmisson to add the missing documentation.
> 
> [1]: https://lore.kernel.org/all/20220212180942.8241-2-git@apitzsch.eu/
> 
>  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied, thanks!
