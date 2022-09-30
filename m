Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02355F0BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiI3MqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiI3MqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C226CD2C;
        Fri, 30 Sep 2022 05:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA2D5B828A1;
        Fri, 30 Sep 2022 12:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2027AC433C1;
        Fri, 30 Sep 2022 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664541956;
        bh=35t7qQvnU5XSjtZ6QKxyr1wUdBmE2pOzmuZg69ufAV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvLRr3H7RS8XecmmidI85YkQayvi3MOxPjR98Tv3O3dhM+BQw6v5J02SStHROTmrQ
         CXQsORq93uDkYqZUPDcgOFD8e4t2EdDqEQUVRFihGwYjbqTl4ysUnGo821p0TbHYOg
         AKUP/EcrUEaxcyxiK8oi48vjSHuJnKL5cyQKAgcN1zqDLezysQ8alo66EM6ALc1oya
         xSWrd28ZfzIKYbTvbpnEHg2ISSywpHuv03HbCQlyQvT5SU/LqvhsGnUwtXnEIps1DI
         wE/gqMVoJJLgaBsNCMFIKJEjCKia1jYFMGsWcPfrqen4Aa40wBgYYSbiKLWU9+9sRA
         ImlESejc0wWjA==
Date:   Fri, 30 Sep 2022 13:45:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mfd tree with the qcom tree
Message-ID: <Yzbk/6SQdpNQTahV@google.com>
References: <20220930115816.128513-1-broonie@kernel.org>
 <1e9a21a3-d6c3-3f76-18dc-ff14e8609846@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e9a21a3-d6c3-3f76-18dc-ff14e8609846@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022, Krzysztof Kozlowski wrote:

> On 30/09/2022 13:58, broonie@kernel.org wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the mfd tree got a conflict in:
> > 
> >   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> > 
> 
> Thanks Mark.
> 
> > between commit:
> > 
> >   4f2e28b2cc2e0 ("dt-bindings: mfd: qcom,tcsr: add several devices")
> 
> It seems this commit was picked by both Bjorn/qcom and Lee/MFD.
> 
> > 
> > from the qcom tree and commits:
> > 
> >   f8c1940165bea ("dt-bindings: mfd: qcom,tcsr: Add several devices")
> >   a328ae8504dbc ("dt-bindings: mfd: qcom,tcsr: Drop simple-mfd from IPQ6018")
> 
> This commit depends on the duplicated one (on "Add several devices"), so
> I think all set can stay in MFD and instead Bjorn could drop his copy of
> the commit.

Not sure why Bjorn is picking up MFD patches?

Was this a mistake Bjorn?

-- 
Lee Jones [李琼斯]
