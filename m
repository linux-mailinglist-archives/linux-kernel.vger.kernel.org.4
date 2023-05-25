Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051C971047C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbjEYExp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbjEYEwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBFA194;
        Wed, 24 May 2023 21:51:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB3D64299;
        Thu, 25 May 2023 04:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E353C43445;
        Thu, 25 May 2023 04:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990279;
        bh=qSTxZ8UQVV+rKocSbxvHMIxvskAu7drUyGIHEvlJPtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRLIIpAJRSyKKtkE1/jcWajcrPs7iqE1jOEKFzktRo4Lqwe/2Y+pu2np6dr4+7t4S
         /EObKCHKmWDW7jeflVzOMtNwquVN/kmUnxVUPgaXM0iSDYVaby7iaF9H+GmhFwDDGx
         3a716CmCBsd3Bxrq2FH4wOD7/HnrNLTfj3gAGVWXagCccQL70eMRHZ1nUxwn0HMc8f
         IwOjVajuEMoY48yCDfj+w2ve5dwMZhMXiklygbg/a5rMKTEoH9Nutm2oYGx0ypPpph
         rBt8S36BLALhOCGC5EZaPay5anRv5t2030kwicu3Aic4B01N2Yh0NTlnQ4TlyFAmik
         9w/Q4d+LRObPw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/3] Fix SA8155P RPMPDs
Date:   Wed, 24 May 2023 21:54:00 -0700
Message-Id: <168499048183.3998961.6169134593328396416.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
References: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 15:47:14 +0200, Konrad Dybcio wrote:
> SA8155P has some kind of a faulty firmware that advertises power
> domains that are actually absent (and trying to access them results
> in a lockup and reboot).. This series tries to amend that.
> 
> v1 -> v2:
> - Reuse 8150 indices for 8155
> - As a consequence of /\, only update domains that differ in the DT
> 
> [...]

Applied, thanks!

[2/3] soc: qcom: rpmhpd: Add SA8155P power domains
      commit: 4a08af2f22ba3c2fb26287dc27fa07bf298acb34

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
