Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3507970DC31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbjEWMPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjEWMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EC4119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D5A6319C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF74C433EF;
        Tue, 23 May 2023 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684844144;
        bh=t0ZnWXHr4W89C2nVkt32hoIOuOv+Sm2e39jBAIljHG8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cNFwTc4HnIT0hCWg/Pox+TJQmsquXHgw48FMR12Ekoqv3o5hRha/tCz636z/hSGmJ
         eSnViL7YkB7VsKV+YfT4CdM+w8hoh+j2EXs2EhxfDiHFhScplQRpS5PE1Q0LXUBLmR
         3WmXeZJ0aovr5Cd2ggg376trsm19HmSkuCzu2DWIiHWp+49+lzQD0Rp0JfnrRF8HNf
         350MSeceTyAboG4PcNtUckmaF1f1YMSYCvDps3hx+iCX/UgcEkqqIAGLK1p1DKPK9T
         DfLBcYLzgmkNkVI/G+nJUbrTZuoMHQBh9n/+cxMdXSg4vOST3UTuTBGrDh91NsjzW1
         EF+kWbdhnK3Hw==
Message-ID: <a04a6afa-6daf-ca50-9a99-d52764def948@kernel.org>
Date:   Tue, 23 May 2023 15:15:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] phy: cadence: Sierra: Add single link SGMII register
 configuration
Content-Language: en-US
To:     Marcin Wierzbicki <mawierzb@cisco.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>
References: <20230522172415.1668975-1-mawierzb@cisco.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230522172415.1668975-1-mawierzb@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2023 20:24, Marcin Wierzbicki wrote:
> Add single link SGMII register configuration for no SSC for
> cdns,sierra-phy-t0 compatibility string.
> The configuration is based on Sierra Programmer's Guide and
> validated in Cisco CrayAR SoC.
> 
> Co-developed-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
> Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
> Signed-off-by: Marcin Wierzbicki <mawierzb@cisco.com>
> ---
> v3> - all reported comments were addressed

:)
You should summarize what changes were done.

> - v2: https://lore.kernel.org/lkml/20230508160142.2489365-1-mawierzb@cisco.com/T/#u
> 
> v2
> - rebased version on top of commit 0cfa43ab46b5 ("phy: cadence: Sierra: Add PCIe + SGMII PHY multilink configuration")
> - v1: https://lore.kernel.org/lkml/20230419093008.195094-1-mawierzb@cisco.com/T/
> 
> Regards,
> Marcin

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger
