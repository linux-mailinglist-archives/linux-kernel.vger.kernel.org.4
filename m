Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5470D3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjEWGUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjEWGTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316C130
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 896D062F72
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72211C433EF;
        Tue, 23 May 2023 06:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684822789;
        bh=KAVEqt/JEohCVjW0sfFZBs2E7jSKgH4ZExSL2rRnJAk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RkChh1nRR4XlzI5dz24Hqt59N6RTFlEQXytCmNL9YEZsM/KhIgwR1LRC0pQJlUNNs
         64ihtB8stMuIt/XiOZNQIB/carbXmWibAIAX/K33ptqF+X2KRx8qDNkuGrgmmQEht9
         EHXyyzZ+dGwFQYTmB9UxufWmi5PJYhngfvRBG2z52C9FNRI+yIcYlQmrJiirFDJDUy
         Gh9Le41b1nHwcyGIKuHID3in3tYB7BNwEnavhM+Z5PGvVeCgJ6QVCzpxWDb29kNVOc
         YJ8tfVvev3Ui7ItwVpze18qSxFXqlQRYlVPo+E4QPKtRDl/gvNvkMXFQTisaaA+foG
         KU+0qxcdUmZJg==
Message-ID: <b183ca8b-7292-7d6c-e267-0e10bd32ba8c@kernel.org>
Date:   Tue, 23 May 2023 14:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP
 is off
Content-Language: en-US
To:     Yue Hu <zbestahu@gmail.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org
References: <20230515095758.10391-1-zbestahu@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230515095758.10391-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/15 17:57, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> The function of pcpubuf.c is just for low-latency decompression
> algorithms (e.g. lz4).
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
