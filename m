Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1456F5FC5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJLM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJLM5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625BF33A2A;
        Wed, 12 Oct 2022 05:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1125614E6;
        Wed, 12 Oct 2022 12:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81154C433C1;
        Wed, 12 Oct 2022 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665579433;
        bh=WDbSYWq0wPAI5p27fm3VNziGpqWpDnwBwjDfAlffaJ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Na21Lbq8X4t084BkbZUHMR8zHQJ7j/oMRuo0VLF+gzc38KApN8H3Q00MefrvPdxdb
         AiWpyrrzJyTlLCe2UFnBi1hWNiBjX9LMVUMTExXuetNeYRNfRQHVo+P1PS3qITRIHP
         dLxQ9THvMVwfSl8JY/2XRK5JdBy+p8CD2CA8rDTuslCF3qC/wJ7+dIDpzp+C5tADFM
         EtNNPBhpV/oCd2ovQFT2hy/LFDu9upGZxf2E2As3ROZEZpcv1Xhv0QFEf1HAaFUDYe
         hH4kDvXyPgqEkWx1nEONX0JfyJPDgn91ksVlIpWH2A1TsnXuJ0fipo73HqZctURL/w
         FvwNt9L8AmF5g==
Message-ID: <87380fdb-4053-e8dc-e997-b7c42be025ca@kernel.org>
Date:   Wed, 12 Oct 2022 08:57:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Content-Language: en-US
To:     aakarsh jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
 <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
 <20221011122516.32135-2-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221011122516.32135-2-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 08:25, aakarsh jain wrote:
> From: Smitha T Murthy <smitha.t@samsung.com>
> 
> Convert DT schema for s5p-mfc in yaml format

Convert S5P-MFC bindings to DT schema.

You also missed full-stop.

My second comment was ignored here.


> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt     |  75 --------
>  .../bindings/media/samsung,s5p-mfc.yaml       | 163 ++++++++++++++++++
>  2 files changed, 163 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index aa54c8159d9f..8b137891791f 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

