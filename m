Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B9F602246
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiJRDMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiJRDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC39AFDB;
        Mon, 17 Oct 2022 20:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 905F9CE076D;
        Tue, 18 Oct 2022 03:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C0CC433C1;
        Tue, 18 Oct 2022 03:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062434;
        bh=2lvGC7MIqvJ7vs2I3wfcJKMkobLq2w56iW/gmIr1kfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xravc/PEAC4EPQD6t6gpQO4ofjslFYpc5I0v1vRgNOqPbINfqidJPQqWdzjY3n/39
         sdhdBXAUv2lHEbWs6AD8ze3TglG++M0/U0C1zP0Av+NLRw2R5NEa7Qx/Jd3zsF0cPm
         D/ST5Cz9R6+8s/MbPyYyfwAmPBiGPmrDaOhFm7S635F/zNztm4zH7gNIEhuWVtcYDd
         uqY0VHuvixpnubZ+QHwL8bXix9l3TiX/LQR/oXRcfs4HdrugIDuqBKFoOtDWxc6kcR
         O8MYUH3BLZF2RGy7oGgb2O+sqNgZ7ksOZSkLp07h76AxpnpdUK9n3UKVJ3oSqPVE+a
         O+G0qny8bPv0A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        phone-devel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        caleb.connolly@linaro.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v4 1/2] soc: qcom: spmi-pmic: convert hex numbers to lowercase
Date:   Mon, 17 Oct 2022 22:05:47 -0500
Message-Id: <166606235846.3553294.1104713743944618379.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220922082925.17975-1-luca.weiss@fairphone.com>
References: <20220922082925.17975-1-luca.weiss@fairphone.com>
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

On Thu, 22 Sep 2022 10:29:22 +0200, Luca Weiss wrote:
> There are some IDs that are written in uppercase. For consistency
> convert them to lowercase.
> 
> 

Applied, thanks!

[1/2] soc: qcom: spmi-pmic: convert hex numbers to lowercase
      commit: e0b0da53b7bcf4d55ea9506db151b9596703d4e5
[2/2] soc: qcom: spmi-pmic: add more PMIC SUBTYPE IDs
      commit: 082f9bc60f337fdf4bbb89b5b5d6f8aee9c98d6b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
