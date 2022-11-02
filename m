Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B78616915
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKBQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiKBQbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:31:19 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA7BF61;
        Wed,  2 Nov 2022 09:28:18 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10585311otb.6;
        Wed, 02 Nov 2022 09:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nJSx608b/TpY4+GYKApteZFpVgF16DLBjpLPkm45sk=;
        b=JIeKkC7w/LWmHdpuopPSfyLg2qTA+8ugs0YGFXw0ylTvryVcpjp5ixNJw4b5/BJADs
         yRofutl8xMKU3FK4mmfUh3OHulu5TBABx5rdKRRMmlTKfPb0Zjuq5YC7DBtEQQKwAafP
         Vw2zvHN2PfE4vrKRCCwD+xtpvJRvxjNJaSNw8UE4X/sbVUr9kOOHo70yIGXjM587G4V+
         6u5Ro0qENJe4GId9sPgfMnItHyixJpspTX6eoeSIxwHU7sH7WICJ8XjI9NdPdv9bdtXF
         XzeReYebBe8eGG45JOhiZopcwDGK8x8VbG3DD1FebP1D2kAUKD777WhVKcYJZFeYxbXB
         Ak9Q==
X-Gm-Message-State: ACrzQf1c6aM/FnHVwvadASNiDo00rMLWh7PDMUSkJ+bPIkvilpTK2LVP
        k2ZXRu1ZAWX8tWWDwVfchw==
X-Google-Smtp-Source: AMsMyM7ZbiAuHEQjhJvweOsAkVQ6Q/HE+2N5S59s5emWhP1sM/o/lA6OfyAe5XT738DZgsj55O3wMw==
X-Received: by 2002:a9d:51c3:0:b0:66c:7458:d8e7 with SMTP id d3-20020a9d51c3000000b0066c7458d8e7mr2662993oth.84.1667406497902;
        Wed, 02 Nov 2022 09:28:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a056870e61000b00136c20b1c59sm6200826oag.43.2022.11.02.09.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:28:17 -0700 (PDT)
Received: (nullmailer pid 4002455 invoked by uid 1000);
        Wed, 02 Nov 2022 16:28:19 -0000
Date:   Wed, 2 Nov 2022 11:28:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] bindings: pm8941-misc: rename misc node name
Message-ID: <20221102162819.GA4001767-robh@kernel.org>
References: <20221031175717.942237-1-luca@z3ntu.xyz>
 <20221031175717.942237-2-luca@z3ntu.xyz>
 <028adb9d-e8e7-33db-2aae-028a809a061a@linaro.org>
 <8135515.T7Z3S40VBb@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8135515.T7Z3S40VBb@g550jk>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:43:14PM +0100, Luca Weiss wrote:
> Hi Neil,
> 
> On Mittwoch, 2. November 2022 11:35:55 CET Neil Armstrong wrote:
> > Hi,
> > 
> > On 31/10/2022 18:57, Luca Weiss wrote:
> > > The spmi-pmic bindings is now using usb-detect@ for this node, so adjust
> > > the example to match.
> > 
> > Subject should be:
> > dt-bindings: pm8941-misc: rename misc node name
> > instead of:
> > bindings: pm8941-misc: rename misc node name
> 
> Also here I've followed the style of the previous commits to this file
> 
> 4fcdd677c4ea bindings: pm8941-misc: Add support for VBUS detection
> dd6f5afb1c2d bindings: pm8941-misc: Convert bindings to YAML
> 
> Though it seems other commits in this directory recently have used
> "dt-bindings: extcon: " prefix. Do you still want me to change it?

Yes.
