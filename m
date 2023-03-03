Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C36A957E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCCKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCCKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FA12F31;
        Fri,  3 Mar 2023 02:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14DA7617B0;
        Fri,  3 Mar 2023 10:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A7AC433EF;
        Fri,  3 Mar 2023 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840263;
        bh=geyRpKqW/C1xIlFL9fn6mHd1B/qGy+tTRgJk7fk6L6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGZkVWyYTmSxt3y0TNLk1E5rA0MZj860DPUG7YPkx2RP+pI/xRu1Lt5BxlyuqjnQN
         ZCf6goztiepWYoiYf+VjDdYObyVRIBJrTJHGO2yl3msA6Zyr5ozwkton/guu+RTD5K
         WjK+ZBEq4DoemN60OEaIOYd4wImLPSlaZc3fV3uQr5h0vHGvzJYSA9gj9aiMxTuIt0
         EVWNYJz9jiL2Y50iuTMbgmvoWl+ErRt+prtPw+RU7hunQO6d91OSCdlVV7GL0GeBc5
         eQve4s5w6SYGq915hL/MS65dgEY+J+SJXEsCKV+ASvBQ03+3AOOvVb9PesJGYSpEVs
         Xa/jJDbTTia1w==
Date:   Fri, 3 Mar 2023 10:44:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] mfd: qcom-pm8008: Use .get_irq_reg() for irq chip
Message-ID: <20230303104419.GU2303077@google.com>
References: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
 <20230216222214.138671-4-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216222214.138671-4-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Aidan MacDonald wrote:

> Replace the deprecated not_fixed_stride flag and the associated
> hierarchy of offsets with a .get_irq_reg() callback.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/qcom-pm8008.c | 56 +++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 31 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
