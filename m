Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F965701DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbjENNlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENNlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:41:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FACF10FC;
        Sun, 14 May 2023 06:41:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f139de8cefso60535236e87.0;
        Sun, 14 May 2023 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684071706; x=1686663706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+qvnHcB/azIUhjmByanInN+pkcOd92LVDrbUZO6gKU=;
        b=Sj2fAQWPczlH0VqG5hHOFSTTCgAOvfl/SegsvPvdegYis30vX0MbwKvXo4X0O/W73V
         n0mJEjtQvn53XqQaab6hXIJb96BKe5CTLDOX1uofBwAuyOltJDePPyFoWpEDXzSp9Zj/
         LP5CQmNBGln8qyXnleH/YIEl2IeMFjtiDyycJ1eX42d5PHW1awmV7N8sgJSbGevdEUSC
         /5YPVZDsFL33yrx51WBJlflK8SvOaNolxMCWBLNxbOiBPHBEXyMGDgf+AlEi+yAG2Gwx
         3XC8hXzsBMBlZ+e2P+zWutu0Qjnm3hCf8yi0ZsFAXmfL/Eu4/H68vHlbEm+l5+YK+vNS
         Uo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684071706; x=1686663706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+qvnHcB/azIUhjmByanInN+pkcOd92LVDrbUZO6gKU=;
        b=KfllxvXjLfcTdAENvODsQIrotai1QlG3et4FLbfCq7yJhrL9SyllLiHyBc4rp43PAD
         WRgtQ3Qu/4dB35XSGxXM9+WQC1vP721SqZ4mmYALLTnGLc9K9c56bENi08dDsHWG+heQ
         9cRv7skz84fI8UDuOFO6mgnk/TsgFCal3UloWlUoaFXqHzTkBrs+JZ+vt7cjf5qpcePJ
         GD4B2z4k9xQEPN1FESA6ln3hXLC2WwFIDLd5BNlWrU/TfP8bfN85D0WHDWQqguG2/Mo5
         X7a01BC8t/4hrah1ERwQr70UDisxPy8gFTdYBfRDUBrnmSgly9PN5H2pUfnZXW9ElzGe
         lJjg==
X-Gm-Message-State: AC+VfDzMr+s0CIPRRBF0EC/NYLRpBbC28sH5lywMrPenhZxrm8b2+m13
        z2FGY+a1IRlaGfe06YXMI/T1aT4r+HOMeA==
X-Google-Smtp-Source: ACHHUZ7vkpLjRVlgFHbnD4i09hJ/Fxd5i1LjlJnB4WMMZCY0L4enBlQd68HBgM1gDhyw4F2OGcaKmw==
X-Received: by 2002:a05:6512:10c6:b0:4ed:b86b:9cc9 with SMTP id k6-20020a05651210c600b004edb86b9cc9mr5369371lfg.28.1684071705983;
        Sun, 14 May 2023 06:41:45 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id t27-20020ac243bb000000b004f27d033994sm806724lfl.267.2023.05.14.06.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 06:41:44 -0700 (PDT)
Date:   Sun, 14 May 2023 16:41:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     maz@kernel.org, tsbogend@alpha.franken.de, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] irqchip/mips-gic: Don't touch vl_map if a local
 interrupt is not routable
Message-ID: <20230514134143.6uclwfhzkar4jupe@mobilestation>
References: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
 <20230424103156.66753-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424103156.66753-2-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiaxun

On Mon, Apr 24, 2023 at 11:31:55AM +0100, Jiaxun Yang wrote:
> When a GIC local interrupt is not routable, it's vl_map will be used
> to control some internal states for core (providing IPTI, IPPCI, IPFDC

> input signal for core). Overriding it will interfere core's intetrupt

s/intetrupt/interrupt

> controller.
> 
> Do not touch vl_map if a local interrupt is not routable, we are not
> going to remap it.
> 
> Before dd098a0e0319 (" irqchip/mips-gic: Get rid of the reliance on
> irq_cpu_online()"), if a local interrupt is not routable, then it won't
> be requested from GIC Local domain, and thus gic_all_vpes_irq_cpu_online
> won't be called for that particular interrupt.
> 
> Fixes: dd098a0e0319 (" irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

My system doesn't have VPEs but 2x MIPS32 P5600 cores with GIC enabled as
EIC device so I can't fully test this change, but at the very least it
looks reasonable. Indeed performing the local IRQs routing setups for
the non-routable IRQs looks invalid. A similar change can be spotted
in the gic_irq_domain_map() method implementation.

> ---
>  drivers/irqchip/irq-mips-gic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 046c355e120b..b568d55ef7c5 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -399,6 +399,8 @@ static void gic_all_vpes_irq_cpu_online(void)
>  		unsigned int intr = local_intrs[i];
>  		struct gic_all_vpes_chip_data *cd;
>  
> +		if (!gic_local_irq_is_routable(intr))
> +			continue;

Please add newline here to distinguish the skip-step code chunk and
the setup code so the look would look a tiny bit more readable.

>  		cd = &gic_all_vpes_chip_data[intr];
>  		write_gic_vl_map(mips_gic_vx_map_reg(intr), cd->map);
>  		if (cd->mask)

Other than that the change looks good. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> -- 
> 2.34.1
> 
