Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9856645D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbjAJQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjAJQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:17:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EBB5BA12;
        Tue, 10 Jan 2023 08:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC581617C8;
        Tue, 10 Jan 2023 16:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BB7C43392;
        Tue, 10 Jan 2023 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673367450;
        bh=Ijf2dUYw0I2dE18kW06oPeroTgcqupbvZzwdQhvzM1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bk987HML29p2sWKrn6iaxkaRLs9bgenkefLYIcdOrT4ZT2GDAdmPJu3tE6u0HXGmG
         ZA91B7CHkdwf1YiB5jyQA33tNC+IrYhubWyrZcV1WW7Hff+X4WxnQTnJ2dN7I2wivf
         1XhSH0U7MFkHKACrzQMRpRcsI84cjx6zyJv5nLCJ3w/P8UysTbRd/iM7NGjbp3LIyn
         huuzxBZbPF5hyVl1H7iWLA34SK6l/rMUUqB6bZoo7hsY8Brm4WMMYqa8DP9oMfwQgc
         O5Jp5MmJC0ZFDGbnD4iB+4kh/nxoZa2lqwXvRYWwZ9LdgG2bWv4MkC7aPr/V4KHXWF
         j1pwCP47THJiw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        marijn.suijten@somainline.org, robh+dt@kernel.org,
        jmcnicol@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        fekz115@gmail.com
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: msm8992: Don't use sfpb mutex
Date:   Tue, 10 Jan 2023 10:17:21 -0600
Message-Id: <167336743974.2134489.5775608578928945012.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221219131918.446587-1-konrad.dybcio@linaro.org>
References: <20221219131918.446587-1-konrad.dybcio@linaro.org>
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

On Mon, 19 Dec 2022 14:19:17 +0100, Konrad Dybcio wrote:
> MSM8992 uses the same mutex hardware as MSM8994. This was wrong
> from the start, but never presented as an issue until the sfpb
> compatible was given different driver data.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8992: Don't use sfpb mutex
      commit: 2bd5ab93335bf2c4d22c8db427822ae637ed8dc3
[2/2] arm64: dts: qcom: msm8992-libra: Fix the memory map
      commit: 69876bc6fd4de3ad2dc7826fe269e91fa2c1807f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
