Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A0366E86B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjAQV3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAQV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:27:02 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF756888;
        Tue, 17 Jan 2023 11:47:47 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id r9so2649187oig.12;
        Tue, 17 Jan 2023 11:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+IHFoNJWYwYixNZZghpYGFBJcJFhIKjJaNACs5VaDg=;
        b=AFeSVfSOq6eJiR21HEQ2lYlGm+8BEq+vNj+r7bEXJJDsQzMcl655MvLI9Rk0hkn36g
         qgD9cOUYgkLUMrFC9XDfC4IxeXoJrv2XEfNn3jVMEZAhAsLBAzeW0q612l8veYatTPZT
         4svrc5Uoj0DAFD1hEfCLglcR7pyiDGbjyXnSvCO9XIM6POzVVk3ZUrdM1CP15cNTF9wy
         Idzu0KfZKxbvv8nZVXxqSFq0fgGT/Z4bCUTulT6Qkt6Y5BQtWRjpCq1DVxAp1BA5kFkQ
         KcnD2mJCnwcT9OMke8Qn246j1vatoDJU2fjmAK/3ZJRK5uoCwEsN94AeMlgyxfRK5xwp
         iWHA==
X-Gm-Message-State: AFqh2kpfr1DazqywBaoLxUmklXG0SkBQT6MWI9xxbHSPXfV4F9gwe1BW
        nwobVEmqVwy/DhA6/ovWJA==
X-Google-Smtp-Source: AMrXdXujfZaapsByhZr4E6YBRkw8ujbS+ZP+/j3Kv4OhbIefb/RcTZAmG0lwDWXDMD3jQF4BOUDlcw==
X-Received: by 2002:a54:4583:0:b0:364:625a:1b03 with SMTP id z3-20020a544583000000b00364625a1b03mr2023125oib.25.1673984867146;
        Tue, 17 Jan 2023 11:47:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u30-20020a056808151e00b0035bd65b776bsm15339321oiw.2.2023.01.17.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:47:46 -0800 (PST)
Received: (nullmailer pid 3523628 invoked by uid 1000);
        Tue, 17 Jan 2023 19:47:46 -0000
Date:   Tue, 17 Jan 2023 13:47:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
Message-ID: <20230117194746.GA3507270-robh@kernel.org>
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
 <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
 <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
 <18cab846-f62a-93f2-8d47-17b37b638278@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18cab846-f62a-93f2-8d47-17b37b638278@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 08:10:40PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2023 16:43, Bhupesh Sharma wrote:
> > On Mon, 16 Jan 2023 at 13:23, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/01/2023 22:33, Bhupesh Sharma wrote:
> >>> On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 13/01/2023 21:10, Bhupesh Sharma wrote:
> >>>>> Fix the following '#address-cells' & '#size-cells' related
> >>>>> dt-binding error:
> >>>>>
> >>>>>    $ make dtbs_check
> >>>>>
> >>>>>    From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> >>>>>         arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
> >>>>>               #address-cells:0:0: 2 was expected
> >>>>>       From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> >>>>
> >>>> Don't we want rather to unify the soc address range?
> >>>
> >>> Well, the assumption in the original dt-bindings was that every reg
> >>> variable is 4 * u32 wide (as most new qcom SoCs set #address- and
> >>> #size-cells to <2>). However, that is not the case for all of the
> >>> SoCs.
> >>
> >> Hm, which device of that SoC cannot be used with address/size cells 2?

If 1 cell does the job, then it should be allowed. I'd go a step farther 
and say # of cells should only be as big as needed and that's the 
address size of the children.

> > 
> > As noted in the git log already the geniqup on sm6115 / sm4250 cannot
> > be used with address/size cells 2 (See:
> > https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sm6115.dtsi#L795)

Why can't they use 2? Is it because you forgot 'dma-ranges' and you want 
to implicitly limit DMA to 32-bits?

Unfortunately 'dma-ranges' is frequently omitted so we treat missing as 
1:1 dma-ranges (i.e. empty).

> 
> That's not relevant and not answering to my question. Address/size cells
> affect children, so not geniqup. address-cells 2 means you have
> everywhere 64 bit addresses, so which devices cannot work with such DTS?
> If you claim that geniqup and its children has some troubles - please
> point what troubles. The DTS and existing address/size cells have
> nothing to do with it.
> 
> Best regards,
> Krzysztof
> 
