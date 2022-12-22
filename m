Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB74653E31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiLVKWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVKWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:22:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF010071;
        Thu, 22 Dec 2022 02:22:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5587B81D1B;
        Thu, 22 Dec 2022 10:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636AAC433EF;
        Thu, 22 Dec 2022 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671704562;
        bh=22s/99ngrjGMLNIsEVIM+52lfbZ7CCn6Y6YPEHFsEwA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n2VoowaaAov3rlJlorcSeIQht1unkjO4aYT+/vnfCCuhEbmXXSRM9i4jZ7QfKXVJd
         eEIRkH6T8g9UwNF3X1Q/jmEcmFXOHC58MVEWz3Wg9qRUAfL99HdJdaTkoA5wfxY20/
         n+iT+n4fdehILpa16E7kruNTIT71+P3PktQrDd3j45IKYbfBjPicA0skk0KcxN/M/v
         Vl7U26rdkovEfL9X9VifUPDADXyX88TeoF7q09fq8y6Dm+jF2wm26cErCjDBlgk6Ns
         E2GQWX+wUprsvVZdYARTH/dnArC82K6VsHbmDF0/SmfwacvY03CtO+Imz3k8VG37ct
         IwLCRRUISDRYg==
Message-ID: <2a4b5094-013f-f873-4c0e-bb48ca6ac19e@kernel.org>
Date:   Thu, 22 Dec 2022 11:22:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/7] dt-bindings: Document common device controller
 bindings
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-2-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221221173055.11719-2-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.


On 21/12/2022 18:30, Gatien Chevallier wrote:
> From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>

You same From as SoB.

> 
> Introducing of the common device controller bindings for the controller
> provider and consumer devices. Those bindings are intended to allow
> divided system on chip into muliple domains, that can be used to
> configure hardware permissions.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

Missing SoB.

Missing changelog. This is not v1 but v7 or something.



> ---
>  .../feature-domain-controller.yaml            | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml b/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
> new file mode 100644
> index 000000000000..90a7c38c833c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/feature-controllers/feature-domain-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic Domain Controller bindings

Drop "bindings".

Anyway you duplicate work here:
https://lore.kernel.org/all/c869d2751125181a55bc8a88c96e3a892b42f37a.1668070216.git.oleksii_moisieiev@epam.com/
and maybe you duplicate comments.

I don't think there is point to review things twice, so NAK.


Best regards,
Krzysztof

