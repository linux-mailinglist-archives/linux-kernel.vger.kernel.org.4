Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B196E5D44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjDRJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjDRJZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:25:09 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B259CC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:25:08 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id F02CE9E3;
        Tue, 18 Apr 2023 11:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1681809906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUkY4vygHyk5s53A2oqEQV2z4/qRItW1OOsd86HcBWU=;
        b=wpFsVLHDslrsCnlhCDkjlqM6Rb6eC4IhU7C8n6RsUDGlr6hEoTZLuzeQAqzdFbgP13wMzy
        4OY3Khvk9A3KvbWBde83jA09mVlDk2UimrHuR+LLsdXNkztljNKGeXesDRDx6YC5Vf1006
        fyZ5zj+714A6qh1EWCYlXv0mNOL8dHAxEz1hhUt+7sZTdMM9EXLH8x1T1bjYsg798Bq2OE
        FAm9G5BrcaODBPwHexTU5owA//8mSeMeOGWozkjrzsIf752iN8YWSw2PAW+vWYyYfIvk8W
        gKWb2VGr0Mo/Q3cDQw/8Z6KovQCaEGqCYokGsB9XK8f/zVf/wDvax4XL2UHuZA==
MIME-Version: 1.0
Date:   Tue, 18 Apr 2023 11:25:05 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: Allow post_sfdp hook to return errors
In-Reply-To: <20230405062106.49594-1-tudor.ambarus@linaro.org>
References: <20230405062106.49594-1-tudor.ambarus@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ce297db930bab7ed3d72637dc911436a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-04-05 08:21, schrieb Tudor Ambarus:
> Multi die flashes like s25hl02gt need to determine the page_size at
> run-time by querying a configuration register for each die. Since the
> number of dice is determined in an optional SFDP table, SCCR MC, the
> page size configuration must be done in the post_sfdp hook. Allow
> post_sfdp to return errors, as reading the configuration register might
> return errors.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <michael@walle.cc>
