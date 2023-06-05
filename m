Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EFA722B12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjFEPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjFEPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B04E4B;
        Mon,  5 Jun 2023 08:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D285C61B6F;
        Mon,  5 Jun 2023 15:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F19C433EF;
        Mon,  5 Jun 2023 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685979003;
        bh=ITRoqiSFBqs21EPM1WuquxlL6puwwCP+3OcM6hMuGgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TG3CnnAZ8j2w4olHjvjztA+ySw7tuRtmd/8/j/Dzu7SP3om53z723eZ/ROvyfOk2C
         0mm46Ll2aUgLVTACTbf82/zjfLS5n6zpJzxNka1WDgRHOlLJgjAd8IY1/+9leKRrj0
         xv7wwX6gJLvi+Un96tei5GCoua9F+YkbJuIlyrFcyh6PhyGri/UIdkYi7Az7flHeUQ
         D5HWfVqVDtDoftVaNHqavtBz+SUATTsQWlBeZ2EBo4Bni0CWcTjEDAe1MedBN4bvkK
         BtADJhyeExmg01JX4KcyBDoMM59rK/c1ZHMr221zjmm0TNaYL0d6wqp7vlFFWkXRCN
         mndVs2dRmn+Yw==
Date:   Mon, 5 Jun 2023 16:29:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
Message-ID: <20230605152956.GA21796@willie-the-truck>
References: <20230417125844.400782-1-brgl@bgdev.pl>
 <20230417125844.400782-5-brgl@bgdev.pl>
 <9f2c0b2d-b11e-512f-1566-5097547c60d1@linaro.org>
 <CAMRc=Mey2mjNppokxcNBTyaZPTjBkiuQX-DHTvMXJkiLKq7UoA@mail.gmail.com>
 <83fb5973-5514-6c66-fc15-84fb439f1398@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83fb5973-5514-6c66-fc15-84fb439f1398@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:17:43PM +0200, Krzysztof Kozlowski wrote:
> On 30/05/2023 11:47, Bartosz Golaszewski wrote:
> > On Tue, May 16, 2023 at 1:42 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 17/04/2023 14:58, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> The GPU SMMU will require the clocks property to be set so put the
> >>> relevant compatible into the adreno if-then block.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> ---
> >>
> >>
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Hey IOMMU maintainers, could you please pick this one up for the next
> > merge window?
> 
> I think you missed to Cc them (except Will).

Sorry for the delay, I'll grab this one now.

Will
