Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D066BC11D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjCOXcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjCOXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9626C0C;
        Wed, 15 Mar 2023 16:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2AB261EAC;
        Wed, 15 Mar 2023 23:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E87AC4331E;
        Wed, 15 Mar 2023 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923139;
        bh=4m4ZuwhylIIQ3BuTuS+cR53ELOl2Vpk0nnambBTDF1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmyxweWNGWqyYCmnvsYZnO0QM3iGJMAj2aneOPF0scdajDLOCIZB2mVrX0ozk1TmH
         84F0A7G2vMqL6EFoGwwLK0qF75yP2RTGSNR+08Qo7N9bl03FgomlA7LAhP7MtHIqQV
         uMa5H5Hfe9iksZxYugZOQqZ4vCJBkkmn9LQUhdw9fPEfwrwYJvq9FZyIZKEii52ZHC
         VA13wExQ3VJnS6nnowQ37d7YYxYyLouaT2HjJ8Ok8f/diBuyXDtzxFo6dzDh3WgpxS
         tqondHIj2cEbUxMLJ9JvmWSndfVyPPY+U+kAVlcwRRB+vmP2kM1KSwlabxiEKGmbJx
         XMyAn12gxERNg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/2] arm64: qcom: add initial support for qcom sa8775p-ride
Date:   Wed, 15 Mar 2023 16:34:48 -0700
Message-Id: <167892332566.4030021.6399562607714461846.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230214092713.211054-1-brgl@bgdev.pl>
References: <20230214092713.211054-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 10:27:11 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Bjorn,
> 
> I'm resending this because it's been discussed with Qualcomm that we need to
> drop the watchdog node from the DT. Please don't apply the previous version.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: add initial support for qcom sa8775p-ride
      commit: 603f96d4c9d0cb42f934fb0b99440bb9e8ba4385

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
