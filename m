Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB21663E95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjAJKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbjAJKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:49:08 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B25A1A385
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:49:06 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 4E30815E8;
        Tue, 10 Jan 2023 11:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1673347744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIqBgod//kIB01WRSTzgTlfFAesePEym8xhFBvDEBQw=;
        b=s/BDl0ciSpnmQxUQIInRWg4BHOdRE4OVFYhjVcRohylE+SAos9muPtDoiPZbhBwrKL1MT8
        G/NMdXUTc18dxP1IGWw7MsJ/j2pwnWx1GfUxVR8Y2WpqfAizXsWfQdO/i/fXqAXguT9ec4
        Fj14bpLTt3d1ym/e0VUfRuHuzEUa+D6hAtNg+g/SRNf+knT3sIcX0NlvJrKXRGjJqZpwnN
        VwpxnoTKYFsstNB4kgNgNRPdsPVF/awyc/EPpmx7/X28ii6EDI38TYQpdpnuAPlAoav8j7
        I3gcvpJwrv4niA2JdZj+8r1Qijx0xQcwR4gw1FrWAy2yGKRSvB7gn/gSxxGSBQ==
MIME-Version: 1.0
Date:   Tue, 10 Jan 2023 11:49:04 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: core: fix nvmem_layout_get_match_data()
In-Reply-To: <20230110104645.11705-1-zajec5@gmail.com>
References: <20230110104645.11705-1-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <355b03ae0a0f5f1cbcdba89fa3fa7bcf@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This function was trying to match wrong OF node (parent device's)
> against an of_match_table. It was always returning NULL.
> 
> Make it match layout's OF node against layout's of_match_table.
> 
> Fixes: f5709a684a0a ("nvmem: core: introduce NVMEM layouts")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: Michael Walle <michael@walle.cc>

Thanks!
-michael
