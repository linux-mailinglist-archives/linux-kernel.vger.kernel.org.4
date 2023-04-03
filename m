Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A966D44C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjDCMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjDCMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:46:23 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40732FF0C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:46:20 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2FA9011EF;
        Mon,  3 Apr 2023 14:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1680525979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThdJSjWaqGfdvGxJMXZ4Rq8xgIW8c/iIcHFwfYIKTlc=;
        b=N0F4B8pBEYhpWU6OBLyAp0HNllyvAGGApYTA7ztFa2DfFDW039qxh6/uqSltiSmY79zxzh
        K9CCulvhTxRMSP5UUSbBGHTBOgbTAnColIJjZkQDT7UNoIhGYeh8lO539mVHrLOLL2D6WK
        1IzR/WeYbB4so0dfj9P2S+L79mVfnykuFNqUgiVFPya90ql5jhLG1OoGX+urXkOKhgulSX
        kWawe8LWfObB1f58BnfxaEMIjTWMpJYDUm9WoStXYx/mtGZD5Q4hMcuEHla56HZMfqXM8/
        jJCtnZO2pEjMm/6A8fu6ktZNM1v46DPNxK/ddmh/hQ/pAimte65wWJnNxhjRig==
MIME-Version: 1.0
Date:   Mon, 03 Apr 2023 14:46:19 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] mtd: spi-nor: core: Update name and description
 of spi_nor_set_4byte_addr_mode
In-Reply-To: <20230331074606.3559258-5-tudor.ambarus@linaro.org>
References: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
 <20230331074606.3559258-5-tudor.ambarus@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0ed54fa05870805d858389435d3844eb@walle.cc>
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

Am 2023-03-31 09:46, schrieb Tudor Ambarus:
> Rename method to spi_nor_set_4byte_addr_mode_en4b_ex4b and extend its
> description. This method is described in JESD216 BFPT[SFDP_DWORD(16)],
> BIT(31) and BIT(23).
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <michael@walle.cc>
