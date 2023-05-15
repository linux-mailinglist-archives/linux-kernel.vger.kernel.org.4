Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58E703C90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbjEOSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242842AbjEOSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBF16902;
        Mon, 15 May 2023 11:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3767363151;
        Mon, 15 May 2023 18:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFE5C433D2;
        Mon, 15 May 2023 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684175128;
        bh=Ig15CCmRbUDwPdPSwSK6wyvGYkr4LLBCPsnJsdn+kxc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WWqgCUvVE4SWqJhd6/HvsEI3yUhzihrHCFHep97/HecWMzqFFL7iqK68FJ7dIxva/
         GrB6/PUR+dRLm7VYmWDCGyy2ENv+QXUHT4TlgWcnErrfnGVcLAaqH+nT6Y+dBLzyNI
         ix4gmt5lVp4+27curWS55iBcCO4G1aIQw2n8A8NLLyQGHkhCeMUSEhS+g9PNpLsPKG
         5rciF5NncV3/zcYcVXwTuNjXAgSIlLZ/MGksntjpYkMRv7EFZd6gzHiFkV76+isBTB
         ynZI8nZ7vnhdbeiPCm6yRhOAr/RTrFXP6K/r2By+1emMjkPhH4cjN5FQOWOCRJWZOR
         J5I+CSUtoNCOQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: wcc: Add debug messages
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230509100420.26094-1-matthias.bgg@kernel.org>
References: <20230509100420.26094-1-matthias.bgg@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        brcm80211-dev-list.pdl@broadcom.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        SHA-cyfmac-dev-list@infineon.com,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Matthias Brugger <mbrugger@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168417511892.10390.13808783964763445641.kvalo@kernel.org>
Date:   Mon, 15 May 2023 18:25:25 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> The message is attach and detach function are merly for debugging,
> change them from pr_err to pr_debug.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Patch applied to wireless-next.git, thanks.

87807f77a03d wifi: brcmfmac: wcc: Add debug messages

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230509100420.26094-1-matthias.bgg@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

