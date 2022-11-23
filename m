Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1BA6351AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiKWH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiKWH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:56:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE171CE;
        Tue, 22 Nov 2022 23:55:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F0E4B81D84;
        Wed, 23 Nov 2022 07:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF122C433D6;
        Wed, 23 Nov 2022 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669190116;
        bh=ClJ/avTn0WG47eu5Hbl+GMHBizoFgIfACYzzidRRn/4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bctC9ycZqk6ZM9P6qDB/huHgxahLhSVuLV96NbGC7LPZ23FI88HXIuabX9Iuu/5MQ
         WIhLcnS3tnzcozy2nruwpX8uLKEnLhxqkkMz4OL/3c66lefcC84twONWZnDpfrywy+
         mB8fzdVc6FSK3S4HrQLEVLs5ml9ICTb1OMC9oByx+ryROZQtTM4jSkjj2iYUxPyMAP
         X6WgmzUodpYI7Vf1pY2LegKHsV6lRN9eWEum6q0ivOgzytKQl/mXfa+g+8d3r4ICiM
         lqvGIWiv/ZDyrXs2iuFc64s+e1WoI4zEM/7tQ6r0NgCcDMh/wE1wouFuwgEzKoaX5l
         PFc2Z2DPQdIOw==
Message-ID: <7b9f4fc4-38e6-fdbf-d426-fe23746e30be@kernel.org>
Date:   Wed, 23 Nov 2022 08:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] rv/monitors: Move monitor structure in rodata
To:     Alessandro Carminati <acarmina@redhat.com>,
        linux-trace-devel@vger.kernel.org
Cc:     alessandro.carminati@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
References: <7febf4f5-88d9-7902-e231-af2b6d0d6df0@kernel.org>
 <20221122173648.4732-1-acarmina@redhat.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20221122173648.4732-1-acarmina@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 18:36, Alessandro Carminati wrote:
> It makes sense to move the important monitor structure into rodata to
> prevent accidental structure modification.
> 
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel
