Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B36C68C96D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjBFW3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBFW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79731043A;
        Mon,  6 Feb 2023 14:28:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8274461048;
        Mon,  6 Feb 2023 22:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC26C433EF;
        Mon,  6 Feb 2023 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722511;
        bh=c/TCJY6Y0ZMPKpUQgcp0A16Ybp/2o4HKGJHBZC2TKjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6YOnkqbI16bEla501+M/uaU1dRHOY9RfvuAWoZhYWxU5PKiReVpg4yx4AB3/yoAF
         2Rmai8sQmNjjFdaFwJjM6tjE2jOa6Q4vmGEhVFRxwpLN41geAoDerSPNQxkOmIhM6Q
         SUD8DdKphhu33i5Z/5/A66DaFXPj8V6X+IbVwLQM43WJIOYkgTiIzhTcQR50qAtTfk
         JK0o2oCLuCyyI0goboyHeSVO9p028GeAg3XGBbCUkoKBR4IriKzr9d/SAj12Mb7woZ
         hoM9z5XwwzHwJfHDFf5AJYts11NE2gNmn0J+NoS2holx+RqjNfFz+oS4LLIrSljKVY
         tc7AaNSoo7JnQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, Tom Rix <trix@redhat.com>,
        konrad.dybcio@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: remove redundant calculation of svid
Date:   Mon,  6 Feb 2023 14:30:39 -0800
Message-Id: <167572263441.3569822.2330094320781179275.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206135831.1794583-1-trix@redhat.com>
References: <20230206135831.1794583-1-trix@redhat.com>
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

On Mon, 6 Feb 2023 05:58:31 -0800, Tom Rix wrote:
> gcc with W=1 reports
> drivers/soc/qcom/pmic_glink_altmode.c:223:13: error: variable ‘svid’ set but not used [-Werror=unused-but-set-variable]
>   223 |         u16 svid;
> 
> From reviewing the code, the setting of alt_port->svid does the same calculation.
> Both are not needed.  For debuggablity, keep the setting of local svid.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink: remove redundant calculation of svid
      commit: dcb4e7a57cbe8d85e4927f517ae28aab17596419

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
