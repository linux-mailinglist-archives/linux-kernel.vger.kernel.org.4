Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5BC72DA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjFMGnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjFMGnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8E10D5;
        Mon, 12 Jun 2023 23:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60FC16312C;
        Tue, 13 Jun 2023 06:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C1CC433EF;
        Tue, 13 Jun 2023 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686638619;
        bh=YUDcFl/XWa0txFWoE50reR851y6XMN1PbCBop/xf71Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zk3WseNKtVQGVtAeY1wE8gUUovPpX+u+QDXcdf5F4PyvF8eEai8x2gk1HkQel1g2F
         ccdK54fsVvemoI9qYUEI0NvKD02L1e2xpcGaEe+Xmcn0ZiBsbtkWOmWU6vJL0GkIo3
         2Cz9aFQRW/w/xnjIm81o0eM1KQMjR0XCe+SKxGjDHu0jTQIpFHErqLMbHYHXdJcBpS
         txieRo175lSi0Rwum40REWVNsIbQRrYdkHAsgs3JqDw4hv2NW2PVetdtqPZIjcZO7l
         oRza4ez/D43/pYkiQtpSRFWl6BMcu8cSuIHV+azVYcaeyVdXxKIZu9UJ7sXtYOKi83
         XzHjZMFobtPkQ==
Message-ID: <294406f1-7078-341f-6d2d-1ba8e7273c10@kernel.org>
Date:   Tue, 13 Jun 2023 15:43:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ata: Use of_property_read_reg() to parse "reg"
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230609183125.1765780-1-robh@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230609183125.1765780-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 03:31, Rob Herring wrote:
> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-6.5 with the blan line after the declaration added as Sergey
suggested. Thanks !

-- 
Damien Le Moal
Western Digital Research

