Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31178733569
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFPQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFPQIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970042D6A;
        Fri, 16 Jun 2023 09:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F4D661B65;
        Fri, 16 Jun 2023 16:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086DBC433C8;
        Fri, 16 Jun 2023 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686931698;
        bh=vVuSAFNQlOZX+Auz50QNpcWFgO5PYw/fJf95j9d31YU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RuDwj04ZKml+dl36jOTJShLy5/xBoVEk1rhZiKqWuxCijtWWzyMSVgiIc/RjPZAQp
         oSBet9sxE/j6zetiANLE0iDfGVtAjBR8DTs+Vtm+qg02EmvQTzykBV1L/zXy9du+Gp
         MnwrnfH9z5FeM5NYaClb2AuIBGu3LoRho6P0MUW5nmouN4efYH1WzyJe61iof0zHLn
         KMzXN1WllJ0wf1kaKG6KljOMbzoANYlq4dGcNr10jdblm+is6OlRXrJ4cGUZdYJRH+
         /oce8xywinTajZ27SGwFlXTtujYpEE9CgPlKchKLRBL73YGQmjmHSTyf9iFNm4PPlw
         qYEj3DZIj8yBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath11k: Add missing ops config for IPQ5018 in
 ath11k_ahb_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYZPR01MB5556D7AA10ABEDDDD2D8F39EC953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB5556D7AA10ABEDDDD2D8F39EC953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
To:     Ziyang Huang <hzyitc@outlook.com>
Cc:     quic_srirrama@quicinc.com, quic_kathirve@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168693169253.12400.8675945776351103304.kvalo@kernel.org>
Date:   Fri, 16 Jun 2023 16:08:16 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ziyang Huang <hzyitc@outlook.com> wrote:

> Without this patch, the IPQ5018 WiFi will fail and print the following
> logs:
> 
>         [   11.033179] ath11k c000000.wifi: unsupported device type 7
>         [   11.033223] ath11k: probe of c000000.wifi failed with error -95
> 
> Fixes: 25edca7bb18a ("wifi: ath11k: add ipq5018 device support")
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

469ddb20cae6 wifi: ath11k: Add missing ops config for IPQ5018 in ath11k_ahb_probe()
80c5390e1f5e wifi: ath11k: Restart firmware after cold boot calibration for IPQ5018
ce282d8de71f wifi: ath11k: Add missing hw_ops->get_ring_selector() for IPQ5018

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYZPR01MB5556D7AA10ABEDDDD2D8F39EC953A@TYZPR01MB5556.apcprd01.prod.exchangelabs.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

