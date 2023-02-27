Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74556A4E01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjB0W3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB0W3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:29:07 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459D4D33C;
        Mon, 27 Feb 2023 14:29:06 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-172334d5c8aso9017889fac.8;
        Mon, 27 Feb 2023 14:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFoqsd6EBPQ0PzNdCKJoWZA5o9P3njK484v747rHzjE=;
        b=mA3wWkjykAgF96HAeXFsQLsm+Ae8jmvbBMLerfdoX8ApnIyK8+cQCmW6COXcDQnYA3
         Tt60250jJJVKi8lT9ldCS0EJpr+xzPqcXq7kjBo5R42w9cg2zjrcsHsd6ez6DC5fbGy4
         CuMODpGUFXxBwqssIisI1ERbtwx754oj2Epn31kyEECZ950w8X/Kshw8oGwseK+ksHj9
         BVzJvk0pld7VpM568AEVm7nbugymfbHjRHeNYaAnNzX0W7aC2hlevNoqVJF/MchElLwN
         GC7yTr8tXJWZpuu/6xnz7wRtew7KNn3rX2PjVNi+8eB8XKx/qnOVdw175KPUH4sFhj+2
         iEtA==
X-Gm-Message-State: AO0yUKVESjBtekQyvgZ/gAfdboUMsx2rlOrhUSjJunMAHurhhhYO34Vf
        mX5/FLkYc2U9+N0pfPA5pbDM7NGRKA==
X-Google-Smtp-Source: AK7set9EvaHbC0pq/Q5M8Jesf6gQwD4JT+CCUAwMK4iN767gMIlj2Bv0JNrjP2eDiCwdeJnGYGCy1A==
X-Received: by 2002:a05:6870:c113:b0:173:245d:d26c with SMTP id f19-20020a056870c11300b00173245dd26cmr271200oad.17.1677536945490;
        Mon, 27 Feb 2023 14:29:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x9-20020a4a8689000000b0051d13098c54sm3139588ooh.19.2023.02.27.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 14:29:05 -0800 (PST)
Received: (nullmailer pid 1215162 invoked by uid 1000);
        Mon, 27 Feb 2023 22:29:04 -0000
Date:   Mon, 27 Feb 2023 16:29:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Message-ID: <20230227222904.GC1048218-robh@kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
> 
> 
> On 2023/2/21 7:43, Rob Herring wrote:
> > On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
> >> Add documentation to describe StarFive System Controller Registers.
> >> 
> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >> ---
> >>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
> >>  MAINTAINERS                                   |  5 ++
> >>  2 files changed, 56 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >> 
> >> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >> new file mode 100644
> >> index 000000000000..fa4d8522a454
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >> @@ -0,0 +1,51 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: StarFive JH7110 SoC system controller
> >> +
> >> +maintainers:
> >> +  - William Qiu <william.qiu@starfivetech.com>
> >> +
> >> +description: |
> >> +  The StarFive JH7110 SoC system controller provides register information such
> >> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - enum:
> >> +          - starfive,jh7110-stg-syscon
> >> +          - starfive,jh7110-sys-syscon
> >> +          - starfive,jh7110-aon-syscon
> > 
> > Is 'syscon' really part of what the blocks are called? Is just 'stg', 
> > 'sys' and 'aon' not unique enough?
> > 
> > Rob
> Hi Rob,
> 
> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
> controller, so 'syscon' is added to avoid confusion.

You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2 
different h/w blocks and unrelated to each other? Or 'syscrg' is the 
clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child 
of 'sys-syscon' or possibly just all one node. Please provide details on 
the entire h/w block so we can provide better input on the bindings.

Rob
