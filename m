Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC46A334A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBZRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:48:41 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4D9021;
        Sun, 26 Feb 2023 09:48:39 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id u6so2764621ilk.12;
        Sun, 26 Feb 2023 09:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tACdGgGFajYXgjnpQBRHCU3URa1Aa3HOSGApSi6BQP0=;
        b=myqudvnsG8xmQ98pTy5nIT/dOUOKDebbFWpR32ve25DsFnVDbR2lZSPzUKvI7MBOz/
         z4lg6Dc4UcPTd59FLpoNiP8Uk0VgPcUgMHNDaH5NFhN8BoRgMZ7YO/kKvpGwfCTa5o/E
         cNaZfMaR8/6tE8qxJcOgoc5VBwsGsWAWAi05xojydpHe6h/jQJq5s+JvnEqJMmVMoedx
         Bo3Mop8UlRWo5jD/CAS4k4ZIN8h9znKAA1PcoxEEmZG+qHi6J/jGZYNFD8DMmlg9I7tn
         j2HnAYaVYSFCPDiawEvkaA5JThOpCu6iTs1jeh2WlaCJA/wKCZZqNQtEzzeF384b6GHt
         DAGw==
X-Gm-Message-State: AO0yUKVMhe4B2+EEAKzPvDKu9XQx4HfJAjs7KYEQd93anEbV+gFszD27
        mdr/7eBI3u2l3ZEeCf7aDA==
X-Google-Smtp-Source: AK7set8Wd5SMOa9NAntTVq35NywdsrvS0Q2rvoUt9kZ/yG7JfyCQCXnbFwE/T/rvGtqqOhUIjqeNHg==
X-Received: by 2002:a05:6e02:1a8c:b0:316:e793:9dba with SMTP id k12-20020a056e021a8c00b00316e7939dbamr15338967ilv.26.1677433719096;
        Sun, 26 Feb 2023 09:48:39 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id z19-20020a056638001300b003a9595b7e3asm1479085jao.46.2023.02.26.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:48:38 -0800 (PST)
Received: (nullmailer pid 84297 invoked by uid 1000);
        Sun, 26 Feb 2023 17:48:33 -0000
Date:   Sun, 26 Feb 2023 11:48:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Message-ID: <20230226174833.GA76710-robh@kernel.org>
References: <20230217145645.1768659-1-herve.codina@bootlin.com>
 <20230217145645.1768659-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217145645.1768659-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 03:56:36PM +0100, Herve Codina wrote:
> Add support for the time slot assigner (TSA)
> available in some PowerQUICC SoC such as MPC885
> or MPC866.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml | 215 ++++++++++++++++++
>  include/dt-bindings/soc/cpm1-fsl,tsa.h        |  13 ++
>  2 files changed, 228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
>  create mode 100644 include/dt-bindings/soc/cpm1-fsl,tsa.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
> new file mode 100644
> index 000000000000..332e902bcc21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml
> @@ -0,0 +1,215 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,cpm1-tsa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PowerQUICC CPM Time-slot assigner (TSA) controller
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The TSA is the time-slot assigner that can be found on some PowerQUICC SoC.
> +  Its purpose is to route some TDM time-slots to other internal serial
> +  controllers.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,mpc885-tsa
> +          - fsl,mpc866-tsa
> +      - const: fsl,cpm1-tsa
> +
> +  reg:
> +    items:
> +      - description: SI (Serial Interface) register base
> +      - description: SI RAM base
> +
> +  reg-names:
> +    items:
> +      - const: si_regs
> +      - const: si_ram
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#fsl,serial-cells':

#foo-cells is for when there are differing foo providers which need 
different number of cells. That's not the case here.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    const: 1
> +    description:
> +      TSA consumers that use a phandle to TSA need to pass the serial identifier
> +      with this phandle (defined in dt-bindings/soc/fsl,tsa.h).
> +      For instance "fsl,tsa-serial = <&tsa FSL_CPM_TSA_SCC4>;".
