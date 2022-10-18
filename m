Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476BC6021CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJRDH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJRDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD11659E;
        Mon, 17 Oct 2022 20:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F3B6B81BDF;
        Tue, 18 Oct 2022 03:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A086C43143;
        Tue, 18 Oct 2022 03:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062395;
        bh=wwH3kXkF5b9/j45O+71rK3UCfCfCJ1NTBp4FMKc5syE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOf3C3OOrOKqqaOFv7gix4GPkd6xxN22myTCvzP8CISjK0ZsZRv2KDPQg/SFiu7Hj
         Zxp1xoSEBgyDMVoNekLOs9LFCdsxkWh5VEBwFdzg+508F/Jd/IHPz65h6/ImWh7Mhs
         1u9KHJ1OPnZjfe1mxgSG/tNLpG/SSZgaJoY1re+riz8yGJ4hYSTtyBEO2h5E3vtXqu
         IrG5QtWiCX/Ux1a2f1ACixvQzcXIUnfmom9dEVICtPZXPTsfN5NWol1tSCHr8klrPR
         tLZSSWaQ3sJ3RUU/rmZ+NI0lDreOufdg6eSVugroGZJpTn52mJRPq+CzrQgRwlS1wA
         K/kFcnTBlheng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     joelselvaraj.oss@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        robh+dt@kernel.org, agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 0/3] Add support for Xiaomi Poco F1 EBBG variant
Date:   Mon, 17 Oct 2022 22:05:17 -0500
Message-Id: <166606235854.3553294.4567323167810982228.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
References: <20220909035447.36674-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 22:54:44 -0500, Joel Selvaraj wrote:
> Changes in v5:
> --------------
> - Do not rename the compatible property of the existing variant (Tianma)
> to avoid any further conflict with other projects/users.
> (Suggested by Krzysztof Kozlowski)
> 
> Changes in v4:
> --------------
> - Update board's compatible and model property to distinguish between the
> two variants. (Suggested by Krzysztof Kozlowski and Marijn Suijten)
> - Update the dt-bindings as per the new compatible values.
> (Fix checkpatch.pl script warnings)
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts
      commit: dd6459a0890a17e136c539abda07f8b671615c29
[2/3] dt-bindings: arm: qcom: Add Xiaomi Poco F1 EBBG variant bindings
      commit: 341fdef8ea49448a0c44a17ab442a1d25e4481fa
[3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi Poco F1 EBBG variant
      commit: bcf429831ecb4810caf1454f6692352401616ad4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
