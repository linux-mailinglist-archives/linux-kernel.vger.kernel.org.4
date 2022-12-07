Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55C645E18
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLGPyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiLGPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:53:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1605BE0C;
        Wed,  7 Dec 2022 07:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3554A61AA0;
        Wed,  7 Dec 2022 15:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D51EC433D7;
        Wed,  7 Dec 2022 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670428412;
        bh=IZZx+Ki5noX8jGBotoEV8vMit8npaFRikHxYnAFS9h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkNUCkjRbA94oNYJPHhO6lVfzHZWR6BW4DzN9hhmZmMDfvYHDj1JWTApBnw/QJX8E
         0Au/G+i+fDcxjA5/7hqj+fPYYAlGJO+t4Zy29mciqK8fWlN1WjSOZ1uNUjtzeRIi3x
         XcFun6unQDCSh4vM1zu9lfvUcjoW9eEBvOVdnJsOpU5lQgnPdi1khrOboAdNIgIshf
         Z7+bcRiJngn7unvVivGjhBKDsjc3ix4AIorT6UAcPbLRsCiNcLtdSE87uQbvCbuYl9
         mGsN86Tbe9YSAX38dk02OnbpX6Cw7gRk6MbdRB92FReIG6xYYgszhwGg0kMCjhVk8Z
         QssPPpZpDSsrg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        quic_mojha@quicinc.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, rishabhb@codeaurora.org,
        quic_sibis@quicinc.com, mathieu.poirier@linaro.org,
        agross@kernel.org, sidgup@codeaurora.org
Subject: Re: (subset) [PATCH v2 1/2] remoteproc: qcom_q6v5_pas: disable wakeup on probe fail or remove
Date:   Wed,  7 Dec 2022 09:53:25 -0600
Message-Id: <167042840345.3235426.16469925193980791677.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221118090816.100012-1-luca.weiss@fairphone.com>
References: <20221118090816.100012-1-luca.weiss@fairphone.com>
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

On Fri, 18 Nov 2022 10:08:15 +0100, Luca Weiss wrote:
> Leaving wakeup enabled during probe fail (-EPROBE_DEFER) or remove makes
> the subsequent probe fail.
> 
> [    3.749454] remoteproc remoteproc0: releasing 3000000.remoteproc
> [    3.752949] qcom_q6v5_pas: probe of 3000000.remoteproc failed with error -17
> [    3.878935] remoteproc remoteproc0: releasing 4080000.remoteproc
> [    3.887602] qcom_q6v5_pas: probe of 4080000.remoteproc failed with error -17
> [    4.319552] remoteproc remoteproc0: releasing 8300000.remoteproc
> [    4.332716] qcom_q6v5_pas: probe of 8300000.remoteproc failed with error -17
> 
> [...]

Applied, thanks!

[1/2] remoteproc: qcom_q6v5_pas: disable wakeup on probe fail or remove
      commit: 9a70551996e699fda262e8d54bbd41739d7aad6d
[2/2] remoteproc: qcom_q6v5_pas: detach power domains on remove
      commit: 34d01df00b84127be04c914fc9f8e8be1fcdf851

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
