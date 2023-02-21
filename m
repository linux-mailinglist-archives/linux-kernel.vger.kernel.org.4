Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6769E3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjBUPov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjBUPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:44:46 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D710428;
        Tue, 21 Feb 2023 07:44:43 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id c11so5362461oiw.2;
        Tue, 21 Feb 2023 07:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML6FJgVr1CESsDocvpM6jc9w+sfHk6M5jGKbigbs6cc=;
        b=SXL/dVIvGRrWgzq/kocZIU1myDZtuzAPWb0KRBpN9xWJUfp/ffWUDvqGRHtiFTKXJU
         u5ex1/KB5z+g5xBTdwQmE2hYp9UHoNq56GaRn1vaNK0ZNPQ+2QYjG/B2+e+498yVv9Gz
         m/siyKrtOjFo0wbnJhSOSDarkPnQSrWPC5qtFspbsw19EHwp3bU0bJkWSBhu9Z4PZgtb
         Xr12VrCTBgOeZOgXwItHKQzjEeLVctp3k5lle8KKAt0aJ3sMzb0UfbZ1V7NHpECnME7g
         BFgr/CFAHPHcpu72qCkWZ16xdrmo/DKxan2hIeBmMdRuGsgGYs1K/mXv0ZRcr4jLLUp3
         DDFQ==
X-Gm-Message-State: AO0yUKV8BKa0o5eRp8F4z4iD3IXv1Hl+lXGCVev7NVb+5/iInIDvm377
        7oxLBtrmPmk9Fe3WDv+J7LXakID2Xw==
X-Google-Smtp-Source: AK7set/tUJ9E3057QQUUU+n9CS7QeprCTYQH79dldizvLsyH1qjRbpYQYSoFp2/p+JQrJ0qoyVn3Dg==
X-Received: by 2002:aca:90f:0:b0:36c:a58f:a245 with SMTP id 15-20020aca090f000000b0036ca58fa245mr6703649oij.8.1676994283166;
        Tue, 21 Feb 2023 07:44:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y9-20020aca3209000000b003436fa2c23bsm1414713oiy.7.2023.02.21.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:44:42 -0800 (PST)
Received: (nullmailer pid 2591764 invoked by uid 1000);
        Tue, 21 Feb 2023 15:44:42 -0000
Date:   Tue, 21 Feb 2023 09:44:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH][next] of: dynamic: Fix spelling mistake "kojbect" ->
 "kobject"
Message-ID: <167699428181.2591689.14195770747885222255.robh@kernel.org>
References: <20230220144422.873356-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220144422.873356-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2023 14:44:22 +0000, Colin Ian King wrote:
> There is a spelling mistake in a pr_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/of/dynamic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

