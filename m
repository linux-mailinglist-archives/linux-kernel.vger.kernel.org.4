Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F66738E41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjFUSKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjFUSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33E1718;
        Wed, 21 Jun 2023 11:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE906166F;
        Wed, 21 Jun 2023 18:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C3C433C0;
        Wed, 21 Jun 2023 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687370989;
        bh=tFnG/OlpCytzKrmXchONwtrtgtVYHMPwSIIzL4WuRbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRqbJCPwt//RFfyKlhXEeSxYlzJhWoCV8fkB/wZirme6tja2iuuABlg6M7VBi1HNK
         VmHOFEAmmlSHiS/i4kdrNpc6yENO8huZjsLVWH8mMD+NnZ0pGNRf3Hxp0Zrwnrxbi2
         IxFc3z7ea4dRIN/QygBkjd+5h0KIzMq5yXFc/IK0WMxh4S2ogAiK8+uD6II3Dm5m8o
         6f7FySRdQp9k0VKwep8RnZHl4m9lD4HVeXLEPh9FiPqYtVD1iEI4ZJ+XZCkvF4ACkf
         dyBBgz5I6DhaaMivg1knxavEzU4uGuAhqLyIXr4rfYqE/gI4Hl67MGzNWKTlmwH2fn
         tGXxMFCuqOHjQ==
Date:   Wed, 21 Jun 2023 19:09:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Raymond Hackley <raymondhackley@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH 2/2] leds: sgm3140: Add richtek,rt5033-led compatible
Message-ID: <20230621180945.GT10378@google.com>
References: <20230602130644.259933-1-raymondhackley@protonmail.com>
 <20230602131024.260297-1-raymondhackley@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602131024.260297-1-raymondhackley@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023, Raymond Hackley wrote:

> Richtek's rt5033-led has pin configurations similar to sgm3140.
> Add it to the compatible list.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
>  drivers/leds/flash/leds-sgm3140.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
