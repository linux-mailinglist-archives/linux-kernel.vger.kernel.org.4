Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA5D69845B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBOTTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBOTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:19:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380FB3BDBE;
        Wed, 15 Feb 2023 11:19:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39384CE26D5;
        Wed, 15 Feb 2023 19:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E3C433D2;
        Wed, 15 Feb 2023 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676488761;
        bh=U0XX3CZxvqHoARBipoL3LbLMRv1s0v0bLv6CUnxmXKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pymbhp4mtQx3V3Tbl+rydba0C9B6JoQi9AfaA36EWkhGQf2+JpENAwSw3o5ttdCu/
         XeDIZPg/HGKIMf6i1t1nX2U+5MFE4Az07h3i5QYLD18qfs91LFqDecaCHWj4FaAyUc
         fiYBuxw+MfXuXcMStRwErTiTa7m+mtCHf50Wo1ybqfMqhC+CfyLzTUwrRFpZ5EhzQq
         1vxl9p1Npet+H3q9pVXyMFkPOQ66pZ04d6OK+83OaWLDw3TNsg3RzlHY/pn/xLnBZf
         thiGyP9xM0FKhUCIVuqnYwQ1pn65ql7fStPSYw11Mdbmmi+TysTJeq1TV76aJl2rl3
         sk//Xsf3PXdkw==
Date:   Wed, 15 Feb 2023 11:21:23 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 4/7] dt-bindings: mailbox: qcom,apcs-kpss-global: drop
 mbox-names from example
Message-ID: <20230215192123.4ore7ac6tnedrsyq@ripper>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <20230208101545.45711-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208101545.45711-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:15:42AM +0100, Krzysztof Kozlowski wrote:
> Qualcomm G-Link RPM edge bindings do not allow and do not use mbox-names
> property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None.
> 2. Previously was sent as separate patch.
> 
> There are no strict dependencies. This can go anytime. The next patch
> (glink-rpm-edge) should be applied in the same or later cycle (could be
> via different trees).

Jassi, I missed this note and merged the following patches, introducing
the forecasted issue in linux-next. To remedy this, I took the liberty
of merging this patch as well into the remoteproc tree.

Regards,
Bjorn

> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index 943f9472ae10..56b386b688b3 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -155,7 +155,6 @@ examples:
>          interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>          qcom,rpm-msg-ram = <&rpm_msg_ram>;
>          mboxes = <&apcs_glb 0>;
> -        mbox-names = "rpm_hlos";
>      };
>  
>    # Example apcs with qcs404
> -- 
> 2.34.1
> 
