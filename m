Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F0F70209B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjENWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjENWzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ADF1B8;
        Sun, 14 May 2023 15:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBA2C61280;
        Sun, 14 May 2023 22:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB027C433D2;
        Sun, 14 May 2023 22:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684104900;
        bh=gC1Ol887rJVXf1gaHxcAempzA9OBc5QCvIG9jl0aZr8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LW/xgv+q9k9VZjoCnKlX17DQw2mxSnfhmMLcIm2f00K8agzJie6BRJ3zx6APCdPJ0
         QX5eAF7trc0JdW7Jk/Ar6PdZLSYFEZFmDp0UEHW5VdrKh8PU6x3NehmDRg/+lfWDaO
         sTT0IkNRMGUMerB6SAEsRIszs7WE9XAN7/0DAzA5qnPwt8pK7X6xo+MBBFRmXVbueA
         Gqu4ZmksIdMH+rsfI0PPAOxVNhBM9AW/ZtRXW08of5hFlsjfmhZuGeHpHmUuIyCsbR
         YLh67kkor3ZoEfFlzzh490zrxB2IB2P1jMYgoKQK0Tl717bvla/pNHcSsK7w0zeR0p
         D8bo3NHaaz/pA==
Message-ID: <afd5257e-4550-ef9a-19e6-14941a721d55@kernel.org>
Date:   Mon, 15 May 2023 07:54:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-core: Simplies if condition
Content-Language: en-US
To:     Yahu Gao <yahu.gao@outlook.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <OS3P286MB0632FC8C1783241084E41BB79E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <OS3P286MB0632FC8C1783241084E41BB79E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/23 21:14, Yahu Gao wrote:
> Changes V1->V2:
>   Update the patch title.

This is not the correct way of specifying a patch changelog. This should be
added in the email, between the "---" and the "diff --git a/drivers/ata/..."
lines after the commit message.
