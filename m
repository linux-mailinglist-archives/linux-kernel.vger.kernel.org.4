Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C5663FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbjAJMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbjAJMD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:03:27 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE93E58FA7;
        Tue, 10 Jan 2023 04:03:23 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D44123F272;
        Tue, 10 Jan 2023 13:03:16 +0100 (CET)
Date:   Tue, 10 Jan 2023 13:03:15 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Lux Aliaga <they@mint.lgbt>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org
Subject: Re: [PATCH v6 0/6] arm64: dts: qcom: sm6125: UFS and
 xiaomi-laurel-sprout support
Message-ID: <20230110120315.53edpr334vlpaxc4@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org
References: <20230108195336.388349-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108195336.388349-1-they@mint.lgbt>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-08 16:53:30, Lux Aliaga wrote:
> Introduce Universal Flash Storage support on SM6125 and add support for the Xiaomi Mi A3 based on the former platform. Uses the name xiaomi-laurel-sprout instead of the official codename (laurel_sprout)

Don't forget to wrap these lines properly, same for the changelog below.

> due to naming limitations in the kernel.

I doubt it's a limitation, more like a convention.

> Changes since v5:
> - Drop "non-removable" property from ufs_mem_hc for sm6125 platform
> - Drop "status" and "autorepeat" properties from gpio-keys node for xiaomi-laurel-sprout
> - Rename "key-vol-up" node to "key-volume-up" for xiaomi-laurel-sprout
> - Drop "gpio-key,wakeup" property from key-volume-up node for xiaomi-laurel-sprout

No, you /replaced/ this deprecated property with wakeup-source, which
has the same meaning.

> - Set "linux,input-type" and "wakeup-source" properties on key-volume-up node for xiaomi-laurel-sprout

No, you /removed/ linux,input-type because its value 1 for EV_KEY is
already the default.

> - Change "key_vol_up" node name to "vol-up-n-state" and its label to "vol_up_n" in PM6125 GPIO node for xiaomi-laurel-sprout
> - Use labels instead of node names for PM6125 ADC channels in xiaomi laurel-sprout
> - Set "regulator-allow-set-load" properties on l4, l5, l10, l11, l18 and l24 regulators on xiaomi-laurel-sprout
> 
> v5: https://lore.kernel.org/linux-devicetree/20221231222420.75233-2-they@mint.lgbt/
> 
> 
> 

No need for excessive newlines here.

- Marijn
