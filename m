Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF00F6ECBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjDXMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjDXMIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8DDE7;
        Mon, 24 Apr 2023 05:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A2E6205F;
        Mon, 24 Apr 2023 12:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29DCC4339B;
        Mon, 24 Apr 2023 12:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682338122;
        bh=ErrRKkmK6G6iGbIWajoLixccJTcbn6B4Fn8FiTmI9Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exUbalORHXbDcuUOjUeTThpTF7tzf7kqtNbjqmNpr7yKf6s9FMStZpS5MsALgFVXX
         uEUqgBunzqTlwnXkR6V9JgM4d6FcXZtsIyzKzvbHtozr+hOdkmEegZdxRJBCqEKJtb
         l8f1oy2Iw8yp2oapFUP3Ao3JyB7iJnGY/AK+t4o62azKMQUAJxUr2dDpGb7g1WBSqU
         hN6KHiv4Hlo+iQLl0F9aHZ512004eVMBnxpo54wLYmwLKB2k/iT5+2JerPiv2SUxS8
         p8iMJn1fFC7oQjlc6omEA5wV8fUPb2Uoyan4GXr2EwZ14EU5cPKZT6Hv26uGnttfMu
         YL5RhUA8SrXlw==
Date:   Mon, 24 Apr 2023 13:08:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: x-powers,axp152: Document the
 AXP15060 variant
Message-ID: <20230424120837.GA50521@google.com>
References: <20230417090537.6052-1-wiagn233@outlook.com>
 <TY3P286MB2611439E0FA49C224D639062989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB2611439E0FA49C224D639062989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Shengyu Qu wrote:

> The X-Powers AXP15060 is a PMIC seen on Starfive Visionfive 2 board. Add
> relative compatible item and CPUSLDO support for it.
> 
> Changes since v1:
> - Move cpusldo before drivevbus (Krzysztof Kozlowski)
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
