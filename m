Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C506D449A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjDCMni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjDCMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:43:36 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B8465BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:43:33 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 66D17124;
        Mon,  3 Apr 2023 14:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680525810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYJViz/4N8t4+5Nr3/NhnXJXAfSKnQcLVADtXN8P48w=;
        b=ANttNXQG44x5Lkium/ohFLGpqpx8IiwF8YqUbGDtEMecMjsz/eauOOkCjF+4vn36LeeT4Q
        rZHO4DC18tYBLtwudcZDqGQafJOG1Ry7zfq45yg/QdXoiQxmW24zfrGbTWpc7n4cEgYYHQ
        0FlaIi+inBilF4F1c1L81aKAyEUpOLcvsYshlM/ZQ8w4cbXgNYT0fRd1/ugomXhaNZXro3
        IF6oxFQasTfr0ye/9XOASI95jbNHHOWxkyzEyVvfJSB7hfk2EaxPndwAYdc+BtkZf32Erw
        gZ2tIgEjsnVQ15/PMnu0SNHaY5VniNt8mkHQMX3do44fyyZkiCEH28jCL0AQdA==
MIME-Version: 1.0
Date:   Mon, 03 Apr 2023 14:43:30 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] mtd: spi-nor: core: Move generic method to core
 - micron_st_nor_set_4byte_addr_mode
In-Reply-To: <20230331074606.3559258-2-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
 <20230331074606.3559258-2-tudor.ambarus@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4543c6475a6e2852435a1707ee70ebe9@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-31 09:45, schrieb Tudor Ambarus:
> This method is described in JESD216 BFPT[SFDP_DWORD(16)], BIT(30) and
> BIT(22). Move the method to core.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <michael@walle.cc>
