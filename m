Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B84664C81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjAJTbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjAJTbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:31:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47C01EEFC;
        Tue, 10 Jan 2023 11:31:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E65618CF;
        Tue, 10 Jan 2023 19:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CF5C433EF;
        Tue, 10 Jan 2023 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673379079;
        bh=YHM7OnD1xkzNBw2hgChz55Fq/+ac89HX2y+1zDcTRUc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DXZtYRszJm5fXAKV5wizqXg3VnyyOKnHtfK+0m6E5ajzHb8PHnRmGMGofYljLAHih
         +mzLtx8PkIq7cDr1RAlmLnsrc5iwT841E1pJ4OlgUSPCaVz1iLLkLaVpsmQPHKk63q
         /OuIdOTAT+bhyHh3nZw9+gAPMYdBzh3QZ1aPtD1Dh6dZXHXs+E7wBIgRvYRNHpQbdk
         E5W11a6wugzI9NN+kZLIU7tk2BflJ/gnlGn6TE2MPPdXEroaFIST3JIGTBSPQQ4UKe
         v9GV3lk6jgvRVPqgKIBTQrfA/hZBl9b7sXItq3BwNLjdMChJ0sTSW51WPJJTlMVZv0
         8G6AbCSNhwRGQ==
Message-ID: <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
Date:   Tue, 10 Jan 2023 20:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 02:41, Yuji Ishikawa wrote:
> Adds the Device Tree binding documentation that allows to describe
> the Video Input Interface found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed few of them, so clearly this was not sent correctly.


Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> ---
> Changelog v2:
> - no change
> 
> Changelog v3:
> - no change
> 
> Changelog v4:
> - fix style problems at the v3 patch
> - remove "index" member
> - update example
> ---
>  .../bindings/media/toshiba,visconti-viif.yaml | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> new file mode 100644
> index 00000000000..71442724d1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 SoC Video Input Interface Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description:
> +  Toshiba Visconti5 SoC Video Input Interface (VIIF)
> +  receives MIPI CSI2 video stream,
> +  processes the stream with embedded image signal processor (L1ISP, L2ISP),
> +  then stores pictures to main memory.

Fix wrapping.

> +
> +properties:
> +  compatible:
> +    const: toshiba,visconti-viif

Compatible must be specific. You called your SoC visconti5, didn't you?

> +
> +  reg:
> +    items:
> +      - description: registers for capture control
> +      - description: registers for CSI2 receiver control
> +
> +  interrupts:
> +    items:
> +      - description: Sync Interrupt
> +      - description: Status (Error) Interrupt
> +      - description: CSI2 Receiver Interrupt
> +      - description: L1ISP Interrupt
> +



Best regards,
Krzysztof

