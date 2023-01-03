Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F265C37B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjACQC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjACQCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:02:52 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFAB12620
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:02:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so46244095lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgigOp/BDnrhnzW3nlR0k0WEcItybZNjdktVTzoHZ7Y=;
        b=hCPyFhjTGk42B94xe/jf0susiJ0LVpNhHCKPZTj1SHvwINGkiiZ+4FNEa0Fndu4GCx
         NOetwcg4Izq20P+TQPHCm2BkuikGerqwSFDxOXVc0GlrOQK1oDqarf71qhtKQd0Asqct
         mx8yPXC9MpgjphJ1+ipszpWOzqOYg9D+F+qGOUF5mRBet0ebhbdbMep88y/wDlN5bl5p
         AibMpp9TsHXVx5hap0UPIdrubMCN8aPNbtErv4r4TY2MOpnw1MFzOLxwgloo2onilDP5
         WRsIYkqsZQ3qR175a68OdIW6TKmx0D8IfUV9xqGrYqUVhhA9Gaa8kaWWPjPSil8JamL9
         7lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgigOp/BDnrhnzW3nlR0k0WEcItybZNjdktVTzoHZ7Y=;
        b=3UyStdZJRc+HtnDQE4MRJW7Wo2x0qcSSxjdhso/6diypoajm1dbrjUBN75TJQQvFU1
         1KyNGOxHBetRL826Q2/n4Ey7IjevNPo1Lzan/Dn3WdvbK7dBqUAg5KzI9sH1x3zoK3mp
         wVYWw1mbwJFbjcXkMrrrf6GT6YWCuFYdfAAvMh9IOmuD/NWPf/Dhd0+caTWCzjPbP+j/
         2P61Qn/fle8K7bpIWDIKLzWSQdGJnzxP0sear/CGZ9YToB/pl5bDZ6vTVv7t0YiIZMwe
         LTjConqGp9K0IPpnfxC472aAokbJiRlLlDk9+wVSPf42YBlt0uw1yPOg+EnnNY6ArEIy
         UUFg==
X-Gm-Message-State: AFqh2kqNSAx1AvFsgW8eEtpiHwcVbwEvtCmEWo76UI+7oW1Ze4KdoLPi
        Hs7TldqznSHQSFeb8h7qqBL5nQ==
X-Google-Smtp-Source: AMrXdXt/Wmnjo9s+K2h+jBp08gvIIRAE5SbDp07zD48J8EnmzDnC2FUXDM03Qc5VR76CW0f5zIIPsQ==
X-Received: by 2002:a05:6512:2804:b0:4c0:91d0:e7ad with SMTP id cf4-20020a056512280400b004c091d0e7admr16266370lfb.26.1672761769107;
        Tue, 03 Jan 2023 08:02:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p16-20020a2eb110000000b002800493d63asm12556ljl.6.2023.01.03.08.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 08:02:48 -0800 (PST)
Message-ID: <459fd14d-e0e0-0878-cb37-479c8d02e487@linaro.org>
Date:   Tue, 3 Jan 2023 17:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] Documentation: add Marvell MHU driver bindings
Content-Language: en-US
To:     Wojciech Zmuda <wzmuda@marvell.com>, linux-kernel@vger.kernel.org
Cc:     jassisinghbrar@gmail.com, robh+dt@kernel.org, sgoutham@marvell.com,
        devicetree@vger.kernel.org,
        Wojciech Bartczak <wbartczak@marvell.com>
References: <20230103155612.6217-1-wzmuda@marvell.com>
 <20230103155612.6217-3-wzmuda@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103155612.6217-3-wzmuda@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 16:56, Wojciech Zmuda wrote:
> From: Wojciech Bartczak <wbartczak@marvell.com>
> 
> Marvell Message Handling Unit is a mailbox controller present in
> Marvell OcteonTx and OcteonTX2 SoC family.

1. Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

2. Subject: drop second, redundant "bindings".

3. Subject: drop "driver", unless your piece of hardware is called driver?


> 
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> Signed-off-by: Wojciech Zmuda <wzmuda@marvell.com>
> ---
>  .../bindings/mailbox/marvell,mvl-mhu.yml      | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml b/Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml
> new file mode 100644
> index 000000000000..e06a17eab0f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/marvell,mvl-mhu.yml

Filenames should be based on compatibles, e.g. be the same.

> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/marvell,mvl-mhu.yml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Message Handling Unit driver

Drop driver

> +
> +maintainers:
> +  - Sujeet Baranwal <sbaranwal@marvell.com>
> +  - Sunil Goutham <sgoutham@marvell.com>
> +  - Wojciech Bartczak <wbartczak@marvell.com>
> +
> +description:
> +  The Control-Processors Cluster (CPC) provides Arm-platform specification
> +  entities for managing the system. On of the CPC processors is the System

On->One?

> +  Control Processor (SCP). The SCP is responsible, among others, for booting
> +  the chip, clock and power initialization, controlling power consumption
> +  through DVFS, monitoring temperature sensors and controlling AVS. The SCP,
> +  as each XCP, contains mailboxes for software-to-software communications.
> +  Mailbox writes cause an interrupt to the local XCP core or to the AP.
> +  This driver exposes AP-SCP Message Handling Unit to the system, providing
> +  the mailbox communication mechanism to the system, with the intention
> +  of plugging into the SCMI framework. It is designed to work with Marvell
> +  OcteonTX and OcteonTX2-based platforms.
> +  Mailbox has no other usage than SCMI communication. In case of
> +  configurations running without SCMI support it should be disabled.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: marvell,mbox

This is too generic. Are you sure that all Marvel mailboxes - past,
current and future - will be exactly same as this one. No differences
for next 100 years? IOW, compatible has to be specific to hardware (SoC,
device etc).

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    description: Index of the channel
> +    const: 1

No interrupts?

> +
> +required:
> +  - "#mbox-cells"
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +		/ {

Use 4 spaces for example indentation.

> +			mailbox: mailbox@28,0 {
> +				compatible = "marvell,mbox";
> +				#mbox-cells = <1>;
> +				reg = <0xE000 0 0 0 0>;/*  DEVFN = 0xE0 (1C:0) */

1. reg is a second property, after compatible.
2. unit address is wrong.
3. lowercase hex.
4. Two spaces after /* but missing space before.

> +			};
> +
> +			/* ... */
> +
> +			firmware {
> +				scmi {
> +					compatible = "arm,scmi";
> +					mboxes = <&mailbox 0>;

Drop entire firmware example, unrelated.

> +					mbox-names = "scp_ap";
> +					/* ... */

Best regards,
Krzysztof

