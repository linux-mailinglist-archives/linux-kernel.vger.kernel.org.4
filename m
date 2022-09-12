Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB305B5719
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiILJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiILJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43892AC5D;
        Mon, 12 Sep 2022 02:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4528961151;
        Mon, 12 Sep 2022 09:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE73BC433D6;
        Mon, 12 Sep 2022 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662974508;
        bh=7M30k+DezJ2Ab5iCL6fbA53OWFyHqGq10ax5dBTTDOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O7BX5Ju4V1u9IorgdhQIXd9CHr2OdtmTviIDwzFlMawypdHno9ousDG0nS80cl/Lq
         oZZdJIyX7tkT+6xMDxa9tRFRiMKN1fkAeQPuVCpuYyLO9LD4DnkmQeoN/gZvtqseqg
         eEm+5V6gCxOeJkLNx9Ogs5KLaEPYbTB/soILoL7XB9tGXqsYqrobd3ziYymXM3b8p/
         IwBl5cQloCzLPqwNNK78Ce/6TpoH3J/vLVV9+gI0d+fjkHNkn1zW8cNnwq02+gKujA
         WyMBb+iw4uqAFY0PExjEAbE5YOajopEUkPKymFcJkt0t8cTAhQajyVFbItwXxFw930
         E8Jp/FYhTW0Yw==
Date:   Mon, 12 Sep 2022 17:21:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 3/4] ARM: dts: imx: update sdma node name format
Message-ID: <20220912092142.GV1728671@dragon>
References: <20220905083615.89605-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905083615.89605-1-joy.zou@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:36:15PM +0800, Joy Zou wrote:
> Node names should be generic, so change the sdma node name format 'sdma'
> into 'dma-controller'.
> 
> Acked-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Applied, thanks!
