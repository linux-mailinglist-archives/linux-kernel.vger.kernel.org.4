Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F372CD13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjFLRmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjFLRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:42:06 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9FC98
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:42:04 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686591723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzPWYXh+wV1waviHJqJHrN2+anwfAomXcTII7Rh9plc=;
        b=K+w5UF75/OlCxKl1vVXvjoaei8z/zw9tFnUzqwqM0uoc54WAYmhAORt76/3bPO8I3ogXZB
        8V0e0qJIAijo5X/+ZCfKLGTGRJzve4l4Y+hqtEw5f3tFC1liTSrc6hHVsKjo/3Xk/IIX4i
        FHeugIDme6CaTa/A1EgXLkOxS5AvO2k24OZCxOuUy7G/IHklKETatDa1+HdmS4zimS74vh
        ukFU4aRm9D3RSpH+JPyK9WoPdsbdG8ckoowY8Y6snsnnsKgx2VSkmPmdNajspC+tKpl/YL
        oc1+Yd5kbFrwm4LgdyIJl+Ke7nUuCHNk5gW/OO0uOTY9tJZm3QMNfdFwW4ODYQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E682E0008;
        Mon, 12 Jun 2023 17:42:00 +0000 (UTC)
Date:   Mon, 12 Jun 2023 19:41:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v2 4/5] mtd: nand: raw: add basic sandisk manufacturer
 ops
Message-ID: <20230612194158.6f2ace4a@xps-13>
In-Reply-To: <86aaf385-3c0a-21d9-46fe-f84ee26efbc6@gmail.com>
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
        <86aaf385-3c0a-21d9-46fe-f84ee26efbc6@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

jbx6244@gmail.com wrote on Mon, 12 Jun 2023 17:03:35 +0200:

> Add basic Sandisk manufacturer ops support to get
> SDTNQGAMA timing data with the nand_get_sdr_timings()
> function.

Actually you can send patches 4 and 5 aside, in a dedicated series,
with the prefixes changed to "mtd: rawnand: ".

Thanks,
Miqu=C3=A8l
