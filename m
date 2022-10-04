Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D25F3D1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJDHQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJDHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914443160;
        Tue,  4 Oct 2022 00:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 648EFB818FC;
        Tue,  4 Oct 2022 07:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694EFC433C1;
        Tue,  4 Oct 2022 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664867801;
        bh=pubk6XSf4oZayl6xSyPQOx0fVOLaj6FBLng09EACGOo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YPr4uCeqFPj1RpgnCAAdHgx9yEdxolnZ8/KpGnL+8gg+Wpn31isZS+Wvp8uP24tjo
         6njivxcoIdoyadHQcw1uyjOP9GFt5+RA1ML2hqXY0znSbEa7iSenppyanx12/07sYN
         6GtBdUMW5nFDhqgdc6GThCMKTzHPTs60U1Y2Dm1O2wvSDi9SRdmMXt0hRVOCZEqhQ4
         TX2+fXX2KNtOBF3XBUQC7v51SJ1dGBPHOfcb0+edCBa3s4mb3jjdxXHZOhQCy0Kr1i
         uDxgPIOle7z0tUMuFtexF6Ggs5dUNccmcn8Ok7CBkk0d6yjlIEJ+zFBoW5/0zvH2ts
         8XUlQymXa74fw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wireless: wl1251: switch to using gpiod API
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220928222210.1922758-2-dmitry.torokhov@gmail.com>
References: <20220928222210.1922758-2-dmitry.torokhov@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166486779765.9318.1005901653195559558.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 07:16:40 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> This switches the driver from legacy gpio API to a newer gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I assume you have only compiled tested this? It would be good to mention that
in the commit log.

Also the title should be:

wifi: wl1251: switch to using gpiod API

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220928222210.1922758-2-dmitry.torokhov@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

