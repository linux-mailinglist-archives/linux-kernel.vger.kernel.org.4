Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7A5F2B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiJCIOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJCINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F368D4BD09;
        Mon,  3 Oct 2022 00:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 557AD60DC4;
        Mon,  3 Oct 2022 07:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17591C433D6;
        Mon,  3 Oct 2022 07:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664783250;
        bh=qIA7SuX6qZbjWhvfQnpRqwjejMZeenj5lDBV5ylAw7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwWBXO6U5imcOKv3ixnoVkeoNgbiTY/V/tKsNpVJi88QxJ0PFpNXEMmyiFHeAdCbs
         zExzwkKXgfK+k8teN2V+sqH8AZJ8VxbhF3/5FpS6Nide+Ln/MIQXAe3lG9eywpB2/O
         +XFIhYZZ3Ubd7+oV1E2stgsQowp8MX96ssl26Lxs7kkhCVQGRqDrR3A0CGIWJ0B4t2
         Go8U19vuUfHfHf1nnUYgmeDNU07t1mVlZgA2L8B3zDAzcmh+hZqZTTngGmLBoxfFen
         G0/zwBLFdwMScc8Rizrn1s2VxT3vpINILwKhhyPcFYBlZO+cLqK7mjlYVtPjggrMoI
         QHOgzAJ+UyvHA==
Date:   Mon, 3 Oct 2022 08:47:25 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mfd tree with the qcom tree
Message-ID: <YzqTjb9YbECU+EEt@google.com>
References: <20220930115816.128513-1-broonie@kernel.org>
 <1e9a21a3-d6c3-3f76-18dc-ff14e8609846@linaro.org>
 <Yzbk/6SQdpNQTahV@google.com>
 <ef71ab54-d337-1c4c-9b90-ca39b1c1ed17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef71ab54-d337-1c4c-9b90-ca39b1c1ed17@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022, Krzysztof Kozlowski wrote:

> On 30/09/2022 14:45, Lee Jones wrote:
> > On Fri, 30 Sep 2022, Krzysztof Kozlowski wrote:
> > 
> >> On 30/09/2022 13:58, broonie@kernel.org wrote:
> >>> Hi all,
> >>>
> >>> Today's linux-next merge of the mfd tree got a conflict in:
> >>>
> >>>   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> >>>
> >>
> >> Thanks Mark.
> >>
> >>> between commit:
> >>>
> >>>   4f2e28b2cc2e0 ("dt-bindings: mfd: qcom,tcsr: add several devices")
> >>
> >> It seems this commit was picked by both Bjorn/qcom and Lee/MFD.
> >>
> >>>
> >>> from the qcom tree and commits:
> >>>
> >>>   f8c1940165bea ("dt-bindings: mfd: qcom,tcsr: Add several devices")
> >>>   a328ae8504dbc ("dt-bindings: mfd: qcom,tcsr: Drop simple-mfd from IPQ6018")
> >>
> >> This commit depends on the duplicated one (on "Add several devices"), so
> >> I think all set can stay in MFD and instead Bjorn could drop his copy of
> >> the commit.
> > 
> > Not sure why Bjorn is picking up MFD patches?
> > 
> > Was this a mistake Bjorn?
> 
> 
> This was a part of big set MFD + ARM64 dts, so I guess it just slipped in:
> 
> https://lore.kernel.org/all/20220819083209.50844-1-krzysztof.kozlowski@linaro.org/

Thanks for the info.

Fair enough.  It happens.

-- 
Lee Jones [李琼斯]
