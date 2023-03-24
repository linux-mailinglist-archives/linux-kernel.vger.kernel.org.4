Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AE6C851E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjCXSb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCXSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E62211CF;
        Fri, 24 Mar 2023 11:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CDE62BAB;
        Fri, 24 Mar 2023 18:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E5BC433D2;
        Fri, 24 Mar 2023 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682696;
        bh=giksiwG+y1raPFgsECEMPdOl5K4x1ObUSLCYbKv5zjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQxP5fxOs60fPY0E0G1qWA7T++jwBHZEf9/Z2GVI/xpF9tyGApH590lydJuywkJSf
         9fgxoQPht9h0EGmAjNHodJ6l6o23dHKMqXin48cf4UgoyItq2iM/pHZfi4GsqPVVdg
         8aOX8W2M4/T/M8i1CD//jW7/dQQb5o1TmA/uESUzMJVa5CajkL7IlIj6Xwp6X+IUG0
         rHMSWP5xQRLzZT2caNHTPrzx8y213M47taI2uvUO5iT7UGLD27A83AlAKXmyuIYzKj
         aElnomZgEleeVGir1v8/GHXd+NZIJHW2I/raqE34fksD1u/IjLAiL5sh/0ixXCDNM5
         tnfM06FryG8gA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ye.xingchen@zte.com.cn, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH] soc: qcom: smsm: Use dev_err_probe()
Date:   Fri, 24 Mar 2023 11:34:35 -0700
Message-Id: <167968287204.2233401.12076700959319661092.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202303241018532824420@zte.com.cn>
References: <202303241018532824420@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 10:18:53 +0800 (CST), ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> 

Applied, thanks!

[1/1] soc: qcom: smsm: Use dev_err_probe()
      commit: 74f9d27ac7591e0df05c85ca5eb538253f39919d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
