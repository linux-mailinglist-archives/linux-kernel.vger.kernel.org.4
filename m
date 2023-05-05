Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567216F7E05
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjEEHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5411544;
        Fri,  5 May 2023 00:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2884363BDF;
        Fri,  5 May 2023 07:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B21C433EF;
        Fri,  5 May 2023 07:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683272306;
        bh=Pw3z/wSPton4j3lNLrHMugPK+GlT51qJrffU70l3EZ0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=C1/ydpdinmi/GrtJJ0vsKhISDEEVcNA8iEONGU11bwz25hwix5IZMYYJg8lfnUK7N
         nKcmR6lxOJPPst1pMh5miDsd8PP5Ea5tZ/Wq9zNBBdekpqsd5WiszUQhqfJFnEs2OY
         duzKLsiKZ5pYZAxvSIety3CAQ+JSmw9TaapH3p49Q4AJuYkhXkTfkWMWBhkbp+8PmZ
         YqAsAbYAkghk1T7B2foI2Tsu7zu7hzEYWT5xYjtKwacAGFvIW8YZxT7Yrx/SVQbwGK
         jZkq30G0Qp38istRCVFLToSfa0xnfAsgxBQWOYzRByPtX+CaAzdOJXLCFwP42d/jkb
         MVh0twUDY0A9A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] wifi: rtw88: fix incorrect error codes in
 rtw_debugfs_copy_from_user
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <tencent_D2EB102CC7435C0110154E62ECA6A7D67505@qq.com>
References: <tencent_D2EB102CC7435C0110154E62ECA6A7D67505@qq.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     pkshih@realtek.com, tony0620emma@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168327230065.10202.16584084872255391845.kvalo@kernel.org>
Date:   Fri,  5 May 2023 07:38:24 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Shurong <zhang_shurong@foxmail.com> wrote:

> If there is a failure during copy_from_user or user-provided data
> buffer is invalid, rtw_debugfs_copy_from_user should return negative
> error code instead of a positive value count.
> 
> Fix this bug by returning correct error code. Moreover, the check
> of buffer against null is removed since it will be handled by
> copy_from_user.
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

225622256b1b wifi: rtw88: fix incorrect error codes in rtw_debugfs_copy_from_user
770055337772 wifi: rtw88: fix incorrect error codes in rtw_debugfs_set_*

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/tencent_D2EB102CC7435C0110154E62ECA6A7D67505@qq.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

