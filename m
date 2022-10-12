Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47425FCBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJLTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJLTjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:39:00 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AA35FF52
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:38:59 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 65AB72070B;
        Wed, 12 Oct 2022 21:38:58 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 12 Oct 2022 21:25:18 +0200
From:   konrad.dybcio@somainline.org
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 0/2] add device Xiaomi Mi 6 (codename sagit) and board
 binding
In-Reply-To: <20221012185245.1282599-1-dsankouski@gmail.com>
References: <20221012185245.1282599-1-dsankouski@gmail.com>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <82891b0026f8f43b266245c7c0c85a98@somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-12 20:52, Dzmitry Sankouski wrote:
> Add initial support for Xiaomi Mi 6 phone (codename sagit)
> 
> Dzmitry Sankouski (2):
>   dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
>   arm64: dts: qcom: sagit: add initial device tree for sagit
> 
Looks like you resent this series just to add the A-b on the dt-bindings 
patch?
If that's the case, you don't have to do it, the maintainer will pick up 
the tags
when applying your patch and an essentially empty revision just adds 
confusion.

Konrad
>  .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 681 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
>  4 files changed, 691 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
