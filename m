Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC604749659
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjGFH0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjGFH0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:26:13 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F41BFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:26:07 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C8AFF14B;
        Thu,  6 Jul 2023 09:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1688628365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YByh8/bD0lokeLpwwWy7poHsp9CxyNU7yYEqLS8fnbM=;
        b=N2KmBuvYlYNhjlwPc4e//wQwq3U5zCy1arst2ocZgKa/6/TyDRTbwjiOog1y8r5YdwwMWQ
        o/RpgbV6EmkJ8BLRG0d+3yp7FE5l5MYwBwAoZOGiUHPGYCZh1PpATIx8cBFVYJ1L8DWHiN
        UacgjSdCdPRerlEIpW7FvVeo5W+pOxvoXKZkJiZtchTLS12DinPaSuATDj2C9at5vMZUhn
        LmC86NiKoo0TAX3N5NOLY9wS/fBRulpJyjjmiqNCxZhWeyvgyY1LGSTsRmvi8R4UW5d4mP
        W6kI+lzeoi4uT0QBPLq5GZHLU5W4I1+n/PRcHj1+Ksci76Z7P6A9Z4cZFJLJuw==
MIME-Version: 1.0
Date:   Thu, 06 Jul 2023 09:26:05 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mamta Shukla <mamta.shukla@leica-geosystems.com>
Cc:     Mamta Shukla <mamta.shukla@leica-geosystems.com>,
        tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH] mtd: micron-st: enable lock/unlock for mt25qu512a
In-Reply-To: <419d80f252f12f091b9c555da0965c84@walle.cc>
References: <20230705130010.2999839-1-mamta.shukla@leica-geosystems.com>
 <419d80f252f12f091b9c555da0965c84@walle.cc>
Message-ID: <582915cc4adc89b8ce16568f4d0421ca@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-07-05 15:22, schrieb Michael Walle:

> FWIW, I noticed the difference between MT25QU and MT25QL here. But
> I don't think we can do anything about it. It is just another example,
> that the name is mostly irrelavant/cannot be trusted. Vendors tend to
> reuse the id for different (software compatible probably) parts. Maybe
> we can get rid of it entirely. Tudor, Pratyush?

I must have been blind, the ID is different (ba vs bb), but my point
is still valid.

-michael
