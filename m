Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FCD6A2C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBYWtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYWtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:49:51 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A113D5C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 14:49:49 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C2D5F240002;
        Sat, 25 Feb 2023 22:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677365388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1eJi9aFfeHw4XIo76QiONNeIzY51ZAxdJnXby/UHkk=;
        b=gD91fOoIe8nK4JHPicx55CjgNSDd+TSJdKGUj569D08+m3RHo8wutxllglTKEUEqvKItIe
        Rbm0Jrxz0JS+3GvAbtfj/cjuyq7N10jiiLjy6l1LNN4Y2AuL3gyJm9h0x/2BxwdMRggttK
        5wOQ4dosvznpzjLEckHyreeNbSdrZG4Bmrju6dFBTJgteVQfYVW5zoOPR5kFENuPnGxR/a
        QuyYJZEpMUXBcV0GTgqu3PnLZnuV+zIcOeyBtQE4nMyQPaZFX8+rM2v/MuVMF9Q1pEg6UO
        c9EGimiGaXLcRGVOjXXwvHAyWEy2A7G/GnXEtX451FHFksa26DCtI3+5Cbbc5A==
Date:   Sat, 25 Feb 2023 23:49:47 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jack Chen <zenghuchen@google.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>
Subject: Re: [PATCH v3] i3c: update dw-i3c-master i3c_clk_cfg function
Message-ID: <167736537001.623134.2161286183992135167.b4-ty@bootlin.com>
References: <20230216151057.293764-1-zenghuchen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216151057.293764-1-zenghuchen@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2023 10:10:57 -0500, Jack Chen wrote:
> Bus-speed could be default(12.5MHz) or defined by users in dts.
> Dw-i3c-master should not hard-code the initial speed to be
> I3C_BUS_TYP_I3C_SCL_RATE (12.5MHz)
> And because of Synopsys's I3C controller limit (hcnt/lcnt register
> length) and core-clk provided, there is a limit to bus speed, too.
> For example, when core-clk is 250 MHz, the bus speed cannot be
> lowered below 1MHz.
> 
> [...]

Applied, thanks!

[1/1] i3c: update dw-i3c-master i3c_clk_cfg function
      commit: 07eac9c306a0efd73a43804b50c88c67696a3c74

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
