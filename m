Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37A0630874
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKSB1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiKSB0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:26:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BB5107B49;
        Fri, 18 Nov 2022 16:27:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9610BB825BB;
        Sat, 19 Nov 2022 00:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33384C433C1;
        Sat, 19 Nov 2022 00:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668817662;
        bh=ZwrerKpqTP7IZHjZ5ymQk8nLNnAP06AensXtMPNZjVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UD9Zgfybik/UWs/B6xEnigxcMLtoUaWz+YdJaOFarKAvNuYs9pomZnClHHpkyj4bb
         HS/5UadCh/TqRK2aMQBKLNKXwFLwBOEer1XXBGofF62k4DJYR6Rh3EtldF2nBgp1or
         CMTppWZ5Wxxk1IjR6aVNdi5PX17Qio0RP3wurpryw+XJ4G/rgn7aCTrobjgMsFLAxQ
         5yBhsLpf73NFKEW5NNgE6q23rv/5F4iiR+dYSd7u+z0wcTZ9wPzlvSt+ZGczocYvg1
         RICmbMQULW47zcE2eE/ACVKMZUw+8mt3jG0IJsoTcsKoWtQk8mAOUkmYyfQZwfH67w
         CSyhHRQ3m3Bcg==
Date:   Sat, 19 Nov 2022 08:27:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        kernel@puri.sm, dev@lynxeye.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq: fix dtschema warning for imx7-csi
Message-ID: <20221119002734.GA25638@T480>
References: <20220909083940.1554887-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909083940.1554887-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 10:39:40AM +0200, Martin Kepplinger wrote:
> According to dtschema for the csi bridge, compatible is an enum and
> only one must be used. Fixing this removes the following warning:
> 
> compatible: 'oneOf' conditional failed, one must be fixed
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Applied, thanks!
