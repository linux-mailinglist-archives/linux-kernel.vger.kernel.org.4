Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78086585BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiL1STI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiL1SSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:18:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50098175B4;
        Wed, 28 Dec 2022 10:18:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1A466159C;
        Wed, 28 Dec 2022 18:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB54CC43392;
        Wed, 28 Dec 2022 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672251523;
        bh=wQu6V4JXnEqzKaCGFiH6e/Jze+gbQn7pV1zFXUHplkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LT5oq6Zm8kCP0xN2Fh7fvIzJHNmLVvSzL6kGqG6ZgShSvLC5CcNgSA/YuGZyhrPr8
         8r9SxpU1oWKtqXs6/df6abcWGq3WTDYqrJFXt8uiznax9z8qWhvlFGJAkcqo5KeTMT
         GNq6fTEePDHP0VaTovWYW11VlGj3Fs+9zIIb0VZebM+2RRP8eu4jGidENUdrG0+52z
         2lfTq4ucNJcU88UMxHcVO1GVksAZsYW+O96HsrG8A9nbeCsKF+7qien3rA08KLY/ES
         04sCBsb+ou4FQ0GYGJU9Nz0ApfXb1EnycmpQXlVlHf5ijynfKqS5V5L86j0iFcAjxX
         ou7Iv+DVOcSxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     sireeshkodali1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dmitry.baryshkov@linaro.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 0/2] remoteproc: qcom: Add support for MSM8953 ADSP
Date:   Wed, 28 Dec 2022 12:18:32 -0600
Message-Id: <167225151234.950465.1055044011318869402.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221013042749.104668-1-sireeshkodali1@gmail.com>
References: <20221013042749.104668-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 09:57:47 +0530, Sireesh Kodali wrote:
> This patch series adds support for the ADSP PIL as found on the MSM8953
> platform. It is a subset of a previous patch series.
> 
> Changes since v3:
>  * Made ordering of compatible strings lexical in driver patch
> 
> Link to v3: https://lkml.org/lkml/2022/10/8/204
> 
> [...]

Applied, thanks!

[1/2] remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
      commit: 1cfaa13b82c73977e8ddaca63c791203addc39c1
[2/2] dt-bindings: remoteproc: qcom: adsp: Add ADSP on MSM8953
      commit: 4a0510a46c4447ad3e807a1e4d6cf195fd604c1d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
