Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC574FE95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGLFDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLFDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B810C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40D3F616CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FB3C433C7;
        Wed, 12 Jul 2023 05:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689138220;
        bh=uqV6Um97XmlcNN/yUzLMTOP1cF0T1bI1RVjvshk7iMc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pxXw+soQaj2mQLxD2H6AFhyoPP0ATXGQAaalhfSyqvVBO9X9xtBfrPEXOiN4XovV5
         s0uswwLXghNDN7gi9CPvR/FMyQwZW/HxV6GjNWDybULzlxDrXremK0A7tWRstHqR9G
         9LT7Z+xQoS02MGs8VR8SshD20SmQyA8RgD9Vhpcqrd4CKGnxiS8bLXO41FiOus8GtR
         htKka98iZNQF4KelRCuI9j21/lCBqxcIYbisMgPUPxdSOXqCFbZg5a9M+7Nd2Pqi5j
         S40xZ/umSLlH+o3TLUmrnknK+81n9Xqcf0QjnOjP72idlXQpUMFE0sAqn3aun5adz2
         DMu3rV58oT/uQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>
Cc:     linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230711194542.898230-1-sean.anderson@seco.com>
References: <20230711194542.898230-1-sean.anderson@seco.com>
Subject: Re: [PATCH] phy: zynqmp: Allow variation in refclk rate
Message-Id: <168913821797.212309.17019092167663097914.b4-ty@kernel.org>
Date:   Wed, 12 Jul 2023 10:33:37 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Jul 2023 15:45:39 -0400, Sean Anderson wrote:
> Due to limited available frequency ratios, the reference clock rate may
> not be exactly the same as the required rate. Allow a small (100 ppm)
> deviation.
> 
> 

Applied, thanks!

[1/1] phy: zynqmp: Allow variation in refclk rate
      commit: ea64a79fa6aebf6900f6cba0d6dd9c141010fda8

Best regards,
-- 
~Vinod


