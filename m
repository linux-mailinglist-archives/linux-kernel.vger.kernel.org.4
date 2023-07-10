Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0CB74D918
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjGJOet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:34:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4548F2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:34:46 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.176.73])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21CD26606FFB;
        Mon, 10 Jul 2023 15:34:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688999685;
        bh=Ikn20gvsO9Yd2CF7LJFreLY2PwFJww5XfuEAwAVlJEA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iMuKavFy4tHgZSWewb8/svFDRCl3StjzrziWoSdJ9r5fJmcliIHY3gfyNpCSJ2Iw8
         Wu78+MR280AsP5SDJ30mAF9Owgr8X7mSEiNBGQlcmn1Tz2OMya0arL/xSQFyFTJKRB
         Alhlr0myBDwsIQVAWyIXzGB97Y8dMF6aXkgm+FQrWqAGiKTMczXam0HCV95ydlieT+
         kAB2HMe7tNErP0m7szHrosP9gu/xT1s3oA3HJV+f7CgEGXj4RGkup4hTl3kTbVcf9e
         Ky/BNB2SCS2+RcNNsn0sgulhvsx38/csVf6dse/NWjSIrZD4qmK+uBd3caWNnFLxkw
         Cy3lBw88eU0Ow==
Message-ID: <fa7cad50-e66a-7b76-e4d9-9e86fc4229d1@collabora.com>
Date:   Mon, 10 Jul 2023 17:34:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] regmap: spi: Use spi_message_init_with_transfers()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230710142335.66598-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20230710142335.66598-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 17:23, Andy Shevchenko wrote:
> Use spi_message_init_with_transfers() instead of open coded variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
