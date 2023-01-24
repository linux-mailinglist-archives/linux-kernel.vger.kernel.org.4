Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7990C679F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjAXRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjAXRDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:03:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C0DBE7;
        Tue, 24 Jan 2023 09:02:46 -0800 (PST)
Received: from [192.168.2.197] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DAD86602E22;
        Tue, 24 Jan 2023 17:02:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674579765;
        bh=VAJAGj9mDF7o3WZ3VOmzDTm34wwnrr+/a3gGZ+27DcI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OqA6JBs5LLnbiF3bNfeASDGBc4uGRUfEr6zBijDjjsUF63mSKkRq61H+Ogw9Va3U5
         nXK1JWLUho68iAggIZRLRUaU3vAJzpDl7Ea9j/EXVA2YnShDKFWGszLSNQ5aex2/xt
         lRC2qqNKV84Q6dsmY94S3inYxg+tY1jgQlEbBChdhQVKfylFuG97e6KJny1mjhgtxc
         v49Ei6tcwTPI+78x+xVmsZGn59CmY6jUoag06XVedrIQtZHKceH2Ao8SQSqvCwUYKf
         fQ8fSgDT+4wrTCWXwjeeQ62Dt0ZXeCrrALllFMtrGu5qpGKWVPxKfr2x2hqhJnd0GO
         EchjENhVjcddg==
Message-ID: <cdc91bc4-aa76-f824-36c9-d2995c17fb18@collabora.com>
Date:   Tue, 24 Jan 2023 20:02:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 02/21] dt-bindings: display: tegra: vi: add 'vip'
 property and example
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
 <20221229133205.981397-3-luca.ceresoli@bootlin.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221229133205.981397-3-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/22 16:31, Luca Ceresoli wrote:
> +        vip {
> +            compatible = "nvidia,tegra20-vip";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +                reg = <0>;
> +                ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    port@0 {
> +                        reg = <0>;
> +                        vi_vip_in: endpoint {
> +                            remote-endpoint = <&mt9v111_out>;
> +                        };
> +                    };
> +                    port@1 {
> +                        reg = <1>;
> +                        vi_vip_out: endpoint {
> +                            remote-endpoint = <&vi_in>;
> +                        };
> +                    };
> +                };
> +            };

In the changelog you said that the channel@0 node is removed

-- 
Best regards,
Dmitry

