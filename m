Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6999665EF93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjAEPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjAEPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:01:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6434D70C;
        Thu,  5 Jan 2023 07:01:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B07D661AEF;
        Thu,  5 Jan 2023 15:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317BEC433EF;
        Thu,  5 Jan 2023 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672930893;
        bh=F25JZKchzOLM49nm5uwBownBm0eGt/bdT2dzwKvj1V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3lsmtaN0f+NR/cSLUH/Ma/vQ6k5ubwu3crIibDbg9cC6iBDDdKfaHoLYjOUd1VPf
         Th4ucEeo1Sf6YYIxqwALY+hEVu6kBXMmpBTXtiFZ2zCAqIa8QVud5eq4vliOyVFyaz
         jhd4FNfIklaUTUz1iqLSneQfwughSo7hqG5e7fQQ2HeWkiaUBItEETnNFkM4Fe+vQ8
         ri7yDIprYx0CMpwYvERJjJGlzuQzXoIjSTvio+Y9oZ8es7S+R/6uqH+x5572WkXKyK
         jzV4pPFnozecXevlumuniBenZiLw1uXMjjTTUiKM5IkhKKBizHT0EA+1VU+Oja5a4a
         DouMQfE1vYrEQ==
Date:   Thu, 5 Jan 2023 15:01:28 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mfd: qcom-pm8xxx: Remove set but unused variable 'rev'
Message-ID: <Y7bmSDtkO1q7f+OF@google.com>
References: <20221227081921.56448-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221227081921.56448-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022, Jiapeng Chong wrote:

> Variable rev is not effectively used in the function, so delete it.
> 
> drivers/mfd/qcom-pm8xxx.c:513:6: warning: variable 'rev' set but not used.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3558
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/mfd/qcom-pm8xxx.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
