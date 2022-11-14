Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563F3627A34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbiKNKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiKNKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:12:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55F1FCFC;
        Mon, 14 Nov 2022 02:12:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD43560FB8;
        Mon, 14 Nov 2022 10:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06271C433D6;
        Mon, 14 Nov 2022 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668420739;
        bh=d+jhhaKDwv6gdL1gYoyJvD+Z5TFltg8saUvPEdlfU8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbB2KVI6XinDU5gTRYKFYUTk3K7vADjnnvkpJoqmOiOWnazG99ZyNiH9JocJp7xVQ
         SxZezpZQ2F3qWu6fq1XMiCgXOtd3xGStxFuu56OaJ2UDrmjvvCC8toEV7oXuQ5pErG
         MBPVFnTQ2iP5Q4IQDgm5B2dzA1z8Z+O4XxA+qIcWbAc0UAzlRlXoAzuCN3SYpHyUSb
         oqyQk/kwX4cHLoDa5F4rru0VhjSbtoNWH9XArxSt2z6ZyN/T7lCFhKrOIceDYusfpm
         yo1e9OtJyeP64GvNoqGwVxFkXDDITYbUDWyOfhcCkBJyx5jesAzXM69/IHQ4QtKZNE
         ermTZugZ6qeRQ==
Date:   Mon, 14 Nov 2022 10:12:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: soc: qcom: convert non-smd RPM
 bindings to dt-schema
Message-ID: <Y3IUfKyeP5IREdnZ@google.com>
References: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v3-4-e5e045644971@linaro.org>
 <20221106034823.quftsxs7zpvb73tv@builder.lan>
 <4c31425b-34b5-01ec-a2cf-d8269448766f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c31425b-34b5-01ec-a2cf-d8269448766f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022, Neil Armstrong wrote:

> Hi,
> 
> On 06/11/2022 04:48, Bjorn Andersson wrote:
> > On Fri, Oct 21, 2022 at 05:27:56PM +0200, Neil Armstrong wrote:
> > [..]
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> > > new file mode 100644
> > > index 000000000000..6531c8805894
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml
> > > @@ -0,0 +1,101 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ipc-rpm.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Qualcomm Resource Power Manager (RPM) over IPC
> > 
> > It's true that there's something executing elsewhere in the SoC
> > acting upon the request written to the RPM memory region.
> > 
> > But for me the phrasing "over IPC" applies much more to the SMD/GLINK
> > variant than to this. So I would prefer to just name this
> > "qcom,rpm.yaml" and omit the "over IPC" phrasing.
> > 
> > 
> > Binding looks good to me.
> 
> Thanks I'll post a v4 with these changes,
> Rob, Lee, can I keep your current review tags with only the renaming and removal of " over IPC" in title ?

Yes, NP.

-- 
Lee Jones [李琼斯]
