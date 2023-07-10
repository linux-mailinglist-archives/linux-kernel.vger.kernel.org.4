Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4E74D741
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGJNS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGJNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E37C4;
        Mon, 10 Jul 2023 06:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B5260FC6;
        Mon, 10 Jul 2023 13:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15663C433C7;
        Mon, 10 Jul 2023 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688995105;
        bh=tZoKT0iTj9eivM7Crvy7OGjVN9EKmM6fh9YkevdWoXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kz7aLEFv4tR+QPcOOuUeS+ZFm7gwDlcOwXxzVV926zQZrxsbs0k91i67v9SkAfmtY
         OEBSToZLdN80ARrXDNBZmWai1vY5xjasd2R08nKdDMhFpUry0qjFtBNt8eJRpd9zss
         E97VI9fT6fkmbRm6vlSG+z/REo7OERLWXqjhX86pq+wR5dWEmUrr6MQkqg2AyhXiJK
         YhoTT1mH0jmBryeo5aYqcyS/5uRwX7Imyr2XrV1LpipJqJBRp0a4MPnTb046qq+GLO
         kDrFUZYE7a2tZr4SjmclRRff9aXMTHkzeIHC582zzOa7HHIWKRqtCDhIGGzOE8+XQ/
         0fwBgiWQG2naQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qIqmx-0004gh-1R;
        Mon, 10 Jul 2023 15:18:51 +0200
Date:   Mon, 10 Jul 2023 15:18:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com
Subject: Re: [PATCH v10 1/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZKwFO3Z0F0yYIoJu@hovoldconsulting.com>
References: <20230710055915.3290-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710055915.3290-1-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 01:59:13PM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and NVM downloading.
> as the RF performance of QCA2066 SOC chip from different foundries may
> vary. Therefore we use different NVM to configure them based on board ID.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---

Again, there is still no changelog here describing what changed in each
revision of your patch as I've asked you to add. For example:

	Changes in v10
	 - break out ... into a separate patch
	 - ...
	Changes in v9
	 - ...
	...

When sending a series you should add a cover letter. The cover letter
should ideally contain the changelog for the whole series.

Also the two patches you have here should go in reverse order.

Johan
