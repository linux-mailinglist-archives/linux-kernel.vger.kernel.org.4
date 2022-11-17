Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C9162E6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbiKQVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:01 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6313E8D;
        Thu, 17 Nov 2022 13:14:59 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2E579240006;
        Thu, 17 Nov 2022 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=676Ci+ArdGmO9gtFmjKwk3wPDlLDxMlHsS2sEFwfOTU=;
        b=neLKmiZ4QTXkhSKVHie20Ze27uces7qsZa7Pg1ITeRq5shfv5JtkLyCd7piax0uHjLRTqX
        mjYg99+yLIPtMksv7tnyOffFfIiRYz+U5i99W1+bS/Z2N3S4fEpF1WdA0r9I8NA2gFQLDf
        qtAF4VOjjTFGc30WKhY77uk4QTz4nKCcoTvPgPJD40eBwTa9yeaLi8dfHEN9c+GM20h7cK
        XKi44VGvLD5IIkPvbacTQco5DOBxiC2qegtcFhHcb4t6GUDfXEk5ej9E3tHHTnjAce+6+o
        Pkj5+l5CYaX78RtsolZrsHSsPKJEpBmQ0/xwFaF7Tk6/TilKEuvmM7zRjL62nA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: fixed-partitions: Fix 'sercomm,scpart-id' schema
Date:   Thu, 17 Nov 2022 22:14:54 +0100
Message-Id: <20221117211454.1273169-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111212824.4103514-1-robh@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2f05bff26c9e847ac5f68370eaf3e5f5d3bc58ce'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-11 at 21:28:24 UTC, Rob Herring wrote:
> The schema for 'sercomm,scpart-id' is broken. The 'if' condition is
> never true because 'compatible' is in the parent node, not the child
> node the sub-schema applies to. The example passes as there are no
> constraints on additional/unevaluated properties. That's a secondary
> issue which is complicated due to nested partitions.
> 
> Drop the if/then schema and the unnecessary 'allOf' so that the
> 'sercomm,scpart-id' property is at least defined.
> 
> Cc: Mikhail Zhilkin <csharper2005@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
