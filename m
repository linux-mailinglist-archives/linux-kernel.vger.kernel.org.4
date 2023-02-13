Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF8694C12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBMQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBMQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:12:24 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF52681
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:12:24 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AFEE080465;
        Mon, 13 Feb 2023 17:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676304741;
        bh=iWkoawfMTRzTCJQq9Jw+vzWeoVnfWfuRMV04cEKaPxQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=v+m8HNIbad6Cu32eW7+Xzrxh5fWAl4xvroqGc+vt3BiXcs0KS5ToSJv58QMhaYVho
         VmwRI1Neaw+WFractoxTFecqaFh6SuCKIC0vxhKSI19+7eKRnZ8PqKyFoW2t3J5eXg
         XviS4bLltFSstE+Loa/z/cURW8oigUgnMkXra9popM2kTZOy5ZqowIsZf09fsJxCyX
         E53a98uvqmNwNV2YXAw92MnIbaxb1Byh2QicUQ093ipTGHQJaJh1hhuHLWUdLleF+H
         eZllCvyf9cFfYXKzlQ3vyCphpRCgcQentORw0Wh8EdFuzpF1puqMTL1d3fgZ4D9lpU
         W3RAuYHZUPtEA==
Message-ID: <735e2f8d-0763-8064-a8af-f1a4c633a03b@denx.de>
Date:   Mon, 13 Feb 2023 17:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] regulator: pca9450: Fix enable register for LDO5
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-3-frieder@fris.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230213155833.1644366-3-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 16:58, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The LDO5 regulator has two configuration registers, but only
> LDO5CTRL_L contains the bits for enabling/disabling the regulator.
> 
> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Marek Vasut <marex@denx.de>
