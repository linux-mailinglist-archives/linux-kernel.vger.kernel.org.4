Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F546AFADA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCHAJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCHAI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:08:58 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA299FBFA;
        Tue,  7 Mar 2023 16:08:57 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id bj30so11005601oib.6;
        Tue, 07 Mar 2023 16:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXwIkZ1uxD0E4xCsEg4lApAyXIPzeC7f+IDqZY4PFjg=;
        b=UfaE0B4jv6z2o7DPtmG7X6HCQiR9A+ikuEl3marzbZnEzeRxrTwA6+6/PY0qSGh8OV
         vJRxnMDz9Co3V31IQ43nfHGmRJtejx44BwTbGRjfxJZYkWGCroMEffH9NPnC/44HiQ/n
         Cw9fWAcCCKTGycDq/9L8JoQLfUXRYs9g9ua9qwOIDAtAHOJhuAnQE/Nne7ATU9lSj6tm
         eRPdxVpLhLpEOXNmbMXA+pVSLCwaw7WRYydlYu2oM8NuKMoMyPxQi5D8V1Ni4Nrwzi0A
         y0/gzseDCxz2TTfeVU2viwvoQMB5BUoqQrg8aiLDDJ8+2NJo5/P0RMfeUo80zKJXFYJx
         bakg==
X-Gm-Message-State: AO0yUKXZ63UdMyezeHaKrpDMkWWioW6WUbCXTuxxr3KfTHiHJjdbDygW
        jAZKa5H6sgdF6WaRHCA/DidspP0iK/RL
X-Google-Smtp-Source: AK7set+YyRrc0JXwe+563xRrImH2ceAMEhc5aQe20LUPq57XE+Vw/8+BzT6SqyIsSQXkZQmC6gVBUw==
X-Received: by 2002:a05:6808:153:b0:384:bc3a:a73f with SMTP id h19-20020a056808015300b00384bc3aa73fmr4011885oie.26.1678234135160;
        Tue, 07 Mar 2023 16:08:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h19-20020a056808015300b00384926684b8sm5627699oie.13.2023.03.07.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:08:54 -0800 (PST)
Received: (nullmailer pid 513069 invoked by uid 1000);
        Wed, 08 Mar 2023 00:08:54 -0000
Date:   Tue, 7 Mar 2023 18:08:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 08/21] dt-bindings: nvmem: Fix spelling mistake
 "platforn" -> "platform"
Message-ID: <167823407854.511949.8644806672046927604.robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-9-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165359.225361-9-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Mar 2023 17:53:46 +0100, Miquel Raynal wrote:
> From: Colin Ian King <colin.i.king@gmail.com>
> 
> There is a spelling mistake in platforn-name. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



