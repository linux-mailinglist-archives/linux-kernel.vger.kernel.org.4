Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8E600646
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJQF2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJQF2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:28:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9453A7B;
        Sun, 16 Oct 2022 22:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 375ACB80EDF;
        Mon, 17 Oct 2022 05:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5696AC433D6;
        Mon, 17 Oct 2022 05:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665984493;
        bh=Kk/vVQVO1n4Hl5d04Qf2mWV4W6hzzjjjmYLuEzxTK0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQKyTfxIjqjhdL191PMHg1pyAvK5iFM5mPKrqZ2pqpU9b3of65GIEBqkr9X6yx2bz
         k3AfUiUTt8HojL7flWmMsRhBjIKw9CcEY0nOUxv5/fwP6ZJ9gqt43DHKnRYDxnmskn
         4BTu1277XImgtnEx4JVdbcQ3v3e8aNU0PTHnwAZv//q+Hb0pFoVw5mojUc2V6CZl9a
         xNjtUSV8fIj+Og9RwOFAdz2Ow4ZbG3tv+nD5buej4zeHgNiTpMDCE9FXAUm3D83qRO
         spFnnP5ofnx5tyr2hECDG0SUwe5hr6yeMM19oeJhNS9jCb9AgJlIihASoj4ZLc5aRm
         AF1a10yGO1Epg==
Date:   Mon, 17 Oct 2022 10:58:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, xu.yang_2@nxp.com,
        kishon@ti.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        linux-phy@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: phy: imx8mq-usb: add power-domains property
Message-ID: <Y0zn6Rczb9relP+N@matsya>
References: <20221014095550.2125018-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014095550.2125018-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-10-22, 17:55, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add optional power-domains property for usb phy.

Applied, thanks

-- 
~Vinod
