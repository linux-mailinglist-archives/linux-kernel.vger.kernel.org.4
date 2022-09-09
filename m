Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68B5B36B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiIILum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiIILug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:50:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD6102D6B;
        Fri,  9 Sep 2022 04:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FA85B824F0;
        Fri,  9 Sep 2022 11:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68D9C433D6;
        Fri,  9 Sep 2022 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662724229;
        bh=PtQE/YhXm6St5Y9JcAd1LJh87edXn81fJl5QLGWj/kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+Iluq77ucNorR29R6YwzNMUt5accogZTJmkvYv17gl/mXvDEMklaE4mbhjOr+mCs
         ZlEs4BSrHWIdIt+BIUz0+wrZBy08Vw4tG8D/wJgduSvnCmqmmksAal7zT8Y/IlrpmQ
         Lnjh3UiayP7t1qAoJ9D8wQx1CXmLovb3q49tosHg0Azb465TiLaylb72L6cbqxgaGU
         95ta8EctiYo7VjlB2mOkjwTD6Ub3HTz2fjAqbNrVj8K36aDfgSqmrpLvlHcfHWQcsw
         m+u0vHvLmElAPSJz4xazcttJjv4fck1YodoIh8dOCkYzyr78h/524oWGMxTZd1L1eJ
         wtCpjGmxNR1PA==
Date:   Fri, 9 Sep 2022 12:50:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Cixi Geng <gengcixi@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        baolin.wang@linux.alibaba.com,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YxsofwCfTZqqJOiK@google.com>
References: <20220909073456.239668-1-gengcixi@gmail.com>
 <20220909073456.239668-2-gengcixi@gmail.com>
 <Yxr0+LJWWsF53dr2@google.com>
 <CAF12kFteDZLk-2PBufnuar43bgPzoxWsOjR0-zQ01ZqLyTCxQw@mail.gmail.com>
 <dc63bd52-edbf-d13b-86b3-db83bfd8b7e1@linaro.org>
 <CAF12kFt95PYcK249Zm8r+jZtEm3vGTd3AXn2DB_CG0Xf=3xeFQ@mail.gmail.com>
 <fe1838eb-8ec5-62a9-3d90-bf2fe4070535@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe1838eb-8ec5-62a9-3d90-bf2fe4070535@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022, Krzysztof Kozlowski wrote:

> On 09/09/2022 12:16, Cixi Geng wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 于2022年9月9日周五 17:57写道：
> >>
> >> On 09/09/2022 11:50, Cixi Geng wrote:
> >>> Lee Jones <lee@kernel.org> 于2022年9月9日周五 16:10写道：
> >>>>
> >>>> On Fri, 09 Sep 2022, Cixi Geng wrote:
> >>>>
> >>>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>>>
> >>>>> Add bindings for Unisoc system global register which provide register map
> >>>>> for clocks.
> >>>>>
> >>>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> >>>>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>>>> ---
> >>>>>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> >>>>>  1 file changed, 68 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> >>>>
> >>>> I'll take this when the clk driver changes are merged.
> >>> this patch is depends on the clk dt-bingdings, which is already merged [1]
> >>
> >> which is merged to different tree, so this one here cannot go via MFD
> >> tree without cross-tree merges.
> > Hi Krzysztof:
> > I test on the latest kernel 506357871c18e06565840d71c2ef9f818e19f460
> > (torvalds/master) version:6.0.0.rc4
> > what you mean is I must warting your branch upgrade the cross-tree?
> 
> Ah, you linked email message so that rather indicated applying to clk
> tree, but indeed it is already in the mainline.

... and also, I'm *still* not playing that game with DT bindings.

It's bad enough that we have to sync across subsystems to avoid
build-breakages.  If documentation comes together in -next and
subsequently Mainline that should be adequate.

I doubt Linus is running DT checker(s) on each pull-request he merges,
nor are there any stipulations for DT bindings to be bisectable
post-merge.

-- 
Lee Jones [李琼斯]
