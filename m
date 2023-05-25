Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56277110B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbjEYQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjEYQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B5139;
        Thu, 25 May 2023 09:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7BEE60B01;
        Thu, 25 May 2023 16:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0024C433D2;
        Thu, 25 May 2023 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031418;
        bh=TJiBJ2DgCNX45ZQwl5QA2StCRdzzXCcqJIJYACkob9g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FXTZLoihJeobgoDjkkqDM0xJJSFZLzGPrc0F529nvBAHdtndXNdS0SmbHTQNQTKBA
         6z+tZ2RGxfUcrsw1GU5GFGtSkUNbVvEeK0me9ayjgMLq1Gzlpr2haN5Gn+Prv/5Pi8
         zPuGzK0nyn0QiRTQ6kOuegN4sqzohw6X2AoDOv5vS3lpQQoo/x8w+NOEgtpdPZ53f/
         L18wye0xolFS2OS4/RTBiTlHBqwEvFEtm64rxs3afu3QrhLJ73Ohan6puu3B2h+9yt
         ANzQIjKf4jCBZBedRDIDgZ7glrT9ff2Dbhhuaewxc9JYqbUQzTqpGpOTL1Uef/Uu74
         SNBz5Vg2/ZQCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] wifi: wl3501_cs: Fix an error handling path in
 wl3501_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <7cc9c9316489b7d69b36aeb0edd3123538500b41.1684569865.git.christophe.jaillet@wanadoo.fr>
References: <7cc9c9316489b7d69b36aeb0edd3123538500b41.1684569865.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503141504.22756.5325042313582442239.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:16:56 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Should wl3501_config() fail, some resources need to be released as already
> done in the remove function.
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

391af06a02e7 wifi: wl3501_cs: Fix an error handling path in wl3501_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/7cc9c9316489b7d69b36aeb0edd3123538500b41.1684569865.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

