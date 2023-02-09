Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0833D68FE90
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBIEY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBIEYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B911658;
        Wed,  8 Feb 2023 20:24:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9628D61898;
        Thu,  9 Feb 2023 04:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1291C433EF;
        Thu,  9 Feb 2023 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916485;
        bh=kPB3sPbDPeK1E0XwRxvUqD9D9kV9Ak6axdjOKW61zsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNCPvMGex8WrcqvxT/88f6UP8CPq7Iun39eI/EqNd6Uv0LXoRlcmPMCHayoV3t/Hp
         R++aT/0MH3G16P6L6ZatNh3BhOKKzBghQjJvJEUWMfblLQQr/wni3r0fG4UOurZODI
         l53Oxt+pfzmur4f5gW7je7ve3VgwnOy+7TG0/zulta6Iga1wz0nl1TGmUQ33F3NTTc
         kgqFTnSRuhQPm3cFFhCxfl4CmGciw5nQ9QsSxNIwIOLHzPwdz2ebdVj58seaEf6fpB
         T2ZF3U5xxaxVlgSRwTJ+iO0r6Qe67pMQGpidJW3zM7v0oDBrtnlXEkX0XtnMpdL8E3
         A+6TFZiB+2rqQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible
Date:   Wed,  8 Feb 2023 20:22:43 -0800
Message-Id: <167591660368.1230100.1469946170144348483.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127192139.299228-1-brgl@bgdev.pl>
References: <20230127192139.299228-1-brgl@bgdev.pl>
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

On Fri, 27 Jan 2023 20:21:39 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for the sa8775p platform's Secure Channel Manager
> firmware interface.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible
      commit: 27d71e8063d99b4429832bc52de171ace6b1e562

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
