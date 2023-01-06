Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5881366083E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjAFUYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFUY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:24:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED43109E;
        Fri,  6 Jan 2023 12:24:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 897EBCE1E17;
        Fri,  6 Jan 2023 20:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55460C43392;
        Fri,  6 Jan 2023 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673036661;
        bh=+AtIr4tkDXhCceor64nJXGDuX/DDFyU6LzAmD7IDWhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgGP1CHvYam7/NYiXpKZY1EGzyZZzTD2i/y0diozAU4aMhv0Oa7DJyFr6VeETj4R3
         jcVGryikHlwtWOC2Jjr9tuYqasFZ7K0R4A2zBm+nmr0ZfvR5YSRUe6yv6QSiktItII
         MHGPPGLnWjd4Oc0jV5VY9enZ7Hpsq1OgDBnX74XGJGBTUhwpyJUUjeEP8ZS7pPVhn0
         qrsEJ/GDUgu0F+ABMnLT6DOwSunUnNRYkTzdYWnIN896iXXFbwIN+gLH8bhdII8r8g
         Yfj6AnT4HAGlXbdhMvKmPz5sfmRLpNR1OZxloip08yUqBENZrYWKPkdN2/CeXwZRts
         kQDU5NX+PaL9g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, set_pte_at@outlook.com
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: apr: make remove callback of apr driver void returned
Date:   Fri,  6 Jan 2023 14:24:17 -0600
Message-Id: <167303665351.1802272.14996643528670691763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <TYCP286MB23232B7968D34DB8323B0F16CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB23232B7968D34DB8323B0F16CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
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

On Fri, 6 Jan 2023 23:28:03 +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return void")
> forces bus_type::remove be void-returned, it doesn't make much sense
> for any bus based driver implementing remove callbalk to return
> non-void to its caller.
> 
> As such, change the remove function for apr bus based drivers to
> return void.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: apr: make remove callback of apr driver void returned
      commit: 33ae3d0955943ac5bacfcb6911cf7cb74822bf8c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
