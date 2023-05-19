Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A285709E96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjESRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjESRyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A875DD1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D7A1659F7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 17:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D273C433D2;
        Fri, 19 May 2023 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684518853;
        bh=97Bz3gBu3cjMub0ke7MmKbcC+HeuWyYj4GzpqG/0u3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWaZrMfp2bStabm0ely1bhnRcEqCR+YB3uEp7Sac3dSS8jW2seO49cVpL5YpaLhpM
         QlDwLutKOtdP1nQXNQBpclTgqUzRQmc0wU6vaZcVmIJClsCAZ0BV1eJqG995nUJIB/
         cRg2GXhCtQR0DLNL3cQ0cU7sjydtehsiSuqjz1+RwsylcBXV3J0TwyX0m8uzt7Ztyl
         iUbLJhpCfzNAkviW9sLxTV1XrbuCmPdJZhdBW3cuYtB0QQ/59gnrOAG5bze1H297CP
         jCkqUJjgvupFaHmDrIcppwH7Hl6wl4YzJ7HocwxZR//KUXpqCK2+/BzCkFv1wD2fzT
         NS0pkjDORuMvQ==
Date:   Fri, 19 May 2023 23:24:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v9 1/2] phy: core: add debugfs files
Message-ID: <ZGe3wY7U9o0QzsxB@matsya>
References: <20230513092218.21139-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513092218.21139-1-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-23, 17:22, Chunfeng Yun wrote:
> Add a debugfs root for phy class, and create a debugfs directory under
> the root when create phy, then phy drivers can add debugfs files.

Applied both, thanks

-- 
~Vinod
