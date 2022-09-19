Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB525BD156
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiISPmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiISPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:42:44 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF3386A4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:42:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E1E651BF20F;
        Mon, 19 Sep 2022 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663602152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SriSdZ3MZoOBR30tzW6ihzhEciKWiMVtrZBs37hEjbM=;
        b=b0cTDt01QYb0NIwnCdVvAc3XpjBYnNey6WwTxNr0GCgXpM7sT9Y094nArcxMcRgav0diGR
        FyebLR8WBrrXDFUrXlFvLVzL/a9x7X5pI9DY4CLgSncu4YRDfD536pEzoehEAwH4X2Bz14
        7+LVTxWqYTgRNN33YReVAbYMihwLiRyBOw9x8F0nn2NmvkQuN6RbLJDZ1Wz7D3V7RIonBC
        tMd3afgUuC6vdfUpucScl6ycRcWeixhMg3fJHW4T6f8Srq5Br0BHLZOEft3Vdudx3Y7Egw
        opIINw0rziO/8/6me6hMGu9HQ24aVeiIx9aasxF0h05VA++xABr+aBbOlhkMiQ==
Date:   Mon, 19 Sep 2022 17:42:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 02/13] mtd: allow getting MTD device associated with a
 specific DT node
Message-ID: <20220919174230.59f95ca2@xps-13>
In-Reply-To: <20220916122100.170016-3-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
        <20220916122100.170016-3-srinivas.kandagatla@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 16 Sep 2022 13:20:49 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MTD subsystem API allows interacting with MTD devices (e.g. reading,
> writing, handling bad blocks). So far a random driver could get MTD
> device only by its name (get_mtd_device_nm()). This change allows
> getting them also by a DT node.
>=20
> This API is required for drivers handling DT defined MTD partitions in a
> specific way (e.g. U-Boot (sub)partition with environment variables).
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Can you please keep me in Cc for the whole series, otherwise I only
receive a single patch among 13 and it does not make any sense.

Thanks,
Miqu=C3=A8l
